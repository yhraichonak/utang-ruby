Before do
  @Log_In_screen = Log_In_screen.new selenium, appium
end

Then(/^I should see the Login window$/) do
  wait_for(2) { expect(@Log_In_screen.login_window_message.text).to eq "Please Enter Your Site Credentials" }
  # expect(@Log_In_screen.username_field.exists).to be true
	# expect(@Log_In_screen.password_field.exists).to be true
	# expect(@Log_In_screen.login_button.exists).to be true
	 expect(@Log_In_screen.login_window_title.text).to eq $NAME_OF_SITE
end

Then(/^I should see the Login Failed window$/) do
  wait_for(2) { expect(@Log_In_screen.login_window_message.text).to eq "Please Enter Your Site Credentials" }
  expect(@Log_In_screen.login_window_title.text).to eq $NAME_OF_SITE
  # The "Login Failed" pop up needs to be an actual element to verify
end

Then(/^I should see "(.*?)" in the title of the login window$/) do |site|
  @Log_In_screen.login_window_title.text.should eql site
end

Then(/^I should see "(.*?)" as the login message$/) do |arg1|
  @Log_In_screen.login_window_message.text.should eq arg1
end

Given(/^I have the site name "(.*?)" in navigation bar$/) do |arg1|
  @Log_In_screen.navigation_bar.name.should eq arg1
end

When(/^I enter username "(.*?)"$/) do |arg1|
	$USER_FROM_FEATURE = arg1
 @Log_In_screen.username_field.send_keys arg1
end

When(/^I enter password "(.*?)"$/) do |arg1|
  @Log_In_screen.password_field.send_keys arg1
end

When(/^click Login button$/) do
  @Log_In_screen.login_button.click
end

Then(/^I should verify the name$/) do
  #puts @Log_In_screen.password_field.text
  #puts @Log_In_screen.password_field.name
  #puts @Log_In_screen.password_field.hint
end

Then(/^I should see "(.*?)" in the username field$/) do |arg1|
  @Log_In_screen.username_field.text.should eq arg1
end

Then(/^I should see "(.*?)" in the password field$$/) do |arg1|
  @Log_In_screen.password_field.text.should eq arg1
end

When(/^I click off the login window$/) do
  @Log_In_screen.login_window_title.click(0,-100)
end





