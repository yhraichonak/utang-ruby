require 'rest-client'
Dir[File.dirname(__FILE__) + "/../../../common/**/*.rb"].each {|file| require file }
Before do
  @Log_In_screen = Log_In_screen.new selenium, appium
  @Patient_List_screen = Patient_List_screen.new selenium, appium
  @VendorLogIn_screen = VendorLogIn_screen.new selenium, appium
  @Welcome_screen = Welcome_screen.new selenium, appium
  @Menu = Menu.new selenium, appium
  @About_window = About_window.new selenium, appium
  @Site_List_screen = Site_List_screen.new selenium, appium
end

And(/^I disable crash detection for this scenario$/) do
  puts "[CRASH] Crash inspection is now disabled for this scenario."
  $set_crash_inspection = false
end


Given(/^I open (pm-mon|pm-evt) (Ascom|Engage|Intouch|Voalte|CCF|Epic|MH|PKOB) C3PO url with payload (.*?)$/) do |target, vendor, payload|
  payload = process_param(payload)
  # Hardcoded to site 34 until automation site c3p0 is working
  # site_id = '1763'
  c3Po_url = "utangone://#{vendor.downcase}/#{target}?siteid=#{SITE_ID}&payload=#{payload}"
  # c3Po_url = "utangone://#{vendor.downcase}/#{target}?siteid=#{site_id}&payload=#{payload}"
  @selenium.navigate.to c3Po_url
end

When(/^I open (pm-mon|pm-evt) for MH C3PO url with payload (.*?)$/) do |target, payload|
  payload = process_param(payload)
  # Hardcoded to site 34 until automation site c3p0 is working
  # c3Po_url = "utangone://#{vendor.downcase}/#{target}?siteid=#{SITE_ID}&payload=#{payload}"
  c3Po_url = "utangone://mh/#{target}?siteid=#{SITE_ID}&payload=#{payload}"
  @selenium.navigate.to c3Po_url
end

When(/^I open (ecg|mrn) for epic C3PO url with payload (.*?)$/) do |target, payload|
  payload = process_param(payload)
  # Hardcoded to site 34 until automation site c3p0 is working
  # site_id = '1763'
  # c3Po_url = "utangone://#{vendor.downcase}/#{target}?siteid=#{SITE_ID}&payload=#{payload}"
  c3Po_url = "utangone://epic/#{target}?siteid=#{SITE_ID}&payload=#{payload}"
  @selenium.navigate.to c3Po_url
end

When(/^I open C3PO url$/) do
  c3Po_url = "utangone://ccf/pm-evt?siteid=1764&payload=Ci3Zyavj85Tk1ppooKzSQoX6VO5qoxT6v4Y%2BmXjYhxRIvn1e4N7S6cVLtJ6tivTw"
  # c3Po_url = "utangone://epic/ecg?siteid=4751&payload=%2Bx%2FqkWw3gw4rT%2Bs9qJqHLGl4lp9WO4vi6ef2eIT0fgKMemdXFDD0M5Ha1nBI4dpuopZhn%2F0a8RhYe73e2vWeykAzA23%2FCj0sk4rgBT%2B4QCytEg3oXVJzTNpCd6hANAcX"
  @selenium.navigate.to c3Po_url
  sleep(10)
end


And(/^I perform the screenshot for "(.*?)"$/) do |name|
  sleep 1
  @appium.screenshot "#{$SCREENSHOT_HOME}/#{name}_#{Common.cur_time}.png"
end

Then(/^I should see the "(.*?)" site name in the action bar$/) do |site_name|
  wait_for(10) { @Patient_List_screen.action_bar_tv_site_element.exists }
  expect(@Patient_List_screen.action_bar_tv_site.text).to eq(site_name)
end

