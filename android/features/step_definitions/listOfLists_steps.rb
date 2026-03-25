Before do
  @List_Of_Lists_window = List_Of_Lists_window.new selenium, appium
end

When(/^I click the AS1 button$/) do
  @wait.until { !!@List_Of_Lists_window.as_one_button.attribute("displayed") }
  @List_Of_Lists_window.as_one_button.click
  @wait.until { !!@List_Of_Lists_window.list_drawer.attribute("enabled") }
end

Then(/^I should see my ListOfList window$/) do
  expect(@List_Of_Lists_window.list_drawer.attribute("enabled")).to eq "true"
end

Then(/^I should see my ListOfList window refresh$/) do
  expect(@List_Of_Lists_window.is_list_menu_displayed).to eq false
end

Then(/^I should see the AS1 main menu button in the Open state$/) do
  expect(@List_Of_Lists_window.as_one_button.attribute('contentDescription')).to eq "Open"
end

Then(/^I should see the AS1 main menu button in the Closed state$/) do
  expect(@List_Of_Lists_window.as_one_close_button.attribute('contentDescription')).to eq "Close"
end

Then(/^I click the List of Lists back button$/) do
  @List_Of_Lists_window.as_one_close_button.click
end

Then(/^I should see the refresh button on the List of Lists$/) do
  expect(@List_Of_Lists_window.site_list_refresh_button.attribute('enabled')).to eq "true"
end

When(/^I click the refresh button in List of List menu$/) do
  @List_Of_Lists_window.site_list_refresh_button.click
end

When(/^I click "(.*?)" in List of List menu$/) do |listName|
  @List_Of_Lists_window.list_element(listName).click
end

When(/^I click OB Patient List in List of List window$/) do
   Appium::TouchAction.new.tap(:x => 200, :y => 1600, :duration => 100).perform
end

When(/^I click "(.*?)" in Cardio PM List of List window$/) do |listName|
  @List_Of_Lists_window.cardio_pm_list(listName).click
end

And(/^I should not see "(.*?)" in List of List window$/) do |listName|
  if(@List_Of_Lists_window.cardio_pm_list(listName).nil?)
	  expect(@List_Of_Lists_window.cardio_pm_list(listName)).to be_nil
  else
	  expect(@List_Of_Lists_window.cardio_pm_list(listName)).to eq("not found in list")
  end
end

And(/^I should see "(.*?)" in List of List window$/) do |listName|
  expect(@List_Of_Lists_window.cardio_pm_list(listName).displayed?).to be_truthy
end

When(/^utang displays in the banner$/) do
  expect(@List_Of_Lists_window.ce_marks.exists).to be true
end

When(/^the site name displays the footer$/) do
  expect(@List_Of_Lists_window.siteName_text.text.upcase).to eq $CI_SITE.upcase
end

When(/^I click the list of lists refresh button$/) do
  @List_Of_Lists_window.lol_refresh.click
end

When(/^the refresh button displays$/) do
  expect(@List_Of_Lists_window.lol_refresh.exists).to be true
end

When(/^I click on Training OB Census$/) do
	@List_Of_Lists_window.training_census[2].click
end
