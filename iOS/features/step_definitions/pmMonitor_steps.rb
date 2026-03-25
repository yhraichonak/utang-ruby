Before do
  @PMMonitor_screen = PMMonitor_screen.new selenium, appium
  @TrendedData_screen = TrendedData_screen.new selenium, appium
end

Then(/^I should see the MONITOR screen not LIVE at "(.*)" timestamp$/) do |timestamp|
  expect(@PMMonitor_screen.live_button.displayed?).to be_truthy
  if timestamp.start_with?("contains:")
    timestamp=process_param(timestamp.gsub("contains:",""))
    expect(@appiumDriver.find_element(:xpath, "//XCUIElementTypeStaticText[contains(@value,\"#{timestamp}\")]").displayed?).to be_truthy
  else
    expect(@appiumDriver.find_element(:xpath, "//XCUIElementTypeStaticText[@name=\"#{timestamp}\"]").displayed?).to be_truthy
  end
end

Then(/^I should see the Live Monitor screen(| of .* patient)$/) do |patient|
  sleep 4
  begin
    @wait.until { @PMMonitor_screen.live_button.displayed? == true }
    expect(@PMMonitor_screen.live_button.displayed?).to be_truthy
  rescue
    @wait.until { @PMMonitor_screen.live_button.displayed? == true }
    expect(@PMMonitor_screen.live_button.displayed?).to be_truthy
  end
  if (patient.include? "patient")
    patient = process_param(patient.split[1])
    expect(@PMMonitor_screen.patient_name.text).to eql patient
  end
end

When(/^I click on discrete value "(.*?)"$/) do |discrete|
  if discrete == "HR {beat}/min"
    if $sitenbr == "39"
      discrete = "HR /min"
    else

    end
  elsif discrete == "NBP mm[Hg]"
    if $sitenbr == "39"
      discrete = "BP mmHg"
    else

    end
  elsif discrete == "PulseRate {beat}/min"
    if $sitenbr == "39"
      discrete = "SpO2 PR /min"
    else

    end
  end

  element = @PMMonitor_screen.discreet_elementType(discrete)
  Common.click_center_of_object(element)
end

Then(/^I should see the trended value screen$/) do
  sleep 7
  expect(@TrendedData_screen.navigationBar.exists).to be_truthy
end

When(/^I close the trended value screen$/) do
  element = @TrendedData_screen.close_button
  Common.click_center_of_object(element)
end

When(/^I click back on the trended value screen$/) do
  if @appVersion == "1.5.2100" || @appVersion == "1.5.2300"
    element = @TrendedData_screen.close_button
    Common.click_center_of_object(element)
  elsif @appVersion == "1.6.0"
    element = @TrendedData_screen.back_button
    Common.click_center_of_object(element)
  else
    element = @TrendedData_screen.back_button
    Common.click_center_of_object(element)
  end
end

When(/^I click done on the trended value screen$/) do
  # if @appVersion == "1.5.2100" || @appVersion == "1.5.2300"
  #   element = @TrendedData_screen.close_button
  #   Common.click_center_of_object(element)
  # elsif @appVersion == "1.6.0"
  #   element = @TrendedData_screen.back_button
  #   Common.click_center_of_object(element)
  # else
  #   element = @TrendedData_screen.done_button
  #   Common.click_center_of_object(element)
  # end
  if $is_7x_version
    @TrendedData_screen.back_button.click
  else
    @TrendedData_screen.done_button.click
  end

end

When(/^I click on waveform "(.*?)"$/) do |wave|
  waveform=process_param(wave)
  if waveform == "ECG-II"
    if $sitenbr == "39"
      wave = "II"
    else

    end
  elsif waveform == "NBP mm[Hg]"
    if $sitenbr == "39"
      wave = "BP mmHg"
    else

    end
  elsif waveform == "PulseRate {beat}/min"
    if $sitenbr == "39"
      wave = "SpO2 PR /min"
    else

    end
  end

  element = @PMMonitor_screen.waveform_button(waveform)
  Common.click_center_of_object(element)
end

When(/^I doubleclick on waveform "(.*?)"$/) do |wave|
  element = @PMMonitor_screen.waveform_button(wave)
  Common.click_center_of_object(element)
  Common.click_center_of_object(element)
end

Then(/^I should see the waveform disabled$/) do
  expect(@PMMonitor_screen.waveform_indicator_button(1).value).to be_nil
end

Then(/^I should see the waveform enable$/) do
  expect(@PMMonitor_screen.waveform_indicator_button(1).value).to be_truthy
end

Then(/^I should see the all other waveforms disabled$/) do

end

Then(/^I should see the all other waveforms enabled$/) do

end

Then(/^I should see the Monitor screen for Event$/) do
  @wait.until { @PMMonitor_screen.live_button.displayed? == true }
  expect(@PMMonitor_screen.live_button.displayed?).to be_truthy
end

When(/^I click the close button on Monitor screen$/) do
  element = @PMMonitor_screen.close_button
  Common.click_center_of_object(element)
end

When(/^I click the back button on Monitor screen$/) do
	if @appVersion == "1.5.2100" || @appVersion == "1.5.2300"
		element = @PMMonitor_screen.close_button
		Common.click_center_of_object(element)
	elsif @appVersion == "1.6.0"
		element = @PMMonitor_screen.back_button
		element.click
	#Common.click_center_of_object(element)
	else
		element = @PMMonitor_screen.back_button
		element.click
		 #Common.click_center_of_object(element)
	end
end

When(/^I swipe "(.*?)" on the waveforms$/) do |direction|
  if direction == 'up'
    do_swipe(200,100,300,200)
	  # Appium::TouchAction.new.swipe(:start_x => 200, :start_y => 100, :end_x => 300, :end_y => 200, :duration => 100).perform

  elsif direction == 'down'
    do_swipe(200,300,300,200)
	  # Appium::TouchAction.new.swipe(:start_x => 200, :start_y => 300, :end_x => 300, :end_y => 200, :duration => 100).perform

  elsif direction == 'right'
    do_swipe(100,400,300,400)
   # Appium::TouchAction.new.swipe(:start_x => 100, :start_y => 400, :end_x => 300, :end_y => 400, :duration => 100).perform

  elsif direction == 'left'
    do_swipe(300,500,200,500)
	  # Appium::TouchAction.new.swipe(:start_x => 300, :start_y => 500, :end_x => 200, :end_y => 500, :duration => 100).perform

  end
end

Then(/^I should see historical data for the waveforms \(not Live mode\)$/) do
  expect(@PMMonitor_screen.live_button.value).to be_nil
end

When(/^I click the Live button$/) do
  element = @PMMonitor_screen.live_button
  Common.click_center_of_object(element)
end

When(/^I click on the options button on Live Monitor screen$/) do
  if ENV['DEVICE'].include? "iPad"
	puts ENV['DEVICE']
  else
	element = @PMMonitor_screen.options_button
	Common.click_center_of_object(element)
  end
end

When(/^I click the Share button$/) do
  element = @PMMonitor_screen.share_button
  Common.click_center_of_object(element)
end
