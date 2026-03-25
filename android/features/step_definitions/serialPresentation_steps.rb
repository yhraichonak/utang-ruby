Before do
  @SerialPresentation_screen = SerialPresentation_screen.new selenium, appium
end

When(/^I double click on the top 3 sec Lead "(.*?)"$/) do |lead|
	sleep(2)
  Common.double_tap(@SerialPresentation_screen.top_ecg_grid_element(lead))
end

Then(/^I should see the serial presentation screen$/) do

	orientation = selenium.orientation.to_s
  if(orientation  == "landscape")
	expect(@SerialPresentation_screen.top_ecg_analysis.text).to_not be_nil
	$TOP_ECG_ANALYSIS = @SerialPresentation_screen.top_ecg_analysis.text
	$TOP_ECG_DATE = @SerialPresentation_screen.top_ecg_date_info.text
	$BOTTOM_ECG_ANALYSIS = @SerialPresentation_screen.bottom_ecg_analysis.text
	$BOTTOM_ECG_DATE = @SerialPresentation_screen.bottom_ecg_date_info.text
  elsif(orientation == "portrait")
		wait_for(15){ @SerialPresentation_screen.top_ecg_label('I') }
	expect(@SerialPresentation_screen.top_ecg_label("I").text).to eq "I"
	expect(@SerialPresentation_screen.top_ecg_label("II").text).to eq "II"
	expect(@SerialPresentation_screen.top_ecg_label("III").text).to eq "III"
	expect(@SerialPresentation_screen.top_ecg_label("aVR").text).to eq "aVR"
	expect(@SerialPresentation_screen.top_ecg_label("aVL").text).to eq "aVL"
	expect(@SerialPresentation_screen.top_ecg_label("aVF").text).to eq "aVF"
	expect(@SerialPresentation_screen.top_ecg_label("V1").text).to eq "V1"
	expect(@SerialPresentation_screen.top_ecg_label("V2").text).to eq "V2"
	expect(@SerialPresentation_screen.top_ecg_label("V3").text).to eq "V3"
	expect(@SerialPresentation_screen.top_ecg_label("V4").text).to eq "V4"
	expect(@SerialPresentation_screen.top_ecg_label("V5").text).to eq "V5"
	expect(@SerialPresentation_screen.top_ecg_label("V6").text).to eq "V6"

	expect(@SerialPresentation_screen.bottom_ecg_label("I").text).to eq "I"
	expect(@SerialPresentation_screen.bottom_ecg_label("II").text).to eq "II"
	expect(@SerialPresentation_screen.bottom_ecg_label("III").text).to eq "III"
	expect(@SerialPresentation_screen.bottom_ecg_label("aVR").text).to eq "aVR"
	expect(@SerialPresentation_screen.bottom_ecg_label("aVL").text).to eq "aVL"
	expect(@SerialPresentation_screen.bottom_ecg_label("aVF").text).to eq "aVF"
	expect(@SerialPresentation_screen.bottom_ecg_label("V1").text).to eq "V1"
	expect(@SerialPresentation_screen.bottom_ecg_label("V2").text).to eq "V2"
	expect(@SerialPresentation_screen.bottom_ecg_label("V3").text).to eq "V3"
	expect(@SerialPresentation_screen.bottom_ecg_label("V4").text).to eq "V4"
	expect(@SerialPresentation_screen.bottom_ecg_label("V5").text).to eq "V5"
	expect(@SerialPresentation_screen.bottom_ecg_label("V6").text).to eq "V6"

	$TOP_ECG_ANALYSIS = @SerialPresentation_screen.top_ecg_analysis.text
	$TOP_ECG_DATE = @SerialPresentation_screen.top_ecg_date_info.text

	$BOTTOM_ECG_ANALYSIS = @SerialPresentation_screen.bottom_ecg_analysis.text
	$BOTTOM_ECG_DATE = @SerialPresentation_screen.bottom_ecg_date_info.text
  end
end

When(/^I click on the top ecg chevron on the Serial Compare screen$/) do
  @SerialPresentation_screen.top_ecg_carrot.click
