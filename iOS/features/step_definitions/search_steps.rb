Before do
  @Search_screen = Search_screen.new selenium, appium
  @PatientList_screen = PatientList_screen.new selenium, appium
end

Then(/^I should see the Search Screen$/) do
  @wait.until { @Search_screen.search_navigation.displayed? == true }
  expect(@Search_screen.search_navigation.visible).to eq "true"
end

Then(/^I should see the Cardio Search Screen$/) do
  @wait.until { @Search_screen.search_navigation.displayed? == true }
  expect(@Search_screen.search_navigation.visible).to eq "true"
end

Then(/^I should see the PM Search Screen$/) do
	@wait.until { @Search_screen.search_title.displayed? == true }
  expect(@Search_screen.search_title.text).to eq "Search"
end

Then(/^I should see the EMR search screen$/) do
  expect(@Search_screen.emr_last_name.exists).to eq true
  expect(@Search_screen.emr_first_name.exists).to eq true
  expect(@Search_screen.emr_dob.exists).to eq true
  expect(@Search_screen.emr_mrn.exists).to eq true
  expect(@Search_screen.emr_fin.exists).to eq true
end

When(/^I enter "(.*?)" in "(.*?)" search field$/) do |text, searchType|
  sleep 2
  patient_data=process_param(text)
  if(searchType == "DOB")
    searchType = "MM/DD/YYYY"
  end
  
  element = @Search_screen.search_criteria_button(searchType)
  Common.click_center_of_object(element)
    
  begin
    found = false
		
      for i in 0..5
        value = @Login_screen.keyboard.visible
        value = value.to_boolean
        puts "the value is #{value}"
        #puts "++++"
        #puts value.to_boolean
        #puts "++++"
        if value == true
          found = true
          break
        else
          KEYBOARD.toggle_hardware_keyboard         
        end
        value = @Login_screen.keyboard.visible
        if value == true        
          found = true
          break
        end
        if found == true
          break
        end
      end
  rescue StandardError => e

  end
  
  element.send_keys(patient_data)
  
end

When(/^I click the search button$/) do
  element = @Search_screen.search_button
  puts element.name
  Common.click_center_of_object(element)
end

When(/^I click the clear form button$/) do
  element = @Search_screen.clear_form_button
  Common.click_center_of_object(element)
end

When(/^I should no patient matches found in patient list$/) do
	if @appVersion == "1.5.2100" || @appVersion == "1.5.2300"
		expect(@PatientList_screen.patient_cell("No patient matches found.").nil?).to be_falsey
	elsif @appVersion == "1.6.0"
		expect(@PatientList_screen.patient_cell("No patient records in the list.").nil?).to be_falsey
	end
end

Then(/^I should see a total of (\d+) patient\(s\) in the search results$/) do |numOfPatients|
  sleep(5)
  @wait.until { @Search_screen.search_result_returned.displayed? == true }
  value = @PatientList_screen.getNumOfPatientsInList  
  expect(value).to be >= numOfPatients.to_i
end

Then(/^I should see the Missing Criteria dialog$/) do
  expect(@Search_screen.missing_criteria_dialog.exists).to eq true
end

When(/^I click the OK button$/) do
  element = @Search_screen.missing_criteria_ok_button
  Common.click_center_of_object(element)
end
