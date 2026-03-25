Before do
  @Menu = Menu.new selenium, appium
  @GroupBySortBy = GroupBySortBy.new selenium, appium
  # @PMMonitor_screen = PMMonitor_screen.new selenium, appium
end

When(/^I select the new navigation Home button$/) do
    # TODO: get rid of Live mode turn off. WIth live mode  - click on any thing throws StaleElementException
    @PMMonitor_screen.live_button.click
    sleep(1)
    Common.click_center_of_object( @Menu.new_nav_home)
end

When(/^I select the new navigation Home button on pm screen for training site$/) do
  element = @Menu.new_nav_home_training_pm
  Common.click_center_of_object(element)
end

When(/^I select the new navigation Home button on docs screen for training site$/) do
  element = @Menu.new_nav_home_training_docs
  Common.click_center_of_object(element)

  @wait.until { @SnippetTool_Screen.new_nav_home_training_docs.displayed? == true }

  element = @Menu.new_nav_home_training_docs
  Common.click_center_of_object(element)
end

When(/^I select the new navigation Home button for training site$/) do
  @wait.until { @SnippetTool_Screen.new_nav_home_training.displayed? == true }

  element = @Menu.new_nav_home_training
  Common.click_center_of_object(element)
end

When(/^I select the menu back button$/) do
  element = @Menu.back_button
  Common.click_center_of_object(element)
end

When(/^I select the new navigation Monitor button$/) do
  element = @Menu.new_nav_monitor
  Common.click_center_of_object(element)
end

When(/^I select the new navigation Events button$/) do
  # TODO: get rid of Live mode turn off. WIth live mode  - click on any thing throws StaleElementException
  @PMMonitor_screen.live_button.click
  sleep(1)
  element = @Menu.new_nav_events
  Common.click_center_of_object(element)
end

When(/^I select the new navigation Tool button$/) do
  # TODO: get rid of Live mode turn off. WIth live mode  - click on any thing throws StaleElementException
  @PMMonitor_screen.live_button.click
  sleep(1)
  element = @Menu.new_nav_tool
  element.click
end

When(/^I select the new navigation Share button$/) do
  # TODO: get rid of Live mode turn off. WIth live mode  - click on any thing throws StaleElementException
  @PMMonitor_screen.live_button.click
  sleep(1)
  element = @Menu.new_nav_share
  Common.click_center_of_object(element)
end

When(/^I select the pm census filter button$/) do
  element = @Menu.pm_census_filter
  Common.click_center_of_object(element)
end

When(/^I select the pm group by sort by button$/) do
  element = @Menu.pm_group_sort_by
  Common.click_center_of_object(element)
end

Then(/^I should see the PM Census Filter Screen$/) do
  expect(@Menu.unit_filter_bar.displayed?).to be true
end

Then(/^I should see the PM Sort By Group By Screen$/) do
  expect(@Menu.group_sort_bar.displayed?).to be true
end

When(/^I select the group by option$/) do
  element = @GroupBySortBy.group_by_option
  Common.click_center_of_object(element)
end

Then(/^I should see the Group By Picker$/) do
  expect(@GroupBySortBy.picker_wheel.displayed?).to be true
end

When(/^I select the picker wheel$/) do
	@wait.until { @GroupBySortBy.group_by_picker.displayed? == true }
  element = @GroupBySortBy.group_by_picker

  x = element.size[:width] / 2
  y = element.size[:height] / 2

  #puts x
  #puts y

  offsetX = 0
  offsetY = 0

  Appium::TouchAction.new.tap( :x => x + offsetX, :y => y + offsetY, :count => 10).release.perform
end

And(/^I select the group by apply button$/) do
  element = @Menu.apply_button
  Common.click_center_of_object(element)
end

And(/^I scroll down on the group by wheel$/) do
  element = @Menu.apply_button
  Common.click_center_of_object(element)
end

When(/^I click the Tool button on Monitor screen from the overflow menu$/) do
	element = @Menu.pm_tool
	Common.click_center_of_object(element)
end

When(/^I click the Choose Time button on Monitor screen from the overflow menu$/) do
	if @appVersion == "1.5.2100" || @appVersion == "1.5.2300"
		if ENV['DEVICE'].include? "iPad"
			element = @PMMonitor_screen.choose_time_ipad_five
			Common.click_center_of_object(element)
		else
			element = @PMMonitor_screen.choose_time_overflow_button
			Common.click_center_of_object(element)
		end
	elsif @appVersion == "1.6"
		if ENV['DEVICE'].include? "iPad"
			element = @PMMonitor_screen.choose_time_ipad_six
			Common.click_center_of_object(element)
		else
			element = @PMMonitor_screen.choose_time_overflow_button
			Common.click_center_of_object(element)
		end
	end
end

When(/^I click the Choose Time button on Monitor screen$/) do
    if @appVersion == "1.5.2100" || @appVersion == "1.5.2300"
      if ENV['DEVICE'].include? "iPad"
        element = @PMMonitor_screen.choose_time_btn_ipad
        Common.click_center_of_object(element)
      else
        element = @PMMonitor_screen.choose_time_btn
        Common.click_center_of_object(element)
      end
    elsif @appVersion == "1.6.0"
      element = @PMMonitor_screen.chooseTime_button
      Common.click_center_of_object(element)
    else
      element = @PMMonitor_screen.chooseTime_button
      Common.click_center_of_object(element)
    end
end
