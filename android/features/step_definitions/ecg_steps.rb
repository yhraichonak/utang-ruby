include Constants

Before do
  @Alert_window = Alert_window.new selenium, appium
  @ECG_View_screen = ECG_View_screen.new selenium, appium
  @ZoomLead_screen = ZoomLead_screen.new selenium, appium
  @Menu = Menu.new selenium, appium
  @selenium = selenium
end

Then(/^I should see the ecg list on ECG screen$/) do
  while @ECG_View_screen.ecg_list_slide_empty.exists == true
    @ECG_View_screen.close_menu_button.click
    sleep(0.5)
  end
  @ECG_View_screen.ecg_scroll_view.exists.should be true
end

When(/^I click the MIView button$/) do
  wait_for(3) { @ECG_View_screen.ecg_miview_element.exists == true }
  @ECG_View_screen.ecg_miview_button.click
end

Then(/^I should see the MIView screen$/) do
  wait_for(5) { @ECG_View_screen.ecg_details_element.exists == true }
end

When(/^I click the ECG Details button$/) do
  wait_for(3) { @ECG_View_screen.ecg_details_element }
  @ECG_View_screen.ecg_details_button.click
end

Then(/^I should see the ECG Details Info$/) do
  wait_for(5) { @ECG_View_screen.ecg_patient_details_legend.exists == true }
end

Then(/^I should see the patient name info in the demographics header$/) do
  wait_for(5) { expect(@ECG_View_screen.ecg_demo_patient_name.exists).to be true }
end

Then(/^I should see the patient gender info in the demographics header$/) do
  wait_for(5) { expect(@ECG_View_screen.ecg_demo_patient_gender.exists).to be true }
end

Then(/^I should see the patient age info in the demographics header$/) do
  wait_for(5) { expect(@ECG_View_screen.ecg_demo_patient_age.exists).to be true }
end

Then(/^I should see the patient MRN info in the demographics header$/) do
  wait_for(5) { expect(@ECG_View_screen.ecg_demo_patient_mrn.exists).to be true }
end

Then(/^I should see the patient location info in the demographics header$/) do
  wait_for(5) { expect(@ECG_View_screen.ecg_demo_patient_location.exists).to be true }
end

Then(/^I should see the patient site info in the demographics header$/) do
  wait_for(5) { expect(@ECG_View_screen.ecg_demo_patient_site.exists).to be true }
end

Then(/^I should see the following ecg on row (\d+) of ecg list$/) do |row, table|
  data = table.rows_hash
  @ECG_View_screen.ecg_list_info(row)["diagnosis"].should eql data["diagnosis"]
  @ECG_View_screen.ecg_list_info(row)["time"].should eql data["time"]
end

When(/^I click on row (\d+) on ecg list$/) do |row|
  @ECG_View_screen.ecg_list(row).click
  @Alert_window.handle_alert(title=ALERT_TITLE_ACK_ECG, action=ALERT_CANCEL)
end

Then(/^I should see the patient ECG screen$/) do
  wait_for(10) { @ECG_View_screen.threeSecondLeadGrid_element.exists == true }
  wait_for(10) { !@ECG_View_screen.tvCardioDatetime_element.text.include?("--") }
end

Then(/^I should see the ECG screen(| of .* patient)$/) do |patient|
  wait_for(20) { @ECG_View_screen.threeSecondLeadGrid_element.exists == true }
  if patient.include? 'patient'
    patient = process_param(patient.split[1])
    expect(@ECG_View_screen.getPatientInfoFromHeader['name']).to eql patient
  end
end

Then(/^I should see the patient 3 second ECG grid/) do
  @ECG_View_screen.threeSecondLeadGrid_element.exists.should be true
end

Then(/^I should see the patient details displayed on the ECG screen/) do
  @ECG_View_screen.ecg_patient_details_legend.exists.should be true
end

Then(/^I should see the patient 10 second ECG grid$/) do
  @ECG_View_screen.tenSecondLeadGrid_element.exists.should be true
end

Then(/^I should see the 10 sec leads$/) do
  @ECG_View_screen.tenSecLeadElement("aVL")
end

