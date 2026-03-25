Before do
  @Events_screen = Events_screen.new selenium, appium
end

When(/^I select the new nav monitor button on the events screen$/) do
  element = @Events_screen.new_nav_live_monitor_button
  Common.click_center_of_object(element)
end

Then(/^I should see the Events screen$/) do
  @wait.until { @Events_screen.navigationBar.displayed? == true }
  expect(@Events_screen.navigationBar.displayed?).to be_truthy
end

Then(/^I should see the Events screen of .* patient$/) do |patient|
  sleep 4
  begin
    @wait.until { @Events_screen.navigationBar.displayed? == true }
    expect(@Events_screen.navigationBar.displayed?).to be_truthy
  rescue
    @wait.until { @Events_screen.navigationBar.displayed? == true }
    expect(@Events_screen.navigationBar.displayed?).to be_truthy
  end
  if (patient.include? "patient")
    patient = process_param(patient.split[1])
    expect(@PMMonitor_screen.patient_name.text).to eql patient
  end
end

Then(/^I should see the Events screen with no events listed$/) do
  expect(@Events_screen.navigationBar.displayed?).to be_truthy
end

When(/^I click on the Live Monitor button$/) do
  element = @Events_screen.liveMonitor_button
  Common.click_center_of_object(element)
end

When(/^I click on Event on row (\d+)$/) do |row|
  begin
    no_events = @Events_screen.noEvent_staticText
    #puts no_events
  rescue StandardError => e

  end

  if no_events.nil? == false
    puts 'No Events listed for patient'
    steps %{
      When I select the new nav monitor button on the events screen
    }
  else
    element = @Events_screen.event_cell(row)
    Common.click_center_of_object(element)
  end
end

When(/^I click the Choose Time clock button$/) do
	@wait.until { @Events_screen.choose_time_btn_one_six.displayed? == true }
	element = @Events_screen.choose_time_btn_one_six
	Common.click_center_of_object(element)
end
