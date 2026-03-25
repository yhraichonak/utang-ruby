Dir[File.dirname(__FILE__) + "/../../../common/**/*.rb"].each {|file| require file }
Before do
  @Menu = Menu.new selenium, appium
  @Welcome_screen = Welcome_screen.new selenium, appium
  @About_screen = About_screen.new selenium, appium
  @SiteList_screen = SiteList_screen.new selenium, appium
end

Given(/^I open (pm-mon|pm-evt|ecg) (Ascom|Engage|Voalte|CCF|Epic|MH) C3PO url with payload (.*?)$/) do |target, vendor, payload|
  payload=process_param(payload)
  crPo_url="utangone://#{vendor.downcase}/#{target}?siteid=#{SITE_ID}&payload=#{payload}"
  puts "Here is the URL: #{crPo_url}"
  @appiumDriver.navigate.to crPo_url
end

Given(/^I verify the version of the app installed$/) do
  begin
    @appiumDriver.alert_accept
  rescue StandardError => e
    puts "alert not there #{e}"
  end

  currentScreen = nil
  begin
    if @SiteList_screen.navigation_bar_title.name == "Sites"
      currentScreen = "Sites"
    end
  rescue StandardError => e
    if @Welcome_screen.title_text.visible.to_s.include?('true')
      currentScreen = "Welcome"
    end
  end

  if currentScreen == "Welcome"
    steps %{
    When I click the Sign In button
    Then I should see the utang Credentials window prompt
    When I enter "test@test.com" in username field
    And I enter "XXXXX" in password field
    And I click the Sign In cell
    Then the utang Would Like to Send You Notifications Alert window displays
    When I click the Alert Allow Notifications button
    Then I should see the Site List screen
    And I get the current registration code
    And I register the device with global services
    Then I should see the Site List screen
    }
    steps %{
    When I click the gear button on Site List screen
    Then I should see the gear button options
    When I click the About button
    Then I should see the About screen
    When I click the Cancel button on the About screen
    }
  elsif currentScreen == "Sites"
    steps %{
    When I click the gear button on Site List screen
    Then I should see the gear button options
    When I click the About button
    Then I should see the About screen
    When I click the Cancel button on the About screen
    }
  end
  if $install_software == "true"
    if $as_build_number== @buildNumber
     puts "Build is current"
    else
     puts "Build is not current"

     steps %{
     Then I should terminate and uninstall utang One
     And I should install utang One
     And I should launch utang One
     }
    end
  else
   puts "install software flag is set to false"
  end
end

When(/^I click the close button on the menu$/) do
	element = @Menu.x_button
	Common.click_center_of_object(element)
end

Given(/^Wait for 1 second$/) do
  sleep(1)
end

When(/^I click the new nav patient summary button$/) do
  if(ENV['DEVICE'].include? "iPad")

    element = @Menu.new_nav_summary_ipad
    Common.click_center_of_object(element)


    #  puts "++ #{element.name} ++"
    #	x = element.location[:x]
    #  y = element.location[:y]
    #
    #  #x = element.size[:width] / 2
    #  #y = element.size[:height] / 2
    #  #puts x
    #  #puts y
    #
    #  offsetX = 5
    #  offsetY = 5
    #
    #Appium::TouchAction.new.tap( x: x + offsetX, y: y + offsetY).wait(1000).release.perform

    # xx = element.size[:width] / 2
    # yy = element.size[:height] / 2
    # Appium::TouchAction.new.tap( x: xx , y: yy).release.perform

    #Appium::TouchAction.new.tap(element: element, count: 2).perform
  else
    element = @Menu.new_nav_summary
    Common.click_center_of_object(element)
  end
end

When(/^I click the new nav hambrger button$/) do
	element = @Menu.new_nav_hamburger
	Common.click_center_of_object(element)
end

When(/^I click the new nav share button$/) do
  # TODO: get rid of Live mode turn off. WIth live mode  - click on any thing throws StaleElementException
  @PMMonitor_screen.live_button.click
  sleep(1)
	element = @Menu.new_nav_share
	Common.click_center_of_object(element)
end

And(/^I scroll down on the screen$/) do
  @seleniumDriver.execute_script 'mobile: scroll', :direction => 'down'
end

And(/^I scroll up on the screen$/) do
  @seleniumDriver.execute_script 'mobile: scroll', :direction => 'up'
end

And(/^I perform the screenshot for "(.*?)"$/) do |name|
  @appiumDriver.screenshot "#{$SCREENSHOT_HOME}/#{name}_#{Common.cur_time}.png"
end

