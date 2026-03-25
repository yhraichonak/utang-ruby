Before do
  @AS_Admin_Screen = AS_Admin_Screen.new selenium, appium
end

Then(/^I should see the AS Admin screen$/) do 
  expect(@AS_Admin_Screen.title.text).to eq "AS1 Admin"
end

When(/^I select "(.*?)" from the main AS Admin screen$/) do |which|
  @AS_Admin_Screen.selection(which).click
end

Then(/^I should see the "(.*?)" details screen$/) do |which|
  expect(@AS_Admin_Screen.title.text).to eq which
end

When(/^I select "(.*?)" from the main Global Services screen$/) do |which|
  @AS_Admin_Screen.selection(which).click
end

Then(/^I should see the "(.*?)" popup screen$/) do |which|
  expect(@AS_Admin_Screen.alert_title.text).to eq which
end

When(/^I select "(.*?)" from the main Global Services popup screen$/) do |which|
  @AS_Admin_Screen.checked_text_selection(which).click
end
