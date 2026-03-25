Before do
  @ChooseTime_screen = ChooseTime_screen.new selenium, appium
end

Then(/^I should see the Choose Time screen$/) do
  #expect(@ChooseTime_screen.chooseTime_button.nil?).to be_falsey
  
  expect(@ChooseTime_screen.now_text.nil?).to be_falsey
  expect(@ChooseTime_screen.today_text.nil?).to be_falsey
end

When(/^I select a time of (\d+) hours and (\d+) minutes/) do |hours, mins|
  @ChooseTime_screen.hour_pickerWheel.send_keys(hours)
  @ChooseTime_screen.minute_pickerWheel.send_keys(mins)
  @ChooseTime_screen.meridiem_pickerWheel.send_keys("AM")
end

When(/^I click the Choose Time button on the Choose Time Screen$/) do
  element = @ChooseTime_screen.chs_time_button
  Common.click_center_of_object(element)
end