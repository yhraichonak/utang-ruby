Dir["#{Dir.getwd}/ACMS/lib/**/*.rb"].each {|file| require file }
Dir["#{Dir.getwd}/ACMS/pages/**/*.rb"].each {|file| require file }
Dir["#{Dir.getwd}/ACMS/support/**/*.rb"].each {|file| require file }
Dir[File.dirname(__FILE__) + "/../../common/**/*.rb"].each {|file| require file }

Before do
  $ACMS_AT_URL = process_param("[props.ACMS_AT_URL]")
  @ft_login=AlertTracker_LoginPage.new @selenium
  @ft_common=AlertTracker_CommonPage.new @selenium
end


Given(/^FT: User opens login page$/) do
  @selenium.navigate.to $ACMS_AT_URL
  @wait.until { @ft_login.login_form.displayed? }
  expect(@selenium.title).to eq 'Alert Tracker - utang ONE'
end

When (/^FT: User waits for "(.*)" to be displayed in the top right user panel$/) do |username|
  username=process_param(username)
  @wait.until { @ft_common.user_panel.displayed? }
  expect(@ft_common.user_panel.text).to eq username
end

Given(/^FT: User logs in as "(.*)" with password "(.*)"$/) do |username, password|
  username=process_param(username)
  password=process_param(password)
  @ft_login.login_as(username,password)
  steps %(When FT: User waits for "#{username}" to be displayed in the top right user panel)
end

When(/^FT: User enters "(.*)" as username$/) do |username|
  username=process_param(username)
  @ft_login.enter_username(username)
end

When(/^FT: User enters "(.*)" as password$/) do |password|
  password=process_param(password)
  @ft_login.enter_password(password)
end

When (/^FT: User clicks the login button$/) do
  @ft_login.click_login()
end

Then (/^FT: User should see the login button is disabled$/) do
  if @ft_login.is_login_disabled() === true
    log_info "Login button is disabled"
  else
    log_exception "Login button expected to be disabled BUT was not"
  end
end

Then (/^FT: User should see the login button is enabled$/) do
  if @ft_login.is_login_disabled() === false
    log_info "Login button is enabled"
  else
    log_exception "Login button expected to be enabled BUT was not"
  end
end

Then (/^FT: User should see a login error message$/) do
  @wait.until { @ft_login.login_error.displayed? }
end

And (/^FT: User logs out$/) do
  @ft_common.logout
end

Then (/^FT: User should not see any active filters$/) do
  filters = @ft_common.get_current_filters()
  expect(filters).to be_empty
end

Then (/^FT: User (should|should not) see active column filters for the alerts section$/) do |filterFlag|
  filterFlagActual = @ft_common.anyActiveColumnFilter()
  if filterFlag == 'should'
    expect(filterFlagActual).to be_truthy
  elsif filterFlag == 'should not'
    expect(filterFlagActual).to be_falsey
  end
end

Then (/^FT: User should see the Alerts List section$/) do
  expect(@ft_common.alerts_list_panel.displayed?).to be_truthy
end

Then (/^FT: User should see (.*) flight entries in the alerts sections$/) do |num_entries_key|
  num_entries_key = num_entries_key.to_i
  num_entries_actual = @ft_common.get_num_ui_flights
  expect(num_entries_actual).to eq(num_entries_key)
end

When (/^FT: User filters alerts table by Severity value '(Low|Medium|High|Critical)'$/) do |severityValue|
  @ft_common.filter_table_by_severity(severityValue)
end

When (/^FT: User filters alerts table by Alarm Label value '(.*)'$/) do |alarmLabelValue|
  @ft_common.filter_table_by_alarmLabel(alarmLabelValue)
end

When (/^FT: User filters alerts table by Room value '(.*)'$/) do |roomValue|
  @ft_common.filter_table_by_room(roomValue)
end

When (/^FT: User filters alerts table by Delivered value '(Delivered|Not Delivered)'$/) do |deliveredValue|
  @ft_common.filter_table_by_delivered_status(deliveredValue)