Given(/^current screen$/) do
  #determine landing spot
  begin
    @appiumDriver.alert_accept
  rescue StandardError => e
    #alert not there
  end

  @currentScreen = "Undetermined"
  menu_found = false
  welcome_found = false

  begin
    @wait.until { @Menu.nav_bar.displayed? == true }
  rescue
    @wait.until { @Welcome_screen.title_text.displayed? == true }
  end

  begin
    if @Welcome_screen.title_text.displayed?  == true
      welcome_found = true
    end
  rescue
    if @Menu.nav_bar.displayed? == true
      menu_found = true
    end
  end

  if menu_found == true
    @currentScreen = @Menu.nav_bar.name
  end

  if welcome_found == true
    @currentScreen = @Welcome_screen.title_text.name
  end

  puts "Current screen = #{@currentScreen}"
end

And(/^I perform the Welcome screen resolution steps$/) do
  steps %{
    When I click the Sign In button
    Then I should see the utang Credentials window prompt
    When I enter "test@test.com" in username field
    And I enter "XXXXX" in password field
    And I click the Sign In cell
    Then the utang Would Like to Send You Notifications Alert window displays
    When I click the Alert Allow Notifications button
    Then I should see the Site List screen
    When I click the gear button on Site List screen
    Then I should see the gear button options
    When I click the About button
    Then I should see the About screen
  }
end

And(/^I perform the Site screen resolution steps$/) do
  steps %{
    Then I should see the Site List screen
    When I click the gear button on Site List screen
    Then I should see the gear button options
    When I click the About button
    Then I should see the About screen
    }
end

And(/^I get the current registration code$/) do
  if @currentScreen == "Sites"
    steps %{
      And I perform the Site screen resolution steps
    }
  elsif @currentScreen == "WELCOME"
    steps %{
      And I perform the Welcome screen resolution steps
    }
  end
  @REG_CODE_ONE = @RegistrationCode
end

And(/^I signout of the application$/) do
  steps %{
  Then I click the Sign Out button
  Then I should see the Sign Out prompt
  And I click the Sign Out button on the Sign Out prompt
  When I click OK button in alert prompt
  Then I should see the Welcome screen
  }
end

And(/^I should terminate and uninstall utang One$/) do
  `xcrun simctl terminate booted com.utang.One`

  `xcrun simctl uninstall booted com.utang.One`
end

When(/^I move app to background$/) do
  @appiumDriver.background_app(-1)
end

When(/^I force close app$/) do
  @appiumDriver.terminate_app($app_path)
end

Given(/^I reset the AS1 app$/) do
 steps %{
  When I should terminate and uninstall utang One
  And I should install utang One
  And I should launch utang One
 }
end

Given(/^I have fresh session$/) do
  @appiumDriver.reset
end

And(/^I should install utang One$/) do
 h_name = Socket.gethostname
 puts "this is the app path #{$app_path}"
 puts $current_user

 `xcrun simctl install booted "#{$app_path}"`
end

And(/^I should launch utang One$/) do
  sleep 10
  `xcrun simctl launch booted com.utang.One`
end

Then(/^I signin to the application$/) do
  steps %{
    When I click the Sign In button
    Then I should see the utang Credentials window prompt
    When I enter "test@test.com" in username field
    And I enter "XXXXX" in password field
    And I click the Sign In cell
    Then the utang Would Like to Send You Notifications Alert window displays
    When I click the Alert Allow Notifications button
    Then I should see the Site List screen
  }
end

Then(/^I should verify the registration code has not changed$/) do
 puts "in the verify reg code part"
  steps %{
    When I click the gear button on Site List screen
    Then I should see the gear button options
    When I click the About button
    Then I should see the About screen
  }

  expect(@About_screen.table_section("Application Info").nil?).to be_falsey

  about_info = @About_screen.about_info_buttons
  @PostSignOutInRegCode = about_info["registration_code"].text

  if $debug_flag == "debug"
      puts "+++++"
      puts "initial reg code is:  #{@InitialRegCode}"
      puts "post reg code is:  #{@PostSignOutInRegCode}"
      puts "+++++"
  end

  expect(@InitialRegCode).to eq @PostSignOutInRegCode
  #expect(@About_screen.signout_signout_button.exists).to be_truthy
end

And(/^I register the device with global services$/) do
  puts "Registering Device: #{@RegistrationCode}"
  GS_Registration.site_registration(@RegistrationCode, 1763)
  GS_Registration.site_registration(@RegistrationCode, 1764)
  GS_Registration.site_registration(@RegistrationCode, 2419)
  GS_Registration.site_registration(@RegistrationCode, 1770)

  #puts "Refreshing Site List screen"
  #@seleniumDriver.execute_script 'mobile: scroll', :direction => 'up'
  Appium::TouchAction.new.press(x: 200, y: 75).wait(5000).move_to(x: 0, y: 500).release.perform