end

Then(/^I should see the top ECG chevron details on the Serial Compare screen$/) do
	ecg_details = @SerialPresentation_screen.ecg_details_chevron(1)
	$ECG_DIAGNOSIS1 =  ecg_details["diagnosis"]
	$ECG_TIME1 =  ecg_details["time"]

	$ECG_SEX_LABEL1 =  ecg_details["sex_label"]
	$ECG_SEX1 =  ecg_details["sex"]
	expect(ecg_details["sex_label"]).to eq "Sex:"

	$ECG_RACE_LABEL1 =  ecg_details["race_label"]
	$ECG_RACE1 =  ecg_details["race"]
	expect(ecg_details["race_label"]).to eq "Race:"

	$ECG_VHR_LABEL1 =  ecg_details["vhr_label"]
	$ECG_VHR1 =  ecg_details["vhr"]
	expect(ecg_details["vhr_label"]).to eq "V.HR:"

	$ECG_AHR_LABEL1 =  ecg_details["ahr_label"]
	$ECG_AHR1 =  ecg_details["ahr"]
	expect(ecg_details["ahr_label"]).to eq "A.HR:"

	$ECG_DOB_LABEL1 =  ecg_details["dob_label"]
	$ECG_DOB1 =  ecg_details["dob"]
	expect(ecg_details["dob_label"]).to eq "DOB:"

	$ECG_PR_LABEL1 =  ecg_details["pr_label"]
	$ECG_PR1 =  ecg_details["pr"]
	expect(ecg_details["pr_label"]).to eq "PR:"

	$ECG_QT_LABEL1 =  ecg_details["qt_label"]
	$ECG_QT1 =  ecg_details["qt"]
	expect(ecg_details["qt_label"]).to eq "QT:"

	$ECG_AGE_LABEL1 =  ecg_details["age_label"]
	$ECG_AGE1 =  ecg_details["age"]
	expect(ecg_details["age_label"]).to eq "Age:"

	$ECG_QRS_LABEL1 =  ecg_details["qrs_label"]
	$ECG_QRS1 =  ecg_details["qrs"]
	expect(ecg_details["qrs_label"]).to eq "QRS:"

	$ECG_QTC_LABEL1 =  ecg_details["qtc_label"]
	$ECG_QTC1 =  ecg_details["qtc"]
	expect(ecg_details["qtc_label"]).to eq "QTc:"

	$ECG_PRT_LABEL1 =  ecg_details["prt_label"]
	$ECG_PRT1 =  ecg_details["prt"]
	expect(ecg_details["prt_label"]).to eq "PRT(°):"
end