Then(/^I should see the 15 waveforms I II III aVR aVL aVF V1 V2 V3 V4 V5 V6 V3R V4R V7 waveforms display$/) do
	expect(@ECG_View_screen.tenSecondLead_element("I").text).to eq "I"
	expect(@ECG_View_screen.tenSecondLead_element("II").text).to eq "II"
	expect(@ECG_View_screen.tenSecondLead_element("III").text).to eq "III"
	expect(@ECG_View_screen.tenSecondLead_element("aVR").text).to eq "aVR"
	expect(@ECG_View_screen.tenSecondLead_element("aVL").text).to eq "aVL"
	expect(@ECG_View_screen.tenSecondLead_element("aVF").text).to eq "aVF"
	expect(@ECG_View_screen.tenSecondLead_element("V1").text).to eq "V1"
	expect(@ECG_View_screen.tenSecondLead_element("V2").text).to eq "V2"
	expect(@ECG_View_screen.tenSecondLead_element("V3").text).to eq "V3"
	expect(@ECG_View_screen.tenSecondLead_element("V4").text).to eq "V4"
	expect(@ECG_View_screen.tenSecondLead_element("V5").text).to eq "V5"
  expect(@ECG_View_screen.tenSecondLead_element("V6").text).to eq "V6"
  expect(@ECG_View_screen.tenSecondLead_element("V3R").text).to eq "V3R"
  expect(@ECG_View_screen.tenSecondLead_element("V4R").text).to eq "V4R"
  expect(@ECG_View_screen.tenSecondLead_element("V7").text).to eq "V7"
end

Then(/^I should see the patient ECG screen with (.*?) 3sec leads and (.*?) rhythm strips$/) do |countOf3SecLeads, countOfRhythm|
  @ECG_View_screen.threeSecondLead_element("I").text.should eq "I"
  @ECG_View_screen.threeSecondLead_element("II").text.should eq "II"
  @ECG_View_screen.threeSecondLead_element("III").text.should eq "III"
  @ECG_View_screen.threeSecondLead_element("aVR").text.should eq "aVR"
  @ECG_View_screen.threeSecondLead_element("aVL").text.should eq "aVL"
  @ECG_View_screen.threeSecondLead_element("aVF").text.should eq "aVF"
  @ECG_View_screen.threeSecondLead_element("V1").text.should eq "V1"
  @ECG_View_screen.threeSecondLead_element("V2").text.should eq "V2"
  @ECG_View_screen.threeSecondLead_element("V3").text.should eq "V3"
  @ECG_View_screen.threeSecondLead_element("V4").text.should eq "V4"
  @ECG_View_screen.threeSecondLead_element("V5").text.should eq "V5"
  @ECG_View_screen.threeSecondLead_element("V6").text.should eq "V6"

  @ECG_View_screen.tenSecondLead_element("I").text.should eq "I"
  @ECG_View_screen.tenSecondLead_element("II").text.should eq "II"
  @ECG_View_screen.tenSecondLead_element("III").text.should eq "III"
  @ECG_View_screen.tenSecondLead_element("aVR").text.should eq "aVR"
  @ECG_View_screen.tenSecondLead_element("aVL").text.should eq "aVL"
  @ECG_View_screen.tenSecondLead_element("aVF").text.should eq "aVF"
  @ECG_View_screen.tenSecondLead_element("V1").text.should eq "V1"
  @ECG_View_screen.tenSecondLead_element("V2").text.should eq "V2"
  @ECG_View_screen.tenSecondLead_element("V3").text.should eq "V3"
  @ECG_View_screen.tenSecondLead_element("V4").text.should eq "V4"
  @ECG_View_screen.tenSecondLead_element("V5").text.should eq "V5"

  #if state code below doesnt work yet
  #if @ECG_screen.getCountOf10SecLeadsOnScreen == 15
  #  @ECG_screen.tenSecondLead_element("V3R").exists.should be true
  #  @ECG_screen.tenSecondLead_element("V4R").exists.should be true
  #  @ECG_screen.tenSecondLead_element("V7").exists.should be true
  #end

  #swipe back to top of screen
  selenium.execute_script 'mobile: swipe', :startX => 0.5, :startY => 0.2, :endX => 0.5, :endY => 0.9, :duration => 0.5
  selenium.execute_script 'mobile: swipe', :startX => 0.5, :startY => 0.2, :endX => 0.5, :endY => 0.9, :duration => 0.5

end

Then(/^I should see the following info in patient banner on ECG screen$/) do |table|
  data = table.rows_hash
  patientDetails = @ECG_View_screen.getPatientInfoFromHeader
  patientDetails["name"].should eq data["name"]
  patientDetails["gender"].should match data["gender"]
  patientDetails["age"].should match data["age"]
  patientDetails["site"].should match data["site"]
  patientDetails["mrn"].should match data["mrn"]
