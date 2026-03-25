Before do
  @ListOfLists_window = ListOfLists_window.new selenium, appium
  @PatientList_screen = PatientList_screen.new selenium, appium
  @Search_screen = Search_screen.new selenium, appium
end

Then(/^I should see the "(.*?)" patient List$/) do |listName|
 navbar = @PatientList_screen.navigation_bar(listName)
  #puts navbar.name
  expect(navbar.exist).to be_truthy
  expect(navbar.name).to include listName
end

When(/^I enter patient "(.*?)" in the pm patient list search field$/) do | which_patient | #one or two
  @wait.until { @PatientList_screen.patient_search_field. displayed? == true }
  patient=process_param(which_patient)
  puts patient
  element = @PatientList_screen.patient_search_field
  Common.click_center_of_object(element)
  element.clear
  element.send_keys patient
  search_buton=@PatientList_screen.search_keyboard_button
  search_buton.click unless search_buton.nil?
  sleep 2
end

When(/^I enter "(.*?)" in the pm patient list search field$/) do | patient_name |
  sleep 5
  @wait.until {@PatientList_screen.patient_search_field}
  element = @PatientList_screen.patient_search_field
  Common.click_center_of_object(element)
  element.clear
  element.send_keys patient_name
end

When(/^I enter search criteria "(.*?)" in the pm patient list search field$/) do | which |
  case which
  when "patient one"
    patient_name = PM_PATIENT_ONE
  when "patient one first name"
    patient_name = PM_PATIENT_ONE_FIRST_NAME
  when "patient one last name"
    patient_name = PM_PATIENT_ONE_LAST_NAME
  when "patient one partial last name"
    patient_name = PM_PATIENT_ONE_PARTIAL_LAST
  when "patient one partial first name"
    patient_name = PM_PATIENT_ONE_PARTIAL_FIRST
  when "patient one mrn"
    patient_name = PM_PATIENT_ONE_MRN
  when "patient one unit"
    patient_name = PM_PATIENT_ONE_UNIT
  when "patient one bed"
    patient_name = PM_PATIENT_ONE_BED
  when "patient three"
    patient_name = PM_PATIENT_THREE
  when "patient three mrn"
    patient_name = PM_PATIENT_THREE_MRN
  when "patient three unit"
    patient_name = PM_PATIENT_THREE_UNIT
  end

  element = @PatientList_screen.patient_search_field
  Common.click_center_of_object(element)
  element.clear
  element.send_keys patient_name
 end

When(/^I enter "(.*?)" patient list search field$/) do | patient_name |
 element = @PatientList_screen.patient_search_field
 Common.click_center_of_object(element)
 element.send_keys patient_name
  #@PatientList_screen.patient_search_field.send_keys patient_name
end

When(/^I click clear text button on the nav search$/) do | patient_name |
 element = @Search_screen.nav_clear_button
 Common.click_center_of_object(element)
end

When(/^I click cancel button on the nav search$/) do
 element = @Search_screen.nav_cancel_button
 Common.click_center_of_object(element)
end

When(/^I click search button on the nav search$/) do
 element = @Search_screen.nav_search_button
 Common.click_center_of_object(element)
end

Then(/^I should see the following patient "(.*?)" in patient list$/) do |patient_name|
  patient = @PatientList_screen.get_patient(patient_name)

  expect(patient.text.upcase).to eq patient_name.upcase
end

Then(/^I should see patient "(.*?)" in patient search results$/) do |which_patient|
  which_patient=process_param(which_patient)
  patient = @PatientList_screen.get_patient(which_patient)
  expect(patient.text.upcase).to eq which_patient.upcase
end

Then(/^I should see the PM Search screen$/) do
 @Search_screen.pm_first_name.exists.should be true
end

When(/^I click on patient row "(.*?)" on ob patient list$/) do |row|
  element = @PatientList_screen.patientRow_cell(row)
  Common.click_center_of_object(element)
end

When(/^I click on patient on ob patient list$/) do
  element = @PatientList_screen.patient_cell(@patientName)
  Common.click_center_of_object(element)
end

When(/^I get ob patient data on row "(.*?)"$/) do |row|
  patientData = @PatientList_screen.getPatientInfoFromPatientList_ob(row)

  for i in 0..patientData.count-1
    puts patientData[i]
  end

  @patientEAG = patientData[0]
  @patientPhysician = patientData[1]
  @patientMembraneStatus = patientData[2]
  @patientName = patientData[3]
  @patientGravidaPara = patientData[4]
  @patientCervicalExam = patientData[5]

  if patientData.count > 7
    @patientCervicalExamTime = patientData[6]
    @patientRoomNumber = patientData[7]

  else
    @patientRoomNumber = patientData[6]
  end
end

When(/^I click on "(.*?)" in the training patient list$/) do |name|
 @TRAINING_PATIENT_NAME = name

	#@PatientList_screen.patient_cell(name).click
	element = @PatientList_screen.patient_cell(name)
	Common.click_center_of_object(element)
end

When(/^I click on patient "(.*?)" in the pm patient list$/) do |which_patient|
  which_patient=process_param(which_patient)
  patient = @PatientList_screen.patient_cell(which_patient)
  puts patient.name
  patient.click
end

