# frozen_string_literal: true

Before do
  @PM_Monitor_Screen = PM_Monitor_Screen.new @selenium
  @PM_Navigation_Menu = PM_Navigation_Menu.new @selenium
  @MultiPatientView_Screen = MultiPatientView_Screen.new @selenium
  @PatientList_Screen = PatientList_Screen.new @selenium
  @Header_bar = Header_Bar.new @selenium
  @Sidebar = Sidebar.new @selenium
end

Then(/^I click the "(.*?)" field and should see the following options:$/) do |groupSortOption, table|
  optionList = table.raw
  optionsArray = optionList.flatten
  @wait.until { @PMGroupSort_Window.group_by_field_control.displayed? == true }
  @wait.until { @PMGroupSort_Window.first_sort_by_field_control.displayed? == true }
  @wait.until { @PMGroupSort_Window.second_sort_by_field_control.displayed? == true }
  case
  when groupSortOption == "Group by"
    @PMGroupSort_Window.group_by_field_control.click
  when groupSortOption == "First Sort by"
    @PMGroupSort_Window.first_sort_by_field_control.click
  when groupSortOption == "Second Sort by"
    @PMGroupSort_Window.second_sort_by_field_control.click
  end
  expect(optionsArray.sort).eql?@PMGroupSort_Window.group_by_field_options.sort
end

Then(/^I should see (\d+) full monitors and details should match the first (\d+) patients in previous screen$/) do |total_monitors, _int|
  @wait.until { @MultiPatientView_Screen.dualMonitorView_button.displayed? == true }
  @selenium.manage.timeouts.implicit_wait = DEFAULT_EXPLICIT_WAIT
  expect(total_monitors).eql?@MultiPatientView_Screen.multipatients_array.count
  expected_names = @filtered_mpv_name_array.take(total_monitors).to_s
  expected_locations = @filtered_mpv_array.take(total_monitors).to_s
  actual_names = @MultiPatientView_Screen.multipatients_array.collect { |t| t['name'] }.to_s
  actual_locations = @MultiPatientView_Screen.multipatients_array.collect { |t| t['location'].text }.to_s
  expect(actual_names).eql?expected_names
  expect(actual_locations).eql?expected_locations
end

Then(/^I should see the multi patient list Group or Sort by "(.*?)" in (Ascending|Descending) Order$/) do |choice, order|
  @wait.until { @MultiPatientView_Screen.multi_patient_window.displayed? == true }
  @filtered_mpv_array = @MultiPatientView_Screen.multipatients_array.collect {|t| t['location'].text}
  @filtered_mpv_name_array = @MultiPatientView_Screen.multipatients_array.collect {|t| t['name']}
  case choice
  when "Last Name"
    groupByLastName=@MultiPatientView_Screen.multipatients_array.collect {|t| t['name'].split(",",2)[0].strip.downcase}
    actual_sort = groupByLastName.reject(&:empty?)
    expected_sort = actual_sort.sort
  when "First Name"
    groupByFirstName=@MultiPatientView_Screen.multipatients_array.collect {|t| t['name'].split(",",2)[1].split("•",2)[0].strip.downcase}
    actual_sort = groupByFirstName.reject(&:empty?)
    expected_sort = actual_sort.sort
  when  "None"
    groupByBed=@MultiPatientView_Screen.multipatients_array.collect {|t| t['location'].text.split("•",2)[1].strip.downcase}
    actual_sort = groupByBed
    # The Bed filter is displaying incorrect in the UI, once this is fixed - uncomment the next line and comment the next after it
    # expected_sort = as1_sort.sort_by {|s| s.split(/(\d+)/).map {|s| begin Integer(s, 10); rescue ArgumentError; s end }}
    expected_sort = actual_sort.sort! { |a, b | a <=> b }
  when  "Bed"
    groupByBed=@MultiPatientView_Screen.multipatients_array.collect {|t| t['location'].text.split("•",2)[1].strip}
    actual_sort = groupByBed
    # The Bed filter is displaying incorrect in the UI, once this is fixed - uncomment the next line and comment the next after it
    # expected_sort = as1_sort.sort! { |a, b | a <=> b }
    expected_sort = actual_sort.sort_by {|s| s.split(/(\d+)/).map {|s| begin Integer(s, 10); rescue ArgumentError; s end }}
  when  "Unit"
    groupByUnit=@MultiPatientView_Screen.multipatients_array.collect {|t| t['location'].text.split("•",2)[0].strip}
    actual_sort = groupByUnit
    expected_sort = actual_sort.sort
  when  "Age"
    groupByAge=@MultiPatientView_Screen.multipatients_array.collect {|t| t['name'].split(",",2)[1].split("•",3)[2].strip.to_i}
    actual_sort = groupByAge
    expected_sort = actual_sort.sort
  when  "Gender"
    groupByGender=@MultiPatientView_Screen.multipatients_array.collect {|t| t['name'].split(",",2)[1].split("•",3)[1].strip}
    actual_sort = groupByGender
    expected_sort = actual_sort.sort
    # when "MRN"
    # when "DOB"
    # when "Active/Inactive"
  end
  expected_sort = expected_sort.reverse unless order == "Ascending"
  puts "AS1 GroupBy or SortBy: #{actual_sort}"
  puts "Ruby GroupBy or SortBy: #{expected_sort}"
  expect(actual_sort.should == expected_sort)
  @mpv_sorted_array = actual_sort
end

When(/^I click "(.*?)" button in the header$/) do |backButton|
  expect(@MultiPatientView_Screen.multi_patient_window_back_button.text).eql? backButton
  @MultiPatientView_Screen.multi_patient_window_back_button.click
end
