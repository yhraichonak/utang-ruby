Before do
  @Ventilator_screen = Ventilator_screen.new selenium, appium 
end

Then(/^the Settings grid disappears$/) do 
  @Ventilator_screen.select_discrete.exists.should be true
end
  
Then(/^the patient summary screen displays$/) do
  sleep(10)
  #Common.wait_for_loading_prompt(selenium)
  @Patient_Summary_screen.v_tile.text.should eql "VENTILATOR"
end

Then(/^the Settings grid displays$/) do 
  @Ventilator_screen.settings_grid.exists.should be true
end

When(/^I click on the VENTILATOR tile$/) do
  @Patient_Summary_screen.v_tile.click
end

Then(/^the VENTILATOR tile displays$/) do
   @Patient_Summary_screen.v_tile.text.should eql "VENTILATOR"
end 

Then(/^the most recent data displays in the column to the left of the legend$/) do
  #@Ventilator_screen.
end

Then(/^I should see past logs$/) do
  #@Ventilator_screen.
end

Then(/^the discrete banner displays$/) do
  #puts "discrete_row exists = #{@Ventilator_screen.discrete_row.exists}"
  expect(@Ventilator_screen.discrete_row.exists).to be true
  @Ventilator_screen.discrete_row.exists.should be true
end

Then(/^I click the trends toggle button$/) do
  @Ventilator_screen.discretes_toggle.click
end

Then(/^I click the grid toggle button$/) do
  @Ventilator_screen.grid_toggle.click
end

Then(/^the Ventilator screen displays$/) do
  @Ventilator_screen.settings_grid.exists.should be true
end

When(/^I click on the discrete named "([^"]*)"$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^the "([^"]*)" trend displays$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^the time stamp displays in (\d+) hour format$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I click on the trend toggle button$/) do
  @Ventilator_screen.trends_toggle.click
end

Then(/^the "([^"]*)" trend disappears$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I should see the VENTILATOR tile$/) do
  @Patient_Summary_screen.ventilator_tile.text == "VENTILATOR"
end

When(/^I click on the overflow button on the vent screen$/) do
  @Ventilator_screen.vent_options.click
end

When(/^I click the refresh button on the vent screen$/) do
  @Ventilator_screen.vent_refresh.click
end

When(/^I click to vent Events$/) do
    if (@Ventilator_screen.tablet_alarm.exists == true)
     sleep(3)
     @Ventilator_screen.tablet_alarm.click
    elsif (@Ventilator_screen.tablet_alarm.exists == false)
    steps %{
		 When I click on the overflow button on the vent screen
     And I click on Events from the vent options
      }
    end
end

Then(/^I click on Events from the vent options$/) do
  @Ventilator_screen.vent_events.click
end

Then(/^the Events page displays$/) do
  @Ventilator_screen.alarm_date_list.exists.should be true
end

When(/^I click the Share button from the vent screen$/) do
  @Ventilator_screen.vent_share.click
end

Then(/^the alarm Date column displays$/) do
  @Ventilator_screen.alarm_date_list.exists.should be true
end

Then(/^the alarm Time column displays$/) do
  @Ventilator_screen.alarm_time.exists.should be true
end

Then(/^the Alarm Type column displays$/) do
  @Ventilator_screen.alarm_type.exists.should be true
end

Then(/^the Alarm Status column displays$/) do
  @Ventilator_screen.alarm_status.exists.should be true
end

Then(/^the Ventilator icon displays$/) do
  @Ventilator_screen.vent_icon.exists.should be true
end

Then(/^the Share Patient Details window displays$/) do
  @Ventilator_screen.share_patientdetail.exists.should be true
end

Then(/^I select the To field$/) do
  @Ventilator_screen.select_recip.click
end

Then(/^I select my recipient$/) do
  @Ventilator_screen.recip.click
end

Then(/^message sent successfully displays$/) do 
  @Ventilator_screen.msg_success.text ==  "Message Sent Successfully"
end

