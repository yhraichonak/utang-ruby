require 'time'
 Dir["#{Dir.getwd}/ACMS/lib/**/*.rb"].each {|file| require file }
 Dir["#{Dir.getwd}/ACMS/pages/**/*.rb"].each {|file| require file }
 Dir["#{Dir.getwd}/ACMS/support/**/*.rb"].each {|file| require file }
 Dir["#{Dir.getwd}/common/**/*.rb"].each {|file| require file }

 Before do
   $ACMS_AT_URL = process_param("[props.ACMS_AT_URL]")
   $ACMS_AD_URL = process_param("[props.ACMS_AD_URL]")
   $FLIGHT_MANAGER_REL_URL = process_param("[props.ACMS_FM_REL_URL]")
   $FLIGHT_PLAN_REL_URL = process_param("[props.ACMS_FP_REL_URL]")
   $MESSAGE_BROKER_API_URL =  process_param("[props.ACMS_MESSAGE_BROKER_API_URL]")
   $GENERATED_ALARM_FLIGHTS_MAP={}
   $ALARM_PIDS=[]
   $FM_API_URL="#{$ACMS_API_URL}#{$FLIGHT_MANAGER_REL_URL}".gsub("://","__").gsub("//","/").gsub("__","://")
   $FP_API_URL="#{$ACMS_API_URL}#{$FLIGHT_PLAN_REL_URL}".gsub("://","__").gsub("//","/").gsub("__","://")
   $SSH_CONNECTION_URL= process_param("[props.COMMON_SERVER_SSH_CONNECTION]")
   execute_command_no_wait( "ssh -o StrictHostKeyChecking=no -t #{$SSH_CONNECTION_URL} \"exit\"")
   upload_alert_generation_script_terminator
   $ACMS_INT_TEST_CONSOLE_PATH= process_param("[props.ACMS_INT_TEST_CONSOLE_PATH]")
   $ACMS_IMPORTER_PATH= process_param("[props.ACMS_EXCEL_IMPORTER_CLIENT_PATH]")
   $ACMS_IMPORTER_INPUT_OUTPUT_PATH= process_param("[props.ACMS_EXCEL_IMPORTER_IMPORT_OUTPUT_PATH]")
   $ACMS_IMPORTER_INPUT_FILE_PATH= process_param("[props.ACMS_EXCEL_IMPORTER_IMPORT_FILE_PATH]")
   $ACMS_IMPORTER_OUTPUT_FILES_PATTERN= process_param("[props.ACMS_EXCEL_IMPORTER_OUTPUT_FILES_PATTERN]")
   $SERVER_IP= process_param("[props.COMMON_SERVER_IP]")
   @ft_login=AlertTracker_LoginPage.new @selenium
   @common = CommonPage.new @selenium
   @ft_common=AlertTracker_CommonPage.new @selenium
   @ad_common=AlertDispatch_CommonPage.new @selenium
   @fm_api = Flight_Manager_API.new
 end



 Before('@clear_atc_db_sql') do
   if ENV['SKIP_CLEANUP'].nil? || ENV['SKIP_CLEANUP'].empty?|| ENV['SKIP_CLEANUP'].downcase.include?('false')
     log_info("Clearing ATC DB via SQL as Before hook @clear_atc_db_sql ...")
     steps %(Given User clears ATC DB via SQL)
   else
     log_info("Skipping clearing ATC Flights/Alerts via SQL as SKIP_CLEANUP specified")
   end
 end

 Before('@clear_atc_db') do
   if ENV['SKIP_CLEANUP'].nil? || ENV['SKIP_CLEANUP'].empty? || ENV['SKIP_CLEANUP'].downcase.include?('false')
     log_info("Clearing ATC DB as Before hook @clear_atc_db ...")
     steps %(Given User clears ATC DB)
   else
     log_info("Skipping clearing ATC Flights/Alerts as SKIP_CLEANUP specified")
   end
 end

 Before('@clear_atc_flights') do
   if ENV['SKIP_CLEANUP'].nil? || ENV['SKIP_CLEANUP'].empty? || ENV['SKIP_CLEANUP'].downcase.include?('false')
     log_info("Clearing ATC Flights/Alerts as Before hook @clear_atc_flights ...")
     steps %(When API: Clear ATC Flights and Alarms records)
   else
     log_info("Skipping clearing ATC Flights/Alerts as SKIP_CLEANUP specified")
   end
 end

After('@restore_agregated_fp') do
  if $RESTORE_AGGREGATED_FP
    log_info("Restoring aggregated Flight Plan  due to @restore_agregated_fp ...")
    steps %(The default flight plan is configured in ATC)
  end
