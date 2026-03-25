# frozen_string_literal: true

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

Dir[File.dirname(__FILE__) + '/../lib/helpers/*.rb'].each {|file| require file }
include Common

$WORKING_DIR = "#{Dir.pwd}/"
$BROWSER_PROXY_PORT = get_param("COMMON_BROWSER_PROXY_PORT")
$BROWSER_PROXY_HOST = get_param("COMMON_BROWSER_PROXY_HOST")
$BROWSER_PROXY_URL = "http://#{$BROWSER_PROXY_HOST}:#{$BROWSER_PROXY_PORT}"
user = Etc.getlogin


Before('@pre_backup_server_config') do
  log_info("Backing up server config.json ...")
  steps %(
  When User backs up test environment config.json file
  )
end

After('@post_restore_server_config') do
  log_info("Restoring up server config.json ...")
  steps %(
  When User restores backed up test environment config.json file
  And restart WebClient service
  )
end
Before('@mock') do
    wiremock_start_timeout = 5
    log_info("Starting WireMock ...")
    wiremock_root_dir = File.dirname(__FILE__)+"/../../../mock"
    start_mock_script = "java -jar #{wiremock_root_dir}/wiremock-standalone-3.4.1.jar --enable-browser-proxying --port #{$BROWSER_PROXY_PORT} --root-dir #{wiremock_root_dir} > #{wiremock_root_dir}/wiremock.log 2>&1"
    $WIREMOCK_PID = Process.spawn(start_mock_script)
    raise "Unable to wait until Wiremock is up" unless wait_for_host_port($BROWSER_PROXY_HOST,$BROWSER_PROXY_PORT.to_i,wiremock_start_timeout)
end

