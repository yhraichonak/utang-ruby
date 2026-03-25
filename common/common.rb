require 'allure-cucumber'
require 'inifile'
require 'active_support/time'
require 'pp'
require 'logger'
require 'date'
require 'webdrivers'

if ENV['THREAD_INDEX'].nil?
  THREAD_INDEX=""
  if ENV['TEST_ENV_NUMBER'] == ""
    THREAD_INDEX="1"
  else unless ENV['TEST_ENV_NUMBER'].nil?
         THREAD_INDEX = ENV['TEST_ENV_NUMBER']
       end
  end
else
  THREAD_INDEX= ENV['THREAD_INDEX']
end

webdriverInstallDirPath = ENV['WEBDRIVER_INSTALL_DIR'] || File.expand_path('~/.webdrivers/')

Webdrivers.install_dir = File.expand_path("#{webdriverInstallDirPath}" + THREAD_INDEX.to_s)
if ENV['CHROMEDRIVER_LOCATION'].nil? || ENV['CHROMEDRIVER_LOCATION'].empty?
  if ENV['CHROMEDRIVER_VERSION'].nil? || ENV['CHROMEDRIVER_VERSION'].empty?
    puts "Trying to use latest available chromedriver"
  else
    puts "Using specific chromedriver version #{ENV['CHROMEDRIVER_VERSION']}"
    Webdrivers::Chromedriver.required_version = ENV['CHROMEDRIVER_VERSION']
  end
else
  puts "Using specific chromedriver path #{ENV['CHROMEDRIVER_LOCATION']}"
  Selenium::WebDriver::Chrome::Service.driver_path=ENV['CHROMEDRIVER_LOCATION']
end

if ENV['EDGEDRIVER_LOCATION'].nil? || ENV['EDGEDRIVER_LOCATION'].empty?
  if ENV['EDGEDRIVER_VERSION'].nil? || ENV['EDGEDRIVER_VERSION'].empty?
    puts "Trying to use latest available edgedriver"
  else
    puts "Using specific chromedriver version #{ENV['EDGEDRIVER_VERSION']}"
    Webdrivers::Edgedriver.required_version = ENV['EDGEDRIVER_VERSION']
  end
else
  puts "Using specific edge driver path #{ENV['EDGEDRIVER_LOCATION']}"
  Selenium::WebDriver::Edge::Service.driver_path=ENV['EDGEDRIVER_LOCATION']
end

def not_dry_run()
  result=(ENV["DRY_RUN"].nil? or ENV["DRY_RUN"].downcase.include?('false'))
  return result
end

Before do
  begin
    $TEST_DATA_MAP={}
    if ENV['ENV_CUSTOM_URL'].nil? or ENV['ENV_CUSTOM_URL'].strip.empty?
      unless defined?(SITE_NAME).nil?
        # SERVER_URL required for API calls from mobile test automation
        if SITE_NAME.include?('34')
          SERVER_URL = 'http://site34.asttesthost01.utangtech.com/as1/rc/#/'
        elsif SITE_NAME.include?('35')
          SERVER_URL = 'http://site35.asttesthost01.utangtech.com/as1/rc/#/'
        elsif SITE_NAME.downcase.include?('auto')
          SERVER_URL = process_param("[props.COMMON_SERVER_URL]")
        end
      end
    else
      ENV['COMMON_SERVER_IP'] = "UNKNOWN"
      ENV['COMMON_SERVER_DB_ADDRESS'] = "UNKNOWN"
      SERVER_URL=ENV['ENV_CUSTOM_URL'].strip
    end

    CONFIG_JSON = JSON.parse(RestClient.get(SERVER_URL.gsub('/#/','')+'/config.json'))
    SITE_ID = "#{CONFIG_JSON['siteid']}"
    SUPER_USERNAME = process_param("[props.SU_USERNAME]")
    SUPER_PASSWORD = process_param("[props.SU_PASSWORD]")
  rescue
    puts 'Unable to access config.json file form test site'
    SITE_ID = -1
  end
end


