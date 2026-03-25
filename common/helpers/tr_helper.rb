require 'selenium-webdriver'
require 'webdrivers'
require_relative 'testrail'
require_relative 'props_helper'
require 'logger'
$logger=Logger.new($stdout, Logger::DEBUG)
$tr_client = TestRail::APIClient.new(get_param("TR_ADDRESS"))
$tr_client.user = get_param("TR_USERNAME")
$tr_client.password = get_param("TR_PASSWORD")


$selenium_options = Selenium::WebDriver::Chrome::Options.new
$selenium_options.add_argument('--ignore-certificate-errors')
$selenium_options.add_argument('--disable-save-password-bubble')
$selenium_options.add_argument('--capture-network-traffic') # Added by Neil.N for network traffic log testing
$selenium_options.add_option(:exclude_switches, ['enable-automation'])
$selenium_options.add_preference(:credentials_enable_service, false)
$selenium_options.add_preference(:password_manager_enabled, false)
$selenium_options.add_preference(:captureNetworkTraffic, true) # Added by Neil.N for network traffic log testing
$selenium_options.add_argument('--headless')
$selenium_options.add_argument('--no-sandbox')
$selenium_options.add_argument('--disable-gpu')
$selenium_options.add_argument('--disable-dev-shm-usage')

def tr_get_test_run(test_set_run_id, test_id)
   tr_get_test_runs(test_set_run_id,test_id).sort_by {|obj| obj["id"]}.reverse.first
end

def tr_get_test_runs(test_set_run_id, test_id)
  r = $tr_client.send_get("get_results_for_case/#{test_set_run_id}/#{test_id}")
  r.sort_by {|obj| obj["id"]}
end

def tr_get_test_run_id(test_set_run_id, test_id)
  r = $tr_client.send_get("get_tests/#{test_set_run_id}")
  r.find {|obj| obj["case_id"].to_s == test_id}['id']
end


def tr_get_tests_from_test_run(test_set_run_id, non_executed_only)
  $tr_client.send_get("get_tests/#{test_set_run_id}").find_all{|x| (x["custom_autostatus"] == 5)  && ((non_executed_only.downcase == 'false') || x["status_id"] != 1)}
end

def tr_get_case_results_from_run(test_set_run_id, case_id)
  $tr_client.send_get("get_results_for_case/#{test_set_run_id}/#{case_id}")
end

def tr_get_case(case_id)
  $tr_client.send_get("get_case/#{case_id}")
end

def tr_add_result_for_test(test_set_run_id,test_case_id,status, result_comment)
  $tr_client.send_post(
    "add_result_for_case/#{test_set_run_id}/#{test_case_id}",
    { status_id: status, comment: result_comment }
  )
end

def tr_add_results_for_set(test_set_run_id, results_json)
  $tr_client.send_post(
    "add_results_for_cases/#{test_set_run_id}",
    {results: [results_json] }
  )
end

def tr_ui_try_set_comon_passed_test_result()
  if @tr_browser.find_elements(:css, "div.step-result-inner>select").filter{|t| t.attribute("value")!="1"}.empty?
    full_test_status_element= @tr_browser.find_element(:css, "select#addResultStatus")
    if full_test_status_element.enabled?
      Selenium::WebDriver::Support::Select.new(full_test_status_element).select_by(:text, "Passed")
    end
  end
end

def tr_ui_set_test_result(testRailCaseId,status, result_comment)
  $logger.info("Setting test execution results to PASS via UI")
  @tr_browser = Selenium::WebDriver.for :chrome, capabilities: $selenium_options
  @tr_browser.manage.timeouts.implicit_wait = 4
  @tr_browser.get(get_param("TR_ADDRESS"))
  @tr_browser.find_element(:css,"input#name").send_keys(get_param("TR_USERNAME"))
  @tr_browser.find_element(:css,"input#password").send_keys(get_param("TR_PASSWORD"))
  @tr_browser.find_element(:css,"button[type='submit']").click
  @tr_browser.find_element(:xpath,".//a[.='Dashboard']").displayed?
  @tr_browser.get("#{get_param("TR_ADDRESS")}/index.php?/tests/view/#{testRailCaseId}")
  @tr_browser.find_element(:css,"a#addResult").click
  @tr_browser.find_element(:css,"textarea#addResultComment").send_keys(result_comment)
  Selenium::WebDriver::Support::Select.new(@tr_browser.find_element(:css,"select#addResultStatus")).select_by(:text, status)
  @tr_browser.find_element(:css,"button#addResultSubmit").click
  sleep 1
  @tr_browser.quit
end

