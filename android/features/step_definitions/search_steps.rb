Before do
  @Search_screen = Search_screen.new selenium, appium
  @List_Of_Lists_window = List_Of_Lists_window.new selenium, appium
end

When(/^I click Search on the List of Lists$/) do
  #@List_Of_Lists_window.list_button("Search").click
  @List_Of_Lists_window.cardioSearchList_button.click
end

When(/^I click the search RESET button$/) do
  @Search_screen.reset_btn.click
end

When(/^I click "(.*?)" on the List$/) do |arg1|
  @List_Of_Lists_window.cardio_pm_list(arg1).click
end

Then(/^I should see Search screen$/) do
  expect(@Search_screen.navigation_bar.text).to eq 'SEARCH' | 'Search'
end

Then(/^I should see OB Search screen$/) do
  expect(@Search_screen.nav_bar.text.upcase).to eq('SEARCH').or eq('Search')
  sleep 10
end

Then(/^I should see No patient matches found on the screen$/) do
  expect(@Search_screen.no_patients_found.text).to eq 'No Results for Search Criteria'
end

Then(/^I should see Search in the nav bar for PM$/) do
  @wait.until { @Search_screen.navigation_bar.exists == true }
  @Search_screen.navigation_bar.text.should eq 'Search'
end

Then(/^I should see Search in the nav bar for EMR$/) do
  @wait.until { @Search_screen.navigation_bar.exists == true }
  @Search_screen.navigation_bar.text.should eq 'SEARCH'
end

Then(/^I should see Search in the nav bar$/) do
  @wait.until { @Search_screen.navigation_bar.exists == true }
  @Search_screen.navigation_bar.text.should eq 'SEARCH'
end

When(/^I enter "(.*?)" in the "(.*?)" field$/) do |first_name, search_field|
  #Common.wait_for_loading_prompt(selenium)
  @Search_screen.search_field(search_field, first_name)
end

When(/^I enter "(.*?)" in the cardio "(.*?)" field$/) do |first_name, search_field|
  #Common.wait_for_loading_prompt(selenium)
  first_name = process_param(first_name)
  @Search_screen.cardio_search_field(search_field, first_name)
end

When(/^I enter "(.*?)" in the cardio "(.*?)" field for partial search$/) do |text, search_field|
  text = process_param(text)
  text_array = text.chars
  text_array.delete_at(text_array.length - 1)
  partial = text_array.join
  @Search_screen.cardio_search_field(search_field, partial)
end

When(/^I enter "(.*?)" in the EMR Search "(.*?)" field$/) do |first_name, search_field|
  #Common.wait_for_loading_prompt(selenium)
  @Search_screen.emr_search_field(search_field, first_name)
end

When(/^I enter "(.*?)" in the pm "(.*?)" field$/) do |first_name, search_field|
  #Common.wait_for_loading_prompt(selenium)
  @Search_screen.pm_search_field(search_field, first_name)
end

When(/^I enter "(.*?)" in the ob "(.*?)" field$/) do |name, search_field|
  #Common.wait_for_loading_prompt(selenium)
  sleep(3)
  if(name == 'ob_patient_one' && search_field == 'First')
	@Search_screen.ob_search_field(search_field, $OB_FIRST_NAME_ONE)
  elsif(name == 'ob_patient_one' && search_field == 'Last')
	@Search_screen.ob_search_field(search_field, $OB_LAST_NAME_ONE)
  elsif(name == 'ob_patient_two' && search_field == 'First')
	@Search_screen.ob_search_field(search_field, $OB_FIRST_NAME_TWO)
  elsif(name == 'ob_patient_two' && search_field == 'Last')
	@Search_screen.ob_search_field(search_field, $OB_LAST_NAME_TWO)
  elsif(name == 'ob_patient_three' && search_field == 'First')
	@Search_screen.ob_search_field(search_field, $OB_FIRST_NAME_THREE)
  elsif(name == 'ob_patient_three' && search_field == 'Last')
	@Search_screen.ob_search_field(search_field, $OB_LAST_NAME_THREE)
  end
end

And(/^I should verify the patient info for George Russell$/) do
	 @Ob_Summary_screen.Ob_Summary_pName.text.should eq 'Russell, George'
	 #@Ob_Summary_screen.Ob_Summary_tvdate.text.should eq "345678912•DOB: 06/21/1976"
	 #@Ob_Summary_screen.Ob_Summary_tvname_sub.text.should eq "•M•37"

	 #puts @Ob_Summary_screen.Ob_Summary_pName.text
	 #puts @Ob_Summary_screen.Ob_Summary_tvname_sub.text
	 #puts @Ob_Summary_screen.Ob_Summary_tvdate.text

