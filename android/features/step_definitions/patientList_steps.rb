Before do
  @List_Of_Lists_window = List_Of_Lists_window.new selenium, appium
  @Patient_List_screen = Patient_List_screen.new selenium, appium
  @Ob_Summary_screen = Ob_Summary_screen.new selenium, appium
  @Patient_Summary_screen = Patient_Summary_screen.new selenium, appium
  @Notification_screen = Notification_screen.new selenium, appium
end

Then(/^I should see the NOTIFICATIONS patient List$/) do
  sleep(2)
  expect(@Notification_screen.oncall_toggle.exists).to be true
  #@eyes.check_window("Patient List")
end

Then(/^I should see the patient List$/) do
  begin
    wait_for(20) { expect(@Patient_List_screen.patient_list_obj.displayed?).to be true }
  rescue
    @ResponseErrorHandler.inspection
  end
end

Then(/^I should see the OB patient List$/) do
  sleep(3)
  if(@List_Of_Lists_window.as_one_button.name == "Open")
    expect(@List_Of_Lists_window.as_one_button.name).to eq "Open"
  elsif(@List_Of_Lists_window.as_one_button.name == "Close")
    expect(@List_Of_Lists_window.as_one_button.name).to eq "Close"
  end
end

Then(/^I should see the "(.*?)" patient List$/) do |listName|
  sleep(2)
  @Patient_List_screen.navigation_bar(listName).exists.should be true
  @Patient_List_screen.navigation_bar(listName).text.should eql listName
end

When(/^I click on "(.*?)" in patient list$/) do |arg1|
  sleep(1)
  arg1 = process_param(arg1)
  @Patient_List_screen.patient_cell(arg1).click
  sleep(1)
end

When(/^I click on default patient in list(| without redirect)$/) do |do_redierct|
  steps %(
    When I click on "#{DEFAULT_PATIENT}" in patient list#{do_redierct}
        )
end

When(/^I click on the first person in the Most Recent List$/) do
  @Patient_List_screen.get_cell_from_patient_list(by_index=0).click
end

When(/^I click on the first person in the Patient List$/) do
  @Patient_List_screen.get_cell_from_patient_list(by_index=0).click
end

When(/^I click on the live monitor button for "(.*?)" in patient list$/) do |arg1|
  sleep(1)
  @Patient_List_screen.patient_cell(arg1).click
  sleep(1)
end

When(/^I click utangOne button on top left of screen$/) do
  sleep(1)
  @List_Of_Lists_window.as_one_button.click
  sleep(1)
end

And(/^I should not see patient "(.*?)" in the patient list$/) do |patient_name|
  value = @Patient_List_screen.find_patient_cell(patient_name)
  expect(value).to eq false
end

Then(/^I should see the following patient in patient list$/) do |table|
  patients = table.hashes
  patients.each do |patient|
    patientInfo = @Patient_List_screen.get_patient_obj(patient[:patientName])
    patientInfo["full_name"].should eql patient[:patientName]
    #patientInfo["age_sex"].should include patient[:gender]
    #patientInfo["age_sex"].should include patient[:age]
    patientInfo["time_info"].should eql patient[:acqDate]
    patientInfo["ecg_count"].should eql patient[:ecgCount]
    patientInfo["ecg_info"].should eql patient[:diagState1]
  end
end

Then(/^I should see the patient with the name "(.*?)" in the patient list$/) do |full_name|  
  @Search_screen.patient_exists(full_name).should eq true
end

When(/^I click on the first patient in the ob patient list$/) do
  sleep(2)

  $OB_PATIENT_LIST_OBJ = @Patient_List_screen.return_patient_ob_object(1)
  
  #puts $OB_PATIENT_LIST_OBJ["full_name"]
  #puts $OB_PATIENT_LIST_OBJ["age_sex"]
  #puts $OB_PATIENT_LIST_OBJ["membrane_status"]
  #puts $OB_PATIENT_LIST_OBJ["gradiva_para_time"]
  #puts $OB_PATIENT_LIST_OBJ["doctor"]
  #puts $OB_PATIENT_LIST_OBJ["location"]
  
  @Patient_List_screen.patient_cell($OB_PATIENT_LIST_OBJ["full_name"]).click
  
  sleep(2)
