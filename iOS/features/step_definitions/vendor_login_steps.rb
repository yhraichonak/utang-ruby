Before do
  @Login_screen = Login_screen.new selenium, appium
  @VendorLogin_screen = VendorLogin_screen.new selenium, appium
end
Then(/^I should see the vendor credentials login screen$/) do
  expect(@VendorLogin_screen.vendor_text("Muse").nil?).to be_falsey
end

When(/^I enter vendor username "(.*?)"$/) do |username|
  element = @VendorLogin_screen.username_textfield
  Common.click_center_of_object(element)
  #@VendorLogin_screen.username_textfield.click
  element.clear 
  element.send_keys username
end

When(/^I enter vendor password "(.*?)"$/) do |password|
  element = @VendorLogin_screen.password_textfield
  Common.click_center_of_object(element)
  #@VendorLogin_screen.password_textfield.click
  element.clear
  element.send_keys password
end

When(/^click vendor Login button$/) do 
  element = @VendorLogin_screen.login_button
  #Common.click_center_of_object(element)
  element.click
  #@VendorLogin_screen.login_button.click
end