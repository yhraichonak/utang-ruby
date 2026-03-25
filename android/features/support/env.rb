require 'rspec/core'
require 'rspec/expectations'
require 'selenium-webdriver'
require 'json'
require 'time'
require 'httparty'
require 'appium_lib'
require 'appium_lib_core'
# require 'eyes_selenium'
require 'logger'
require 'net/scp'
require 'net/sftp'
require 'date'
require 'benchmark'

$ANDROID = 'android'
$APK = 'apk'
$DEBUG_STRING = 'DEBUG'
$EMULATOR = 'emulator'
$IOS = 'ios'
$IPA = 'ipa'
$RUN_STRING = 'RUN'
$SERVER_IP = 'SERVER_IP'

Dir[File.dirname(__FILE__) + '/../lib/views/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../lib/helpers/*.rb'].each {|file| require file }

$HOME = Dir.home
$WORKING_DIR = Dir.pwd.split('/android')[0]

$BUILD_DIR = "#{$WORKING_DIR}/build"
$BUILD_DIR_AS = "#{$HOME}/development/builds/as1/android/"
$USERNAME = ENV['USER']
$RUNTIME = if ENV['RUBYLIB'] =~ /ruby-debug-ide/ then $DEBUG_STRING else $RUN_STRING end

include AMP_API
include Common
include Constants
include DeviceExtensions
include ElementHasher
include Global_Services
include RSpec::Matchers

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end

SERVER_TIMEOUT ||= if $RUNTIME == $DEBUG_STRING then 6000 else 180 end

bundle_type = if $BUILD_DIR.include($ANDROID) then $APK
              elsif $BUILD_DIR.include($IOS) then $IPA
              end

bundle_path = Dir.glob("#{$BUILD_DIR}/*.#{bundle_type}").max_by {|f| File.mtime(f)}
bundle_path_as = Dir.glob("#{$BUILD_DIR_AS}/*.#{bundle_type}").max_by {|f| File.mtime(f)}
bundle_path_old = Dir.glob("/Users/#{$USERNAME}/Downloads/*.#{bundle_type}").max_by {|f| File.mtime(f)}
vm_user_list = %w[devadmin01 vent qaautomation]
application_path =
  if vm_user_list.include? $USERNAME
    bundle_path_as
  elsif bundle_path != nil then bundle_path
  elsif bundle_path_old != nil then bundle_path_old
  else
    begin
      if (ENV["DRY_RUN"].nil? or ENV["DRY_RUN"].downcase.include?('false'))
        raise ArgumentError.new("Failed to assign a valid '.#{bundle_type}' bundle_path.")
      end
    rescue ArgumentError => e
      puts e.to_s
    end
  end

# device = $EMULATOR
# SCREEN_PATH = "/Users/#{$USERNAME}/Documents/screenshots"
$NAME_OF_SITE = String
$CI_SITE = String
$STYPE = String

DEBUG_FLAG = ENV.fetch('DEBUG_FLAG', 'info') # was: 'info'
if (ENV["DRY_RUN"].nil? or ENV["DRY_RUN"].downcase.include?('false'))
  DEVICE = TESTRAIL_ID = ENV['DEVICE'] || `adb shell getprop ro.kernel.qemu.avd_name`
  emulators_list_cmd = Dir.pwd + '/android/features/lib/helpers/shell/get_android_devices_uids.sh ' + DEVICE

  $UDID = `sh #{emulators_list_cmd}`
  if $UDID.nil? or $UDID.empty?
    all_emulators_cmd = Dir.pwd + '/android/features/lib/helpers/shell/get_android_devices_uids.sh'
    all_emulators = `sh #{all_emulators_cmd}`
    # if all_emulators.strip == ""
    #   raise "No simulators detected. Make sure that target device/emulator is up and running"
    # end
    raise 'Unknown device is specified ' + DEVICE + ". Known devices:\n" + all_emulators + '.' # Using first available device "+all_emulators.split(" ")[0]
    # $UDID=all_emulators.split(" ")[0]
  else
    $UDID = $UDID.strip
  end
end
TESTRAIL_ID = ENV.fetch('TESTRAIL_ID', nil)
AS_BUILD_VER = ENV.fetch('AS_BUILD_VER', '6.10.2')
AS_BUILD_NUM = ENV.fetch('AS_BUILD_NUM', '1706')
SITE_NAME = ENV.fetch('SITE_NAME', ENV.fetch('SITE_NAME_CI', 'Auto'))
SITE_NAME_CI = SITE_NAME
VIDEO_REC = ENV.fetch('VIDEO_REC', 'true') # Can be set 'true' or 'false'

