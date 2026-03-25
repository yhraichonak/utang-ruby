Before do
  @Emr_screen = Emr_screen.new selenium, appium
end


When(/^I should see the choose a role screen$/) do
	expect(@Emr_screen.choose_role_text.displayed?).to be true 
end

When(/^I select the "(.*?)" role$/) do | role_name |	
	element = @Emr_screen.role_selection(role_name)
	Common.click_center_of_object(element)
end