Given(/^I login to the test site with "(.*?)" and "(.*?)"$/) do |username, password|
  # -1 [PRE] Config Check
  puts "Feature Name: #{$FEATURE_NAME}"
  puts "Scenario Name: #{$SCENARIO_NAME}"
  puts "TestRail Id: #{$TESTRAIL_ID}\n\n"
  $CI_SITE = Common.convert_ci_site(SITE_NAME_CI)
  username = process_param(username)
  password = process_param(password)
  Common.sitename_flag_config_check($CI_SITE)

  # if Common.first_run_check == true
  #   Common.build_config_info
  #   # PP.pp(@appium.driver.manage) # Disabled because of spam
  #   sleep(2) # First run idle wait
  # end

  # 0 [BEFORE] Wait until app has loaded, to begin login routine
  @wait.until { @Menu.action_bar.displayed? == true }
  # puts "[STARTUP] Beginning 'Startup' routine"

  # 1.0 [APP_LOGIN] Check to see if this is the first test in run
  if Common.first_run_check == true
    puts "[STARTUP] Beginning 'First Run' routine"
    reg_code_check = PyBridge.get_reg_code_from_pkg_shell

    # 1.1 [APP_LOGIN] Are we logged-in to the App?
    app_username = "test@test.com"
    window_title = @Menu.action_bar.text
    # 1.2 [APP_LOGIN] If Welcome screen displayed, we need to enter app login info
    if window_title == "Welcome"
      puts "[STARTUP] Executing 'App Login' logic"
      steps %(
        When I click Sign On button
        And I enter email "#{app_username}"
        And I enter email password "#{password}"
        And click Sign On button
      )
    end
    sleep(1)

    # 2.0 [DEVICE_REG] Is the device registered?
    # puts "[STARTUP] Executing 'Registration Code' logic"
    @RegistrationCode = PyBridge.get_reg_code_from_pkg_shell

    begin
      @RegistrationCode.split('-').count == 2
      # puts "[STARTUP] Device is already registered"
    rescue
      if reg_code_check == false
        # 2.1 [DEVICE_REG] The device isn't registered yet, let's register it
        puts "[STARTUP] Device needs to be registered"
        case $CI_SITE
        when "34 QA Cardio PM", "QA Cardio PM 35", "Muse9", "MuseNX", "Nihon Khoden", "Mindray PM"
          steps %(
            And I register devices with global services
            When I click refresh button on the Site List Screen
          )
        when "Carle Vent Dev", "Carle EMR Test", "Palomar utang ONE OB"
          steps %(
            And I register devices with prod global services
          )
        end
      end
    end

    Common.set_first_run_false
    # puts "[STARTUP] Completing 'First Run' routine"
  end

  # 3.0 [LOGIN] Are we ready to log into the test site?
  begin
    # 3.1 [LOGIN] If Site List is empty (No Data), we still need to register the device
    if wait_for(1) { @Site_List_screen.data_not_found.text == 'Data Not Found' }
      puts "[STARTUP] Executing 'Device Registration' logic"
      steps %(
        And I register devices with global services
        When I click refresh button on the Site List Screen
      )
    end
  rescue
    # puts "[STARTUP] 'Device Registration' state: OK"
  end

  # puts "[STARTUP] Executing 'Site Login' logic"

  # 3.1.1 [LOGIN] Are we logged into the correct user?
  last_user_login = PyBridge.get_last_login_user_for(SITE_NAME_CI)
  if last_user_login != username
    # 3.1.2 [LOGIN] We need to switch users for this test
    puts "[STARTUP] User SWITCH: Last login: '#{last_user_login}', Given login: '#{username}'"
    @Menu.more_options_button.click
    @Menu.logout_button.click
    sleep(1)

  else
    # puts "[STARTUP] Last login: '#{last_user_login}', Given login: '#{username}'"
  end

  # 3.2 [LOGIN] We need to click on our target Site
  @Site_List_screen.get_site_tile($CI_SITE).click
  $NAME_OF_SITE = $CI_SITE


  # 3.2.1 [LOGIN] We still need to log in to our Site
  if @Menu.main_content_window.exists == true
    nil # We're logged in, and ready to test

  elsif @Log_In_screen.username_field.exists == true
		steps %(
		  Then I should see the Login window
		  When I enter username "#{username}"
		  And I enter password "#{password}"
		  And click Login button
		  Then I should see the "#{$NAME_OF_SITE}" site name in the action bar
		)

  elsif @Patient_List_screen.action_bar_site.exists == true
		expect(@Patient_List_screen.action_bar_site.text == $CI_SITE)

  elsif @VendorLogIn_screen.title.exists == true
    steps %( Then I should complete the vendor login )

  end

  # if @Alert_window.alert_title.exists == true
  #   @ResponseErrorHandler.inspection
  # end

  # 4.0 [AFTER] We have completed the login and startup routines
  startup_data = { "STARTUP": {
      "App": { "username": app_username, "password": password },
      "Site": { "username": username, "password": password,
        "$CI_SITE": $CI_SITE, "SITE_NAME": SITE_NAME_CI },
      "Registration Code": { "Check": reg_code_check, "RegCode": @RegistrationCode } } }
  puts startup_data