end

Given(/^login to the cardio test site with "(.*?)" and "(.*?)"$/) do |username, password|
steps %{
    Given I should see the "cardio" test site button on Site List screen
    When I click the gear button on Site List screen
    And I click the Logout button
    When I click the Ok button on Success window prompt
    Then I should see the Site List screen
    }

  steps %{
    And I click the test site button on Site List screen
    Then I should see the Site Login screen
    When I enter username "#{username}"
    And I enter password "#{password}"
    And click Login button
    When I login with vendor credentials "#{$muse_user}" and "#{$muse_password}"
  }
end

Given(/^login to the node test site with "(.*?)" and "(.*?)"$/) do |username, password|
  steps %{
    Given I should see the "node" test site button on Site List screen }

  steps %{
    When I click the gear button on Site List screen
    And I click the Logout button
    }

  steps %{
    And I click the test site button on Site List screen
    Then I should see the Site Login screen
    When I enter username "#{username}"
    And I enter password "#{password}"
    And click Login button
    When I login with vendor credentials "#{$muse_user}" and "#{$muse_password}"
  }
end

Given(/^login to the pm test site with "(.*?)" and "(.*?)"$/) do |username, password|
  #when site list screen logout works again change back to the commented out group
  steps %{
   Given I should see the "pm" test site button on Site List screen
    When I click the gear button on Site List screen
    Then I should see the menu display
    And I click the Logout button
    When I click OK button in alert prompt
    Then I should see the Site List screen
    And I click the test site button on Site List screen
    Then I should see the Site Login screen
    When I enter username "#{username}"
    And I enter password "#{password}"
    And click Login button
    When I login with vendor credentials "#{$muse_user}" and "#{$muse_password}"
  }
end

Given(/^login to the test site with "(.*?)" and "(.*?)"$/) do |username, password|
  user=process_param(username)
  pass=process_param(password)
  steps %{
   Given logout of all sites
   And I click the test site button on Site List screen
   Then I should see the Site Login screen
   When I enter username "#{user}"
   And I enter password "#{pass}"
   And click Login button
   When I login with vendor credentials "#{$muse_user}" and "#{$muse_password}"
  }
end

Given(/^logout of all sites$/) do
  steps %{
    Given I should see the test site button on Site List screen
   When I click the gear button on Site List screen
   And I click the Logout button
   When I click OK button in alert prompt
   Then I should see the Site List screen
  }
end

Given(/^login to the AUTO test site with "(.*?)" and "(.*?)"$/) do |username, password|
  steps %{
   Given I should see the "AUTO" test site button on Site List screen
    When I click the gear button on Site List screen
    # Then I should see the menu display
    And I click the Logout button
    Then I should see the Site List screen
    And I click the test site button on Site List screen
    Then I should see the Site Login screen
    When I enter username "#{username}"
    And I enter password "#{password}"
    And click Login button
    When I login with vendor credentials "#{$muse_user}" and "#{$muse_password}"
  }

  # steps %{
  #   Given I should see the "pm" test site button on Site List screen

  #    And I click the test site button on Site List screen
  #    Then I should see the Site Login screen
  #    When I enter username "#{username}"
  #    And I enter password "#{password}"
  #    And click Login button
  #    When I login with vendor credentials "#{$muse_user}" and "#{$muse_password}"
  #  }
end

Given(/^login to the Mindray PM site with "(.*?)" and "(.*?)"$/) do |username, password|
  steps %{
   Given I should see the "Mindray" test site button on Site List screen
    When I click the gear button on Site List screen
    # Then I should see the menu display
    And I click the Logout button
    Then I should see the Site List screen
    And I click the test site button on Site List screen
    Then I should see the Site Login screen
    When I enter username "#{username}"
    And I enter password "#{password}"
    And click Login button
    When I login with vendor credentials "#{$muse_user}" and "#{$muse_password}"
  }
end

When(/^I click '(.*)' button$/) do |buttonName|
  Common.wait_for_element_with_timeout(@appiumDriver, :accessibility_id, buttonName, 5)
  @appiumDriver.find_element(:accessibility_id, buttonName).click
end

Given(/^login to the Nihon Khoden PM site with "(.*?)" and "(.*?)"$/) do |username, password|
  steps %{
    Given I should see the "Nihon" test site button on Site List screen
    When I click the gear button on Site List screen
    # Then I should see the menu display
    And I click the Logout button
    Then I should see the Site List screen
    And I click the test site button on Site List screen
    Then I should see the Site Login screen
    When I enter username "#{username}"
    And I enter password "#{password}"
    And click Login button
    When I login with vendor credentials "#{$muse_user}" and "#{$muse_password}"
  }