Then(/^I should see the bottom ECG chevron details on the Serial Compare screen$/) do
	begin
		retries ||= 0
		@selenium.action
						 .move_to_location(600, 1000)
						 .click_and_hold
						 .move_to_location(600, 200)
						 .release
						 .perform
		# Appium::TouchAction.new.swipe(:start_x => 600, :start_y => 1000, :end_x => 600, :end_y => 200, :duration => 500).perform
		# Appium::TouchAction.new.swipe(:start_x => 600, :start_y => 1000, :end_x => 600, :end_y => 200, :duration => 500).perform

		sleep(2)

		ecg_details = @SerialPresentation_screen.ecg_details_chevron(2)
		$ECG_DIAGNOSIS2 =  ecg_details["diagnosis"]
		$ECG_TIME2 =  ecg_details["time"]

		$ECG_SEX_LABEL2 =  ecg_details["sex_label"]
		$ECG_SEX2 =  ecg_details["sex"]
		expect(ecg_details["sex_label"]).to eq "Sex:"

		$ECG_RACE_LABEL2 =  ecg_details["race_label"]
		$ECG_RACE2 =  ecg_details["race"]
		expect(ecg_details["race_label"]).to eq "Race:"

		$ECG_VHR_LABEL2 =  ecg_details["vhr_label"]
		$ECG_VHR2 =  ecg_details["vhr"]
		expect(ecg_details["vhr_label"]).to eq "V.HR:"

		$ECG_AHR_LABEL2 =  ecg_details["ahr_label"]
		$ECG_AHR2 =  ecg_details["ahr"]
		expect(ecg_details["ahr_label"]).to eq "A.HR:"

		$ECG_DOB_LABEL2 =  ecg_details["dob_label"]
		$ECG_DOB2 =  ecg_details["dob"]
		expect(ecg_details["dob_label"]).to eq "DOB:"

		$ECG_PR_LABEL2 =  ecg_details["pr_label"]
		$ECG_PR2 =  ecg_details["pr"]
		expect(ecg_details["pr_label"]).to eq "PR:"

		$ECG_QT_LABEL2 =  ecg_details["qt_label"]
		$ECG_QT2 =  ecg_details["qt"]
		expect(ecg_details["qt_label"]).to eq "QT:"

		$ECG_AGE_LABEL2 =  ecg_details["age_label"]
		$ECG_AGE2 =  ecg_details["age"]
		expect(ecg_details["age_label"]).to eq "Age:"

		$ECG_QRS_LABEL2 =  ecg_details["qrs_label"]
		$ECG_QRS2 =  ecg_details["qrs"]
		expect(ecg_details["qrs_label"]).to eq "QRS:"

		$ECG_QTC_LABEL2 =  ecg_details["qtc_label"]
		$ECG_QTC2 =  ecg_details["qtc"]
		expect(ecg_details["qtc_label"]).to eq "QTc:"

		$ECG_PRT_LABEL2 =  ecg_details["prt_label"]
		$ECG_PRT2 =  ecg_details["prt"]
		expect(ecg_details["prt_label"]).to eq "PRT(°):"

		@SerialPresentation_screen.bottom_ecg_carrot.click
		sleep(4)
	rescue Selenium::WebDriver::Error::NoSuchElementError
		retry if (retries += 1) < 3
	end
end

Then(/^I should see the following info in patient banner on Serial Presentation screen$/) do |table|
  data = table.rows_hash
  patientDetails = @SerialPresentation_screen.getPatientInfoFromHeader
  patientDetails["name"].should eq data["name"]
  patientDetails["gender"].should match data["gender"]
  patientDetails["age"].should match data["age"]
  patientDetails["site"].should match data["site"]
  patientDetails["mrn"].should match data["mrn"]
end

When(/^I should see detail patient info$/) do
  #Common.wait_for_loading_prompt(selenium)
  #@eyes.check_window("Serial Presentation screen - 1st ECG detail")
end

When(/^I should see detail patient info for 2nd ECG$/) do
	sleep(2)
  #Common.wait_for_loading_prompt(selenium)
  #@eyes.check_window("Serial Presentation screen - 2nd ECG detail")
end