def tr_ui_update_test_results(testRailCaseId,testRailCaseRunId,testRailCaseName, result_comment, previous_results)
    test_result_panel_xpath_template=".//table[@id='custom_custom_test_field_table']//td[contains(@class,'step-content')]//h2[contains(.,'%s')]/../../.."
    $logger.info("Updating test execution results via UI")
    @tr_browser = Selenium::WebDriver.for :chrome, capabilities: $selenium_options
    @tr_browser.manage.timeouts.implicit_wait = 4
    @tr_browser.get(get_param("TR_ADDRESS"))
    @tr_browser.find_element(:css,"input#name").send_keys(get_param("TR_USERNAME"))
    @tr_browser.find_element(:css,"input#password").send_keys(get_param("TR_PASSWORD"))
    @tr_browser.find_element(:css,"button[type='submit']").click
    @tr_browser.find_element(:xpath,".//a[.='Dashboard']").displayed?
    @tr_browser.get("#{get_param("TR_ADDRESS")}/index.php?/tests/view/#{testRailCaseId}")
    begin
      @tr_browser.find_element(:css,"span#editChange-#{testRailCaseRunId}").click
    rescue => e
      $logger.info("Not able to find test execution results via on UI adding a new one #{e}")
      @tr_browser.find_element(:css,"a#addResult").click
    end

    if @tr_browser.find_element(:css, "select#addResultStatus").enabled?
      Selenium::WebDriver::Support::Select.new(@tr_browser.find_element(:css, "select#addResultStatus")).select_by(:text, "In Progress")
    end

   # update current test results with the previous partial results
    unless previous_results.empty?
      previous_results.each do |prev_res|
        scenario_name= prev_res['content'].split("  ")[0].gsub("##","").strip
        puts scenario_name
        test_run_step_prev_result = @tr_browser.find_element(:xpath,test_result_panel_xpath_template % [scenario_name])
        test_run_step_prev_result_selector=Selenium::WebDriver::Support::Select.new(test_run_step_prev_result.find_element(:css,"select"))
        test_run_step_prev_result_selector.select_by(:text, "Passed")
      end
    end

   # update  full case resutl description
    if @tr_browser.find_element(:css,"textarea#addResultComment").text.empty?
      @tr_browser.find_element(:css,"textarea#addResultComment").send_keys(result_comment)
    end

   # If not all results are passing  - try to update with current result
    unless @tr_browser.find_elements(:css, "div.step-result-inner>select").filter { |t| t.attribute("value") != "1" }.empty?
      test_run_step_result = @tr_browser.find_element(:xpath, test_result_panel_xpath_template % [testRailCaseName])
      Selenium::WebDriver::Support::Select.new(test_run_step_result.find_element(:css, "select")).select_by(:text, "Passed")
    end

   # If all results are passing  - try to set all test to Pass
    tr_ui_try_set_comon_passed_test_result

    @tr_browser.find_element(:css,"button#addResultSubmit").click
    sleep 1
    @tr_browser.quit
end

def tr_ui_update_test_result(testRailCaseId,testRailCaseRunId,testRailCaseName, result_comment)
  tr_ui_update_test_results(testRailCaseId, testRailCaseRunId,testRailCaseName,result_comment,[] )
end

def tr_ui_add_test_result(test_set_run_id,test_case_id ,status, result_comment)
  case_details=tr_get_case(test_case_id)
  @tr_browser = Selenium::WebDriver.for :chrome, capabilities: $selenium_options
  @tr_browser.manage.timeouts.implicit_wait = 4
  @tr_browser.get(get_param("TR_ADDRESS"))
  @tr_browser.find_element(:css,"input#name").send_keys(get_param("TR_USERNAME"))
  @tr_browser.find_element(:css,"input#password").send_keys(get_param("TR_PASSWORD"))
  @tr_browser.find_element(:css,"button[type='submit']").click
  @tr_browser.find_element(:xpath,".//a[.='Dashboard']").displayed?
  @tr_browser.get("#{get_param("TR_ADDRESS")}/index.php?/runs/view/#{test_set_run_id}")
  @tr_browser.find_element(:xpath,".//a[.='#{ case_details["title"]}']").click
  @tr_browser.find_element(:css,"a#addResult").click
  Selenium::WebDriver::Support::Select.new(@tr_browser.find_element(:css,"select#addResultStatus")).select_by(:text, status)
  @tr_browser.find_element(:css,"textarea#addResultComment").send_keys(result_comment)
  @tr_browser.find_element(:css,"button#addResultSubmit").click
  sleep 1
  @tr_browser.quit
end

def tr_import_passed_scenario_result(_scenario, result_comment)
  tms_tag = _scenario.tags.find { |t| t.name.include?("TMS") }
  unless tms_tag.nil?
    case_id = tms_tag.name.split(":").last
    tr_do_import_passed_scenario_result(ENV['TR_EXECUTION'], case_id, _scenario.name, result_comment)
  end
end

def tr_analyze_previous_runs(run_id, case_id)
  res=tr_get_test_runs(run_id, case_id).sort_by {|obj| obj["id"]}.last
  aggregated_result=[]
  if res["status_id"] != 1 then
    unless res["custom_custom_test_field"].nil?
      aggregated_result += res["custom_custom_test_field"]
      aggregated_result = aggregated_result.uniq.filter{|t| t["status_id"]==1}
    end
  end
  aggregated_result
end

def tr_do_import_passed_scenario_result(run_id, case_id, scenario_name, result_comment)
  unless case_id.nil?
    test_run_in_set = tr_get_test_run(run_id, case_id)

    # if the first attempt to run test in test run
    if test_run_in_set.nil? || test_run_in_set["status_id"].nil? ||test_run_in_set["status_id"] == 4
      # tr_add_result_for_test(run_id, case_id,8, result_comment)
      test_id_in_test_run= tr_get_test_run_id(run_id, case_id)
      tr_ui_set_test_result(test_id_in_test_run,"In Progress",result_comment)
      test_run_in_set = tr_get_test_run(run_id, case_id)
    end

    # if parent  test is not fully passed
    if test_run_in_set["status_id"] != 1
      if test_run_in_set["custom_custom_test_field"].nil?
        #if single scenario feature-file
        tr_add_result_for_test(run_id, case_id, 1, result_comment)
      else
        #if multi-scenario feature-file
        previous_results = tr_analyze_previous_runs(run_id,case_id)
        tr_ui_update_test_results(test_run_in_set["test_id"], test_run_in_set["id"], scenario_name, result_comment,previous_results)
        test_run_in_set = tr_get_test_run(run_id, case_id)
        if test_run_in_set["custom_custom_test_field"].filter { |t| t["status_id"] != 1 }.empty?
          test_run_in_set[:case_id] = case_id
          test_run_in_set[:status_id] = 1
          tr_add_results_for_set(run_id, test_run_in_set)
        end
      end
    end
  end
end