end

And(/^I should verify the patient info for Jonathan Blair$/) do
	 @Ob_Summary_screen.Ob_Summary_pName.text.should eq 'Blair, Jonathan'
end

When(/^I click the ob search button$/) do
  @Search_screen.search_btn.click
end

When(/^I verify the age is entered$/) do
  @Search_screen.age_criteria.should eq '37'
end

When(/^I click the search button$/) do
  @Search_screen.search_button.click
end

Then(/^the Search results list displays$/) do
  #Common.wait_for_loading_prompt(selenium)
  @Search_screen.patient_exists(full_name).should eq true
end

Then(/^I should verify the patient information$/) do |table|
  @wait.until { @Search_screen.search_result_header.exists == true }

  expected_data = table.rows_hash
  expected_data['full_name'] = process_param(expected_data['full_name'])
  patient_info = @Search_screen.get_patient_cell_data(expected_data['full_name'])

  patient_info['full_name'].should eq expected_data['full_name']

  unless expected_data['age_sex'].nil?
    expected_data['age'] = process_param(expected_data['age'])
    expected_data['sex'] = process_param(expected_data['sex'])
    patient_info['age_sex'].should include expected_data['age']
    patient_info['age_sex'].should include expected_data['sex']
  end

  unless expected_data['time_info'].nil?
    patient_info['time_info'] == process_param(expected_data['time_info'])
  end

  unless expected_data['ecg_info'].nil?
    expect(patient_info['ecg_info']).to eq(process_param(expected_data['ecg_info'])).or eq('Test3')
  end

  unless expected_data['ecg_count'].nil?
    patient_info['ecg_count'].should eq process_param(expected_data['ecg_count'])
  end
end

Then(/^I should verify the ob patient information for "(.*?)"$/) do |name|
	sleep 5
  if(name == 'ob_patient_one')
	patient_info = @Search_screen.get_patient_obj("#{$OB_LAST_NAME_ONE}, #{$OB_FIRST_NAME_ONE}")
	patient_info['full_name'].should eq "#{$OB_LAST_NAME_ONE}, #{$OB_FIRST_NAME_ONE}"
  elsif(name == 'ob_patient_two')
	patient_info = @Search_screen.get_patient_obj("#{$OB_LAST_NAME_TWO}, #{$OB_FIRST_NAME_TWO}")
	patient_info['full_name'].should eq "#{$OB_LAST_NAME_TWO}, #{$OB_FIRST_NAME_TWO}"
  elsif(name == 'ob_patient_three')
    patient_info = @Search_screen.get_patient_obj("#{$OB_LAST_NAME_THREE}, #{$OB_FIRST_NAME_THREE}")
	patient_info['full_name'].should eq "#{$OB_LAST_NAME_THREE}, #{$OB_FIRST_NAME_THREE}"
  end
end

Then(/^I should verify the pm patient information$/) do |table|
  sleep(1)
  expected_data = table.rows_hash
  expected_data['patientName'] = process_param(expected_data['patientName'])
  patient_info = @Search_screen.get_pm_patient_obj(expected_data['patientName'])

  expected_data['age'] = process_param(expected_data['age'])
  expected_data['gender'] = process_param(expected_data['gender'])
  expected_data['MRN'] = process_param(expected_data['MRN'])
  expected_data['bed'] = process_param(expected_data['bed'])
  unless expected_data['DOB'].nil?
    expected_data['DOB'] = process_param(expected_data['DOB'])
    patient_info['mrn_dob'].should include process_param(expected_data['DOB'])
  end

  patient_info['full_name'].downcase.should eq expected_data['patientName'].downcase
  patient_info['age_sex'].should include expected_data['age']
  patient_info['age_sex'].should include expected_data['gender']
  patient_info['mrn_dob'].should include expected_data['MRN']
  patient_info['bed'].should include expected_data['bed']
end

Then(/^I should verify the emr patient information$/) do |table|
  sleep(1)
  expectedData = table.rows_hash
  patient_info = @Search_screen.get_emr_patient_obj(expectedData['full_name'])
  patient_info['full_name'].should eq expectedData['full_name']
  patient_info['age_sex'].should include expectedData['sex']
  patient_info['age_sex'].should include expectedData['age']
  patient_info['mrn_dob'].should include expectedData['dob']
  patient_info['mrn_dob'].should include expectedData['mrn']
  patient_info['location'].should include expectedData['location']
end

And(/^I should verify the patient info for Esron$/) do
	 @Search_screen.pmsearchresults.text.should eq 'NESBITT, ESRON'
end
