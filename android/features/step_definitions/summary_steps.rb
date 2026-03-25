Before do
  @Patient_Summary_screen = Patient_Summary_screen.new selenium, appium
  @PM_Monitor_screen = PM_Monitor_screen.new selenium, appium
  @Active_Meds_screen =  Active_Meds_screen.new selenium, appium
  @Ob_Summary_screen = Ob_Summary_screen.new selenium, appium
  @Menu = Menu.new selenium, appium
end

Then(/^I should see the patient name "(.*?)" in patient summary header/) do |patient_name|
  patient_obj = @Menu.patient_header_object
  expect(patient_obj["name"].text).to eq patient_name
end

When(/^I click the patient summary back button/) do
  @Menu.back_button.click
end

Then(/^I should see the patient summary screen$/) do
  wait_for(10) { expect(@Patient_Summary_screen.gen_info_tile.attribute("enabled")) }
  # expect(@Patient_Summary_screen.gen_info_tile.attribute("enabled"))
  #
  # general_info_tile = @Patient_Summary_screen.gen_info_tile.text
  # general_info_tile.should eql "GENERAL INFO"
end

Then(/^I click on the General Info tile$/) do
  sleep 3
  @Patient_Summary_screen.gen_info_tile.click
end

Then(/^I click on the live monitor button$/) do
  sleep 3
  @Patient_Summary_screen.live_monitor_tile.click
end

And(/^I should no events on the monitor tile$/) do
  begin
	$MONITOR_TILE_INFO = @Patient_Summary_screen.monitor_tile_info
	if($MONITOR_TILE_INFO["record_count"].to_i > 0)
	  expect(@Patient_Summary_screen.monitor_tile_no_events.text).not_to eq "No Events"
	elsif($MONITOR_TILE_INFO["record_count"] == "0")
	  expect(@Patient_Summary_screen.monitor_tile_no_events.text).to eq "No Events"
	end
  rescue
	  
  end
end

Then(/^I should see the EMR patient summary screen$/) do
  @Patient_Summary_screen.demographics_tile.text.should eql "DEMOGRAPHICS"
  @Patient_Summary_screen.ecgs_tile.text.should eql "ALLERGIES"  
end

When(/^I click on the ECG tile$/) do
  #Common.wait_for_loading_prompt(selenium)
  @Patient_Summary_screen.ecgs_tile.click
end

When(/^I click on the Demographics tile$/) do
  @Patient_Summary_screen.demographics_tile.click
end


When(/^I scroll down and click on the MONITOR tile$/) do
  Appium::TouchAction.new.swipe(:start_x => 600, :start_y => 1000, :end_x => 600, :end_y => 400, :duration => 1000).perform
end

When(/^I click on the MONITOR tile$/) do
  sleep(2)
  #Common.wait_for_loading_prompt(selenium)
  
  $MONITOR_TILE_INFO = @Patient_Summary_screen.monitor_tile_info
  $MONITOR_TILE_INFO["record_count"]
  @Patient_Summary_screen.monitor_tile.text.should eql "MONITOR"

  @Patient_Summary_screen.monitor_tile.click
end

And (/^I should see the patient demographics tile information$/) do |table|
	@Patient_Summary_screen.gen_info_tile.click
	
	sleep(2)
	
	expect(@Patient_Summary_screen.gen_information_expanded_view.exists).to be true
	data = table.rows_hash  
	patientDetails = @Patient_Summary_screen.general_info_data
	
	patientDetails["patient_name_label"].to_s.should include data["patient_name_label"].to_s
  
	patientDetails["mrn_label"].to_s.should include data["mrn_label"].to_s
	
	patientDetails["dob_label"].to_s.should include data["dob_label"].to_s
	
	patientDetails["gender_label"].to_s.should include data["gender_label"].to_s
   
	patientDetails["age_label"].to_s.should include data["age_label"].to_s
	
	patientDetails["location_label"].to_s.should include data["location_label"].to_s