end

When(/^I click the chevron$/) do
  begin
    retries ||= 0
    @ECG_View_screen.chevron.click
    @ECG_View_screen.ecg_patient_details_legend.exists.should be true
  rescue RSpec::Expectations::ExpectationNotMetError
    retry if (retries += 1) < 3
  end
end

When(/^I click on the Edit button after confirming an ECG$/) do
  sleep(45)
  @ECG_View_screen.edit_button.click
end

When(/^I click on the Edit button$/) do
  @ECG_View_screen.edit_button.click
end

When(/^I click the ECGS button$/) do
  #sleep(1)
  @ECG_View_screen.ecgs_button.click
end

When(/^I click the ECGs List button$/) do
  sleep(2) #Sleep is needed because the click happens before the ECG is fully loaded
  @ECG_View_screen.ecgs_list.click
end

Then(/^I should see the patient details$/) do
  #@eyes.check_window("ECG Screen - demographic details")
end

Then(/^I reset the scrubber$/) do
  sleep(1)
  Appium::TouchAction.new.swipe(:start_x => 200, :start_y => 600, :end_x => 1000, :end_y => 600, :duration => 500).perform
  sleep(1)
  element = @selenium.find_element(:id, "#{APP_PACKAGE}:id/cardio_scruber_view")
  element.click
end

When(/^I double click on 3 sec Lead "(.*?)"$/) do |lead|
  @wait.until{ @ECG_View_screen.ecgs_list.displayed? == true }
  $AFFECTED_LEAD = lead
  $ECG_THREE = @ECG_View_screen.threeSecondLead_element(lead)
  expect($ECG_THREE.attribute("enabled")).to eq "true"

  e = $ECG_THREE

  location = e.location
  offsetX = 20
  offsetY = 20
  @selenium.action
           .pause(duration: 1)
           .move_to_location(location.x + offsetX, location.y + offsetY)
           .click
           .pause(duration: 0.1)
           .click
           .perform

  sleep(1)
	begin
		while(@ECG_View_screen.threeSecondLead_element(lead).displayed? == false)
			puts "the 3 second element has not displayed for #{$AFFECTED_LEAD}"
      @selenium.action
               .move_to_location(location.x + offsetX, location.y + offsetY)
               .click
               .pause(duration: 0.1)
               .click
               .perform
		end
	rescue
		 #@appiumDriver.screenshot "#{SCREEN_PATH}/#{$AFFECTED_LEAD}_error#{Common.random_time}.png"
	end

	 #@appiumDriver.screenshot "#{SCREEN_PATH}/#{$AFFECTED_LEAD}_#{Common.random_time}.png"
end

When(/^I double click on 10 sec Lead "(.*?)"$/) do |lead|
	puts "** 10 sec Lead: %s" % lead

	#Common.wait_for_loading_prompt(selenium)
	# $ECG_TEN = @ECG_View_screen.tenSecondLead_element(lead)
  $ECG_TEN = @selenium.find_element(:id, "#{APP_PACKAGE}:id/avf")
	expect($ECG_TEN.attribute("enabled")).to eq "true"
	element = $ECG_TEN

	location = element.location
  puts location
	offsetX = 5
	offsetY = 5
  puts location[:x] + offsetX
  puts location[:y] + offsetY
  @selenium.action
           .pause(duration: 1)
           .move_to_location(location.x + offsetX, location.y + offsetY)
           .click
           .pause(duration: 0.1)
           .click
           .perform
  # 2.times { Appium::TouchAction.new.tap( :x => location[:x] + offsetX, :y => location[:y] + offsetY, :count => 10).release.perform }
	 #@ECG_View_screen.tenSecondLead_element(lead).doubleClick(50,50)
end

When(/^I swipe the scrubber to the "(.*?)"$/) do |direction|
  if direction == "right"
    @selenium.action
             .move_to_location(200, 1700)  # Start point
             .click_and_hold
             .move_to_location(800, 1700)   # End point
             .release
             .perform
  elsif direction == "left"
    @selenium.action
             .move_to_location(800, 1700)  # Start point
             .click_and_hold
             .move_to_location(200, 1700)   # End point
             .release
             .perform
  end
  sleep(2)
end

