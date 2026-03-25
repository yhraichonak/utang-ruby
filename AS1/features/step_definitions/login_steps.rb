# frozen_string_literal: true

Before do
  @Login_Window = Login_Window.new @selenium
  @SignOn_Screen = SignOn_Screen.new @selenium
  @SiteList_Screen = SiteList_Screen.new @selenium
  @About_Window = About_Window.new @selenium
  @Header_Bar = Header_Bar.new @selenium
  @SiteListLogin_Window = SiteListLogin_Window.new @selenium
end

Then(/^I should see "(.*?)" in navigation bar login window$/) do |site_name|
  expect(@Login_Window.loginWindowTitle_div.text).to eql "Login to #{site_name}"
end

When(/^I enter username "(.*?)"$/) do |text|
  @wait.until { @Login_Window.username_input }
  @wait.until { @Login_Window.login_button.enabled? }
  sleep 2
  username_field = @Login_Window.username_input
  @selenium.action.move_to(username_field).click.send_keys(text).perform
  # username_field.send_keys(text)
  # @selenium.action.send_keys(text).perform
end

When(/^I enter password "(.*?)"$/) do |text|
  password_field = @Login_Window.password_input
  @selenium.action.move_to(password_field).click.perform
  # password_field.send_keys(text)
  @selenium.action.send_keys(text).perform
end

When(/^I click the Login button$/) do
  @Login_Window.login_button.click
  # sleep 2
end

When(/^I click the Cancel button$/) do
  @Login_Window.cancel_button.click
end

When(/^I click the Sign On button$/) do
  @SignOn_Screen.signOn_button.click
end

When(/^I click the Reset Password button$/) do
  @SignOn_Screen.resetPassword_button.click
end

When(/^I click the Login popup x button$/) do
  @Login_Window.x_button.click
end

Then(/^the WEB 1.1 Sign On screen displays$/) do
  @wait.until { @SignOn_Screen.signOn_button }
  sleep(2)
  expect(@SignOn_Screen.main_div.text).to include 'Welcome to utang ONE'
  expect(@SignOn_Screen.main_div.text).to include 'utang ONE is intended for use by physicians and other care providers.'
  expect(@SignOn_Screen.main_div.text).to include 'In order to use utang ONE the hospital at which you practice must have purchased and installed the utang ONE system. If your hospital has done this, please proceed to sign on.'
  expect(@SignOn_Screen.signOn_button.text).to eql 'Sign On'
  expect(@SignOn_Screen.resetPassword_button.text).to eql 'Reset Password'
end

When(/^the Login popup window displays$/) do
  @Login_Window.loginWindowTitle_div.text.should eql 'utang Sign On'
  expect(@Login_Window.banner_text.text).to eql 'Please Enter Your utang ONE™ Credentials'
  expect(@Login_Window.checkbox_text.text).to include 'This is a public computer.'
  expect(@Login_Window.username_input.displayed? &&
    @Login_Window.password_input.displayed? &&
    @Login_Window.login_button.displayed? &&
    @Login_Window.cancel_button.displayed? &&
    @Login_Window.checkbox.displayed?).to eql true
end

Then(/^the Sign On Failed message displays$/) do
  expect(@Login_Window.signOnFailed_text.text).to include 'Sign On failed. Please try to Sign On again.'
end

Then(/^the Please enter your user name! message displays$/) do
  @Login_Window.noUserName_text.text.should eql 'Please enter your user name!'
end

Then(/^the Please enter your password! message displays$/) do
  @Login_Window.noPassword_text.text.should eql 'Please enter your password!'
end

When(/^I click the X button$/) do
  @Login_Window.x_button.click
end

And(/^I click the public computer checkbox$/) do
  @Login_Window.checkbox.click
end

Then(/^the checkbox is selected$/) do
  expect(@Login_Window.checkbox.selected?).to eql true
end

Then(/^I should see the error alert window$/) do
  sleep 2
  expect(@Login_Window.alert_window.displayed?).to be_truthy
end

And(/^I should see the "(.*?)" message on the error alert window$/) do | message |
  expect(@Login_Window.alert_window_title.text).to eq message
end

When(/^I click the ok button in error alert window$/) do
  @Login_Window.alert_ok_button.click
end

Then(/^I should see the login screen$/) do
  expect(@Login_Window.username_input.displayed?).to be_truthy
end

When(/^$/) do
  # pending
end

When(/^I wait for the site to timeout$/) do
  sleep 10
end

Then(/^I should see a error timeout message$/) do
  @wait.until { @Login_Window.alert_window.displayed? }
  if INFO == true
    puts @Login_Window.alert_window.text
    puts @Login_Window.alert_content.text
  end
  expect(@Login_Window.alert_window.text).to eql 'Session Ended'
  expect(@Login_Window.alert_content.text).to eql 'You have been logged out.'
end

When(/^I click OK on error message$/) do
  @Login_Window.alert_ok_button.click
end
