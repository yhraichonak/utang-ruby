
require 'rspec'
require 'selenium-webdriver'
require 'tiny_tds'
require 'dotenv/load'
require 'date'
require 'time'
require 'webdrivers'
require 'json'
require 'allure-cucumber'
require 'etc'
require 'rest-client'
require 'sys/proctable'

include Common

$WORKING_DIR = "#{Dir.pwd}/"
user = Etc.getlogin

Before do |scenario|
  if !scenario.tags.to_s.include?("@utility") && !scenario.tags.to_s.include?("@atc_api")
    DEFAULT_IMPLICIT_WAIT = 10
    DEFAULT_EXPLICIT_WAIT = 20
    log_info 'Test started: ' + scenario.name
    browser_options = BrowserOptions.new.preferences(BROWSER)
    if (HEADLESS.downcase.include? 'true')
      browser_options.add_argument('--headless')
      browser_options.add_argument('--no-sandbox')
      browser_options.add_argument('--disable-gpu')
      browser_options.add_argument('--disable-dev-shm-usage')
    end
      case BROWSER
      when 'chrome'
        begin
           @selenium = Selenium::WebDriver.for :chrome, capabilities: browser_options
        rescue  => e
          raise e unless e.to_s.include?("file busy")
          sleep 1
          @selenium = Selenium::WebDriver.for :chrome, capabilities: browser_options
        end
      when 'edge'
        @selenium = Selenium::WebDriver.for :edge, capabilities: browser_options

      def wait_for(timeout=DEFAULT_EXPLICIT_WAIT_FOR)
        Selenium::WebDriver::Wait.new(timeout: timeout).until { yield }
      end

    end

    @selenium.manage.timeouts.implicit_wait = DEFAULT_IMPLICIT_WAIT
    @selenium.manage.timeouts.page_load = 60
    @selenium.manage.window.resize_to(1280, 1600) if BROWSER == 'chrome' || BROWSER == 'edge' || BROWSER == 'ie' || BROWSER == 'safari'
    @wait = Selenium::WebDriver::Wait.new(timeout: DEFAULT_EXPLICIT_WAIT)
  end
end

After do |_scenario|
  Allure.replace_label("thread",THREAD_INDEX)
  unless $ALARM_PIDS.empty?
    alarm_generator_killer_script="#{process_param("[props.ACMS_TOOLS_PATH]")}/kill_alert_generator.ps1"
    alert_generation_killer_command= "ssh -t -t #{$SSH_CONNECTION_URL} \"PowerShell #{alarm_generator_killer_script}\""
    execute_command_no_wait(alert_generation_killer_command)
  end
  # TODO: technical timeout to disable alert merge feature
  # sleep(5)
  # $ALARM_PIDS.each do |pid|
  #   begin
  #     `pkill -TERM -P #{pid}`
  #     Process.kill("TERM",pid)
  #   rescue
  #      puts "Something went wrong while killing the process"
  #   end
  # end
  $ALARM_PIDS=[]
  all_features_report = 'testsRun.txt'
  featureName = _scenario.location.file.to_s
  if File.exist?(all_features_report)
    if !File.readlines(all_features_report).grep(/#{featureName}/).any?
        open(all_features_report, 'a') do |f|
          f.puts featureName
        end
    end
  else
    open(all_features_report, 'w') do |f|
      f.puts featureName
    end
  end
  failed_features_report = 'failed.txt'
  if _scenario.failed?

    if File.exist?(failed_features_report)
      if !File.readlines(failed_features_report).grep(/#{featureName}/).any?
        open(failed_features_report, 'a') do |f|
          f.puts  featureName
        end
      end
    else
      open(failed_features_report, 'w') do |f|
        f.puts featureName
      end
    end
    if (_scenario.exception!=nil) && !_scenario.exception.to_s.include?("See diff above") && !_scenario.tags.to_s.include?("@atc_api")
      screenshotFile = Time.now.strftime('%Y-%m-%d_%H.%M.%S.png')
      encoded_img = @selenium.save_screenshot('docs/screenshots/' + screenshotFile)
      Allure.add_attachment(name: 'Screenshot', source: encoded_img, type: Allure::ContentType::PNG, test_case: true)
      attach 'docs/screenshots/' + screenshotFile,'image/png'
    end
    elsif _scenario.passed?
           if File.exist?(failed_features_report)
             other_failed_features = File.readlines(failed_features_report).select { |ln| !ln.include?(featureName) }
             IO.write(failed_features_report, other_failed_features.join(''))
         end
    end
  log_info  'Test finished: ' + _scenario.name + ' - [' + _scenario.status.to_s.upcase + ']'
  log_info _scenario.location.to_s
  USERNAME = nil
  @selenium.quit unless @selenium.nil?
end

AllureCucumber.configure do |config|
  config.clean_results_directory = false
  config.results_directory = '/docs/allure'
  config.logging_level = Logger::INFO
  config.logger = Logger.new($stdout, Logger::DEBUG)
  config.environment = 'environment'
  config.link_tms_pattern = 'http://qa-app-01/testrail/index.php?/cases/view/{}'
  config.link_issue_pattern = 'https://utang.atlassian.net/browse/{}'
  config.environment_properties = {
    custom_attribute: 'foo'
  }
end