end

Given(/^login to the sm test site with "(.*?)" and "(.*?)"$/) do |username, password|
  steps %{
    Given I should see the "sm" test site button on Site List screen
    When I click the gear button on Site List screen
    And I click the Logout button
    When I click OK button in alert prompt
    Then I should see the Site List screen
    And I click the test site button on Site List screen
    Then I should see the Site Login screen
    When I enter username "#{username}"
    And I enter password "#{password}"
    And click Login button
    When I login with vendor credentials "#{$muse_user}" and "#{$muse_password}"
  }
end

Given(/^login to the ob test site with "(.*?)" and "(.*?)"$/) do |username, password|
  steps %{
    Given I should see the "ob" test site button on Site List screen
    When I click the gear button on Site List screen
    And I click the Logout button
    And I click the test site button on Site List screen
    Then I should see the Site Login screen
    When I enter username "#{username}"
    And I enter password "#{password}"
    And click Login button
  }
end

Given(/^login to the Muse9 cardio site with "(.*?)" and "(.*?)"$/) do |username, password|
  steps %{
    Given I should see the "Muse9" test site button on Site List screen
    When I click the gear button on Site List screen
    And I click the Logout button
    And I click the test site button on Site List screen
    Then I should see the Site Login screen
    When I enter username "#{username}"
    And I enter password "#{password}"
    And click Login button
  }
end

Given(/^login to the MuseNX cardio site with "(.*?)" and "(.*?)"$/) do |username, password|
  steps %{
    Given I should see the "MuseNX" test site button on Site List screen
    When I click the gear button on Site List screen
    And I click the Logout button
    And I click the test site button on Site List screen
    Then I should see the Site Login screen
    When I enter username "#{username}"
    And I enter password "#{password}"
    And click Login button
  }
end

Given(/^login to the ob prod site with site credentials$/) do |username, password|
  steps %{
    Given I should see the "ob" prod site button on Site List screen
    When I click the gear button on Site List screen
    And I click the Logout button
    And I click the test site button on Site List screen
    Then I should see the Site Login screen
    When I enter username "#{username}"
    And I enter password "#{password}"
    And click Login button
  }
end

Given(/^login to the training site with site credentials$/) do
  steps %{
    Given I should see the "training" test site button on Site List screen
	And I click the test site button on Site List screen
  }
end

Given(/^login to the node simulator site with site credentials$/) do
  steps %{
    Given I should see the "node" test site button on Site List screen
	And I click the test site button on Site List screen
  }
end

Given(/^steps below are pending$/) do
  pending
end

Then(/^validate "(.*?)" screen via image compare$/) do |screenName|
  screenName = screenName.gsub(/[{}\/]/, '')
  if $eyes == true
	begin
	  retries ||= 0
	  $eyes.check_window(screenName)
	rescue StandardError => e
	  puts e.class.name
	  puts e.message
	  retry if (retries += 1) < 4
	end
  end
end

When(/^I rotate the device to "(.*?)"$/) do |orientation|
  sleep(2)
  begin
    if orientation == "landscape"
      selenium.rotate :landscape
    elsif orientation == "portrait"
      selenium.rotate :portrait
    end
  rescue StandardError => e
    puts "rotation failed"
  end
end

Then(/^the device orientation is "(.*?)"$/) do |orientation|
  puts "#{selenium.orientation.to_s}"
  selenium.orientation.to_s.should include orientation
end

When(/^I need the Element Tree$/) do
  puts selenium.page_source
end

When(/^I pinch zoom "(.*?)" on screen$/) do |zoomType|
  height = 100
  rate = 200

  label = "titleLabel':I, 'zoomScale"
  ele = selenium.find_element(:xpath, "//XCUIElementTypeOther[contains(@name, #{label})]")
  top = TouchAction.new
  top.swipe({ :start_x => 0.5, :start_y => (1 - rate) * height,
              :offset_x => 0.0, :offset_y => - (1 - rate) * height }, ele)

  bottom = TouchAction.new
  bottom.swipe({ :start_x => 0.5, :start_y => rate * height,
                 :offset_x => 0.0, :offset_y => (1 - rate) * height }, ele)

  [top, bottom]
end

When(/^I clear vendor credential password in AMP$/) do
  puts "Clearing vendor creds in AMP"
  AMP_API.clear_vendor_password
end

When(/^I launch the C3PO app$/) do
  @appiumDriver.execute_script("mobile: launchApp", {:bundleId => 'com.utang.c3po'})
end

When(/^I terminate the C3PO app$/) do
  @appiumDriver.execute_script("mobile: terminateApp", {:bundleId => 'com.utang.c3po'})
end
