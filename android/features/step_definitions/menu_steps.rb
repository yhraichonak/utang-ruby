Before do
  @Menu = Menu.new selenium, appium
  @Unit_filter_window =  Unit_filter_window.new selenium, appium
  @Group_sort_window = Group_sort_window.new selenium, appium
end

When(/^I click the unit filter button$/) do
  @Menu.unit_filter_button.click 
end

Then(/^I should see the unit filter window/) do
  expect(@Unit_filter_window.title.text).to eq "Unit Filter" 
end

When(/^I click the unit filter toggle all button on$/) do
  sleep(1)
  values = @Unit_filter_window.unit_selection_object
  counter = 0
  
  for i in 0..(values.count - 1)
	if(values[i][1] == "true")	   
	   values[i][0].click
	else
		counter = counter + 1
	end
  end
  
  if(counter < values.count)
	@Unit_filter_window.toggle_all_button.click
	sleep 1
  end

  values = @Unit_filter_window.unit_selection_object
  counter = 0
  
  for i in 0..(values.count - 1)
	if(values[i][1] == "true")
	   counter = counter + 1
	end
  end
  # expect(counter).to eq values.count
end


When(/^I filter out all units except for "(.*?)"$/) do |unit_name|
  values = @Unit_filter_window.unit_selection_object
  counter = 0
  
  for i in 0..(values.count - 1)
	if(values[i][1] == "true")	   
	   values[i][0].click
	else
		counter = counter + 1
	end
  end
  
  for i in 0..(values.count - 1)
	if(values[i][0].text == unit_name)	   
	   values[i][0].click
	end
  end
end

When(/^I click the unit filter ok button$/) do
  @Unit_filter_window.ok_button.click 
end

When(/^I click the group sort button$/) do
  @Menu.group_sort_button.click 
end

Then(/^I should see the group sort window/) do
  expect(@Group_sort_window.title.text).to eq "Group/Sort"
end

When(/^I click the more options button then the Share button$/) do
  sleep 2
  @Menu.more_options_button.click
  sleep 1
  @Menu.share_button.click
  sleep 1
end

And(/^I click the more options button then the Logout button$/) do
  sleep (10)
  @Menu.more_options_button.click
  sleep 1
  @Menu.logout_button.click
  sleep 1
end

And(/^I click the more options button then the Refresh button$/) do
  @Menu.more_options_button.click
  @Menu.refresh_overflow.click
  sleep(10)
end

And(/^the site list displays$/) do
  expect(@Welcome_screen.as_welcome_logo.exists).to be true
  puts @Welcome_screen.as_welcome_logo.exists
end

And(/^I click About$/) do
  @Menu.about_button.click 
end

And(/^I click Sign Out$/) do
  @Welcome_screen.sign_out.click 
end

And(/^I click Yes$/) do
  @Welcome_screen.yes_button.click 
end

And(/^I click the group sort reset button$/) do
  @Group_sort_window.reset_button.click
end

When(/^I click the group by dropdown and select "(.*?)"$/) do |group_by_option|
  @Group_sort_window.reset_button.click
  sleep(1)
  @Group_sort_window.group_by_spinner.click
  sleep(1)
  @Group_sort_window.group_by_dropdown(group_by_option).click
  sleep(2)
end

When(/^I click the group sort invert button$/) do
  @Group_sort_window.group_by_invert.click
  sleep(1)
end

And(/^I click the group sort ok button$/) do 
  @Group_sort_window.ok_button.click
end

And(/^I click the yes button$/) do 
  @Signoff_window.yes_button.click
end