When(/^I click on "(.*?)" in the pm patient list$/) do |name|
  patient = @PatientList_screen.patient_cell(name)
  puts patient.name

  Common.click_center_of_object(patient)
end

When(/^I click on "(.*?)" in patient list$/) do |name|
  patient_data=process_param(name)

   patient = @PatientList_screen.patient_cell(patient_data)
   puts patient.name

   Common.click_center_of_object(patient)

end

When(/^I click the options-monitor button for patient "(.*?)" and bed "(.*?)"$/) do |name, bed|

  row = @PatientList_screen.getRowOfPatientNameFromPMPatientList(name)
  puts row
  element = @PatientList_screen.pm_list_options_button(row)
  Common.click_center_of_object(element)
  #location = element.location
  #aa = location[:x]
  #bb = location[:y]
  ##xx = element.size[:width] / 2
  ##yy = element.size[:height] / 2
  #
  #Appium::TouchAction.new.press(x: aa, y: bb).wait(5).release.perform
  #@PatientList_screen.pm_list_options_button(row).click

  #@PatientList_screen.pm_list_monitor_button(row).click



  #element = @PatientList_screen.pm_list_bed(bed)
  #Common.click_center_of_object(element)


  #location = element.location
  #aa = location[:x]
  #bb = location[:y]
  ##xx = element.size[:width] / 2
  ##yy = element.size[:height] / 2
  #
  #Appium::TouchAction.new.press(x: aa, y: bb).wait(5).release.perform
  #@PatientList_screen.pm_list_bed(bed).click
end

When(/^I click the options-events button for patient "(.*?)"$/) do |name|

  row = @PatientList_screen.getRowOfPatientNameFromPMPatientList(name)

  element = @PatientList_screen.pm_list_options_button(row)
  Common.click_center_of_object(element)



  #element = @PatientList_screen.pm_list_events_button(row)
  # Common.click_center_of_object(element)

end

When(/^I click on patient "(.*?)" with the ecg count of "(.*?)" in patient list$/) do |name, ecg|
  element = @PatientList_screen.getRowOfPatientNameFromPatientList_ecg_count(name, ecg)
  Common.click_center_of_object(element)
end

When(/^I click on "(.*?)" in EMR patient list$/) do |name|
  row = @PatientList_screen.getRowOfPatientNameFromEMRPatientList(name)

  element = @PatientList_screen.patient_cell(row)
  Common.click_center_of_object(element)
end

When(/^I click on "(.*?)" in PM patient list$/) do |name|
  row = @PatientList_screen.getRowOfPatientNameFromPMPatientList(name)

  element = @PatientList_screen.pm_patient_cell(row)
  Common.click_center_of_object(element)
end

When(/^I click options button on top left of screen$/) do
  wait_for(15) { expect(@ListOfLists_window.nav_bar.displayed?).to be true }
  # begin
  #   expect(@ListOfLists_window.nav_bar.displayed?).to be true
  # rescue
  #   expect(@ListOfLists_window.nav_bar.displayed?).to be true
  # end

  if $device_version == "13.7"
   element = @ListOfLists_window.options_button
  else
   element = @ListOfLists_window.options_button14
   if element == nil
     sleep 7
     element = @ListOfLists_window.options_button14
   end
  end

  Common.click_center_of_object(element)
end

Then(/^I should see the following patient in patient list$/) do |table|
  patients = table.hashes
  sleep 1
  patients.each do |patient|
    puts patient[:patientName]
    processed_patient=process_param(patient[:patientName])
    processed_gender=process_param(patient[:gender])
    processed_age=process_param(patient[:age])
    row = @PatientList_screen.getRowOfPatientNameFromPatientList(processed_patient)
    puts row
    patientData = @PatientList_screen.getPatientInfoFromPatientList(row)

    patientData[1].should eql processed_patient
    patientData[2].should eql processed_gender
    patientData[4].should include processed_age
    #patientData[3].should eql patient[:acqDate]
    #patientData[4].should eql patient[:ecgCount]
    #patientData[5].should include patient[:diagState1]
  end
end

Then(/^I should see the following patient in PM patient list$/) do |table|

  #@PatientList_screen.get_cellview_cell_textviews

  patients = table.hashes
  patients.each do |patient|
    row = @PatientList_screen.getRowOfPatientNameFromPMPatientList(patient[:patientName])
    #puts "row count = #{row}"
    patientData = @PatientList_screen.getPatientInfoFromPMPatientList(row)
    patientData[0].should eql patient[:patientName]
    patientData[1].should include patient[:gender]
    #patientData[2].should include patient[:age]
    patientData[3].should eql patient[:mrn]
    patientData[4].should eql patient[:bed]
  end
end

Then(/^I should see the following patient in EMR patient list$/) do |table|
  patients = table.hashes
  patients.each do |patient|
    row = @PatientList_screen.getRowOfPatientNameFromEMRPatientList(patient[:patientName])
    patientData = @PatientList_screen.getPatientInfoFromEMRPatientList(row)
    patientData[0].should eql patient[:patientName]
    patientData[1].should eql patient[:gender]
    patientData[2].should eql patient[:age]
    patientData[3].should eql patient[:mrn]
    patientData[4].should eql patient[:admitDate]
    patientData[5].should eql patient[:location]
  end
end