After do |_scenario|
  featureName = _scenario.location.file.to_s
  Allure.replace_label("thread",THREAD_INDEX)
  raw_results_folder= (ENV["REPORT_FOLDER"]==nil)?"":(ENV["REPORT_FOLDER"]+"/")
  if  not_dry_run
    if _scenario.passed?
      passed_features_report_v2 = "#{raw_results_folder}passed_v2.txt"
      `touch #{passed_features_report_v2}`
      tms_tag = _scenario.tags.find { |t| t.name.include?("TMS") }
      unless tms_tag.nil?
        case_id = tms_tag.name.split(":").last
      end
      read_mode= File.exist?(passed_features_report_v2)? 'a':'w'
      if read_mode == 'a'
        if !File.readlines(passed_features_report_v2).grep(/#{featureName}:#{_scenario.location.line}/).any?
          open(passed_features_report_v2, read_mode) {|f|  f.puts   "#{featureName}::#{_scenario.location.line}::#{_scenario.name}::#{case_id}"}
        end
      else
        open(passed_features_report_v2, read_mode) {|f|  f.puts   "#{featureName}::#{_scenario.location.line}::#{_scenario.name}::#{case_id}"}
      end
      if  !ENV["TR_RUNTIME_EXPORT"].nil? and (ENV["TR_RUNTIME_EXPORT"].downcase == "true")
        begin
          if _scenario.location.to_s.start_with?("iOS")
            tr_import_passed_scenario_result(_scenario, "iOS: device: #{ENV['DEVICE']}, platform: #{ENV['VERSION']}, appVersion: #{ENV['AS_VERSION']}, appBuild: #{ENV['AS_BUILD_NUMBER']}, site:#{ENV['SITE_NAME']}")
          elsif _scenario.location.to_s.start_with?("android")
            tr_import_passed_scenario_result(_scenario, "Android: device: #{ENV['DEVICE']}, appVersion: #{ENV['AS_VERSION']}, appBuild: #{ENV['AS_BUILD_NUMBER']}, site:#{ENV['SITE_NAME']}")
          elsif _scenario.location.to_s.match?("(ACMS|ATC|AAM)")
            tr_import_passed_scenario_result(_scenario,process_param("Verified. App Version: #{ENV['APP_VERSION'] }\nBuild Number: #{ENV['APP_BUILD']}\nBrowser: #{BROWSER} #{ENV['BROWSER_VERSION'] || 'latest'} \nAD_URL: [props.ACMS_AD_URL]\nAT_URL: [props.ACMS_AT_URL]"))
          else
            tr_import_passed_scenario_result(_scenario, "Browser Type: #{BROWSER} \nBrowser Version: #{ENV['BROWSER_VERSION'] || 'latest'} \nTest Env: #{ENV['ENVIRONMENT'] } \nBranch: #{ ENV['BRANCH']} \nSite Url: #{SERVER_URL} \nApp Version: #{ENV['APP_VERSION'] } \nBuild Number: #{ENV['APP_BUILD']} ")
          end

        rescue => e
          puts("Unable to export test results to TR (will be placed under passed*.txt file). #{e}")
        end
      end
    end
    all_features_report = "#{raw_results_folder}testsRun.txt"
    all_features_report2 = "#{raw_results_folder}testsRun_v2.txt"
    read_mode= File.exist?(all_features_report)? 'a':'w'
    `touch #{all_features_report} #{all_features_report2}`
    if !File.readlines(all_features_report2).grep(/#{featureName}::#{_scenario.location.line}/).any?
      open(all_features_report2, read_mode) { |f| f.puts "#{featureName}::#{_scenario.location.line}" }
    end

    if !File.readlines(all_features_report).grep(/#{featureName}/).any?
      open(all_features_report, read_mode) { |f| f.puts "#{featureName}" }
    end

    failed_features_report = "#{raw_results_folder}failed.txt"
    failed_features_report_v2 = "#{raw_results_folder}failed_v2.txt"
    if _scenario.failed?
      read_mode= File.exist?(failed_features_report_v2)? 'a':'w'
      if read_mode == 'a'
        if !File.readlines(failed_features_report_v2).grep(/#{featureName}::#{_scenario.location.line}/).any?
          open(failed_features_report, read_mode) {|f|  f.puts  featureName}
          open(failed_features_report_v2, read_mode) {|f|  f.puts   "#{featureName}::#{_scenario.location.line}"}
        end
      else
        open(failed_features_report, read_mode) {|f|  f.puts  featureName}
        open(failed_features_report_v2, read_mode) {|f|  f.puts   "#{featureName}::#{_scenario.location.line}"}
      end
    elsif _scenario.passed?
      if File.exist?(failed_features_report)
        other_failed_features = File.readlines(failed_features_report).select { |ln| !ln.include?(featureName) }
        IO.write(failed_features_report, other_failed_features.join(''))
      end
    end
    if ENV['TEST_ENV_NUMBER'].nil? || ENV['TEST_ENV_NUMBER'].empty?
      worker='1'
    else
      worker=ENV['TEST_ENV_NUMBER']
    end
    log  'THREAD #'+worker+': ['+Time.now.to_s+'] Test finished: '+ _scenario.name+' - ['+_scenario.status.to_s.upcase+']'
    log_info _scenario.location.to_s
  end
end
$logger=Logger.new($stdout, Logger::DEBUG)

def execute_command(command)
  execute_command_with_output(command,true)
end
def execute_command_with_output(command,print_output)
  log_info "Executing command [#{command}]"
  output=%x|#{command}|
  log_info "Output: #{output}" if print_output
  output
end
  def wait_for_host_port(host, port, timeout)
    system("timeout #{timeout} sh -c 'until nc -z $0 $1; do sleep 1; echo waiting for #{host}:#{port}; done' #{host} #{port}")
    $?.exitstatus == 0
  end

def execute_command_no_wait(command)
  log_info "Executing command without waiting [#{command}]"
  $ALARM_PID=Process.spawn(command)
  $ALARM_PIDS.push($ALARM_PID)
end

def log_info(message)
  if ENV['TEST_ENV_NUMBER'].nil? || ENV['TEST_ENV_NUMBER'].empty?
    worker = '1'
  else
    worker = ENV['TEST_ENV_NUMBER']
  end
  $logger.info "THREAD # #{worker}: [ #{Time.now}] #{message}\n"
end

def log_exception(message)
  if ENV['TEST_ENV_NUMBER'].nil? || ENV['TEST_ENV_NUMBER'].empty?
    worker = '1'
  else
    worker = ENV['TEST_ENV_NUMBER']
  end
  raise "THREAD # #{worker}: [ #{Time.now}] #{message}\n"
end

def log_error(message)
  log_exception(message)
end

AllureCucumber.configure do |config|
  config.clean_results_directory = false
  config.results_directory = '/docs/allure'
  config.logging_level = Logger::INFO
  config.logger = Logger.new($stdout, Logger::DEBUG)
  config.environment = 'environment'

  # these are used for creating links to bugs or test cases where {} is replaced with keys of relevant items
  config.link_tms_pattern = 'http://qa-app-01/testrail/index.php?/cases/view/{}'
  config.link_issue_pattern = 'https://utang.atlassian.net/browse/{}'

  # additional metadata
  # environment.properties
  config.environment_properties = {
    custom_attribute: 'foo'
  }
  # categories.json
  # config.categories = File.new("my_custom_categories.json")

end