SERVER_IP = ENV.fetch('SERVER_IP', '0.0.0.0:4723')
APP_PATH = ENV.fetch('APP_PATH', application_path)
APP_PACKAGE = ENV.fetch('APP_PACKAGE', 'com.utang.one.qa')
seleniumHub = ENV.fetch('SELENIUMHUB', 'false')
$PLATFORM_VERSION = ENV.fetch('PLATFORM_VERSION', ENV['VERSION'])

$debug_flag = ENV.fetch('DEBUG_FLAG', 'info')
$first_run = true

$DEVICE_BUILD_VERSION = `adb -s '#{$UDID}' shell getprop ro.build.version.release`.to_s

# Session Archive Routine
$DATE = Common.cur_time('date')
$TIME = Common.cur_time('time')
$SESSIONS_BASE_DIR = "#{$WORKING_DIR}/sessions"
$ARCHIVE_DIR = "#{$SESSIONS_BASE_DIR}/_archive"
Common.validate_dir($ARCHIVE_DIR)
Common.archive_session_folders($SESSIONS_BASE_DIR, $ARCHIVE_DIR) if $USERNAME == 'neilnorton'
# Common.archive_removal(days_over=7)
$RSD == true
$ResultProcess = ResultProcess.new
SITE_TYPE = String
def desired_capabilities #https://kobiton.com/blog/understanding-appium-desired-capabilities/ List of Appium Capabilities
  {
    # 'deviceName' => DEVICE,
    '$UDID' => $UDID.strip,
    'platformName' => 'Android',
    'automationName' => 'uiautomator2',
    'uiautomator2ServerLaunchTimeout' => '20000',
    'bundleId' => 'com.utang.one.qa',
    'appActivity' => 'com.utang.one.ui.user.WelcomeActivity',
    'platformVersion' => $DEVICE_BUILD_VERSION,
    'app' => APP_PATH,
    'appPackage' => APP_PACKAGE,
    'sendKeyStrategy' => 'oneByOne',
    'newCommandTimeout' => SERVER_TIMEOUT,
    'launchTimeout' => 60,
    'noReset' => true,
    'fullReset' => false,
    'autoAcceptAlerts' => true,
    'log-level' => 'debug',
    'clearDeviceLogsOnStart' => true
  }
end

def appium_opts
  {
     :server_url => "http://#{SERVER_IP}/wd/hub"
    # :server_url => "https://yhraichonak:14ac06c2-ca28-4780-9fec-419dfefc0451@api.kobiton.com/wd/hub"
  }
end

Before do |scenario|
  DEFAULT_EXPLICIT_WAIT ||= 20
  DEFAULT_EXPLICIT_WAIT_FOR ||= 5
  @wait = Selenium::WebDriver::Wait.new(timeout: DEFAULT_EXPLICIT_WAIT)
  if (ENV["DRY_RUN"].nil? or ENV["DRY_RUN"].downcase.include?('false'))
    desired_capabilities['name'] = scenario.name
    desired_capabilities['wait_timeout'] = scenario.name
    capab = desired_capabilities
    @appiumDriver = Appium::Driver.new({:caps => desired_capabilities, :appium_lib => appium_opts}, true)
    @seleniumDriver = @appiumDriver.start_driver
    @appiumDriver.terminate_app(APP_PACKAGE)
    @appiumDriver.activate_app(APP_PACKAGE)
    @appiumDriver.set_screen_orientation(mode = 0) # Assure portrait orientation at start of test run
    @appiumDriver.set_wait 5

    def wait_for(timeout=DEFAULT_EXPLICIT_WAIT_FORG)
      Selenium::WebDriver::Wait.new(timeout: timeout).until { yield }
    end
    $WINDOW_SIZE = @appiumDriver.window_size

    if ENV['TEST_ENV_NUMBER'].nil? || ENV['TEST_ENV_NUMBER'].empty?
      worker = '1'
    else
      worker = ENV['TEST_ENV_NUMBER']
    end
    $logger.info 'THREAD #' + worker + ': [' + Time.now.to_s + '] Test started: ' + scenario.name
  end
end

def selenium
  @seleniumDriver
end

def appium
  @appiumDriver
end

After do |_scenario|
    if _scenario.failed? and !@selenium.nil?
       screenshotFile = Time.now.strftime('%Y-%m-%d_%H.%M.%S.png')
        encoded_img = @selenium.save_screenshot('docs/screenshots/' + screenshotFile)
        Allure.add_attachment(name: 'Screenshot', source: encoded_img, type: Allure::ContentType::PNG, test_case: true)
        attach 'docs/screenshots/' + screenshotFile,'image/png'
        @appiumDriver.driver_quit
  end
end
