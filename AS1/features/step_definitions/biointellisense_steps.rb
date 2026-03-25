# frozen_string_literal: true

Before do
  @PatientList_Screen = PatientList_Screen.new @selenium
  @Sidebar = Sidebar.new @selenium
  @MultiPatientView = MultiPatientView_Screen.new @selenium
  @PatientChart_Nav = PatientChart_Nav.new @selenium
  @BodySensor_Trends = BodySensor_Trends.new @selenium
  @BodySensor_GridView = BodySensor_GridView.new @selenium
end

When(/^I click on "(.*?)" tab$/) do |list_name|
  @wait.until { @PatientList_Screen.patientList_form.displayed? == true }
  @wait.until { @Sidebar.sidebarOption_button(list_name).displayed? == true}
  puts list_name
  @Sidebar.sidebarOption_button(list_name).click

  @wait.until {@Sidebar.active_menu_option.displayed? == true}

  @patient_list_count = @PatientList_Screen.patient_card.count

end

When(/^I click on the "(.*?)" view in subheader$/) do |body_sensor_view|
  link = ''

  case body_sensor_view
  when 'Grid View'
    link = @BodySensor_Trends.grid_view_link
  when 'Trends'
    link = @BodySensor_GridView.trends_view
  when 'Month'
    link = @BodySensor_Trends.month_view_link[0]
  when 'Week'
    link = @BodySensor_Trends.week_view_link[0]
  when 'Day'
    link = @BodySensor_Trends.day_view_link[0]
  end

    expect(link.displayed?).to eql true


  link.click

end

When(/^I click "(.*?)" in the MPV sidebar$/) do |mpv_view|
  fifty_view = @MultiPatientView.sideNav_50view
  observation_view = @MultiPatientView.sideNav_observationView

  @wait.until { fifty_view.displayed? == true }

  case mpv_view
  when '50 view'
    fifty_view.click
  when 'observation view'
    observation_view.click
  end
end

Then(/^I should see "(.*?)" tab selected$/) do |tab_name|
  @wait.until { @PatientList_Screen.patientList_form.displayed? == true }

  sidebar_selected = @Sidebar.active_menu_option
  @patient_list = @PatientList_Screen.patient_card
  @patient_count = @patient_list.count

  sidebar_selected.text.should include tab_name
  puts @patient_count
end

Then(/^I should see Body Sensor Screen$/) do
  @wait.until { @BodySensor_Trends.body_sensor_tab.displayed? == true }
  @BodySensor_Trends.attribute(:class).should include 'active'
end

Then(/^I should see Multi Patient Current Reading list view$/) do
  @wait.until { @MultiPatientView.bodySensorObservations_view.displayed? == true }
  expect(@MultiPatientView.bodySensorObservations_view.displayed?).to eql true
end

Then(/^Multipatient List should match Patient List count$/) do
  @mpv_patient_count = @MultiPatientView.bodySensorObservationsList_count
end



Then(/^I should see Multi Patient Event list view$/) do
  @wait.until { @MultiPatientView.bodySensorEvents_view.displayed? == true }
  expect(@MultiPatientView.bodySensorEvents_view.displayed?).to eql true
end

Then(/^Multi Patient count matches Patient List count$/) do 
  patient_list_count = @patient_count
  @mpv_patients = ''
  mpv_view = @MultiPatientView_Screen.biointel_viewOptions

  if mpv_view[0].attribute('className').include? 'active'
    puts "Observation/Current Readings view is active"
    @mpv_patients = @MultiPatientView_Screen.MPV_ObservationView_Patients
  elsif mpv_view[1].attribute('className').include? 'active'
    puts "Events Tile view is active"
    @mpv_patients = @MultiPatientView_Screen.MPV_EventTileView_Patients
  end
  
  mpv_patient_count = @mpv_patients.count
  puts "This is multi patient count: #{mpv_patient_count}"
  puts "This is patient list count: #{patient_list_count}"
  mpv_patient_count.should == patient_list_count
end

Then(/^I see patient "(.*?)" information$/) do |view|
  bodySensor_tab = @PatientChart_Nav.bodySensor_tab
  currentReading = ''
  eventsTimeline = ''
  respirationRate = ''

  @wait.until { bodySensor_tab.displayed? == true}

  @wait.until { @PatientChart_Nav.bodySensor_tab.displayed? == true}

  expect(bodySensor_tab.attribute('className').include? 'active').to eql true

  case view
  when 'Grid View'
    eventsTimeline = @BodySensor_GridView.eventsTimeline_table
    respirationRate = @BodySensor_GridView.respirationRate_chart
    
  when 'Trends'
    currentReading = @BodySensor_Trends.currentReadings_table
    eventsTimeline = @BodySensor_Trends.eventsTimeline_table
    respirationRate = @BodySensor_Trends.respirationRate_chart
  end

  if view == 'Trends'
    @wait.until { currentReading.displayed? == true }
    expect(currentReading.displayed?).to eql true
  end

  @wait.until { eventsTimeline.displayed? == true }
  expect(eventsTimeline.displayed?).to eql true
  expect(respirationRate.displayed?).to eql true
end

Then(/^I "(.*?)" the "(.*?)" option view$/) do |see_or_dont, view_link|
  month_link = @BodySensor_Trends.month_view_link
  week_link = @BodySensor_Trends.week_view_link
  day_link = @BodySensor_Trends.day_view_link
  link = ''

  case view_link
  when 'Month'
    link = month_link
  when 'Week'
    link = week_link
  when 'Day'
    link = day_link
  end

  puts "This is the link: #{link}"

  case see_or_dont
  when 'see'
    expect(link.size() > 0).to eql true
  when "don't see"
    expect(link.size() < 1).to eql true
  end
end

Then(/^The events timetable is updated to show the last "([^"]*)"$/) do |subview|
  events = @BodySensor_Trends.eventsTimeline_table
  date = DateTime.now
  formattedDate = date.strftime("%m/%d")
  beginningDate = ''

  case subview
  when "Month"
    beginningDate = (formattedDate - 1.months).strftime("%m/%d")
    expect(beginningDate == (formattedDate - 1.month))
  when "Week"
    beginningDate = (formattedDate - 1.week).strftime("%m/%d")
    expect(beginningDate == (formattedDate - 1.week))
  when "Day"
    beginningDate = (formattedDate - 1.day).strftime("%m/%d")
    expect(beginningDate == (formattedDate - 1.day))
  end

  puts beginningDate
  return beginningDate

end

