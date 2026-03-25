require 'rspec/expectations'
require 'rspec/core'
require 'selenium-webdriver'
require 'appium_lib'
#require 'eyes_selenium'
require 'logger'
require 'fileutils'
require 'tiny_tds'
require 'etc'

$sitenbr = ENV.fetch("SITE_NAME", '34')
Dir[File.dirname(__FILE__) + "/../../../common/**/*.rb"].each {|file| require file }
Dir[File.dirname(__FILE__) + "/../lib/views/*.rb"].each {|file| require file }
Dir[File.dirname(__FILE__) + "/../lib/helpers/*.rb"].each {|file| require file }
Dir[File.dirname(__FILE__) + "/../lib/test_data/*.rb"].each {|file| require file }

$HOME = Dir.home
$SCREENSHOT_HOME = "#{$HOME}/Documents/screenshots/iOS"
#Dir.mkdir($SCREENSHOT_HOME) unless File.exist?($SCREENSHOT_HOME)

if(File.exist?($SCREENSHOT_HOME))

else
  #puts "creating the screenshot directory"
  FileUtils.mkdir_p($SCREENSHOT_HOME)
end

include RSpec::Matchers
include Common
include QA_Integration_site50
include QA_Site_34
#include QA_Site_39
include Appium_lib
include GS_Registration
include AMP_API
include KEYBOARD

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end

$eyes ||= nil

$install_software = ENV.fetch("INSTALL_SOFTWARE", 'false')

$debug_flag = ENV.fetch("DEBUG_FLAG", 'warn')
$as_version = ENV.fetch("AS_VERSION", get_param("COMMON_ABOUT_APP_VERSION"))
$is_7x_version = $as_version.start_with?"7."
$as_man_date = ENV.fetch("AS_MAN_DATE", get_param("COMMON_ABOUT_BUILD_DATE"))
$as_build_number = ENV.fetch("AS_BUILD_NUMBER", get_param("COMMON_ABOUT_APP_BUILD"))
$as_udi = ENV.fetch("UDI", get_param("COMMON_ABOUT_APP_UDI"))

$device_name = ENV.fetch("DEVICE", 'iPhone 13')
$device_version = ENV.fetch("VERSION", '15.0')
$real_device = ENV.fetch("REALDEVICE", "false")
$build_version = ENV.fetch("BUILD_VERSION", "QA")

$platform_version = ENV.fetch("PLATFORM_VERSION", ENV['DEVICEVERSION'])
$app_path = ENV.fetch("APP_PATH", '')
$server_ip = ENV.fetch("SERVER_IP", "0.0.0.0:4723")

seleniumHub = ENV.fetch("SELENIUMHUB", 'false')
$eyes_log_param = ENV.fetch("EYES_LOGGER", 'false')
$current_user = Etc.getlogin

#explicit wait
DEFAULT_EXPLICIT_WAIT = 30

if $debug_flag == "info" || $debug_flag == "debug"
  puts "device name: #{$device_name}"
  puts "device version: #{$device_version}"
end

$siteName = "tbd"
$appUser = "test@test.com"

if $sitenbr == '34'
  $siteName = '34 QA Cardio PM'
elsif $sitenbr == 'node'
  $siteName = 'Node Simulator'
elsif $sitenbr == '35'
  $siteName = 'QA Cardio PM 35'
elsif $sitenbr == '45'
  $siteName = 'Site 45 - HCA NewDev'
elsif $sitenbr == '39'
  $siteName = '39 QA App Orchard'
elsif $sitenbr == 'Mindray'
  $siteName = 'Mindray PM'
elsif $sitenbr == 'Nihon'
  $siteName = 'Nihon Khoden'
elsif $sitenbr == 'MuseE9'
  $siteName = 'Muse9'
elsif ['Auto', 'Automation','AUTO'].include?($sitenbr)
  $siteName = 'Automation Site'
  $appUser = 'superall'
elsif ['Auto1'].include?($sitenbr)
  $siteName = 'astqaautoenv1-01'
  $appUser = 'superall'
elsif $sitenbr == 'Auto Con'
  $siteName = 'Automation Site Con'
elsif $sitenbr == 'Auto NG'
  $siteName = 'Automation Site NG'
elsif $sitenbr == 'MuseNX'
  $siteName = 'MuseNX'
elsif $sitenbr == 'Palomar'
  $siteName = 'Palomar utang ONE OB'
  USERNAME = '39054'
  PASSWORD = 'Airtech@18'
elsif $sitenbr == 'Columbus'
  $siteName = 'Columbus Regional'
  USERNAME = 'utangTECH'
  PASSWORD = 'bz6d4fgg'
else
  $siteName = $sitenbr
end

$node_sitename = $siteName
$cardio_sitename = $siteName
$cardio_censusname = "MOST RECENT"
$muse_user = "devadmin"
$muse_password = "01codE)!"

$pm_sitename = $siteName
$pm_censusname = "Census"