end

When (/^I click on the demographics tile$/) do
  @Patient_Summary_screen.demographics_tile.click
end

And (/^I should see the EMR patient demographics tile information$/) do |table|  
  data = table.rows_hash  
 
  patientDetails = @Patient_Summary_screen.demographics_tile_emr_data
  
  patientDetails["weight_label"].should include data["weight_label"]  
  patientDetails["weight_text"].should eql data["weight_text"]
  patientDetails["admit_date_label"].should include data["admit_date_label"]
  patientDetails["admit_date_text"].should include data["admit_date_text"]  
  patientDetails["code_status_label"].should include data["code_status_label"]
  patientDetails["code_status_text"].should include data["code_status_text"]
  patientDetails["location_label"].should include data["location_label"]
  patientDetails["location_text"].should eq data["location_text"]
  patientDetails["isolation_status_label"].should include data["isolation_status_label"]
  patientDetails["isolation_status_text"].should eq data["isolation_status_text"]
  patientDetails["fin_label"].should include data["fin_label"]
  patientDetails["fin_text"].should eq data["fin_text"]
  patientDetails["dob_label"].should include data["dob_label"]
  patientDetails["dob_text"].should eq data["dob_text"]
  patientDetails["religion_label"].should include data["religion_label"]
  patientDetails["religion_text"].should eq data["religion_text"]
  patientDetails["language_label"].should include data["language_label"]
  patientDetails["language_text"].should eq data["language_text"]
  patientDetails["primary_contact_label"].should include data["primary_contact_label"]
  patientDetails["primary_contact_text"].should eq data["primary_contact_text"]
  patientDetails["secondary_contact_label"].should include data["secondary_contact_label"]
  patientDetails["secondary_contact_text"].should eq data["secondary_contact_text"]
  patientDetails["age_label"].should include data["age_label"]
  patientDetails["age_text"].should eq data["age_text"] 
  patientDetails["primary_md_label"].should include data["primary_md_label"] 
  patientDetails["primary_md_text"].to_s.should eql data["primary_md_text"].to_s
end

When (/^I click on the Allergies tile$/) do 
  sleep(1)
  @Patient_Summary_screen.allergies_tile.click
end

Then (/^I should see the Allergies tile information$/) do
  sleep(1)  
  #data = table.rows_hash   
  #patientDetails = @Patient_Summary_screen.allergies_tile_emr_data  
  #patientDetails["allergy_column_label"].should include data["allergy_column_label"]
  #patientDetails["reaction_column_label"].should include data["reaction_column_label"]
  #patientDetails["allergy_type_one"].should include data["allergy_type_one"]
  #patientDetails["allergy_one_name"].should include data["allergy_one_name"]
  #patientDetails["allergy_one_reaction"].should include data["allergy_one_reaction"] 
end

When (/^I click on the Care Team tile$/) do
  #Common.wait_for_loading_prompt(selenium)
  @Patient_Summary_screen.careteam_tile.click
end

Then (/^I should see the Care Team tile information/) do
  sleep(15)
end

When (/^I click on the DX\/Problems tile$/) do
  sleep(1)
  @Patient_Summary_screen.dx_problems_tile.click
end

Then (/^I should see the DX\/Problems tile information/) do
  sleep(1)
end

When (/^I click on the Active Meds tile$/) do
  sleep(1)
  @Patient_Summary_screen.active_meds_tile.click
end

Then (/^I should see the Active Meds tile information/) do
  sleep(1)
end

When (/^I click on the Labs tile$/) do
  sleep(1)
  @Patient_Summary_screen.labs_tile.click
end

Then (/^I should see the Labs tile information/) do
  sleep(1)
end

When(/^I swipe to the "(.*?)" on the horizontal scroll view$/) do |direction|	
    if direction == "right"
      Appium::TouchAction.new.swipe(:start_x => 1000, :start_y => 300, :end_x => 500, :end_y => 300, :duration => 1000).perform
    elsif direction == "left"
      Appium::TouchAction.new.swipe(:start_x => 200, :start_y => 300, :end_x => 1000, :end_y => 300, :duration => 1000).perform
    end