When(/^I pinch zoom "(.*?)" on ECG screen$/) do |action|
	if action == "in"
		element = @selenium.find_element(:id, "#{APP_PACKAGE}:id/cardio_ecg_grid")

    center_x = element.size[:width] / 2
    center_y = element.size[:height] / 2

    # Create action builders
    action_builder = @selenium.action

    # First touch action
    touch1 = action_builder.add_pointer_input(:touch, 'finger1')
    touch1.create_pointer_move(duration: 0, x: center_x, y: center_y)
    touch1.create_pointer_down(:left)
    touch1.create_pointer_move(duration: 1, x: center_x - 200, y: center_y - 200)
    touch1.create_pause(1)
    touch1.create_pointer_up(:left)

    # Second touch action
    touch2 = action_builder.add_pointer_input(:touch, 'finger2')
    touch2.create_pointer_move(duration: 0, x: center_x + 200, y: center_y + 200)
    touch2.create_pointer_down(:left)
    touch2.create_pointer_move(duration: 1, x: center_x + 300, y: center_y + 300)
    touch2.create_pause(1)
    touch2.create_pointer_up(:left)

    # Perform the actions
    action_builder.perform

    # Perform the actions
    action_builder.perform

	elsif action == "out"

		element = @selenium.find_element(:id, "#{APP_PACKAGE}:id/cardio_ecg_grid")

    center_x = element.size[:width] / 2
    center_y = element.size[:height] / 2

    # Create action builders
    action_builder = @selenium.action

    # First touch action
    touch1 = action_builder.add_pointer_input(:touch, 'finger1')
    touch1.create_pointer_move(duration: 0, x: center_x - 200, y: center_y - 200)
    touch1.create_pointer_down(:left)
    touch1.create_pointer_move(duration: 1, x: center_x, y: center_y)
    touch1.create_pause(1)
    touch1.create_pointer_up(:left)

    # Second touch action
    touch2 = action_builder.add_pointer_input(:touch, 'finger2')
    touch2.create_pointer_move(duration: 0, x: center_x + 300, y: center_y + 300)
    touch2.create_pointer_down(:left)
    touch2.create_pointer_move(duration: 1, x: center_x - 200, y: center_y - 200)
    touch2.create_pause(1)
    touch2.create_pointer_up(:left)

    # Perform the actions
    action_builder.perform
	end
end

When(/^I pinch OLD zoom "(.*?)" on ECG screen$/) do |action|
  if action == "in"
    @selenium.execute_script 'mobile: pinchClose', :element => @ECG_View_screen.threeSecondLeadGrid_element.ref

  elsif action == "out"
    @selenium.execute_script 'mobile: pinchOpen', :element => @ECG_View_screen.threeSecondLeadGrid_element.ref
  end
  sleep(1)
end

When(/^I click the ECGs sbutton$/) do
  #Common.wait_for_loading_prompt(selenium)
  sleep(1)
  if(@Menu.ecg_list_button.exists)
	@Menu.ecg_list_button.click
  elsif(@Menu.miviewer_button.nil? || @Menu.color_icon.nil?)
	@Menu.ecg_banner_button.click
  else
	@Menu.more_options_button.click
	@Menu.ecgs_button_overflow.click
  end
end

When(/^I click the ECGs option$/) do
  @ECG_View_screen.ecgs_option.click
end

When(/^I click the options button$/) do
  @ECG_View_screen.options_button.click
end

Then(/^I should see the ECG List window$/) do
  @wait.until{ @ECG_View_screen.ecg_slider_container.displayed? == true }
  expect( @ECG_View_screen.ecg_slider_container.displayed? == true )
end

When(/^I click on the ECG on row (\d+)$/) do |row|
  @ECG_View_screen.ecg_list(row).click
  # @Alert_window.handle_alert(title=ALERT_TITLE_ACK_ECG, action=ALERT_CANCEL)
end

When(/^I click on another ECG on row (\d+)$/) do |row|
  @ECG_View_screen.ecg_list(row).click
  # @Alert_window.handle_alert(title=ALERT_TITLE_ACK_ECG, action=ALERT_CANCEL)
end

When(/^I click the more options button then the ECGs button$/) do
  #Common.wait_for_loading_prompt(selenium)
  if(@Menu.ecg_list_button.exists)
	  puts "11111"
	@Menu.ecg_list_button.click
  elsif(@Menu.miviewer_button.nil? || @Menu.color_icon.nil?)
	  puts "22222"
	@Menu.ecg_banner_button.click
  else
	  puts "333333"
	@Menu.more_options_button.click
	sleep 1
	@Menu.ecgs_button_overflow.click
  end
end
