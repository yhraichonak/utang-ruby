Before do
  @ECG_screen = ECG_screen.new selenium, appium
end

Then(/^I should see the patient ECG screen "(.*?)"$/) do |name|
  sleep 2
  @wait.until { @ECG_screen.navigationBar.name.include? 'Workspace' }
  @wait.until { @ECG_screen.threeSecondLead_element("aVR").name.include? "'titleLabel':aVR; 'zoomScale':4" }
	expect(@ECG_screen.navigationBar.visible).to include 'true'
end

Then(/^I should see the patient ECG screen$/) do
  sleep 5
  @wait.until { @ECG_screen.navigationBar.name.include? 'Workspace' }
  #@wait.until { @ECG_screen.threeSecondLead_element("aVR").displayed? == true }
  # @wait.until { @ECG_screen.threeSecondLead_element("aVR").name.include? "'titleLabel':aVR; 'zoomScale':4" }
	expect(@ECG_screen.navigationBar.visible).to include 'true'
end

When(/^I select the new nav Home button on the patient ecg screen$/) do
  # if $device_version == "13.7"
    element = @ECG_screen.new_nav_home_button
    Common.click_center_of_object(element)
  #  else
  #   element = @ECG_screen.new_nav_home_button14
  #   puts element.text
  # 	element.click()
  #  end
end

When(/^I select the new nav ECG button on the patient ecg screen$/) do
	element = @ECG_screen.new_nav_ecg_button
	Common.click_center_of_object(element)
end

When(/^I select the new nav Share button on the patient ecg screen$/) do
	element = @ECG_screen.new_nav_share_button
	Common.click_center_of_object(element)
end

Then(/^I should see the ECG Leads with appropiate zoom scale of "(.*?)" and of "(.*?)"$/) do |threeSecLeadsZoom, tenSecLeadsZoom|

end

Then(/^I should see the following info in patient banner on ECG screen$/) do |table|

end

Then(/^I should see the patient ECG displaying: "(.*?)"$/) do |ecgType, table|

end

Then(/^I should see the patient ECG displaying: SPS_500$/) do

end

Then(/^I should see the patient ECG displaying: Vector_Cardiogram$/) do

end

When(/^I click on the patient caret button$/) do
  element = @ECG_screen.caret_button
  Common.click_center_of_object(element)
end

Then(/^I should see detail patient info$/) do
  #.check_window("Patient ECG Detail Screen #{name}")
end

When(/^I double click on 3 sec Lead "(.*?)"$/) do |lead|

  #@wait.until { @ECG_screen.threeSecondLead_element(lead).displayed? == true }

  threeLead = @ECG_screen.threeSecondLead_element(lead).location
  selenium.execute_script 'mobile: doubleTap', :x => threeLead[:x]+50, :y => threeLead[:y]+50
end

When(/^I double click on 10 sec Lead "(.*?)"$/) do |lead|
  tenLead = @ECG_screen.tenSecondLead_element(lead)

  # trycount = 0
  # while tenLead.displayed? == false and trycount < 2
  #   @appiumDriver.scroll(:direction => "up", :dy)
  #   tenLead = @ECG_screen.tenSecondLead_element(lead)
  #   trycount = trycount + 1
  # end

  if desired_capabilities['deviceName'].include? 'iPad' and lead == 'V3'
    @appiumDriver.swipe(:direction => "up")
  end

  # if lead == 'V6'
  #   @appiumDriver.swipe(:direction => "up")
  # end
  #TODO: implement universal way to scroll the app
  unless tenLead.nil? || !tenLead.displayed?
    do_swipe(200,500,200,1000)
    tenLead = @ECG_screen.tenSecondLead_element(lead)
  end

  Common.do_small_swipe unless tenLead.rect.y <   $GLOBAL_APPIUM.manage.window.size.height*0.8
  Common.double_tap(tenLead)
end

Then(/^I should see 10 sec lead "(.*?)"$/) do |lead|
  tenLead = @ECG_screen.tenSecondLead_element(lead)

  if tenLead.displayed? == false
    @appiumDriver.swipe(:direction => "up")
    tenLead = @ECG_screen.tenSecondLead_element(lead)
  end

  tenLead = @ECG_screen.tenSecondLead_element(lead)
  expect(tenLead.nil?).to be_falsey