When(/^I swipe the "(.*?)" ECG leads to the "(.*?)"$/) do |ecg, direction|
	top_set = @selenium.find_element(:id, "#{APP_PACKAGE}:id/cardio_ecg_grid1")
	bottom_set = @selenium.find_element(:id, "#{APP_PACKAGE}:id/cardio_ecg_grid2")

	top_left_ecg  = top_set.find_elements(:id, "#{APP_PACKAGE}:id/II")
	top_right_ecg = top_set.find_elements(:id, "#{APP_PACKAGE}:id/v5")
	bottom_left_ecg = bottom_set.find_elements(:id, "#{APP_PACKAGE}:id/II")
	bottom_right_ecg = bottom_set.find_elements(:id, "#{APP_PACKAGE}:id/v5")

	top_left_ecg_x = top_left_ecg[0].location[:x] + 130
	top_left_ecg_y = top_left_ecg[0].location[:y] + 150
	top_right_ecg_x = top_right_ecg[0].location[:x] + 130

	bottom_left_ecg_x = bottom_left_ecg[0].location[:x] + 130
	bottom_left_ecg_y = bottom_left_ecg[0].location[:y] + 150
	bottom_right_ecg_x = bottom_right_ecg[0].location[:x] + 130


  if ecg == "top"
    if direction == "right"
			@selenium.action
							 .move_to_location(top_left_ecg_x, top_left_ecg_y)  # Start point
							 .click_and_hold
							 .move_to_location(top_right_ecg_x, top_left_ecg_y)   # End point
							 .release
							 .perform
      # Appium::TouchAction.new.swipe(:start_x => top_left_ecg_x, :start_y => top_left_ecg_y, :end_x => top_right_ecg_x, :end_y => top_left_ecg_y, :duration => 2000).perform
		elsif direction == "left"
			@selenium.action
							 .move_to_location(top_right_ecg_x, top_left_ecg_y)  # Start point
							 .click_and_hold
							 .move_to_location(top_left_ecg_x, top_left_ecg_y)   # End point
							 .release
							 .perform
      # Appium::TouchAction.new.swipe(:start_x => top_right_ecg_x, :start_y => top_left_ecg_y, :end_x => top_left_ecg_x, :end_y => top_left_ecg_y, :duration => 2000).perform
    end
  else
    if direction == "right"
			@selenium.action
							 .move_to_location(bottom_left_ecg_x, bottom_left_ecg_y)  # Start point
							 .click_and_hold
							 .move_to_location(bottom_right_ecg_x, bottom_left_ecg_y)   # End point
							 .release
							 .perform
      # Appium::TouchAction.new.swipe(:start_x => bottom_left_ecg_x, :start_y => bottom_left_ecg_y, :end_x => bottom_right_ecg_x, :end_y => bottom_left_ecg_y, :duration => 2000).perform
		elsif direction == "left"
			@selenium.action
							 .move_to_location(bottom_right_ecg_x, bottom_left_ecg_y)  # Start point
							 .click_and_hold
							 .move_to_location(bottom_left_ecg_x, bottom_left_ecg_y)   # End point
							 .release
							 .perform
      # Appium::TouchAction.new.swipe(:start_x => bottom_right_ecg_x, :start_y => bottom_left_ecg_y, :end_x => bottom_left_ecg_x, :end_y => bottom_left_ecg_y, :duration => 2000).perform
    end
  end
  sleep(2)
end

