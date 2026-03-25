Before do
  @Site_List_screen = Site_List_screen.new selenium, appium
  @Welcome_screen = Welcome_screen.new selenium, appium
  @VendorLogIn_screen = VendorLogIn_screen.new selenium, appium
  @Menu = Menu.new selenium, appium
end

When(/^I click hardware back button on the Site List Screen$/) do
  DeviceExtensions.back_button_tap
end

When(/^I click refresh button on the Site List Screen$/) do
  @wait.until { @Menu.refresh_button.exists == true }
  @Menu.refresh_button.click
  sleep(1)
end