end

When(/^I pinch zoom out on ECG screen$/) do
  @appiumDriver.zoom(100, 200)
end

When(/^I click the ECG button$/) do
  @wait.until { @ECG_screen.ecgs_button.displayed? == true }
  element = @ECG_screen.ecgs_button
  Common.click_center_of_object(element)
end

Then(/^I should see the ECG List window$/) do
  @wait.until { @ECG_screen.ecg_list.displayed? == true }
  expect(@ECG_screen.ecg_list.displayed?).to be true
end

When(/^I click on another ECG on row (\d+)$/) do |row|
  element = @ECG_screen.ecg_tableCell(row)
  Common.click_center_of_object(element)
end

When(/^I longclick on another ECG on row (\d+)$/) do |row|
  location = @ECG_screen.ecg_tableCell(row).location
  @appiumDriver.touch_and_hold(:x => location[:x]+50, :y => location[:y]+20, :duration => 2)
end

When(/^I click on the X button on the ecg screen$/) do
  if(@appVersion == "1.6")
	 element = @ECG_screen.back_button
	 Common.click_center_of_object(element)
  else
	 element = @ECG_screen.x_button
	 Common.click_center_of_object(element)
  end
end

When(/^I swipe the scrubber to the "(.*?)"$/) do |arg|
  #puts selenium.page_source
  ### this works**********
  #@appiumDriver.execute_script("mobile: scroll", {element: tenLead, toVisible: true})
  ########
  if arg == "right"
    @appiumDriver.swipe(:direction => "left")
  else
    @appiumDriver.swipe(:direction => "right")
  end
end

When(/^I swipe the scrubber from "(.*?)" to "(.*?)" secs$/) do |arg, arg2|
  #puts selenium.page_source
  ### this works**********
  #@appiumDriver.execute_script("mobile: scroll", {element: tenLead, toVisible: true})
  ########
  startx = 0
  endx = 0

  if arg == "0"
    startx = 0
  elsif arg == "2.5"
    startx = 82
  elsif arg == "5"
    startx = 197
  elsif arg == "7.5"
    startx = 288
  end

  if arg2 == "0"
    endx = -50
  elsif arg2 == "2.5"
    endx = 92
  elsif arg2 == "5"
    endx = 200
  elsif arg2 == "7.5"
    endx = 295
  end
  location = @ECG_screen.ecgScrubber_image.location
  #Appium::TouchAction.new.press(x: startx, y: 433.98).wait(1).move_to(x: (endx-startx), y: 0).release.perform
  Appium::TouchAction.new.press(:x => location[:x]+50, :y => location[:y]+20).wait(3000).move_to(:x => (endx-location[:x]), :y => 0).release.perform
end

When(/^I click on the Edit\/Confirm button \(first click options button on iPhone\)$/) do
  if desired_capabilities['deviceName'].include? 'iPad'
    element = @ECG_screen.edit_button
    Common.click_center_of_object(element)
  else
    if $device_version == "13.7"
      element = @ECG_screen.options_button
      Common.click_center_of_object(element)
    else
      element = @ECG_screen.options_button14
      Common.click_center_of_object(element)
    end

    element = @ECG_screen.editAndConfirms_button
    Common.click_center_of_object(element)
  end
end

When(/^I click on the paper mode button$/) do
  if desired_capabilities['deviceName'].include? 'iPad'
    # element = @ECG_screen.paperMode_button_ipad
    element = @ECG_screen.options_button14
    Common.click_center_of_object(element)
  else
    if $device_version == "13.7"
      element = @ECG_screen.options_button
      Common.click_center_of_object(element)
    else
      element = @ECG_screen.options_button14
      Common.click_center_of_object(element)
    end
      element = @ECG_screen.paperMode_button
      Common.click_center_of_object(element)
  end
end

Then(/^I should see the ecg screen in paper mode$/) do
  # express the regexp above with the code you wish you had
  #@$eyes.check_window("ECG Screen Paper Mode")
end

Then(/^I should see the ecg screen in default color mode$/) do
  # express the regexp above with the code you wish you had
end


