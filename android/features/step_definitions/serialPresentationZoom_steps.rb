Before do
  @SerialPresentationZoom_screen = SerialPresentationZoom_screen.new selenium, appium
end

Then(/^I should see the Lead "(.*?)" Serial Presentation Zoom window$/) do |lead|
  wait_for(15) { @SerialPresentationZoom_screen.top_ecg_label.displayed? == true }

  expect(@SerialPresentationZoom_screen.top_ecg_label.text).to eq lead
  expect(@SerialPresentationZoom_screen.bottom_ecg_label.text).to eq lead
  
  expect(@SerialPresentationZoom_screen.top_ecg_analysis.text).to eq $TOP_ECG_ANALYSIS 
  expect(@SerialPresentationZoom_screen.top_ecg_date_info.text).to eq $TOP_ECG_DATE
  
  expect(@SerialPresentationZoom_screen.bottom_ecg_analysis.text).to eq $BOTTOM_ECG_ANALYSIS
  expect(@SerialPresentationZoom_screen.bottom_ecg_date_info.text).to eq  $BOTTOM_ECG_DATE
end

When(/^I click on the top ecg chevron on the Serial Compare Zoom screen$/) do
  @SerialPresentationZoom_screen.top_ecg_carrot.click
end

Then(/^I should see the top ECG chevron details on the Serial Compare Zoom screen$/) do	
	ecg_details = @SerialPresentation_screen.ecg_details_chevron(1)
	expect(ecg_details["diagnosis"]).to eq $ECG_DIAGNOSIS1
	expect(ecg_details["time"]).to eq $ECG_TIME1
	
	expect(ecg_details["sex_label"]).to eq $ECG_SEX_LABEL1
	expect(ecg_details["sex"]).to eq $ECG_SEX1
	expect(ecg_details["sex_label"]).to eq "Sex:"
	
	expect(ecg_details["race_label"]).to eq $ECG_RACE_LABEL1
	expect(ecg_details["race"]).to eq $ECG_RACE1
	expect(ecg_details["race_label"]).to eq "Race:"
	
	expect(ecg_details["vhr_label"]).to eq $ECG_VHR_LABEL1
	expect(ecg_details["vhr"]).to eq $ECG_VHR1
	expect(ecg_details["vhr_label"]).to eq "V.HR:"
	
	expect(ecg_details["ahr_label"]).to eq $ECG_AHR_LABEL1
	expect(ecg_details["ahr"]).to eq $ECG_AHR1
	expect(ecg_details["ahr_label"]).to eq "A.HR:"
	
	expect(ecg_details["dob_label"]).to eq $ECG_DOB_LABEL1
	expect(ecg_details["dob"]).to eq $ECG_DOB1
	expect(ecg_details["dob_label"]).to eq "DOB:"
	
	expect(ecg_details["pr_label"]).to eq $ECG_PR_LABEL1
	expect(ecg_details["pr"]).to eq $ECG_PR1
	expect(ecg_details["pr_label"]).to eq "PR:"
	
	expect(ecg_details["qt_label"]).to eq $ECG_QT_LABEL1
	expect(ecg_details["qt"]).to eq $ECG_QT1
	expect(ecg_details["qt_label"]).to eq "QT:"
	
	expect(ecg_details["age_label"]).to eq $ECG_AGE_LABEL1
	expect(ecg_details["age"]).to eq $ECG_AGE1
	expect(ecg_details["age_label"]).to eq "Age:"
	
	expect(ecg_details["qrs_label"]).to eq $ECG_QRS_LABEL1
	expect(ecg_details["qrs"]).to eq $ECG_QRS1
	expect(ecg_details["qrs_label"]).to eq "QRS:"
	
	expect(ecg_details["qtc_label"]).to eq $ECG_QTC_LABEL1
	expect(ecg_details["qtc"]).to eq $ECG_QTC1
	expect(ecg_details["qtc_label"]).to eq "QTc:"
	
	expect(ecg_details["prt_label"]).to eq $ECG_PRT_LABEL1
	expect(ecg_details["prt"]).to eq $ECG_PRT1
	expect(ecg_details["prt_label"]).to eq "PRT(°):"
end