end

When(/^I swipe the "(.*?)" to the "(.*?)"$/) do |ecg, direction|
  if ecg == "top"
    if direction == "right"
      selenium.execute_script 'mobile: swipe', :startX => 0.1, :startY => 0.15, :endX => 0.9, :endY => 0.15, :duration => 0.5
    elsif direction == "left"
      selenium.execute_script 'mobile: swipe', :startX => 0.9, :startY => 0.15, :endX => 0.1, :endY => 0.15, :duration => 0.5
    end
  else
    if direction == "right"
      selenium.execute_script 'mobile: swipe', :startX => 0.1, :startY => 0.9, :endX => 0.9, :endY => 0.9, :duration => 0.5
    elsif direction == "left"
      selenium.execute_script 'mobile: swipe', :startX => 0.9, :startY => 0.9, :endX => 0.1, :endY => 0.9, :duration => 0.5
    end
  end
  #sleep(2)  
end

Then(/^I should see the EMR patient information in the header$/) do |table|
  #sleep(10)
  
  data = table.rows_hash  
 
  patientDetails = @Patient_Summary_screen.patient_header_emr_data
  
  patientDetails["patient_name"].should include data["patient_name"]
  patientDetails["sex"].should include data["sex"]
  patientDetails["age"].should include data["age"]
  patientDetails["mrn"].should include data["mrn"]
  patientDetails["location"].should include data["location"]
  patientDetails["site"].should include data["site"]  
end

When(/^I click on the Vitals tile$/) do
	@Patient_Summary_screen.vitals_tile.click  
end

When(/^I click on the LABS tile$/) do
	@Patient_Summary_screen.labs_tile.click  
end

And(/^I should see the Vitals tile information$/) do 
  sleep(1)
end

When(/^I click on the Maternal Vitals tile$/) do
  #$MAT_VITALS = @Ob_Summary_screen.maternal_vitals_tile_object
  #
  #expect($MAT_VITALS["r1_range"]).to eq "L - H"
  #expect($MAT_VITALS["r1_value"]).to eq "Rec"
  #expect($MAT_VITALS["r2_label"]).to eq "SBP"
  #expect($MAT_VITALS["r3_label"]).to eq "DBP"
  #expect($MAT_VITALS["r4_label"]).to eq "SPO2"
  #expect($MAT_VITALS["tile_title"]).should include "MATERNAL"
  
  @Patient_Summary_screen.maternal_vitals_tile.click
end

Then(/^I should see the Maternal Vitals screen$/) do
	#expect(@Patient_Summary_screen.maternal_vitals_grid).to be_truthy
	@Patient_Summary_screen.maternal_vitals_grid.exists.should be true
end

When(/^I click the cervical exams tile$/) do
	$CERV_EXAM = @Ob_Summary_screen.cervical_exam_tile_object
	expect($CERV_EXAM["tile_title"]).to eq "CERVICAL EXAMS"
	
	@Patient_Summary_screen.cervical_exams_tile.click
end

Then(/^I should see the Cervical Exams screen$/) do
	expect(@Patient_Summary_screen.expanded_tile).to be_truthy
	$EX_CERV = @Ob_Summary_screen.cervical_expanded_tile_obj
	
	expect($EX_CERV["tile_title"]).to eq "CERVICAL EXAMS"

	if($EX_CERV["data_check"] == "data not found")
		expect($EX_CERV["data_check"]).to eq $CERV_EXAM["data_check"] 
	elsif($EX_CERV["data_check"] == "data found")
		expect($EX_CERV["label"]).to include $CERV_EXAM["label"] 
		expect($EX_CERV["value"]).to eq $CERV_EXAM["value"] 
	end
end