end

 Before('@restart_atc_apppools') do
   log_info("Restarting ATC Apppools ...")
   restart_apppools
 end

 def restart_apppools
   start_appools=[
     "MessageBrokerNotificationService",
     "Aircommand",
     "Flighttracker",
     "FlightManager",
     "ClientAPIs"
   ]
   stop_appools=start_appools.reverse
   stop_appools.each do |apppool|
     execute_command( "ssh #{$SSH_CONNECTION_URL} \"PowerShell Stop-WebAppPool -Name #{apppool}\"" )
   end
   start_appools.each do |apppool|
     execute_command( "ssh #{$SSH_CONNECTION_URL} \"PowerShell Start-WebAppPool -Name #{apppool}\"" )
   end
  end

 After(name: 'Clear common env variables') do
   $GENERATED_ALARM=nil
   $ORIGINAL_MATCHING_ALARMS=nil
   $GENERATED_ALARM_FLIGHT=nil
   $GENERATED_ALARM_FLIGHTS_MAP={}
 end
 def get_alarm_flights(alarm_id)
   url =  "#{$FM_API_URL}flights?alarmId=#{alarm_id}"
   headers = {:content_type => :json}
   response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)
   response = JSON.parse(response)
   return response
 end

 def get_flight_plans()
   url =  "#{$FP_API_URL}FlightPlans/list"
   headers = {:content_type => :json}
   response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)
   response = JSON.parse(response)
   return response
 end
 def wait_for_disappear_spinner
   @selenium.manage.timeouts.implicit_wait = 1
   @wait.until { @selenium.find_elements(:css, "svg[data-test-id='spinner']").empty? }
   @selenium.manage.timeouts.implicit_wait = DEFAULT_IMPLICIT_WAIT
 end

 When(/^Alert initiated on PM with attributes$/) do |attributes_string|
  alert_attributes=JSON.parse(process_param(attributes_string))
  alarm_generator_script="#{process_param("[props.ACMS_TOOLS_PATH]")}/createAlarm.ps1"
  alert_generation_url=process_param("[props.COMMON_ALERT_GENERATOR_URL]")
  session=alert_attributes.fetch("Session",process_param("[props.ACMS_ALARM_SESSION]"))
  alarm_text=alert_attributes.fetch("AlarmText",process_param("[props.ACMS_ALARM_TEXT]"))
  severity=alert_attributes.fetch("Severity",process_param("[props.ACMS_ALARM_SEVERITY]"))
  duration=alert_attributes.fetch("Duration",process_param("[props.ACMS_ALARM_DURATION]"))
  $GENERATED_ALARM= alarm_text.split(",").last
  # Save Alert before generation new
  if ENV['ALARM_DB_VERIFICATION'].nil? || ENV['ALARM_DB_VERIFICATION'].empty? || (ENV['ALARM_DB_VERIFICATION'].downcase == "false")
    $ORIGINAL_MATCHING_ALARMS = @fm_api.get_matching_alarm_list($GENERATED_ALARM)
  else
    $ORIGINAL_MATCHING_ALARMS=get_alerts_by_text_sql($GENERATED_ALARM)
  end
  alarm_text.split(",").each do |single_alarm_text|
    alert_generation_command= "ssh -t -t #{$SSH_CONNECTION_URL} \"PowerShell #{alarm_generator_script} -URL '#{alert_generation_url}' -Session #{session} -AlarmText #{single_alarm_text} -Severity #{severity} -Duration #{duration}\""
    execute_command_no_wait(alert_generation_command)
  end