Then(/^I should see the bottom ECG chevron details on the Serial Compare Zoom screen$/) do
	begin
		retries ||= 0
		@selenium.action
						 .move_to_location(600, 1000)
						 .click_and_hold
						 .move_to_location(600, 200)
						 .release
						 .perform
		# Appium::TouchAction.new.swipe(:start_x => 600, :start_y => 1000, :end_x => 600, :end_y => 200, :duration => 1000).perform
		# Appium::TouchAction.new.swipe(:start_x => 600, :start_y => 1000, :end_x => 600, :end_y => 200, :duration => 1000).perform

		ecg_details = @SerialPresentation_screen.ecg_details_chevron(2)
		expect(ecg_details["diagnosis"]).to eq $ECG_DIAGNOSIS2
		expect(ecg_details["time"]).to eq $ECG_TIME2

		expect(ecg_details["sex_label"]).to eq $ECG_SEX_LABEL2
		expect(ecg_details["sex"]).to eq $ECG_SEX2
		expect(ecg_details["sex_label"]).to eq "Sex:"

		expect(ecg_details["race_label"]).to eq $ECG_RACE_LABEL2
		expect(ecg_details["race"]).to eq $ECG_RACE2
		expect(ecg_details["race_label"]).to eq "Race:"

		expect(ecg_details["vhr_label"]).to eq $ECG_VHR_LABEL2
		expect(ecg_details["vhr"]).to eq $ECG_VHR2
		expect(ecg_details["vhr_label"]).to eq "V.HR:"

		expect(ecg_details["ahr_label"]).to eq $ECG_AHR_LABEL2
		expect(ecg_details["ahr"]).to eq $ECG_AHR2
		expect(ecg_details["ahr_label"]).to eq "A.HR:"

		expect(ecg_details["dob_label"]).to eq $ECG_DOB_LABEL2
		expect(ecg_details["dob"]).to eq $ECG_DOB2
		expect(ecg_details["dob_label"]).to eq "DOB:"

		expect(ecg_details["pr_label"]).to eq $ECG_PR_LABEL2
		expect(ecg_details["pr"]).to eq $ECG_PR2
		expect(ecg_details["pr_label"]).to eq "PR:"

		expect(ecg_details["qt_label"]).to eq $ECG_QT_LABEL2
		expect(ecg_details["qt"]).to eq $ECG_QT2
		expect(ecg_details["qt_label"]).to eq "QT:"

		expect(ecg_details["age_label"]).to eq $ECG_AGE_LABEL2
		expect(ecg_details["age"]).to eq $ECG_AGE2
		expect(ecg_details["age_label"]).to eq "Age:"

		expect(ecg_details["qrs_label"]).to eq $ECG_QRS_LABEL2
		expect(ecg_details["qrs"]).to eq $ECG_QRS2
		expect(ecg_details["qrs_label"]).to eq "QRS:"

		expect(ecg_details["qtc_label"]).to eq $ECG_QTC_LABEL2
		expect(ecg_details["qtc"]).to eq $ECG_QTC2
		expect(ecg_details["qtc_label"]).to eq "QTc:"

		expect(ecg_details["prt_label"]).to eq $ECG_PRT_LABEL2
		expect(ecg_details["prt"]).to eq $ECG_PRT2
		expect(ecg_details["prt_label"]).to eq "PRT(°):"
	rescue Selenium::WebDriver::Error::NoSuchElementError
		retry if (retries += 1) < 3
	end
end


Then(/^I should see the following info in patient banner on Serial Presentation Zoom screen$/) do |table|
  data = table.rows_hash
  patientDetails = @SerialPresentationZoom_screen.getPatientInfoFromHeader
  patientDetails["name"].should eq data["name"]
  patientDetails["gender"].should match data["gender"]
  patientDetails["age"].should match data["age"]
  patientDetails["site"].should match data["site"]
  patientDetails["mrn"].should match data["mrn"]
end

When(/^I should see detail patient info for serial zoom lead screen$/) do
	sleep (2)
  #Common.wait_for_loading_prompt(selenium)
  #@eyes.check_window("Serial Presentation Zoom screen - detail info") 
end

When(/^I should see detail patient info for 2nd ECG on Serial Presentation Zoom screen$/) do |table|
  data = table.rows_hash  
  patientDetails = @SerialPresentationZoom_screen.getPatientEcgDetails(2)
  patientDetails["time"].should eql data["acq_date"]
  patientDetails["diagnosis"].should include data["diag_state1"]
  patientDetails["diagnosis"].should include data["diag_state2"]
  patientDetails["diagnosis"].should include data["diag_state3"]  
  patientDetails["sex"].should eq data["sex"]
  patientDetails["vhr"].should eq data["vhr"]
  patientDetails["ahr"].should eq data["ahr"]
  patientDetails["dob"].should eq data["dob"]
  patientDetails["pr"].should eq data["pr"]
  patientDetails["qt"].should eq data["qt"]
  patientDetails["age"].should eq data["age"]
  patientDetails["qrs"].should eq data["qrs"]
  patientDetails["qtc"].should eq data["qtc"]
  patientDetails["prt"].should eq data["prt"] 
end

When(/^I swipe the "(.*?)" ECG leads to the "(.*?)" on Serial Presentation Zoom screen$/) do |ecg, direction|
  if ecg == "top"
    if direction == "right"
      Appium::TouchAction.new.swipe(:start_x => 1080, :start_y => 491, :end_x => 200, :end_y => 491, :duration => 1000).perform
    elsif direction == "left"
      Appium::TouchAction.new.swipe(:start_x => 200, :start_y => 491, :end_x => 1080, :end_y => 491, :duration => 1000).perform
    end
  else
    if direction == "right"
      Appium::TouchAction.new.swipe(:start_x => 1080, :start_y => 2100, :end_x => 200, :end_y => 2100, :duration => 1000).perform
    elsif direction == "left"
      Appium::TouchAction.new.swipe(:start_x => 200, :start_y => 2100, :end_x => 1080, :end_y => 2100, :duration => 1000).perform
    end
  end
  sleep(3)
end

When(/^I pinch zoom "(.*?)" on Serial Presentation Zoom screen$/) do |action|
  if action == "in"
    selenium.execute_script 'mobile: pinchClose', :element => @SerialPresentationZoom_screen.mainThreeSecondLeadGrid_element.ref
  elsif action == "out"
    selenium.execute_script 'mobile: pinchOpen', :element => @SerialPresentationZoom_screen.mainThreeSecondLeadGrid_element.ref
  end
  sleep(2)
end

When(/^I click the back button on Serial Presentation Zoom screen$/) do
  @SerialPresentationZoom_screen.back_button.click
end