$sm_sitename = $siteName
$sm_censusname = "Census"

$ob_sitename = $siteName
$ob_censusname = "OB > Census"

$ob_sitename_prod = $siteName

#$siteName = testSite

def desired_capabilities
  # agent_path = "/usr/local/lib/node_modules/appium/node_modules/appium-xcuitest-driver/WebDriverAgent/WebDriverAgent.xcodeproj"
  #boot_path =  "/usr/local/lib/node_modules/appium/node_modules/appium-xcuitest-driver/WebDriverAgent"
  {
    #'deviceName' => ENV['DEVICENAME'],
    'deviceName' => $device_name,
    #'browserName' => "Safari",
    'platformName' => "iOS",
    'platformVersion' => $device_version,
    'automationName' => "XCUITest",
    'app' => $app_path,
    'screenshotWaitTimeout' => 15,
    'newCommandTimeout' => 180,
    'launchTimeout' => 60,
    'noReset' => true,
    'fullReset' => false,
    #'sendKeyStrategy' => 'oneByOne',
    'sendKeyStrategy' => 'grouped',
    #'sendKeyStrategy' => 'setValue',
    'useNewWDA' => false,
    'isHeadless' => false,
    'connectHardwareKeyboard' => false,
    'scaleFactor' => '0.5',
    'clearSystemFiles' => true,
    'xcodeConfigFile' => File.dirname(__FILE__) + "/myconfig.xcconfig",
    #'allowTouchIdEnroll' => true,
    'simpleIsVisibleCheck' => true,
    'keepKeyChains' => true,
    'showIOSLog' => false,
    'useJSONSource' => true,
    'boundElementsByIndex' => true,
    #'printPageSourceOnFindFailure' => true,
    ##'agentPath' => agent_path,
    ##'bootstrapPath' => boot_path,

    #'shouldUseSingletonTestManager' => false,
    ##'udid' => ENV['UDID'],
    'shutdownOtherSimulators' => true,
    "appium:settings[pageSourceExcludedAttributes]"=> "accessible",
    "appium:settings[snapshotMaxDepth]"=> "60"

  }
end

def appium_opts
  {
    #server_url: "http://#{$server_ip}/wd/hub"
    :server_url => "http://#{$server_ip}/wd/hub"
  }
end


Before do |scenario|
  #`defaults write com.apple.iphonesimulator ConnectHardwareKeyboard -bool NO`
  #@DEVICE_NME = ENV['DEVICENAME']
  $device_name = ENV['DEVICE']
  $device_plat= ENV['VERSION']

  #$device_plat = ENV['VERSION']

  #puts "###### #{@$device_name} ... #{$device_plat} ..."
  $D_PLATFORM = $device_plat

  desired_capabilities['name'] = scenario.name
  @appiumDriver = Appium::Driver.new({:caps => desired_capabilities, :appium_lib => appium_opts}, true)
  execute_command("xcrun --sdk iphonesimulator --show-sdk-version")
  @seleniumDriver = @appiumDriver.start_driver
  $GLOBAL_APPIUM=@seleniumDriver
  @appiumDriver.set_wait 5

  @wait = Selenium::WebDriver::Wait.new(timeout: DEFAULT_EXPLICIT_WAIT) #DEFAULT_EXPLICIT_WAIT timeout in secs

  def wait_for(timeout=DEFAULT_EXPLICIT_WAIT_FOR)
    Selenium::WebDriver::Wait.new(timeout: timeout).until { yield }
  end

  #@wait = @appiumDriver.manage.timeouts.implicit_wait = DEFAULT_EXPLICIT_WAIT
   app_bundle= get_param("COMMON_APP_BUNDLE")
   @appiumDriver.terminate_app(app_bundle)
   @appiumDriver.activate_app(app_bundle)
  if ENV['TEST_ENV_NUMBER'].nil? || ENV['TEST_ENV_NUMBER'].empty?
    worker='1'
  else
    worker=ENV['TEST_ENV_NUMBER']
  end
  $logger.info 'THREAD #'+worker+': ['+Time.now.to_s+'] Test started: '+ scenario.name
end

def selenium
  @seleniumDriver
end

def appium
  @appiumDriver
end

After do |_scenario|
  if _scenario.failed? and !@appiumDriver.nil?
      reports_location=(ENV['REPORT_FOLDER'].nil? || ENV['REPORT_FOLDER'].empty?)?'docs':ENV['REPORT_FOLDER']
      screenshot_file=Time.now.strftime('%Y-%m-%d_%H.%M.%S.png')
      encoded_img = @appiumDriver.screenshot("#{reports_location}/screenshots/"+screenshot_file)
      Allure.add_attachment(name: 'Screenshot', source: encoded_img, type: Allure::ContentType::PNG, test_case: true)
      attach "#{reports_location}/screenshots/"+screenshot_file,'image/png'
    end
  @appiumDriver.driver_quit
end