When(/^I pinch zoom "(.*?)" on Serial Presentation screen$/) do |action|

	sleep(3)

	if action == "in"
		element = @selenium.find_element(:id, "#{APP_PACKAGE}:id/cardio_ecg_main_viewgroup")

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

		element = @selenium.find_element(:id, "#{APP_PACKAGE}:id/cardio_ecg_main_viewgroup")

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

	# top_set = @selenium.find_element(:id, "#{APP_PACKAGE}:id/cardio_ecg_grid1")
	#
  # 	avl_ecg  = top_set.find_elements(:id, "#{APP_PACKAGE}:id/avl")
	# v2_ecg = top_set.find_elements(:id, "#{APP_PACKAGE}:id/v2")
	# avf_ecg  = top_set.find_elements(:id, "#{APP_PACKAGE}:id/avf")
	# v3_ecg = top_set.find_elements(:id, "#{APP_PACKAGE}:id/v3")
	#
	# avl_ecg_loc = avl_ecg[0].location
	# v2_ecg_loc = v2_ecg[0].location
	# avf_ecg_loc = avf_ecg[0].location
	# v3_ecg_loc = v3_ecg[0].location
	#
  # if action == "in"
	# 	touch_action1 = Appium::TouchAction.new
	# 	touch_action2 = Appium::TouchAction.new
	# 	m_action = Appium::MultiTouch.new
	#
	# 	puts avf_ecg_loc[:x]
	# 	puts avf_ecg_loc[:y]
	# 	puts avl_ecg_loc[:x]
	# 	puts avl_ecg_loc[:y]
	#
	# 	puts v3_ecg_loc[:x]
	# 	puts v3_ecg_loc[:y]
	# 	puts v2_ecg_loc[:x]
	# 	puts v2_ecg_loc[:y]
	#
	# 	touch_action1.long_press(:x => avl_ecg_loc[:x] + 100, :y => avl_ecg_loc[:y] + 100).move_to(:x => v2_ecg_loc[:x] + 100, :y => v2_ecg_loc[:y] + 100).wait(500).release
	# 	touch_action2.long_press(:x => avf_ecg_loc[:x] + 100, :y => avf_ecg_loc[:y] + 100).move_to(:x => v3_ecg_loc[:x] + 100, :y => v3_ecg_loc[:y] + 100).wait(500).release
	# 	m_action.add(touch_action1)
	# 	m_action.add(touch_action2)
	# 	m_action.perform
  # elsif action == "out"
	# 	touch_action1 = Appium::TouchAction.new
	# 	touch_action2 = Appium::TouchAction.new
	# 	m_action = Appium::MultiTouch.new
	#
	# 	touch_action1.long_press(:x => avf_ecg_loc[:x], :y => avf_ecg_loc[:y]).move_to(:x => v3_ecg_loc[:x], :y => v3_ecg_loc[:y]).wait(500).release
	# 	touch_action2.long_press(:x => avl_ecg_loc[:x] , :y => avl_ecg_loc[:y]).move_to(:x => v2_ecg_loc[:x], :y => v2_ecg_loc[:y]).wait(500).release
	#
	# 	m_action.add(touch_action1)
	# 	m_action.add(touch_action2)
	#
	# 	m_action.perform
  # end
	#
	#
  # if action == "inddddd"
	# 	element = @selenium.find_element(:id, "#{APP_PACKAGE}:id/cardio_ecg_viewgroup_grid1")
	#
	# 	#x = element.location[:x]
	# 	#puts x
	# 	#y = element.location[:y]
	# 	#puts y
	#
	# 	xx = element.size[:width] / 2
	# 	puts xx
	# 	yy = element.size[:height] / 2
	# 	puts yy
	#
	#
	# 	touch_action1 = Appium::TouchAction.new
	# 	touch_action2 = Appium::TouchAction.new
	# 	m_action = Appium::MultiTouch.new
	#
	# 	touch_action1.long_press(:x => xx - 100, :y => yy - 100).move_to(:x => xx, :y => yy).wait(1000).release
	# 	touch_action2.long_press(:x => xx + 150, :y => yy + 150).move_to(:x => xx + 100, :y => yy + 100).wait(1000).release
	# 	m_action.add(touch_action1)
	# 	m_action.add(touch_action2)
	# 	m_action.perform
	#
	# elsif action == "outddddddd"
	#
	# 	element = @selenium.find_element(:id, "#{APP_PACKAGE}:id/cardio_ecg_viewgroup_grid1")
	#
	# 	#x = element.location[:x]
	# 	#puts x
	# 	#y = element.location[:y]
	# 	#puts y
	#
	# 	xx = element.size[:width] / 2
	# 	puts xx
	# 	yy = element.size[:height] / 2
	# 	puts yy
	#
	#
	# 	touch_action1 = Appium::TouchAction.new
	# 	touch_action2 = Appium::TouchAction.new
	# 	m_action = Appium::MultiTouch.new
	#
	# 	touch_action1.long_press(:x => xx, :y => yy).move_to(:x => xx - 100, :y => yy - 100).wait(1000).release
	# 	touch_action2.long_press(:x => xx + 100, :y => yy + 100).move_to(:x => xx + 150, :y => yy + 150).wait(1000).release
	# 	m_action.add(touch_action1)
	# 	m_action.add(touch_action2)
	#
	# 	m_action.perform
  # end
end

When(/^I double click on the 1st Lead "(.*?)"$/) do |lead|
  @SerialPresentation_screen.mainThreeSecondLead_element(lead).doubleClick(50,50)
end

When(/^I double click on the 2nd Lead "(.*?)"$/) do |lead|
  @SerialPresentation_screen.compThreeSecondLead_element(lead).doubleClick

  for try in 1..5 do
    if @SerialPresentationZoom_screen.mainThreeSecondLeadGrid_element.exists == false
      @SerialPresentation_screen.compThreeSecondLead_element(lead).doubleClick
      sleep(2)
    else
      break
    end
  end
end