end

And(/^I make note of ob patients for searching$/) do
  $OB_P_ONE = @Patient_List_screen.return_patient_ob_object(0)
  $OB_NAME_ONE = $OB_P_ONE["full_name"].split(", ")
  $OB_LAST_NAME_ONE = $OB_NAME_ONE[0]
  $OB_FIRST_NAME_ONE = $OB_NAME_ONE[1]
  
  $OB_P_TWO = @Patient_List_screen.return_patient_ob_object(1)
  $OB_NAME_TWO = $OB_P_TWO["full_name"].split(", ")
  $OB_LAST_NAME_TWO = $OB_NAME_TWO[0]
  $OB_FIRST_NAME_TWO = $OB_NAME_TWO[1]
  
  $OB_P_THREE = @Patient_List_screen.return_patient_ob_object(2)
  $OB_NAME_THREE = $OB_P_THREE["full_name"].split(", ")
  $OB_LAST_NAME_THREE = $OB_NAME_THREE[0]
  $OB_FIRST_NAME_THREE = $OB_NAME_THREE[1]
end

When(/^I enter "(.*?)" in the census search field to search by "(.*?)" name$/) do |name, search_field|
  expect(@Patient_List_screen.search_field.text).to eq "Search"
  
  if(name == "ob_patient_one" && search_field == "First")
  @Patient_List_screen.search_field.send_keys($OB_FIRST_NAME_ONE)
  expect(@Patient_List_screen.search_field.text).to eq $OB_FIRST_NAME_ONE
  elsif(name == "ob_patient_one" && search_field == "Last")
  @Patient_List_screen.search_field.send_keys($OB_LAST_NAME_ONE)
  expect(@Patient_List_screen.search_field.text).to eq $OB_LAST_NAME_ONE
  elsif(name == "ob_patient_two" && search_field == "First")
  @Patient_List_screen.search_field.send_keys($OB_FIRST_NAME_TWO)
  expect(@Patient_List_screen.search_field.text).to eq $OB_FIRST_NAME_TWO
  elsif(name == "ob_patient_two" && search_field == "Last")
  @Patient_List_screen.search_field.send_keys($OB_LAST_NAME_TWO)
  expect(@Patient_List_screen.search_field.text).to eq $OB_LAST_NAME_TWO
  elsif(name == "ob_patient_three" && search_field == "First")
  @Patient_List_screen.search_field.send_keys($OB_FIRST_NAME_THREE)
  expect(@Patient_List_screen.search_field.text).to eq $OB_FIRST_NAME_THREE
  elsif(name == "ob_patient_three" && search_field == "Last")
  @Patient_List_screen.search_field.send_keys($OB_LAST_NAME_THREE)
  expect(@Patient_List_screen.search_field.text).to eq $OB_LAST_NAME_THREE
  end
end

When(/^I enter "(.*?)" in the census search field to search by first and last name$/) do |name|
  p_one = "#{$OB_LAST_NAME_ONE}, #{$OB_FIRST_NAME_ONE}"
  p_two = "#{$OB_LAST_NAME_TWO}, #{$OB_FIRST_NAME_TWO}"
  p_three = "#{$OB_LAST_NAME_THREE}, #{$OB_FIRST_NAME_THREE}"
  
  expect(@Patient_List_screen.search_field.text).to eq "Search"
  
  if(name == "ob_patient_one")
  @Patient_List_screen.search_field.send_keys(p_one)
  expect(@Patient_List_screen.search_field.text).to eq p_one
  elsif(name == "ob_patient_two")
  @Patient_List_screen.search_field.send_keys(p_two)
  expect(@Patient_List_screen.search_field.text).to eq p_two
  elsif(name == "ob_patient_three")
  @Patient_List_screen.search_field.send_keys(p_three)
  expect(@Patient_List_screen.search_field.text).to eq p_three
  end