Before do |scenario|
  PROXY = ENV.fetch('PROXY', 'false')
  PASSWORD =  process_param("[props.SU#{THREAD_INDEX}_PASSWORD]")
  log_info 'Test started: ' + scenario.name
  browser_options = BrowserOptions.new.preferences(BROWSER)
  if PROXY.downcase.include? 'true' and scenario.tags.to_s.include?("mock")
    log_info("Using proxy settings --proxy-server=#{$BROWSER_PROXY_URL}")
    browser_options.add_argument("--proxy-server=#{$BROWSER_PROXY_URL}")
  end
  if HEADLESS.downcase.include? 'true'
    # Custom fix for Chrome 120 + in headless mode
    browser_options.add_argument('--headless=new')
    browser_options.add_argument('--no-sandbox')
    browser_options.add_argument('--disable-gpu')
    browser_options.add_argument('--disable-dev-shm-usage')
    #browser_options.add_argument('--remote-allow-origins=*')
  end
  if GRID == true
    @selenium = Selenium::WebDriver.for(
      :remote,
      url: GRID_HUB_URL,
      capabilities: browser_options
    )
  elsif SAUCELABS == true # use GRID before SAUCELABS if both true
    remote_options = RemoteOptions.new.preferences(BROWSER)
    capabilities = Selenium::WebDriver::Remote::Capabilities.send(BROWSER, SauceLabs.new.options(remote_options['remote_browser'], remote_options['selenium_ver']))
    @selenium = Selenium::WebDriver.for(
      :remote,
      url: 'https://scott.gillenwater:c0bc365bd6754690a217cef7d3374d8e@ondemand.us-west-1.saucelabs.com:443/wd/hub',
      capabilities: capabilities
    )
  else # use local machine if not remote machines
    case BROWSER
    when 'chrome'
      @selenium = Selenium::WebDriver.for :chrome, capabilities: browser_options
    when 'ie'
      @selenium = Selenium::WebDriver.for :ie, capabilities: browser_options
    when 'edge'

      # if user == "scottgillenwater"
      #   driver_dir = '/Users/scottgillenwater/Downloads/edgedriver_mac64_4'
      # elsif user == "raytrejo"
      #   driver_dir = '/Users/raytrejo/Downloads/edgedriver_mac64'
      # elsif user == "yhraichonak"
      #   driver_dir = '/Users/yhraichonak/Downloads/edgedriver_mac64'
      # elsif user == "colekuzawa"
      #   driver_dir = '/Users/colekuzawa/Downloads/edgedriver_mac64'
      # end

       # Webdrivers.install_dir = '/Users/yhraichonak/WORK/'

      @selenium = Selenium::WebDriver.for :edge, capabilities: browser_options
    when 'safari'
      @selenium = Selenium::WebDriver.for :safari # , capabilities: browser_options
    else # for mobile device emulation on chrome (see chrome emulator devices)
      options = Selenium::WebDriver::Chrome::Options.new
      options.add_emulation(device_name: 'iPad Pro')
      options.add_emulation(device_metrics: { width: 1024, height: 1366, pixelRatio: 2, touch: true })
      @selenium = Selenium::WebDriver.for :chrome, capabilities: options
    end

    def wait_for(timeout=DEFAULT_EXPLICIT_WAIT_FOR)
      Selenium::WebDriver::Wait.new(timeout: timeout).until { yield }
    end

  end

  $logger.info "browser: #{BROWSER}"
  @selenium.manage.timeouts.implicit_wait = DEFAULT_IMPLICIT_WAIT
  @selenium.manage.timeouts.page_load = 60
  @selenium.manage.window.resize_to(1280, 900) if BROWSER == 'chrome' || BROWSER == 'edge' || BROWSER == 'ie' || BROWSER == 'safari'
  @wait = Selenium::WebDriver::Wait.new(timeout: DEFAULT_EXPLICIT_WAIT)
  @selenium.navigate.to(SERVER_URL)
  if (defined? $about_info).nil?
   @selenium.find_element(:css,"img[alt='About']").click
   labeled_title_xpath = ".//span[@class='label' and .='%s']/following-sibling::span"
   $about_info = {"BUILD_NUMBER":@selenium.find_element(:xpath,labeled_title_xpath % ["Build Number"]).text,
                  "UDI":@selenium.find_element(:xpath,labeled_title_xpath % ["UDI"]).text }
   $app_build_number=$about_info["BUILD NUMBER"]
   @selenium.find_element(:xpath,".//button[.='Done']").click
  end
end

After do |_scenario|
  # featureName = _scenario.location.file.to_s
  # Allure.replace_label("thread",THREAD_INDEX)

  wiremock_file=File.dirname(__FILE__) + "/../../../mock/wiremock.log"
  # if File.file?(wiremock_file)
  #   log_info("Wiremock output: #{File.read(wiremock_file)}")
  # end
  unless $WIREMOCK_PID.nil?
    begin
    `pkill -TERM -P #{$WIREMOCK_PID}`
     Process.kill("TERM", $WIREMOCK_PID)
    rescue
      $WIREMOCK_PID=nil
    end
  end

  begin
   Process.kill("KILL",$ALARM_PID) unless $ALARM_PID.nil?
  rescue
    $ALARM_PID=nil
  end
  PATIENT=DEFAULT_PATIENT
  if _scenario.failed?
    screenshot_file = Time.now.strftime('%Y-%m-%d_%H.%M.%S.png')
    encoded_img = @selenium.save_screenshot('docs/screenshots/' + screenshot_file)
    Allure.add_attachment(name: 'Screenshot', source: encoded_img, type: Allure::ContentType::PNG, test_case: true)
    attach 'docs/screenshots/' + screenshot_file,'image/png'
  end

  if INFO == true
    $logger.info '-----------'
    # puts env_info
    $logger.info "App Version:  #{$app_version}"
    $logger.info "Build Number:  #{$app_build_number}"
    $logger.info '-----------'
  end

  USERNAME = nil
  @selenium.quit
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

Before('@network_logs') do
  log_info("Enabling API recording ...")
  steps %(
  When User enable API traffic recording
)
end

