Before do
  @Welcome_screen = Welcome_screen.new selenium, appium
  @Site_List_screen = Site_List_screen.new selenium, appium
  @Menu = Menu.new selenium, appium
  @About_window = About_window.new selenium, appium
  @Signoff_window = Signoff_window.new selenium, appium
end

Given(/^I have AS1-android running with appium$/) do # Make sure you have started appium server
  welcome = false
  begin
    if @Welcome_screen.navigation_bar.text == "Welcome"
     welcome = true
    end
  rescue => e
	if(e)

	end
  end
  if welcome != true
    if @Site_List_screen.navigation_bar.text == "Site List"
     @Menu.more_options_button.click
     @Menu.about_button.click
     @About_window.title.text.should eql "About"
     @About_window.sign_off_button.click
     @Signoff_window.title.text.should eql "Sign Off"
     @Signoff_window.yes_button.click
     @Welcome_screen.navigation_bar.text.should eql "Welcome"
    end
  end
end

Given(/^I am not at the welcome screen$/) do
  expect(@Welcome_screen.navigation_bar.text).to eq "Welcome"
end

Then(/^I should see the AS1 Welcome screen$/) do
 expect(@Welcome_screen.as_welcome_logo.exists).to be true
end

When(/^I click Sign On button$/) do
  @Welcome_screen.sign_in_button.click
end

Then(/^I should see Sign On window$/) do
  sleep(1)
  expect(@Welcome_screen.sign_on_title.text).to eq "Sign On"
  expect(@Welcome_screen.email_textfield.exists).to be true
  expect(@Welcome_screen.email_password_textfield.exists).to be true
  expect(@Welcome_screen.signon_dialog_button.exists).to be true
  #@eyes.check_window("Sign On window")
end

Then(/^I should see the disclaimer text include "(.*?)"$/) do |arg1|
  @Welcome_screen.legal_disclaimer_text.text.should include arg1
end

And(/^the disclaimer text should include "(.*?)"$/) do |arg1|
  @Welcome_screen.legal_disclaimer_text.text.should include arg1
end

When(/^I enter email "(.*?)"$/) do |arg1|
	if(@Welcome_screen.email_textfield.text == arg1)
		@Welcome_screen.email_textfield.text.should eq arg1
	else
		@Welcome_screen.email_textfield.send_keys ""
		@Welcome_screen.email_textfield.send_keys arg1
		@Welcome_screen.email_textfield.text.should eq arg1
	end
end

When(/^I enter email password "(.*?)"$/) do |arg1|
  @Welcome_screen.email_password_textfield.send_keys arg1
end

When(/^click Sign On button$/) do
  @Welcome_screen.signon_dialog_button.click
end

Then(/^I should see the Android Site List$/) do
  sleep(2)
  if @Site_List_screen.get_site_list_count > 0
    return
  elsif @Welcome_screen.navigation_bar.text.should include "Site List"
    return
  else
    raise "ERROR: Could not verify Site List screen is displayed."
  end
end

When(/^the Sign In button displays$/) do
  expect(@Welcome_screen.sign_in_button.exists).to be true
end

When(/^the Reset Password button displays$/) do
  expect(@Welcome_screen.reset_password_button.exists).to be true
end

When(/^the utang logo displays$/) do
  expect(@Welcome_screen.as_welcome_logo.exists).to be true
end

When(/^the utang disclaimer displays$/) do
  expect(@Welcome_screen.as_welcome_text.exists).to be true
  puts @Welcome_screen.as_welcome_text.text
end

When(/^the WELCOME message displays$/) do
  expect(@Welcome_screen.as_welcome_text.exists).to be true
end

When(/^I should see the Welcome screen$/) do
  expect(@Welcome_screen.as_welcome_text.exists).to be true
end

When(/^the CE marks display$/) do
  expect(@Welcome_screen.ce_marks.exists).to be true
end

When(/^the CE mark numbers display as 0086$/) do
  expect(@Welcome_screen.ce_numbers.exists).to be true
end