end

When(/^I should see "(.*?)" in patient list search results$/) do |name|
  p_one = "#{$OB_LAST_NAME_ONE}, #{$OB_FIRST_NAME_ONE}"
  p_two = "#{$OB_LAST_NAME_TWO}, #{$OB_FIRST_NAME_TWO}"
  p_three = "#{$OB_LAST_NAME_THREE}, #{$OB_FIRST_NAME_THREE}"
  
  if(name == "ob_patient_one")
  puts p_one
   patient_info = @Patient_List_screen.get_search_results_obj(p_one)
  expect(patient_info["full_name"]).to eq p_one
  elsif(name == "ob_patient_two")
  puts p_two
  patient_info = @Patient_List_screen.get_search_results_obj(p_two) 
  expect(patient_info["full_name"]).to eq p_two
  elsif(name == "ob_patient_three")
  puts p_three
  patient_info = @Patient_List_screen.get_search_results_obj(p_three) 
  expect(patient_info["full_name"]).to eq p_three
  end
end

When(/^I click on the first patient in the emr patient list$/) do
  sleep(2)

  patient_info = @Patient_List_screen.return_patient_emr_object(1)
  name = patient_info["full_name"]
  
  @Patient_List_screen.patient_cell(name).click
  
  sleep(3)
end

Then(/^I should see the ob patient summary screen$/) do
  sleep(3)	
  @Patient_Summary_screen.maternal_vitals_tile.text.should eql "MATERNAL VITALS"
  @Patient_Summary_screen.cervical_exams_tile.text.should eql "CERVICAL EXAMS"
  #@Patient_Summary_screen.annotations_tile.text.should eql "ANNOTATIONS"
  
  #$OB_HEADER = @Ob_Summary_screen.summary_header_object
  
  #expect($OB_PATIENT_LIST_OBJ["full_name"]).to eq $OB_HEADER["full_name"]
end

Then(/^I should see the emr patient summary screen$/) do
  sleep(15)
  @Patient_Summary_screen.active_meds_tile.text.should eql "ACTIVE MEDS"
end

When(/^I select the patient overflow button for patient "(.*?)"$/) do |patient_name|
  @Patient_List_screen.patient_overflow_menu(patient_name).click
end

And(/^I select the Live Monitor button on the patient list screen$/) do
  @wait.until { @Patient_List_screen.patient_list_button('Monitor').displayed? == true }
  @Patient_List_screen.patient_list_button('Monitor').click
end

And(/^I select the Events button on the patient list screen$/) do
  @wait.until { @Patient_List_screen.patient_list_button('Events').displayed? == true }
  @Patient_List_screen.patient_list_button('Events').click
end

And(/^I select the Cardio button on the patient list screen$/) do
  @Patient_List_screen.patient_list_cardio_button.click
end

And(/^I select Search from the PM census$/) do
  @Patient_List_screen.search_field.click
end

When(/^I enter "(.*?)" in the field$/) do |text|
  text = process_param(text)
  @Patient_List_screen.searchEditor_textView.send_keys(text)
end

When(/^I enter "(.*?)" in the field for partial search$/) do |text|
  text = process_param(text)
  text_array = text.chars
  partial = text_array.drop(1).join
  @Patient_List_screen.searchEditor_textView.send_keys(partial)
end

Then(/^I should see the patient list grouped by "(.*?)"$/) do |group_by_option|
  @wait.until { @Patient_List_screen.patient_list_form.displayed? == true }
  case
  when choice == "Active"
    group_by_option = 'status'
  when choice == "Bed"
    group_by_option = 'bed'
  when choice == "First Name"
    group_by_option = 'firstname'
  when choice == "Last Name"
    group_by_option = 'lastname'
  when choice == "MRN"
    group_by_option = 'mrn'
  end
  if choice == "Unit"
    expect(@Patient_List_screen.patient_group_header.text).to eql "ALARM"
  else
    expect(@Patient_List_screen.group_header_patient_name_compare(group_by_option)).to be_truthy
  end
end
