# frozen_string_literal: true

Before do
  @PM_Navigation_Menu = PM_Navigation_Menu.new @selenium
end

Then(/^the main navigation "(.*?)" button is active$/) do |button_name|
  value = @PM_Navigation_Menu.main_nav_button(button_name)

  puts "value of status = #{value['status']}"
  puts "value of disabled = #{value['disabled']}"

  expect(value['status']).to be_truthy
end

Then(/^the main navigation "(.*?)" button is inactive$/) do |button_name|
  expect(@PM_Navigation_Menu.main_nav_button(button_name)['status']).to be_falsey
end

Then(/^I should see the "(.*?)" button is active$/) do |button_name|
  steps %(
      Then the "#{button_name}" button is active
    )
end
Then(/^the "(.*?)" button is active$/) do |button_name|
  sleep 2
  puts "the button color is #{@PM_Navigation_Menu.sub_nav_button(button_name)['button_obj'].css_value('color')}"
  puts @PM_Navigation_Menu.sub_nav_button(button_name)['status']
  expect(@PM_Navigation_Menu.sub_nav_button(button_name)['status']).to be_truthy
end

Then(/^I should see the "(.*?)" button is inactive$/) do |button_name|
  steps %(
      Then the "#{button_name}" button is inactive
    )
end
Then(/^the "(.*?)" button is inactive$/) do |button_name|
  sleep 2
  button_color = @PM_Navigation_Menu.sub_nav_button(button_name)['button_obj'].css_value('color')
  expect(button_color).to match '.*(125, 125, 125|153, 153, 153|102, 102, 102).*' #Gray
  #value = @PM_Navigation_Menu.sub_nav_button(button_name)['status']
  #puts "the status of button #{button_name} = #{value}"
  #expect(value).to be_falsey
end

Then(/^the "(.*?)" button is disabled$/) do |button_name|
  expect(@PM_Navigation_Menu.sub_nav_button(button_name)['disabled']).to be_truthy
end

When(/^I click the Back button in PM patient header$/) do
  @PM_Navigation_Menu.back_button.click
end

When(/^I click the "(.*?)" link in main navigation menu/) do |button_name|
  @PM_Navigation_Menu.main_nav_button(button_name)['button_obj'].click
end

When(/^I click the "(.*?)" button in sub navigation menu(.*?)$/) do | button_name, exception_statement |
   sleep 1
   initial_button_status= @PM_Navigation_Menu.sub_nav_button(button_name)['status']
  @PM_Navigation_Menu.sub_nav_button(button_name)['button_obj'].click
   sleep 1
  if button_name.include?('Monitor') && @PM_Navigation_Menu.sub_nav_button('Monitor')['status']==initial_button_status
    #TODO: sometimes for some reason double click is needed for running tests via autpmation
    @PM_Navigation_Menu.sub_nav_button(button_name)['button_obj'].click
  end
   if button_name == "Live"
     if (exception_statement == " expecting button inactive")
       @wait.until { @PM_Navigation_Menu.sub_nav_button(button_name)['status'] == false}
     else
       @wait.until { @PM_Navigation_Menu.sub_nav_button(button_name)['status'] != initial_button_status}
     end
     elsif (exception_statement != " expecting button inactive") && button_name != "Select Time"
      @wait.until { @PM_Navigation_Menu.sub_nav_button(button_name)['status'] == true}
  end

  @select_time = @PM_Navigation_Menu.sub_nav_button(button_name)['button_obj'] if (button_name == "Select Time") && @select_time.nil?
end

When(/^I click at the location of Select Time button on screen$/) do
  @selenium.action.move_to(@select_time).click.perform
end

When(/^I click the "(.*?)" button in vents navigation menu$/) do |string|
  @PM_Navigation_Menu.vents_sub_nav_button(string)['button_obj'].click
end

Then(/^I should not see PM Navigation link$/) do
  @selenium.manage.timeouts.implicit_wait = 2
  begin
    expect(@PM_Navigation_Menu.main_nav_button('Overview')['button_obj'].displayed?).to be_falsey
  rescue StandardError
    # dont expect it to find object thus rescue
  end
  @selenium.manage.timeouts.implicit_wait = DEFAULT_IMPLICIT_WAIT
end

Then(/^I should see the Docked Patient List button is greyed out$/) do
  @selenium.manage.timeouts.implicit_wait = 2
  greyed = @PM_Navigation_Menu.pm_monitor_sub_nav('patient')['status']
  expect(greyed).to be_falsey
end

Then(/^I should see the Docked Patient List is "(active|inactive)"$/) do |status|
  @selenium.manage.timeouts.implicit_wait = 2
  menu_active = @PM_Navigation_Menu.pm_monitor_sub_nav_isDisabled('patient')['enabled']
  puts "The Menu Option is Active: #{menu_active}"
  if status == 'inactive'
    expect(menu_active).to be_falsey
  else
    expect(menu_active).to be_truthy
  end
end

Then(/^I should see the Docked Event List is in (live|historical) mode$/) do |status|
  case status
  when "live"
    expect(@selenium.find_element(:css,"button.btn.live-toggle.live").displayed?).to be true
  when "historical"
    expect(@selenium.find_element("button.btn.live-toggle.live").displayed?).to be true
  else
    # type code here
  end
end

Then(/^I should see the (Monitor|Events|Tools) tab active in sub nav$/ ) do |tile|
  tab = @PM_Navigation_Menu.sub_nav_button(tile)
  expect(tab['status']).to be_truthy
  expect(tab['color']).to eql('rgba(28, 172, 221, 1)')
end
