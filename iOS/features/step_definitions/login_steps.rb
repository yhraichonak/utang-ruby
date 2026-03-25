Before do
  @Login_screen = Login_screen.new selenium, appium
  @VendorLogin_screen = VendorLogin_screen.new selenium, appium
end

Then(/^I should see navigation bar login window$/) do
  # puts @Login_screen.login_text
  sleep 5
  @wait.until { @Login_screen.login_text.displayed? == true }
  if $debug_flag == "debug"
    puts "******"
    puts @Login_screen.login_text.text
    puts "******"
  end
  @Login_screen.login_text.name.should eql "Please enter your credentials"
end

When(/^I sign into AS1$/) do
  steps %{
    Then I click the Sign In button
    Then I should see the utang Credentials window prompt
    When I enter "test@test.com" in username field
    And I enter "XXXXX" in password field
    And I click the Sign In cell
    Then the utang Would Like to Send You Notifications Alert window displays
    When I click the Alert Allow Notifications button
    Then I should see the test site button on Site List screen
  }
end
Then(/^I should see the test site name in navigation bar login window$/) do
  @wait.until { @Login_screen.login_text.displayed? == true }
  @Login_screen.login_text.name.should eql "Please enter your credentials"
  appium.find_element(:xpath,"//XCUIElementTypeStaticText[contains(@label,'#{$siteName}')]")
end

Then(/^I should see the Site Login screen$/) do
  puts "in the should see the Site Login screen"
  element = @Login_screen.login_text
  expect(element.name).to eq "Please enter your credentials"

  if $debug_flag == "debug"
    puts "should see the site login screen"
  end
end

Given(/^I have the site name "(.*?)" in navigation bar$/) do |arg1|
  @Login_screen.navigation_bar.name.should include arg1
end

When(/^I enter username "(.*?)"$/) do |username|
  username_textfield = @Login_screen.username_textfield
  username=process_param(username)
  expect(username_textfield.visible).to be_truthy

  if(username_textfield.text == username)
      if $debug_flag == "debug"
        puts "username matches the incoming value"
      end
  else
      if $debug_flag == "debug"
        puts "username does not match the incoming value"
      end

    username_textfield.clear

      if $debug_flag == "debug"
        puts "just clicked in the username field"
      end

    begin
      found = false

        for i in 0..5
          value = @Login_screen.keyboard.visible
          value = value.to_s
            if $debug_flag == "debug"
              puts "the keyboard visible value = #{value}"
              puts "for loop iteration = #{i}"
            end
          if value == "true"
            found = true
            break
          else
            KEYBOARD.toggle_hardware_keyboard
          end
          value = @Login_screen.keyboard.visible
          value = value.to_s
          if value == "true"
            found = true
            break
          end
          if found == true
            break
          end
        end
    rescue StandardError => e
      if $debug_flag == "debug"
        puts e
      end
    end

    username_textfield.send_keys username

  end
end

When(/^I enter password "(.*?)"$/) do |password|
  password=process_param(password)
  password_textfield =  @Login_screen.password_textfield
  expect(password_textfield.visible).to be_truthy
  # password_textfield.click
  #   begin
  #     found = false
  #
  #       for i in 0..5
  #         value = @Login_screen.keyboard.visible
  #         value = value.to_s
  #         #puts value
  #         if value == "true"
  #           found = true
  #           break
  #         else
  #           KEYBOARD.toggle_hardware_keyboard
  #         end
  #         value = @Login_screen.keyboard.visible
  #         value = value.to_s
  #         if value == "true"
  #           found = true
  #           break
  #         end
  #         if found == true
  #           break
  #         end
  #       end
  #   rescue StandardError => e
  #
  #   end

  password_textfield.clear
  password_textfield.send_keys password
end

When(/^click Login button$/) do
  @wait.until { @Login_screen.login_button.displayed? == true }
  element = @Login_screen.login_button
  Common.click_center_of_object(element)
end

Then(/^I should see an invalid login prompt$/) do
	@wait.until { @Login_screen.alertOK_button.displayed? == true }
  expect(@Login_screen.alert_header2.name).to eq "Login failed"
  expect(@Login_screen.alertOK_button.visible).to eq "true"
end

Then(/^I should see site logout prompt$/) do
  @wait.until { @Login_screen.alertOK_button.displayed? == true }
  expect(@Login_screen.alert_header2.name).to eq "Logged out of " + $siteName + "."
end

When(/^I click OK button in alert prompt$/) do
	@wait.until { @Login_screen.alertOK_button.displayed? == true }
	element = @Login_screen.alertOK_button
	Common.click_center_of_object(element)
end

When(/^I click Cancel button$/) do
  @wait.until { @Login_screen.cancel_button.displayed? == true }
  element = @Login_screen.cancel_button
  Common.click_center_of_object(element)
end

Then(/^I should see "(.*?)" in the username field as last logged in user$/) do |username|
  @Login_screen.username_textfield.value.should eql username
end

Then(/^I should see the password field empty$/) do
  @Login_screen.password_textfield.value.should eql "Password"
end

When(/^I login with vendor credentials "(.*?)" and "(.*?)"$/) do |username, password|
  if @VendorLogin_screen.vendor_text("Muse").nil? == false
    steps %{
      When I enter vendor username "#{username}"
      And I enter vendor password "#{password}"
      And click vendor Login button
    }
  end
end

Then(/^the TouchID toggle button displays$/) do
  touchId = nil
  begin
    if @Login_screen.touchIdToggle_button.nil? == true
      touchId = false
    else
      touchId = true
    end
  rescue StandardError => e
    touchId = false
  end

  if touchId == false
    steps %{
      And I click Cancel button
      Then I should see the Site List screen
      When I toggle on Touch Id enrollment
      And I click "#{$pm_sitename}" button on Site List screen
      Then I should see navigation bar login window
    }
  else
    expect(@Login_screen.touchIdInfo_button.nil?).to eq false
    expect(@Login_screen.touchId_staticText.nil?).to eq false
    expect(@Login_screen.touchIdToggle_button.nil?).to eq false
  end
end

When(/^click the Toggle TouchID Login "(.*?)"$/) do |arg1|
  element = @Login_screen.touchIdToggle_button
  Common.click_center_of_object(element)
  ##@Login_screen.touchIdToggle_button.click
end