end

When (/^FT: User filters alerts table by Accepted value '(Accepted|Not Accepted)'$/) do |acceptedValue|
  @ft_common.filter_table_by_accepted_status(acceptedValue)
end

Then(/^FT: User verifies the generated alert is present in alerts table with attributes "(.*)"$/) do |attributes|
  attributes=JSON.parse(attributes)
  @wait.until { @ft_common.get_alert_table_item_by_filght_id($GENERATED_ALARM_FLIGHT['id']).displayed?}
  verify_table_element(@ft_common.get_table,@ft_common.get_alert_table_item_by_filght_id($GENERATED_ALARM_FLIGHT['id']),attributes)
end

When(/^FT: User verifies the generated alert is present in alerts table with attributes$/) do |attributes|
  steps %(When FT: User verifies the generated alert is present in alerts table)
  attributes=JSON.parse(attributes)
  verify_table_element(@ft_common.get_table,@ft_common.get_alert_table_item_by_filght_id($GENERATED_ALARM_FLIGHT['id']),attributes)
end

When(/^FT: User waits unit the generated alert is present in alerts table with attributes$/) do |attributes|
  steps %(When FT: User verifies the generated alert is present in alerts table
"""
#{attributes}
""")
end

When(/^FT: User waits unit the generated alert is present in alerts table with attributes "(.*)"$/) do |attributes|
  ui_update_timeout = process_param("[props.ACMS_ALERT_GENERATED_TIMEOUT]").to_i
  wait_interval = 1
  attributes=JSON.parse(attributes)
  start_time = Time.now.to_f
  found_matches=false
  while (Time.now.to_f-start_time) < ui_update_timeout do
    begin
      steps %(When FT: User verifies the generated alert is present in alerts table)
      verify_table_element(@ft_common.get_table,@ft_common.get_alert_table_item_by_filght_id($GENERATED_ALARM_FLIGHT['id']),attributes)
      found_matches=true
      break
    rescue Exception
      log_info "Waiting for #{wait_interval} more seconds until alert with attributes'#{attributes}' is present"
      sleep wait_interval
    end
  end
  if not found_matches
    log_exception "Unable to wait until the alert has attributes '#{attributes}' during #{ui_update_timeout} seconds"
  end
end

When(/^FT: User verifies the generated alert is present in alerts table$/) do
  @wait.until { @ft_common.get_alert_table_item_by_filght_id($GENERATED_ALARM_FLIGHT['id']).displayed?}
end


When(/^FT: User opens the generated alert details$/) do
  @ft_common.get_alert_table_item_by_filght_id($GENERATED_ALARM_FLIGHT['id']).click
end

Then(/^FT: The "Total Time" field should be populated with an incrementing time elapsed label$/) do
  total_time = @ft_common.alert_table_item_attribute($GENERATED_ALARM_FLIGHT['id'], "totalTime").text
  @wait.until { @ft_common.alert_table_item_attribute($GENERATED_ALARM_FLIGHT['id'], "totalTime").text> total_time}
  expect(@ft_common.alert_table_item_attribute($GENERATED_ALARM_FLIGHT['id'], "totalTime").text > total_time)
end

Then(/^FT: User sees the "Total Time" on the flight entry stop at "(.*)" within (\d+) second range$/) do |time, elapsed_time|
  elapsed_times=@ft_common.flight_time_elapsed($GENERATED_ALARM_FLIGHT['id']).text.split(':')
  actual_time_total=elapsed_times[-2].to_i * 60 + elapsed_times[-1].to_i
  accepted_time_parts=time.split(":")
  acceptable_time_exact=accepted_time_parts[-2].to_i * 60 + accepted_time_parts[-1].to_i
  acceptable_times = [acceptable_time_exact]
  for i in 1..(elapsed_time+1)
    acceptable_times.push(acceptable_time_exact+i)
  end
  expect(acceptable_times).to include(actual_time_total)
end