end

 When(/^Alert "(.*)" initiated on PM with (\d+) seconds timeout$/) do |alert_text, alert_tieout|
   steps %(When Alert initiated on PM with attributes
"""
  {"Session":"[props.ACMS_ALARM_SESSION]","AlarmText":"#{alert_text}","Severity":"[props.ACMS_ALARM_SEVERITY]","Duration":"#{alert_tieout}"}
""")
   end

 When(/^Alert "(.*)" initiated on PM with (\d+) seconds timeout and processed by Flight Manager$/) do |alert_text, alert_tieout|
   attempt = 3
   index = 0
   while index < attempt
     begin
       steps %(When Alert "#{alert_text}" initiated on PM with #{alert_tieout} seconds timeout)
       steps %(And API: Wait until the alert is processed by Flight Manager)
       break
     rescue => e
       index += 1
       if index == 3
         raise e
       end
       sleep(1)
       log_info("Unable to wait until alert processed trying one more time.  ")
     end
   end
 end

 When(/^Alert "(.*)" initiated on PM$/) do |alert_text|
   steps %(When Alert initiated on PM with attributes
"""
  {"Session":"[props.ACMS_ALARM_SESSION]","AlarmText":"#{alert_text}","Severity":"[props.ACMS_ALARM_SEVERITY]","Duration":"[props.ACMS_ALARM_DURATION]"}
""")
 end

 When(/^Alert "(.*)" initiated on PM and processed by Flight Manager$/) do |alert_text|
   attempt = 5
   index = 0
   while index < attempt
     begin
       steps %(When Alert "#{alert_text}" initiated on PM)
       steps %(And API: Wait until the alert is processed by Flight Manager)
       break
     rescue => e
       index += 1
       if index == attempt
         raise e
       end
       sleep(1)
       log_info("Unable to wait until alert processed trying one more time.  ")
     end
   end
 end

 When(/^Alert initiated on PM$/) do
   steps %(When Alert initiated on PM with attributes
"""
  {"Session":"[props.ACMS_ALARM_SESSION]","AlarmText":"[props.ACMS_ALARM_TEXT]","Severity":"[props.ACMS_ALARM_SEVERITY]","Duration":"[props.ACMS_ALARM_DURATION]"}
""")
 end

 When(/^Alert initiated on PM and processed by Flight Manager$/) do

   attempt = 3
   index = 0
   while index < attempt
     begin
       steps %(When Alert initiated on PM)
       steps %(And API: Wait until the alert is processed by Flight Manager)
       break
     rescue => e
       index += 1
       if index == 3
         raise e
       end
       sleep(1)
       log_info("Unable to wait until alert processed trying one more time.  ")
     end
   end
 end

 When(/^User executes test from \"(.*)\" file in ATC Integration Test Console$/) do |file_name|
   file_name=process_param(file_name)
   file_name=File.absolute_path(file_name)
   test_name=File.basename(file_name,".json")
   upload_file_command="scp #{file_name}  #{$SSH_CONNECTION_URL}:#{$ACMS_INT_TEST_CONSOLE_PATH}/Scripts/ 2>&1"
   output=execute_command(upload_file_command)
   integration_test_console= "ssh #{$SSH_CONNECTION_URL}  \"PowerShell \\\"cd #{$ACMS_INT_TEST_CONSOLE_PATH}; echo  #{test_name} | ./IntegrationTestConsole.exe 2>&1\\\" \""
   output=execute_command_with_output(integration_test_console, false)
   if output.empty?
     x = 0
     retries=5
     while x <= retries
       puts "Retrying command in 5 sec due to empty output..."
       sleep 5
       output = execute_command_with_output(integration_test_console, false)
       break unless output.empty?
       x = x + 1
     end
   end
   expect(output.to_s).to( match(".*Test #{test_name} completed successfully.*"), "ACMS integration test '#{test_name}' executed with error #{output}")
   end

 When(/^User manually triggers an (Accept|Escalate) response to be sent back to the Flight Manager for this flight$/) do |response|
   manual_dispatches= @fm_api.get_the_flight_manual_dispatches($GENERATED_ALARM_FLIGHT['id'])
   manual_dispatches=manual_dispatches.select{|t| t.to_s.match?(".*address.*manual.*")}.last['dispatches']
   raise "Unable to find manual dispatches for flight #{$GENERATED_ALARM_FLIGHT['id']}" if manual_dispatches.empty?

   dispatch_id=manual_dispatches.last['id']
   result=@fm_api.trigger_response_to_manual_dispatch(dispatch_id,response)
   expect(result.code).to equal(200)
 end

 When(/^User manually triggers an (Accept|Escalate) response to be sent back to the Flight Manager for this flight to recipient "(.*)"$/) do |response, recipient|
   manual_dispatches= @fm_api.get_the_flight_manual_dispatches($GENERATED_ALARM_FLIGHT['id'])
   manual_dispatches=manual_dispatches.select{|t| t.to_s.match?(".*recipient.*#{recipient}.*address.*manual.*")}
   raise "Unable to find manual dispatches for flight #{$GENERATED_ALARM_FLIGHT['id']} for recipient #{recipient}" if manual_dispatches.empty?
   result=@fm_api.trigger_response_to_manual_dispatch(manual_dispatches.last['id'],response)
   expect(result.code).to equal(200)
 end

 When(/^User executes test from \"(.*)\" file in ATC Integration Test Console if FP "(.*)" not present$/) do |file_name, ignoring_if_fp|
   if ENV['SKIP_CLEANUP'].nil? || ENV['SKIP_CLEANUP'].empty? || ENV['SKIP_CLEANUP'].downcase.include?('false')
     file_name=process_param(file_name)
     ignoring_if_fp=process_param(ignoring_if_fp)
     fps=get_flight_plans
     if fps.find{|t| t.to_s.include?(ignoring_if_fp)}.nil?
       steps %(Given User executes test from "#{file_name}" file in ATC Integration Test Console)
     end
   end
 end

 When(/^User executes test from \"(.*)\" file in ATC Integration Test Console if aggregated FP is not present$/) do |file_name|
   if ENV['SKIP_CLEANUP'].nil? || ENV['SKIP_CLEANUP'].empty? || ENV['SKIP_CLEANUP'].downcase.include?('false')
     file_name=process_param(file_name)
     ignoring_if_fp=process_param(get_param("ACMS_DEFAULT_FLIGHT_PLAN"))
     fps=get_flight_plans
     if fps.find{|t| t.to_s.include?(ignoring_if_fp)}.nil?
       steps %(Given User executes test from "#{file_name}" file in ATC Integration Test Console)
     end
   end
 end

When(/^User executes test from \"(.*)\" file in ATC Integration Test Console and restore aggregated FP if present$/) do |file_name|
  if ENV['SKIP_CLEANUP'].nil? || ENV['SKIP_CLEANUP'].empty? || ENV['SKIP_CLEANUP'].downcase.include?('false')
    file_name=process_param(file_name)
    ignoring_if_fp=process_param(get_param("ACMS_DEFAULT_FLIGHT_PLAN"))
    fps=get_flight_plans
    if fps.find{|t| t.to_s.include?(ignoring_if_fp)}.nil?
      $RESTORE_AGGREGATED_FP=true
    end
    steps %(Given User executes test from "#{file_name}" file in ATC Integration Test Console)
  end
end

 Given(/^The default flight plan is configured in ATC$/) do
   steps %(
   When User executes test from "[props.ACMS_DEFAULT_CONFIG]" file in ATC Integration Test Console if FP "[props.ACMS_DEFAULT_FLIGHT_PLAN]" not present
   )
 end

 Given(/^Attach file "(.*)" into report with title "(.*)"(| as plain text)$/) do |attachment, title, plain|
   if plain.include?("plain")
     Allure.add_attachment(name: title, source: File.read(attachment), type: Allure::ContentType::TXT, test_case: true)
   else
     Allure.add_attachment(name: title, source: File.read(attachment), type: Allure::ContentType::PNG, test_case: true)
   end
 end

 Given(/^User executes (Import|Export|Validate|"Clear Database") command via ATC Excel Importer$/) do |command|
   case command
   when "Export"
     do_run_excel_importer_command(command)
     download_latest_atc_excel_export_file
   when "Validate", '"Clear Database"'
     do_run_excel_importer_command(command)
     else raise "Not yet implemented execution command #{command} via ATC Excel Importer"
   end
 end

 Given(/^User compares downloaded xlsx-file with expected "(.*)" ignoring$/) do |expected_file,ignoring_rules|
   steps %(   And User compares "#{File.basename($DOWNLOADED_FILE)}" xlsx-file with expected "#{expected_file}" ignoring
    """
  #{ignoring_rules}
    """)
 end
 Given(/^User compares "(.*)" xlsx-file with expected "(.*)" ignoring$/) do |test_file, expected_file,ignoring_rules|
   rules=JSON.parse(ignoring_rules)
   baseline_file="#{Dir.pwd}/#{expected_file}"
   ExcelHelper.new.compare_excels(baseline_file, test_file, rules)
   unless File.zero?("compare_txt.txt")
     Allure.add_attachment(name: "Xlsx-file comparison actual:#{File.basename(test_file)}; expected: #{expected_file}", source: File.read("compare_txt.txt"), type: Allure::ContentType::TXT, test_case: true)
     raise "Excel xlsx-files comparison failed. See diff above"
   end
 end
 Given(/^User compares downloaded xlsx-file with one of expected "(.*)" ignoring$/) do |expected_files,ignoring_rules|
       steps %(   And User compares "#{File.basename($DOWNLOADED_FILE)}" xlsx-file with one of expected "#{expected_files}" ignoring
    """
  #{ignoring_rules}
    """)
 end
 Given(/^User compares "(.*)" xlsx-file with one of expected "(.*)" ignoring$/) do |test_file, expected_files,ignoring_rules|
   expected_files.split(",").each_with_index do  |expected_file, index|
     begin
       steps %(   And User compares "#{test_file}" xlsx-file with expected "#{expected_file}" ignoring
    """
  #{ignoring_rules}
    """)
       log_info "File #{test_file} matches to '#{expected_file}'"
       break
     rescue Exception => e
       if index < expected_files.split(",").size
         log_info "Downloaded #{test_file} doesn't match to '#{expected_file}'"
       else
         raise e, "Downloaded #{test_file} doesn't match to any of [#{expected_files}]"
       end
     end
   end
 end

 Given(/^User executes (Import|Validate) command via ATC Excel Importer for file "(.*)"$/) do |command, import_file|
   do_run_excel_importer_command_on_file(command, import_file,nil)
 end

 Given(/^User verifies output for (Import|Validate) command via ATC Excel Importer for file "(.*)"$/) do |command, import_file, output|
   do_run_excel_importer_command_on_file(command, import_file, output)
 end

 def do_run_excel_importer_command_on_file(command,import_file,verify_output)
   upload_atc_excel_import_file(import_file)
   output = do_run_excel_importer_command_no_validate_output(command)
   if verify_output.nil?
     expect(output.to_s).not_to(match(".*failed.*"), "ATC Excel Import command executed with error #{output}")
   else
     expect(output.to_s).to(match(verify_output), "ATC Excel Import command executed with error #{output}")
   end
 end

 def do_run_excel_importer_command(command)
   importer_commandline = "ssh #{$SSH_CONNECTION_URL}  \"PowerShell \\\"cd #{$ACMS_IMPORTER_PATH}; echo Y|./ExcelImportClient.exe --option #{command} --warningBypass true 2>&1\\\" \""
   output = execute_command(importer_commandline)
   expect(output.to_s).not_to( match(".*failed.*"), "ATC Importer #{command} command executed with error #{output}")
 end

 def do_run_excel_importer_command_no_validate_output(command)
   importer_commandline = "ssh #{$SSH_CONNECTION_URL}  \"PowerShell \\\"cd #{$ACMS_IMPORTER_PATH}; echo Y|./ExcelImportClient.exe --option #{command} --warningBypass true 2>&1\\\" \""
   execute_command(importer_commandline)
 end

 def download_latest_atc_excel_export_file
   target_file_export = execute_command("ssh #{$SSH_CONNECTION_URL} \"PowerShell \\\"gci #{$ACMS_IMPORTER_INPUT_OUTPUT_PATH}  -Filter #{$ACMS_IMPORTER_OUTPUT_FILES_PATTERN} | sort LastWriteTime | select -last 1 | select fullname | ft -HideTableHeaders\\\" \"").strip
   downloaded_file_name=target_file_export.split("\\").last
   download_file_command = "scp  #{$SSH_CONNECTION_URL}:#{target_file_export.gsub("\\","/")} #{downloaded_file_name} "
   execute_command(download_file_command)
   $DOWNLOADED_FILE="#{Dir.pwd}/#{downloaded_file_name}"
 end


 def upload_atc_excel_import_file(upload_file)
   upload_file_command = "scp  #{Dir.pwd}/#{upload_file}  #{$SSH_CONNECTION_URL}:#{$ACMS_IMPORTER_INPUT_FILE_PATH}"
   execute_command(upload_file_command)
   end
   def upload_alert_generation_script_terminator()
     upload_file_command = "scp  #{Dir.pwd}/ACMS/scripts/kill_alert_generator.ps1  #{$SSH_CONNECTION_URL}:#{process_param("[props.ACMS_TOOLS_PATH]")}"
     execute_command(upload_file_command)
   end

 Given(/^User clears ATC Flights and Alarms$/) do ||
   steps %(Given clear_flights_data)
 end

 Given(/^User clears ATC DB$/) do ||
   steps %(Given User executes test from "ACMS/testdata/ClearDB.json" file in ATC Integration Test Console)
 end

 Then(/^User clears ATC DB via SQL$/) do
   sql_query = File.read("ACMS/testdata/ClearDB.sql")
   db_response=DB_Client.new.execute_multiple_sqls(process_param(get_param("COMMON_SERVER_DB_ADDRESS")),
                                           process_param(get_param("COMMON_SERVER_DB_PORT")),
                                           process_param(get_param("COMMON_SERVER_DB_USER")),
                                           process_param(get_param("COMMON_SERVER_DB_PASSWORD")),
                                           process_param(get_param("COMMON_SERVER_DB_SCHEMA")),
                                                     sql_query.split("\n"))
   puts db_response
 end

 def get_alerts_by_text_sql(alert_text)
   sql_query = "select * from Alarms where OriginalText = '#{alert_text}'"
   db_response=DB_Client.new.execute_sql(process_param(get_param("COMMON_SERVER_DB_ADDRESS")),
                                                   process_param(get_param("COMMON_SERVER_DB_PORT")),
                                                   process_param(get_param("COMMON_SERVER_DB_USER")),
                                                   process_param(get_param("COMMON_SERVER_DB_PASSWORD")),
                                                   process_param(get_param("COMMON_SERVER_DB_SCHEMA")),
                                                  sql_query)
   db_response
 end


 Given(/^(FT|AC): User is logged in$/) do |ui|
   steps %( When #{ui}: User opens login page
           And #{ui}: User logs in as "[props.ACMS_USERNAME]" with password "[props.ACMS_PASSWORD]")
 end

 Given(/^(FT|AC): User is logged in with default filter applied$/) do |ui|
   steps %( Given #{ui}: User is logged in
            And #{ui}: User applies unit filter to "[props.ACMS_FILTER]")
 end

Given(/^(FT|AC): User clicks on the application header$/) do |ui|
  @common.header.click
  sleep 0.5
end

 Given(/^(FT|AC): User attempts to log in with invalid username$/) do |ui|
   steps %(When #{ui}: User logs in as "[props.ACMS_INVALID_USERNAME]" with password "[props.ACMS_PASSWORD]")
 end

 Given(/^(FT|AC): User attempts to log in with invalid password$/) do |ui|
   steps %(When #{ui}: User logs in as "[props.ACMS_USERNAME]" with password "[props.ACMS_INVALID_PASSWORD]")
 end

 Given(/^(FT|AC): Refresh the page$/) do |ui|
   @selenium.navigate.refresh
   steps %(Given #{ui}: User applies unit filter to "[props.ACMS_UNIT]")
 end

Given(/^(FT|AC): Refresh the page only$/) do |ui|
  @selenium.navigate.refresh
end

Given(/^User sets browser size to (\d+)x(\d+)$/) do |width, height|
  @selenium.manage.window.resize_to(height,width)
end
 Given(/^(FT|AC): User applies unit filter to "(.*)"$/) do |ui,filters|
   filters=process_param(filters)
   log_info("Selecting filter #{filters} on Unit selection module")
   @ft_common.set_filter(filters.split(","))
   wait_for_disappear_spinner
   @selenium.find_element(:css,"img[data-testid='app-logo']").click
   @wait.until { @ad_common.filter_trigger.attribute('data-state') == 'closed' }
 end

 Then (/^User should see all UI header components$/) do
   header = @common.header.displayed?
   as_logo = @common.utang_logo.displayed?
   sitename = @common.sitename_label.displayed?
   ac_logo_class = @common.app_logo.attribute("class")
   unit_filter_label = @common.units_filter_label.displayed?
   unit_filter_value_string = @common.units_filter_summary_value.text.split(" ")[0]
   test_temp = unit_filter_value_string.to_i.to_s

   expect(header).to be_truthy
   expect(as_logo).to be_truthy
   expect(sitename).to be_truthy
   expect(ac_logo_class).to include("w-auto")
   expect(unit_filter_label).to be_truthy
   expect(unit_filter_value_string).to eql(unit_filter_value_string.to_i.to_s)
 end

 Then(/^(FT|AC): User should see that the flight details panel is (visible|hidden)$/) do |ui,flightDetailsVis|
   if flightDetailsVis === "visible"
     expect(@ad_common.isFlightDetailsPanelOpen()).to eq(true)
   elsif flightDetailsVis === "hidden"
     expect(@ad_common.isFlightDetailsPanelOpen()).to eq(false)
   end
 end

 Then(/^(FT|AC): User verifies that the alert details panel is (opened|closed)$/) do |ui, action|
   if action == "opened"
     @flight_details=FlightDetailsPanel.new @selenium
     expect(@flight_details.get_container_element.displayed?).to eq(true)
   else
     expect(FlightDetailsPanel.initialize_no_wait @selenium).to eq(nil)
   end
 end

 Then(/^(FT|AC): User verifies that the alert details has matching text$/) do |ui, regexp|
   expect(@flight_details.get_container_element.text).to match(regexp)
 end

Then(/^(FT|AC): User clicks 'X' button on the alert details$/) do |ui|
  @flight_details.close
end

 Then(/^AC: User verifies that the alert details has Start button$/) do
   expect(@flight_details.start_button.displayed?).to eq(true)
 end


Then(/^AC: User verifies that (Alarms|Alerts) counter on (Alarm Queue|Alerts) panel has value (\d)$/) do |item_type, panel, count|
  target_panel=@ad_common.get_items_list_panel(panel)
  checkbox=target_panel.find_element(:css, "div[data-testid='flight-count']")
  expect(checkbox.text).to include(count.to_s)
end


Then(/^AC: User verifies that Prioritize by Severity is checked on (Alarm Queue|Alerts) panel$/) do |panel|
  target_panel=@ad_common.get_items_list_panel(panel)
  checkbox=target_panel.find_element(:css, "button[role='checkbox']")
  expect(checkbox.attribute("aria-checked")).to include("true")
end

Then(/^AC: User sets Prioritize by Severity to unchecked on (Alarm Queue|Alerts) panel$/) do |panel|
  target_panel=@ad_common.get_items_list_panel(panel)
  checkbox=target_panel.find_element(:css, "button[role='checkbox']")
  begin
    checkbox.click
  rescue => e
    if e.to_s.include?('element click intercepted')
      @selenium.execute_script "arguments[0].click();", checkbox
    end
  end
  sleep 1
end

Then(/^AC: User verifies the order of items on (Alarm Queue|Alerts) panel$/) do |panel, elements|
  target_panel=@ad_common.get_items_list_panel(panel)
  alerts=target_panel.find_elements(:css, "div[data-testid='alarm-label']").map { |t| t.text }.join(",")
  expect(JSON.parse(elements).join(",")).to include(alerts)
end

Then(/^AC: User verifies the order of items in (Active|Completed) section on Alerts panel$/) do |alerts_section, elements|
  alerts=@ad_common.get_alerts_panel.find_elements(:css, "div[data-testid='"+alerts_section+"'] div[data-testid='alarm-label']").map { |t| t.text }.join(",")
  expect(JSON.parse(elements).join(",")).to include(alerts)
end

 Then(/^(AC|FT): User verifies that the alert details has tab (History|Monitor) active$/) do |ui,tab|
   expect(@flight_details.active_tab.text).to eq(tab)
 end
 Then(/^(AC|FT): User verifies that monitor is displayed on the alert details$/) do |ui|
   monitor=@flight_details.monitor
   expect(monitor.displayed?).to eq(true)
   @selenium.switch_to.frame(monitor)
   expect(@selenium.find_element(:css,"div.monitor.widget div.monitor-body").displayed?).to eq(true)
   @selenium.switch_to.window( @selenium.window_handles.last )
 end

 When (/^(AC|FT): User switch to embedded Monitor tab on the alert details$/) do |ui|
   @embedded_monitor=@flight_details.monitor
   expect(@embedded_monitor.displayed?).to eq(true)
   @selenium.switch_to.frame(@embedded_monitor)
   expect(@selenium.find_element(:css,"div.monitor.widget div.monitor-body").displayed?).to eq(true)
 end

 When (/^(AC|FT): User should see event start time on embedded Monitor$/) do |ui|
   sleep(2)
   start_event=DateTime.parse($GENERATED_ALARM_FLIGHT['createdAt']).strftime('%m/%d/%Y - %H:%M:%S')
   expect(@selenium.find_element(:css,"div.chart-end-time").text).to eq start_event
 end

 When (/^(AC|FT): User should see embedded Monitor in historical mode$/) do |ui|
   button_color=@selenium.find_element(:xpath,"//a[.='Live']").css_value('color')
   expect(button_color).to match('.*(125, 125, 125|153, 153, 153|102, 102, 102).*')
   expect(@selenium.find_element(:css,"div.latency").text).to match(".*(ago|from now).*")
 end


 When (/^(AC|FT): User should see at least 4 charts on embedded Monitor$/) do |ui|
   found_elements=@selenium.find_elements(:css,"div.monitor-chart").select { |elem| elem.displayed? }
   expect(found_elements.size).to be >= 4
 end

 When (/^(AC|FT): User opens (Monitor|Events|Tools) tab on embedded Monitor$/) do |ui, tab|
   target_tab=@selenium.find_elements(:css,"nav.monitor-sub-nav a").find{ |elem| elem.text.include? tab}
   unless target_tab.attribute("class").include? "active"
     begin
       target_tab.click
     rescue => e
       if e.to_s.include?('element click intercepted')
         @selenium.execute_script "arguments[0].click();", target_tab
       end
     end
   end
 end

 When (/^(AC|FT): User verifies that (Last Hour|1–6 Hours Ago) events panel (\d)th element match "([^\"]*)" on embedded Monitor$/) do |ui, segment, position, event_text |
   target_segment=@selenium.find_elements(:css,"div.monitor-events .segment").find{ |elem| elem.text.include? segment}
   event_text=event_text.sub!("[EVENT_START_TIME]",
                     DateTime.parse($GENERATED_ALARM_FLIGHT['createdAt']).strftime('%H:%M:%S'))
   expect(target_segment.find_elements(:css,'.event')[position.to_i].text).to match(event_text)
 end
 When (/^(AC|FT): User verifies that (Last Hour|1–6 Hours Ago) events panel (\d)th element match "(.*)" and the alert time on embedded Monitor$/) do |ui, segment, position, event_text |
   max_deviation=2
   target_segment=@selenium.find_elements(:css,"div.monitor-events .segment").find{ |elem| elem.text.include? segment}
   words=target_segment.find_elements(:css,'.event')[position.to_i].text.split("\s")
   expect(words[0]).to match(event_text)
   alert_time = Time.parse(words[1])
   flight_time = Time.parse(DateTime.parse($GENERATED_ALARM_FLIGHT['createdAt']).strftime('%H:%M:%S'))
   time_diff=flight_time-alert_time
   expect(words[0]).to match(event_text)
   expect(time_diff).to be <= max_deviation
 end

Then (/^(AC|FT): User sees "(.*)" tabs on events panel on embedded Monitor$/) do |ui,tabs |
   @selenium.manage.window.maximize
   sleep 1
  segments=@selenium.find_elements(:css,"div.monitor-events .segment .header").collect{|t| t.attribute("innerText").split("\n").first}.to_s
  expect(segments.to_s).to include tabs.split(",").to_s
end

 When (/^(AC|FT): User should not see (primary navigation bar|patient header|side navigation panel|docked events list) on embedded Monitor$/) do |ui, hidden_element|
     case hidden_element
     when /.*primary navigation bar.*/
       found_elements=find_element_no_wait(@selenium,@selenium,:css,"div.header-top")
     when /.*patient header.*/
       found_elements=find_element_no_wait(@selenium,@selenium,:css,"div.patient-header .patient-info")
     when /.*side navigation panel.*/
       found_elements=find_element_no_wait(@selenium,@selenium,:css,"div.pm-side-nav")
     when /.*docked events list.*/
       found_elements=find_element_no_wait(@selenium,@selenium,:css,"div.events.docked-list")
     end
     expect(found_elements).to be(nil)
 end


When (/^(AC|FT): User should see (rhythm strip|monitor zoom view) on embedded Monitor$/) do |ui, element|
  case element
  when /.*rhythm strip.*/
    found_elements=find_element_no_wait(@selenium,@selenium,:css,"div.rhythm-strip")
  when /.*|monitor zoom view.*/
    found_elements=find_element_no_wait(@selenium,@selenium,:css,"div.monitor-body .chart")
  end
  expect(found_elements).not_to be nil
end

When (/^(AC|FT): User clicks on Tools header of embedded Monitor$/) do |ui|
  @selenium.find_element(:css,"div.controls:nth-child(1)").click
end

When (/^(AC|FT): User clicks (Measure|Calipers|Create Snippet|Preview|Save|Cancel|Back) button on embedded Monitor$/) do |ui, button|
  sleep(1)
  begin
    element_to_click=@selenium.find_elements(:xpath,"//button[.='"+button+"']").last
    element_to_click.click
  rescue => e
    if e.to_s.include?('element click intercepted')
      @selenium.execute_script "arguments[0].click();", element_to_click
    end
  end
end

When (/^(AC|FT): User wait for (\d+)s until "(.*)" button is enabled on embedded Monitor$/) do |ui, timeout, button|
  Selenium::WebDriver::Wait.new(timeout: timeout)
                           .until { @selenium.find_element(:xpath,"//button[.='"+button+"']").enabled? }
end

Then (/^(AC|FT): User should see Snippet Preview dialog on embedded Monitor$/) do |ui|
  Selenium::WebDriver::Wait.new(timeout: 3)
                           .until { @selenium.find_element(:css,"div[role='dialog'].snippet-preview").displayed?}
end
Then (/^(AC|FT): User should see Snippet Edit form on embedded Monitor$/) do |ui|
  expect(@selenium.find_element(:css,'div.widget.create-statement').displayed?).to be true;
end
When (/^(AC|FT): User wait for (\d+)s until spinner disappears on embedded Monitor$/) do |ui, timeout|
  Selenium::WebDriver::Wait.new(timeout: timeout)
                           .until { find_element_no_wait(@selenium,@selenium,:css,"div.loader")==nil}
end

When (/^(AC|FT): User wait for spinner disappears on embedded Monitor$/) do |ui|
  Selenium::WebDriver::Wait.new(timeout: 20)
                           .until { find_element_no_wait(@selenium,@selenium,:css,"div.loader")==nil}
end

Then (/^(AC|FT): User wait for Snippet Saved message on embedded Monitor$/) do |ui|
  @selenium.find_element(:xpath,"//div[contains(@class,'swal2-popup') and contains(.,'Snippet Saved')]//button[.='OK']").click
end


When (/^(AC|FT): User sets Event Type to "(.*)" on embedded Monitor$/) do |ui, event_type|
  i = 0
  while i < 5
      if !@selenium.find_element(:css,".snippet-doc-type-select").text.include? event_type
        @selenium.find_element(:css,".snippet-doc-type-select").click
        @selenium.action.send_keys(:arrow_down).perform
        @selenium.action.send_keys(:return).perform
        i += 1
      else
        i=5
      end
  end
end

When (/^(AC|FT): User sets Description to "(.*)" on embedded Monitor$/) do |ui, description|
  @selenium.find_element(:css, 'div.Select__control').click
  @selenium.find_element(:css, 'div.Select input').send_keys description, :return

end

When (/^(AC|FT): User sets "(.*)" measurement value to "(.*)" on embedded Monitor$/) do |ui, label,value|
  element=@selenium.find_element(:xpath, "//label[contains(.,'"+label+"')]/input")
  element.clear
  element.click
  element.send_keys value
end

When (/^(AC|FT): User sets All leads (On|Off) on embedded Monitor$/) do |ui, button|
  sleep(2)
  if (button == "On") && !@selenium.find_element(:css, '.onoffswitch-checkbox').selected?
    @selenium.find_element(:css, "div.onoffswitch").click
  end
 if (button == "Off") && @selenium.find_element(:css, '.onoffswitch-checkbox').selected?
   @selenium.find_element(:css, "div.onoffswitch").click
 end

end

When (/^(AC|FT): User see (Measure|Calipers) button is (enabled|disabled) on embedded Monitor$/) do |ui, button, state|
  button=@selenium.find_element(:xpath,"//div[@class='marker-controls']//button[.='"+button+"']")
  if state == 'enabled'
    expect(button.attribute("className")).to include("selected")
  else
    expect(button.attribute("className")).not_to include("selected")
  end

end

When(/^(AC|FT): User should see measurements P, QR, S, T on Tools header of embedded Monitor$/) do |ui|
  ['P','Q/R', 'S','T'].each do |msr|
      @selenium.find_element(:xpath,"//div[contains(@class,'caliper') and contains(., '"+msr+"')]")
  end
end


Then(/^(AC|FT): User could move P, QR, S, T on Tools header of embedded Monitor$/) do |ui|
  ['P','Q/R', 'S','T'].each do |msr|
    indicator_element= @selenium.find_element(:xpath,"//div[contains(@class,'caliper') and contains(., '"+msr+"')]")
    @selenium.action.click_and_hold(indicator_element).move_by(20, 0).release.perform
  end
end
Then(/^(AC|FT): User could move caliper handles on Tools header of embedded Monitor$/) do |ui|
  indicator_element= @selenium.find_elements(:xpath,"//div[contains(@class,'caliper')]")
  @selenium.action.click_and_hold(indicator_element.first).move_by(20, 0).release.perform
  @selenium.action.click_and_hold(indicator_element.last).move_by(20, 0).release.perform
end

When (/^(AC|FT): User should see (snippet length selector|snippet lead selectors|measure|calipers|paper mode|marchout) on Tools header of embedded Monitor$/) do |ui, element|
  case element
  when /.*snippet length selector.*/
    @selenium.find_element(:xpath,"//div[contains(@class,'Select__value-container') and contains(.,'seconds')]")
  when /.*snippet lead selectors.*/
    @selenium.find_element(:xpath,"//div[contains(@class,'Select__value-container') and contains(.,'ECG')]")
  when /.*measure.*/
    @selenium.find_element(:xpath,"//div[@class='marker-controls']//button[.='Measure']")
  when /.*calipers.*/
    @selenium.find_element(:xpath,"//div[@class='marker-controls']//button[.='Calipers']")
  when /.*paper mode.*/
    @selenium.find_element(:xpath,"//div[contains(@class,'toggle') and .='Paper Mode']")
  when /.*marchout.*/
    @selenium.find_element(:xpath,"//div[contains(@class,'toggle') and .='Marchout']")
  end
end

When (/^(AC|FT): User should see at least a single cardiac rhythm in the zoom view on embedded Monitor$/) do |ui|
  found_elements=@selenium.find_elements(:css,"div.chart div.monitor-chart")
  expect(found_elements.size).to be >= 1
end
When (/^(AC|FT): User can zoom (in|out) view on embedded Monitor$/) do |ui, action|
  zoomer=@selenium.find_element(:css,"input[type='range']")
  orig_time=DateTime.parse(@selenium.find_element(:css,"div.rhythm-strip div.timestamp").text)
  if action == 'in'
    100.times{zoomer.send_keys(:arrow_left)}
    sleep 1
    expect(DateTime.parse(@selenium.find_element(:css,"div.rhythm-strip div.timestamp").text)).to be <orig_time
  else
    200.times{zoomer.send_keys(:arrow_right)}
    sleep 1
    expect(DateTime.parse(@selenium.find_element(:css,"div.rhythm-strip div.timestamp").text)).to be >orig_time
  end
end
 When(/^(FT|AC): User closes generated alert details panel$/) do |panel|
   @flight_details=FlightDetailsPanel.new @selenium
   @flight_details.close
 end

 When(/^(FT|AC): User opens (History|Monitor) tab of the alert details panel$/) do |ui, target_tab|
   @flight_details=FlightDetailsPanel.new @selenium
   sleep(1)
   @flight_details.click_tab(target_tab)
   sleep(1)
 end

 When(/^(FT|AC): User remembers History tab content of the alert details panel$/) do |ui|
   @flight_details=FlightDetailsPanel.new @selenium
   @flight_details_history_content=@flight_details.tab_content_history.text
 end

 When(/^(FT|AC): User verified History tab loaded new data on the alert details panel$/) do |ui|
   @flight_details=FlightDetailsPanel.new @selenium
   @new_data=@flight_details.tab_content_history.text.sub!(@flight_details_history_content, "")
 end

 When(/^(FT|AC): User waits for (\d*) seconds until (History|Monitor) tab of the alert details panel flashes$/) do | ui,timeout, target_tab|
   @flight_details = FlightDetailsPanel.new @selenium
   wait_interval = 0.1
   start_time = Time.now.to_f
   found_matches = false
   while (Time.now.to_f - start_time) < timeout.to_i do
     begin
       if @flight_details.is_tab_flashed(target_tab)
         found_matches = true
         break
       else
         sleep wait_interval
       end
     end
   end
   unless found_matches
     log_exception "Unable to wait until the tab '#{target_tab}' flashed during #{timeout} seconds"
   end
 end

 When(/^(FT|AC): User verifies that the alert details panel has (\d+) events matching "(.*)"$/) do |ui, number_of_events, event_regexp|
   @flight_details=FlightDetailsPanel.new @selenium
   event_regexp=process_param(event_regexp)
   matching_events=@flight_details.get_flight_events.select{|t| t.text.gsub("\n"," ").match?(event_regexp)}
   expect(matching_events).not_to(be_empty, "No events matching #{matching_events} found on Alert Details panel")
   expect(matching_events.count).to(eql number_of_events)
 end

 When(/^(FT|AC): User verifies that the alert details panel has event matching$/) do |ui,event_regexp|
   @flight_details=FlightDetailsPanel.new @selenium
   event_regexp=process_param(event_regexp)
   matching_events=@flight_details.get_flight_events.find{|t| t.text.gsub("\n"," ").match?(event_regexp)}
   expect(matching_events).not_to(be_nil, "No events matching #{matching_events} found on Alert Details panel")
 end

 When(/^(FT|AC): User verifies that the alert details panel has event matching "(.*)"$/) do |ui,event_regexp|
   event_regexp=process_param(event_regexp)
   @flight_details=FlightDetailsPanel.new @selenium
   flight_event=@flight_details.get_flight_events_text
   matching_events=@flight_details.get_flight_events.select{|t| t.text.gsub("\n"," ").match?(event_regexp)}
   expect(matching_events).not_to(be_empty, "No events matching #{event_regexp} found on Alert Details panel")
 end

 When(/^(FT|AC): User waits until alert details panel has event matching "(.*)"$/) do |ui,event_regexp|
   ui_update_timeout = 15
   wait_interval = 1
   event_regexp=process_param(event_regexp)
   start_time = Time.now.to_f
   found_matches=false
   while (Time.now.to_f-start_time) < ui_update_timeout do
     begin
       steps %(#{ui}: User verifies that the alert details panel has event matching "#{event_regexp}")
       found_matches=true
       break
     rescue Exception
       log_info "Waiting for #{wait_interval} more seconds until alert details item '#{attributes}' is present"
       sleep wait_interval
     end
   end
   if not found_matches
     log_exception "Unable to wait until the alert details item '#{attributes}' during #{ui_update_timeout} seconds"
   end
 end

 When(/^(FT|AC): User verifies that the alert details panel doesn't have event matching "(.*)"$/) do |ui, event_regexp|
   event_regexp=process_param(event_regexp)
   @flight_details=FlightDetailsPanel.new @selenium
   matching_events=@flight_details.get_flight_events.select{|t| t.text.gsub("\n"," ").match?(event_regexp)}
   expect(matching_events).to(be_empty, "Kept finding events matching #{event_regexp} found on Alert Details panel")
 end

 Then(/^Time difference between "(.*)" and "(.*)" is (\d+) seconds$/) do |event1, event2, time|
   time_span = 2
   time_span = 7 unless time <= 20
   steps %(
    Then The time stamp difference between "#{event1}" event 1 and "#{event2}" event 1 is #{time} seconds, within #{time_span} second range
   )
 end

 When(/^(FT|AC): User verifies that the alert details panel has events matching$/) do |ui,table|
   regexp_list=table.raw.flatten
   for regexp in  regexp_list
       steps %(When #{ui}: User verifies that the alert details panel has event matching
"""
#{regexp}
""")
   end
 end

 def verify_table_element(table, element, expected_attributes)
   columns=table.find_elements(:css, "th").map { |t| t.text }

   expected_attributes.each do |k, v|
     v=process_param(v.to_s)
     col_index=columns.find_index(k)
     row_columns=element.find_elements(:css,"td")
     actual_value_element=row_columns[col_index]
     actual_value=actual_value_element.text
     v=v.to_s
     case v
     when /.*matches:.*/
       if not v.match(".*(true|false).*")
         expect(actual_value.to_s).to( match(v.gsub("matches:", "")),"Column value [#{k}] is not proper. Actual [#{actual_value}] expected matches: [#{v}]")
       end
     when /.*(true|false).*/
       bool_value=actual_value_element.find_element(:css,"img").attribute("alt")
       if v.include? "true"
        expect(bool_value).to eq("checked"),"Column value [#{k}] is not proper. Actual [#{bool_value}] expected [#{v}]"
       else
        expect(bool_value).to eq("unchecked"),"Column value [#{k}] is not proper. Actual [#{bool_value}] expected [#{v}]"
       end
     when /(High|Medium|Low)/
       severity_title=actual_value_element.find_element(:css,"img").attribute("alt")
       expect(severity_title.to_s).to include(v.to_s.downcase),"Column value [#{k}] is not proper. Actual [#{severity_title}] expected [#{v}]"
     else
       expect(actual_value.to_s.strip.downcase).to( eq(v.to_s.downcase), "Column value [#{k}] is not proper. Actual [#{actual_value}] expected [#{v}]")
     end
   end
 end

 Then(/^The time stamp difference between "(.*)" event (\d+) and "(.*)" event (\d+) is (\d+) seconds, within (\d+) second range$/) do |event1, event1_index, event2, event2_index, time, time_range|
   event1 = process_param(event1)
   event2 = process_param(event2)
   matching_event1=@flight_details.get_flight_events.select{|t| t.text.gsub("\n"," ").match?(event1)}.last
   matching_event2=@flight_details.get_flight_events.select{|t| t.text.gsub("\n"," ").match?(event2)}.last
   event1_time_stamp = Time.parse(matching_event1.find_element(:css, "div[data-testid='time']").text)
   event2_time_stamp = Time.parse(matching_event2.find_element(:css, "div[data-testid='time']").text)
   log_info("this #{event1_time_stamp.to_i}")
   log_info("this #{event2_time_stamp.to_i}")
   time_array = [(time - 1).to_i, time.to_i]
   for i in 1..time_range
     time_array.push((time + i).to_i)
   end
   expect(time_array).to include((event2_time_stamp - event1_time_stamp).to_i)
 end