When(/^I click on the patient's name$/) do
   @Ventilator_screen.vent_pName.click
end

Then(/^I can view the patient's last name, first name, gender, age, MRN, location, and site$/) do
  puts @Ventilator_screen.vent_pName.text
  puts @Ventilator_screen.vent_pGender.text
  puts @Ventilator_screen.vent_pAge.text
  puts @Ventilator_screen.vent_pMRN.text
  puts @Ventilator_screen.vent_pLocation.text
  puts @Ventilator_screen.vent_pSite.text
  @Ventilator_screen.vent_pName.exists.should be true
  @Ventilator_screen.vent_pGender.exists.should be true
  @Ventilator_screen.vent_pAge.exists.should be true
  @Ventilator_screen.vent_pMRN.exists.should be true
  @Ventilator_screen.vent_pLocation.exists.should be true
  @Ventilator_screen.vent_pSite.exists.should be true
end

When(/^I click VIEW CONVERSATION$/) do
  @Ventilator_screen.view_convo.click
end

Then(/^the conversation window displays$/) do
  @Ventilator_screen.msg_item.exists.should be true
end

Then(/^a link with the patient's name displays$/) do
  @Ventilator_screen.vent_link.exists.should be true
end

When(/^I click on the link$/) do
  @Ventilator_screen.vent_link.click
end

When(/^I click the To field$/) do
  @Ventilator_screen.select_recip.click
end

When(/^I click on the Settings column$/) do
  Appium::TouchAction.new.press( :x => 900, :y => 900, :count => 100).release.perform
end

When(/^I swipe the grid to the "(.*?)"$/) do |direction|	
    if direction == "right"
      Appium::TouchAction.new.swipe(:start_x => 300, :start_y => 900, :end_x => 900, :end_y => 900, :duration => 1000).perform
    elsif direction == "left"
      Appium::TouchAction.new.swipe(:start_x => 200, :start_y => 900, :end_x => 1000, :end_y => 900, :duration => 1000).perform
    elsif direction == "down"
      Appium::TouchAction.new.swipe(:start_x => 500, :start_y => 1000, :end_x => 500, :end_y => 300, :duration => 1000).perform
    end
  end

When(/^I swipe the events screen to the "(.*?)"$/) do |direction|	
    if direction == "right"
      Appium::TouchAction.new.swipe(:start_x => 200, :start_y => 900, :end_x => 900, :end_y => 900, :duration => 1000).perform
    elsif direction == "left"
      Appium::TouchAction.new.swipe(:start_x => 900, :start_y => 900, :end_x => 300, :end_y => 900, :duration => 1000).perform
    elsif direction == "down"
      Appium::TouchAction.new.swipe(:start_x => 500, :start_y => 1000, :end_x => 500, :end_y => 300, :duration => 1000).perform
    end
  end

Then(/^I click on a cell that displays a triangle or asterisk$/) do
  #@Ventilator_screen.vent_link.click
end

When(/^I click on About from the vent options$/) do
  @Ventilator_screen.vent_about.click
  sleep(3)
end

Then(/^the About screen displays from the vent options$/) do
  sleep(3)
  @Ventilator_screen.about_title.exists.should be true
end

When(/^I click the OK button$/) do
  @About_window.ok_button.click
end

When(/^I click the refresh button on the ventilator screen$/) do
  @Ventilator_screen.vent_refresh.click
end

When(/^I click the refresh button on the ventilator events screen$/) do
  pending # express the regexp above with the code you wish you had
  ##{APP_PACKAGE}:id/menu_reload
end

And(/^the Events button displays$/) do
  if (@Ventilator_screen.vent_events.text ==  "Events")
  sleep(3)
  elsif (@Ventilator_screen.tablet_alarm.exists == false)
      next
  end
end

And(/^the Share button displays$/) do
  @Ventilator_screen.vent_share.text ==  "Share"
end

And(/^the Logout button displays$/) do
  @Ventilator_screen.vent_logout.text ==  "Logout"
end

And(/^the Settings button displays$/) do
  @Ventilator_screen.vent_settings.text ==  "Settings"
end

And(/^the About button displays$/) do
  @Ventilator_screen.vent_about.text ==  "About"
end

When(/^the build number is recorded$/) do
  puts @Ventilator_screen.app_v.text
  puts @Ventilator_screen.build_v.text
  @Ventilator_screen.app_v.exists.should be true
  @Ventilator_screen.build_v.exists.should be true
end

When(/^the device info is recorded$/) do
  puts @Ventilator_screen.device_mod.text
  puts @Ventilator_screen.device_OS.text
  @Ventilator_screen.device_mod.exists.should be true
  @Ventilator_screen.device_OS.exists.should be true
end