end

Given(/^I have fresh installed AS1$/) do
  steps %(
    When I should terminate and uninstall utang One
    And I should install utang One
    And I should launch utang One
  )
end

Given(/^I reset the AS1 app$/) do
  @appiumDriver.reset
end

And(/^I should terminate and uninstall utang One$/) do
  wait_for(10) { @Menu.more_options_button.displayed? == true }
  @appiumDriver.close_app
  @appiumDriver.remove_app("#{APP_PACKAGE}")
end

And(/^I should install utang One$/) do
  @appiumDriver.install_app("#{APP_PATH}")
end

And(/^I should launch utang One$/) do
  @appiumDriver.launch_app
end

Given(/^I am a super user with all permissions$/) do
  USERNAME = SUPER_ALL_USERNAME
  ANDROID_PASSWORD = DEFAULT_PASSWORD
end

Given(/^I am a super user with no permissions$/) do
  USERNAME = SUPER_NONE_USERNAME
  ANDROID_PASSWORD = DEFAULT_PASSWORD
end

Given(/^I am a user with cardiac fellow permissions$/) do
  USERNAME = CARDIAC_FELLOW_USERNAME
  ANDROID_PASSWORD = EDIT_CONFIRM_PASSWORD
end

Given(/^I am a user that can't confirm without an order number$/) do
  USERNAME = ORDER_USERNAME
  ANDROID_PASSWORD = EDIT_CONFIRM_PASSWORD
end

Given(/^I am a user that can't confirm out of InBasket$/) do
  USERNAME = INBASKET_USERNAME
  ANDROID_PASSWORD = EDIT_CONFIRM_PASSWORD
end

When(/^I login to a testSite with a valid credential$/) do
  # -1 [PRE] Config Check
  puts "Feature Name: #{$FEATURE_NAME}"
  puts "Scenario Name: #{$SCENARIO_NAME}"
  puts "TestRail Id: #{$TESTRAIL_ID}\n\n"
  $CI_SITE = Common.convert_ci_site(SITE_NAME_CI)

  # 0 [VARIABLE_DEFINITIONS] Set the sitename variable to the terminal configuration
  sitename = ANDROID_ENVIRONMENT
   Common.sitename_flag_config_check(sitename)

  # if Common.first_run_check == true
  #   Common.build_config_info
  #   # PP.pp(@appium.driver.manage) # Disabled because of spam
  #   sleep(2) # First run idle wait
  # end

  # 0.1 [BEFORE] Wait until app has loaded, to begin login routine
  @wait.until { @Menu.sites_container.displayed? == true }
  # puts "[STARTUP] Beginning 'Startup' routine"

  # 0.2 [VARIABLE_DEFINITIONS] Set the username and password variables to the terminal configurations
  username = USERNAME
  password = ANDROID_PASSWORD

  # 1.0 [APP_LOGIN] Check to see if this is the first test in run
  if Common.first_run_check == true
    puts "[STARTUP] Beginning 'First Run' routine"
    reg_code_check = PyBridge.get_reg_code_from_pkg_shell

    # 1.1 [APP_LOGIN] Are we logged-in to the App?
    app_username = "test@test.com"
    window_title = @Menu.action_bar.text
    # 1.2 [APP_LOGIN] If Welcome screen displayed, we need to enter app login info
    if window_title == "Welcome"
      puts "[STARTUP] Executing 'App Login' logic"
      steps %(
        When I click Sign On button
        And I enter email "#{app_username}"
        And I enter email password "#{password}"
        And click Sign On button
      )
    end
    sleep(1)

    # 2.0 [DEVICE_REG] Is the device registered?
    # puts "[STARTUP] Executing 'Registration Code' logic"
    @RegistrationCode = PyBridge.get_reg_code_from_pkg_shell

    begin
      @RegistrationCode.split('-').count == 2
      # puts "[STARTUP] Device is already registered"
    rescue
      if reg_code_check == false
        # 2.1 [DEVICE_REG] The device isn't registered yet, let's register it
        puts "[STARTUP] Device needs to be registered"
        case $CI_SITE
        when "34 QA Cardio PM", "QA Cardio PM 35", "Muse9", "MuseNX", "Nihon Khoden", "Mindray PM", "Automation Site", "astqaautoenv1-01"
          steps %(
            And I register devices with global services
            When I click refresh button on the Site List Screen
          )
        when "Carle Vent Dev", "Carle EMR Test", "Palomar utang ONE OB"
          steps %(
            And I register devices with prod global services
          )
        end
      end
    end

    Common.set_first_run_false
    # puts "[STARTUP] Completing 'First Run' routine"
  end

  # 3.0 [LOGIN] Are we ready to log into the test site?
  begin
    # 3.1 [LOGIN] If Site List is empty (No Data), we still need to register the device
    if wait_for(1) { @Site_List_screen.data_not_found.text == 'Data Not Found' }
      puts "[STARTUP] Executing 'Device Registration' logic"
      steps %(
        And I register devices with global services
        When I click refresh button on the Site List Screen
      )
    end
  rescue
    # puts "[STARTUP] 'Device Registration' state: OK"
  end

  # puts "[STARTUP] Executing 'Site Login' logic"

  # 3.1.1 [LOGIN] Are we logged into the correct user?
  last_user_login = PyBridge.get_last_login_user_for(SITE_NAME_CI)
  if last_user_login != username
    # 3.1.2 [LOGIN] We need to switch users for this test
    puts "[STARTUP] User SWITCH: Last login: '#{last_user_login}', Given login: '#{username}'"
    @Menu.more_options_button.click
    @Menu.logout_button.click
    sleep(1)

  else
    # puts "[STARTUP] Last login: '#{last_user_login}', Given login: '#{username}'"
  end

  # 3.2 [LOGIN] We need to click on our target Site
  @Site_List_screen.get_site_tile($CI_SITE).click
  $NAME_OF_SITE = $CI_SITE

  # 3.2.1.2 [LOGIN] We still need to log in to our Site
  if @Menu.main_content_window.exists == true
    nil # We're logged in, and ready to test

  elsif @Log_In_screen.username_field.exists == true
    steps %(
		  Then I should see the Login window
		  When I enter username "#{username}"
		  And I enter password "#{password}"
		  And click Login button
		  Then I should see the "#{sitename}" site name in the action bar
		)

  elsif @Patient_List_screen.action_bar_site.exists == true
    expect(@Patient_List_screen.action_bar_site.text == $CI_SITE)

  elsif @VendorLogIn_screen.title.exists == true
    steps %( Then I should complete the vendor login )

  end

  # if @Alert_window.alert_title.exists == true
  #   @ResponseErrorHandler.inspection
  # end

  # 4.0 [AFTER] We have completed the login and startup routines
  startup_data = { "STARTUP": {
    "App": { "username": app_username, "password": password },
    "Site": { "username": username, "password": password, "sitename": sitename,
              "$CI_SITE": $CI_SITE, "SITE_NAME_CI": SITE_NAME_CI },
    "Registration Code": { "Check": reg_code_check, "RegCode": @RegistrationCode } } }
  puts startup_data
end

When(/^I sign into AS1$/) do
  steps %(
        When I click Sign On button
        And I enter email "#{APP_USERNAME}"
        And I enter email password "#{DEFAULT_PASSWORD}"
        And click Sign On button
      )
end

And(/^I register devices with global services$/) do
  puts "Registering Device: #{@RegistrationCode}" if $debug_flag == 'debug'
	Global_Services.site_registration(@RegistrationCode, 1763) # 34 QA Cardio PM
	Global_Services.site_registration(@RegistrationCode, 4186) # QA Cardio PM 35
	# Global_Services.site_registration(@RegistrationCode, 2419) # 50 QA Integration
  Global_Services.site_registration(@RegistrationCode, 4103) # Muse9
  Global_Services.site_registration(@RegistrationCode, 4104) # MuseNX
  Global_Services.site_registration(@RegistrationCode, 4121) # Mindray PM
  Global_Services.site_registration(@RegistrationCode, 4645) # Nihon Khoden
  Global_Services.site_registration(@RegistrationCode, 4751) # Automation Site
  # Global_Services.site_registration(@RegistrationCode, 5019) # Automation Site NG
  Global_Services.site_registration(@RegistrationCode, 5027) # Automation Site astqaautoenv1-01
  puts "Finished Registering Device!" if $debug_flag == 'debug'
end

And(/^I register devices with prod global services$/) do
  puts "Registering Device: #{@RegistrationCode}" if $debug_flag == 'debug'
  Global_Services.site_registration_prod(@RegistrationCode, 1547)
  Global_Services.site_registration_prod(@RegistrationCode, 1588)
  Global_Services.site_registration_prod(@RegistrationCode, 1544)
  Global_Services.site_registration_prod(@RegistrationCode, 1770)
  puts "Finished Registering Device!" if $debug_flag == 'debug'
end

Given(/^I have AS1 running with appium$/) do
	#@selenium.manage.timeouts.implicit_wait = 45
	$STYPE = "QA"
  if(SITE_TYPE == "QA")
	  $STYPE = "QA"
  elsif(SITE_TYPE == "PROD")
	  $STYPE = "Production"
  end

  config_item = "Global Services"

  title_value = @Welcome_screen.navigation_bar.text

  if $debug_flag == "debug"
    puts "the title value = #{title_value}"
  end

  # if(title_value == "Welcome" || "utang ONE®")
  if @Welcome_screen.as_welcome_text.exists
    steps %(
      When I click Sign On button
      And I enter email "test@test.com"
      And I enter email password "XXXXX"
      And click Sign On button
      And I view the screen
    )

  elsif title_value == "Site List"
    expect(@Site_List_screen.navigation_bar.text).to eq "Site List"
  end
end

Then(/^I should see the Site List screen$/) do
  sleep(2)
  wait_for(10) { @Menu.action_bar }
  if @Menu.action_bar.text != "Site List"
    DeviceExtensions.back_button_tap
  end
  expect(@Menu.action_bar.text).to eq "Site List"
end

When(/^I click the more options button then the About button$/) do
  sleep(1)
	@Menu.more_options_button.click
	@Menu.about_button.click
	@About_window.alert_title.text.should eql "About"
end

# TODO: Code below is useless and supposedly must be deleted
# Then(/^I should see the About window$/) do
# 	#@wait.until { @About_window.ok_button.displayed == true }
#   @About_window.alert_title.text.should eql "About"
#
#   @AppVersion = @About_window.app_version.text
#   @BuildNumber = @About_window.build.text
#   @BuildVariant = @About_window.variant.text
#   @UniqueId = @About_window.unique_id.text
#   @RegistrationCode = @About_window.reg_code_text
#   @DeviceModel = @About_window.device_model.text
#   @DeviceSystemVersion = @About_window.system_version.text
#
#   puts "AS1 App Version: #{@AppVersion}"
#   puts "Build Number: #{@BuildNumber}"
#   puts "Build Variant: #{@BuildVariant}"
#   puts "Device Model: #{@DeviceModel}"
#   puts "Device System Version: #{@DeviceSystemVersion}"
#   puts "Unique ID: #{@UniqueId}"
#   puts "REGISTRATION CODE: #{@RegistrationCode}\n"
# 	sleep(1)
#
# 	begin
# 		file = File.open("buildInfo.txt", "w")
# 		file.write("#{@AppVersion} \n#{@BuildNumber} \n#{@DeviceSystemVersion} \n#{@BuildVariant} \n#{@UniqueId} \n#{@RegistrationCode} \n#{@DeviceModel}")
# 	rescue IOError => e
# 		puts e
# 	ensure
# 		file.close unless file.nil?
# 	end
# end

And(/^I click the OK button on the About window$/) do
  #@wait.until { @About_window.ok_button.displayed == true }
  puts "about to click the ok button on the about screen"

  @About_window.ok_button.click
  puts "just clicked the ok button on the about screen"

end

When(/^I click "(.*?)" button on Site List screen$/) do |arg1|
	sleep(1)
  $NAME_OF_SITE =arg1
  @Site_List_screen.get_site_tile($NAME_OF_SITE).click
end

When(/^I force close app$/) do
  @appiumDriver.close_app
end

When(/^I move app to background$/) do
  @appiumDriver.background_app(-1)
  sleep(0.5)
end

Then(/^I should see the application is foregrounded$/) do
  expect(PyBridge.is_app_foregrounded).to eql(true)
end

Then(/^I should see the application is backgrounded$/) do
  expect(PyBridge.is_app_foregrounded).to eql(false)
end

When(/^I rotate the device to "(.*?)"$/) do |orientation|
  if orientation.downcase == "landscape"
    DeviceExtensions.set_screen_orientation(mode=1, system_pause=3)
  elsif orientation.downcase == "portrait"
    DeviceExtensions.set_screen_orientation(mode=0, system_pause=3)
  else
    raise "ERROR: Argument: '#{orientation}' is not a valid orientation mode"
  end
end

Then(/^the device orientation is set to "(.*?)"$/) do |orientation|
  result = DeviceExtensions.get_screen_orientation
  if orientation.downcase == "landscape"
    expect(result == '1')
  elsif orientation.downcase == "portrait"
    expect(result == '0')
  else
    raise "ERROR: Argument: '#{orientation}' is not a valid orientation mode"
  end
  sleep(1)
end

When(/^I turn the display on$/) do
  DeviceExtensions.toggle_display_state('on')
end

When(/^I turn the display off$/) do
  DeviceExtensions.toggle_display_state('off')
end

Then(/^I verify the display is turned on$/) do
  DeviceExtensions.get_display_state == 'on'
end

Then(/^I verify the display is turned off$/) do
  DeviceExtensions.get_display_state == 'off'
end

When (/^I click on the first patient$/) do
  @Patient_Summary_screen.first_patient.click
end

#Then(/^validate "(.*?)" screen via image compare$/) do |screenName|
#  @appiumDriver.screenshot "#{SCREEN_PATH}/#{screenName}_#{Common.random_time}.png"
#  @eyes.check_window(screenName)
#end

Then(/^validate "(.*?)" screen via image compare$/) do |screenName|
  screenName = screenName.gsub(/[{}\/]/, '')
  if EYES == true
    begin
      retries ||= 0
      @eyes.check_window(screenName)
    rescue Exception => e
      puts e
      retry if (retries += 1) < 4
    end
  end
end

When(/^I clear vendor credential password in AMP$/) do
  puts "Clearing vendor creds in AMP"
  AMP_API.clear_vendor_password
  sleep(1)
end

When(/^I set vendor credential password in AMP$/) do
  puts "Setting vendor creds in AMP"
  AMP_API.set_vendor_password
  sleep(1)
end

When(/^I launch the C3PO app$/) do
  `adb -s '#{$UDID}' shell am start -n com.utang.c3p0/.MainActivity`
  sleep(3)
end

When(/^I terminate the C3PO app$/) do
  `adb -s '#{$UDID}' shell am force-stop com.utang.c3p0`
end

When(/^I clear the AS ONE app cache$/) do
  `adb -s '#{$UDID}' shell pm clear #{APP_PACKAGE}`
end

When(/^I terminate the AS Admin app$/) do
  `adb -s '#{$UDID}' shell pm clear #{APP_PACKAGE}.admin`
  `adb -s '#{$UDID}' shell am force-stop #{APP_PACKAGE}.admin`
end

When(/^I terminate the AS ONE app$/) do
  `adb -s '#{$UDID}' shell am force-stop #{APP_PACKAGE}`
end

When(/^I launch the AS Admin app$/) do
  `adb -s '#{$UDID}' shell am start -n #{APP_PACKAGE}.admin/.MainActivity`
end

When(/^I launch the AS ONE app$/) do
  `adb -s '#{$UDID}' shell am start -n #{APP_PACKAGE}/.ui.user.WelcomeActivity`
end


And(/^I set the language to English Great Britain$/) do
  'adb -s \'#{$UDID}\' shell setprop persist.sys.language en' 'adb shell setprop persist.sys.country GB'
end

And(/^I set the device to use 12 hour format$/) do

  dbResult = 'adb shell "sqlite3 /data/data/com.android.providers.settings/databases/settings.db" \ "insert into system (name,value) values (\'time_12_24\',\'24\');"'

  #dbResult = 'adb shell "sqlite3 /data/data/com.android.providers.settings/databases/settings.db" \ "update system set value=\'12\' where name=\'time_12_24\';"'

  puts "---------------------------------------------------"
  puts "the db query results are:   #{dbResult}"
  puts "---------------------------------------------------"
end

And(/^I set the device to use 24 hour format$/) do
  dbResult = 'adb shell "sqlite3 /data/data/com.android.providers.settings/databases/settings.db" \ "update system set value=\'24\' where name=\'time_12_24\';"'

  puts "---------------------------------------------------"
  puts "the db query results are:   #{dbResult}"
  puts "---------------------------------------------------"
end


When(/^I set the device time to current time$/) do
  time = Time.new
  #20140815.144500
  time = time.strftime("%Y%m%d.%H%M00")
  if SELENIUMHUB
    `adb -s #{@adbDevice} shell date -s #{time}`
  else
    `adb -s '#{$UDID}' shell date -s #{time}`
  end
end

When(/^I run as root$/) do
  `adb -s '#{$UDID}' root`
end

When(/^I disable wifi$/) do
  if SELENIUMHUB
    `adb -s #{@adbDevice} shell "su -c 'svc wifi disable'"`
  else
    #`adb shell "su -c 'svc wifi disable'"`
    `adb -s '#{$UDID}' shell svc wifi disable`
  end
end

When(/^I enable wifi$/) do
  if SELENIUMHUB
    `adb -s #{@adbDevice} shell "su -c 'svc wifi enable'"`
  else
	   #`adb shell "su -c 'svc wifi enable'"`
    `adb -s '#{$UDID}' shell svc wifi enable`
  end
end

When(/^I disable nfc/) do
  if SELENIUMHUB
    `adb -s #{@adbDevice} shell svc nfc disable`
  else
    `adb -s '#{$UDID}' shell svc nfc disable`
  end
end

When(/^I enable nfc/) do
  if SELENIUMHUB
    `adb -s #{@adbDevice} shell svc nfc enable`
  else
    `adb -s '#{$UDID}' shell svc nfc enable`
  end
end

When(/^I disable data/) do
  if SELENIUMHUB
    `adb -s #{@adbDevice} shell "su -c 'svc data disable'"`
  else
    #`adb shell "su -c 'svc wifi disable'"`
    `adb -s '#{$UDID}' shell svc data disable`
  end
end

When(/^I enable data/) do
  if SELENIUMHUB
    `adb -s #{@adbDevice} shell "su -c 'svc data enable'"`
  else
	   #`adb shell "su -c 'svc wifi enable'"`
    `adb -s '#{$UDID}' shell svc data enable`
  end
end

Then(/^the application error displays$/) do
  sleep(2)
  @Menu.app_error_network.text.should eql "Application Error"
end

When (/^I click OK$/) do
  @Menu.app_error_OK.click
end

When (/^I capture my device registration code$/) do
  @RegistrationCode = '22005-839110' #PyBridge.get_reg_code_from_pkg_shell
end

Then(/^I wait "(.*?)" seconds$/) do |seconds|
  puts "Waiting #{seconds} seconds"
  sleep(seconds.to_i)
end

When(/^I click hardware back button$/) do
  if @DeviceSystemVersion.to_i > 12
    Appium::TouchAction.new.swipe(:start_x => 30, :start_y => 1000, :end_x => 400, :end_y => 1000, :duration => 1000).perform
  else
    DeviceExtensions.back_button_tap
  end
end