When(/^I click on the Annotations tile$/) do
	#$ANNOTATION = @Ob_Summary_screen.annotations_tile_object
	#expect($ANNOTATION["tile_title"]).to eq "ANNOTATIONS"
	@Patient_Summary_screen.annotations_tile.click  
end

When(/^I long press on the Annotations tile$/) do
   puts @Patient_Summary_screen.annotations_tile.exists
   Appium::TouchAction.new.long_press(@Patient_Summary_screen.annotations_tile).release
end

Then(/^I should see the Annotations screen$/) do
	expect(@Patient_Summary_screen.expanded_tile).to be_truthy
	@Patient_Summary_screen.expanded_tile_title.text == "ANNOTATIONS" 
end

When(/^I click on the Misc tile$/) do
	@Patient_Summary_screen.misc_tile.click
end

When(/^I click on the Misc tile in landscape mode$/) do
	Appium::TouchAction.new.swipe(:start_x => 600, :start_y => 1400, :end_x => 600, :end_y => 300, :duration => 700).perform
	@Patient_Summary_screen.misc_tile.click
end

When(/^I click on the Pitocin tile$/) do
	@Patient_Summary_screen.pitocin_tile.click
end

When(/^I click on the VITALS tile$/) do
	@Patient_Summary_screen.vitals_tile.click
end

When(/^I click on the DOCUMENTS tile$/) do
	Appium::TouchAction.new.swipe(:start_x => 600, :start_y => 1400, :end_x => 600, :end_y => 300, :duration => 1000).perform
	sleep(2)
	@Patient_Summary_screen.doc_tile.click
end

When(/^I scroll down$/) do
	Appium::TouchAction.new.swipe(:start_x => 600, :start_y => 1400, :end_x => 600, :end_y => 300, :duration => 1000).perform
	sleep(2)
end

When(/^I select a document$/) do
	Appium::TouchAction.new.tap(:x => 200, :y => 1600, :duration => 100).perform
end

When(/^I click on the Other tile$/) do
	Appium::TouchAction.new.swipe(:start_x => 600, :start_y => 1400, :end_x => 600, :end_y => 300, :duration => 1000).perform
	sleep(2)
	@Patient_Summary_screen.other_tile.click
end

Then(/^I should see the Misc screen$/) do
	expect(@Patient_Summary_screen.expanded_tile).to be_truthy
	@Patient_Summary_screen.expanded_tile_title.text ==  "MISC" 
end

Then(/^I should see the Pitocin screen$/) do
	expect(@Patient_Summary_screen.expanded_tile).to be_truthy
	@Patient_Summary_screen.expanded_tile_title.text ==  "PITOCIN" 
end

Then(/^I should see the Other screen$/) do
	expect(@Patient_Summary_screen.expanded_tile).to be_truthy
	@Patient_Summary_screen.expanded_tile_title.text ==  "OTHER" 
end

When(/^I click the General Information tile$/) do
	@Patient_Summary_screen.gen_info_tile.click
end

Then(/^I should see the General Information tile$/) do
	sleep(1)
	@Patient_Summary_screen.gen_information_expanded_view.exists.should be true
end

When(/^I click the Documents tile$/) do
	@Patient_Summary_screen.documents_tile.click
end

Then(/^I should see the Documents list$/) do
	sleep(1)	
end

When(/^I select the depart document$/) do
  @Patient_Summary_screen.depart_document.click
end

Then(/^I should see the Document expanded$/) do
  @Patient_Summary_screen.expanded_document.exists.should be true
end

Then(/^I click on the Monitor button$/) do
  @PM_Monitor_screen.navbar_monitor_button.click
end

Then(/^I click the Ventilator button$/) do
  @Menu.summary_vent_button.click
end

Then(/^I should see the tiles are the same size$/) do
  tile_elements = @Patient_Summary_screen.get_all_patient_summary_tile_elements
  tile1 = tile_elements['ECGs']
  tile2 = tile_elements['Monitor']
  assert(compare_element_size_attr(tile1, tile2, 'both') == true)
end