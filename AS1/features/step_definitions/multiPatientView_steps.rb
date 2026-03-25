# frozen_string_literal: true

Before do
  @PM_Monitor_Screen = PM_Monitor_Screen.new @selenium
  @PM_Navigation_Menu = PM_Navigation_Menu.new @selenium
  @MultiPatientView_Screen = MultiPatientView_Screen.new @selenium
  @PatientList_Screen = PatientList_Screen.new @selenium
  @Header_bar = Header_Bar.new @selenium
  @Sidebar = Sidebar.new @selenium
end

When(/^I click the Multi-Patient View button in header$/) do
  @wait.until { @PatientList_Screen.multiPatientView_link['link_obj'] }
  @patient_list_count = @PatientList_Screen.pm_patientList_count
  @my_patients_sidebar_count = @Sidebar.sidebarOption_count('My Patients')

  if INFO == true
    puts "Current Patient List selected: #{@patient_list_selected}"
    puts "Current Patient List count: #{@patient_list_count}"
    puts "My Patients sidebar count: #{@my_patients_sidebar_count}"
  end

  @expected_mpv_monitors = if @patient_list_selected != 'My Patients'
                             if @patient_list_count < 40
                               @patient_list_count
                             else
                               40
                             end
                           else
                             @my_patients_sidebar_count.to_i
                           end
  @PatientList_Screen.multiPatientView_link['link_obj'].click
end

When(/^I click the Multi-Patient View button on MPV screen$/) do
  @wait.until { @PatientList_Screen.multiPatientView_link['link_obj'] }
  @PatientList_Screen.multiPatientView_link['link_obj'].click
end

Then(/^I should see Multi Patient View screen with condensed monitors selected in full screen mode$/) do
  @wait.until { @selenium.find_elements(:css, ".loader").empty? }
  @wait.until { @MultiPatientView_Screen.multi_patient_window.displayed? == true }
  sleep 5
  expect(@PatientList_Screen.multiPatientView_link['status']).to be_truthy
  if @expected_mpv_monitors.to_i >= 40
    expect(@MultiPatientView_Screen.condensedPatientMonitors.count).to eql 40
  else
    expect(@MultiPatientView_Screen.condensedPatientMonitors.count).to eql @expected_mpv_monitors.to_i
  end

end

Then(/^I should see the back button in the header$/) do
  @wait.until { @PM_Navigation_Menu.mpv_back_button }
  expect(@PM_Navigation_Menu.mpv_back_button).to be_truthy
end

When(/^I click the back button in the Header$/) do
  @wait.until { @PM_Navigation_Menu.mpv_back_button }
  @PM_Navigation_Menu.mpv_back_button.click
end

When(/^I drag a patient to reorder$/) do
  @wait.until { @MultiPatientView_Screen.mpv_patient_list_slideout_component.displayed? === true }
  patient1 = @MultiPatientView_Screen.dragable_patient_card[0]
  patient4 = @MultiPatientView_Screen.dragable_patient_card[3]
  #Workarounf for drag and drop in HTML 5 for Chrome on MAC
  @selenium.execute_script($DND_SCRIPT,patient4,patient1);
  expect(@MultiPatientView_Screen.dragable_patient_card[0].text).to eql patient4.text
end

When(/^I click on individual condensed patient monitor on Multi Patient View screen$/) do

  case ENVIRONMENT
  when '34', 'server_hardening'
    PATIENT = 'Nesbitt, Esron'
    if @MultiPatientView_Screen.hidePHI_button.attribute('className').include? 'active'
      puts 'the PHI button is active'
      @MultiPatientView_Screen.condensedPatientMonitor('Nes, Esr')['monitor_obj'].click
      puts 'i just tried to click on Nes, Esr'
    else
      begin
        puts "about to click on patient #{PATIENT}"
        @MultiPatientView_Screen.condensedPatientMonitor(PATIENT)['monitor_obj'].click
      rescue NoMethodError
        steps %(
          When I move the zoom control to 40 percent zoom
          And I should see the zoom control at 40 percent zoom
        )
        @MultiPatientView_Screen.condensedPatientMonitor(PATIENT)['monitor_obj'].click
      end
    end
  when '35'
    PATIENT = 'ALM2, ALM2'

    if @MultiPatientView_Screen.hidePHI_button.attribute('className').include? 'active'
      puts 'the PHI button is active'
      @MultiPatientView_Screen.condensedPatientMonitor('ALM, ALM')['monitor_obj'].click
      puts 'i just tried to click on ALM, ALM'
    else
      begin
        puts "about to click on patient #{PATIENT}"
        @MultiPatientView_Screen.condensedPatientMonitor(PATIENT)['monitor_obj'].click
      rescue NoMethodError
        steps %(
          When I move the zoom control to 40 percent zoom
          And I should see the zoom control at 40 percent zoom
        )
        @MultiPatientView_Screen.condensedPatientMonitor(PATIENT)['monitor_obj'].click
      end
    end
  when 'automation'
    PATIENT = process_param("[props.MPV_FULL_NAME_NO_PHI]")

    if @MultiPatientView_Screen.hidePHI_button.attribute('className').include? 'active'
      puts 'the PHI button is active'
      @MultiPatientView_Screen.condensedPatientMonitor(PATIENT)['monitor_obj'].click
      puts 'i just tried to click on pla, pfi'
    else
      begin
        @MultiPatientView_Screen.hidePHI_button.click
        puts "about to click on patient #{PATIENT}"
        @MultiPatientView_Screen.condensedPatientMonitor(PATIENT)['monitor_obj'].click
      rescue NoMethodError
        steps %(
          When I move the zoom control to 40 percent zoom
          And I should see the zoom control at 40 percent zoom
        )
        @MultiPatientView_Screen.condensedPatientMonitor(PATIENT)['monitor_obj'].click
      end
    end
  end
end

When(/^I click on individual condensed monitor for patient "(.*?)" on Multi Patient View screen$/) do | patient_one |
  m_patient_info = nil
  if @MultiPatientView_Screen.hidePHI_button.attribute('className').include? 'active'
    puts 'the PHI button is active'
    m_patient_info = @MultiPatientView_Screen.condensedPatientMonitor('Nes, Esr')
    m_patient_info['monitor_obj'].click
    puts 'i just tried to click on Nes, Esr'
  else
    begin
      puts "about to click on patient #{patient_one}"
      m_patient_info = @MultiPatientView_Screen.condensedPatientMonitor(patient_one)
      m_patient_info['monitor_obj'].click
    rescue NoMethodError
      steps %(
        When I move the zoom control to 40 percent zoom
        And I should see the zoom control at 40 percent zoom
      )
      m_patient_info = @MultiPatientView_Screen.condensedPatientMonitor(patient_one)
      m_patient_info['monitor_obj'].click

    end
  end
  @multi_patient_name = m_patient_info['name']
  sleep 5
end

Then(/^I should see the selected patient monitor open on left side of Multi Patient View in split screen mode$/) do
  case ENVIRONMENT
  when '34'
    patient_name = 'Nesbitt, Esron'
  when 'server_hardening'
    patient_name = 'Nesbitt, Esron'
  when '35'

    if @mpv_names.nil? || @mpv_names.empty?
      patient_name = 'ALM2, ALM2'
    else
      patient_name = @mpv_names[0]
    end

    puts patient_name
  when 'automation'
        patient_name = process_param("[props.MPV_FULL_NAME_NO_PHI]")
  end
  puts "should be viewing #{patient_name}"
  sleep 5
  obj = @MultiPatientView_Screen.condensedPatientMonitor(patient_name)
  expect(obj['name']).to include patient_name
end

Then(/^I should see the patient monitor for "(.*?)" open on left side of Multi Patient View in split screen mode$/) do | patient_name |
  obj = @MultiPatientView_Screen.condensedPatientMonitor(patient_name)

  expect(obj["name"]).to eql @multi_patient_name
  expect(@multi_patient_name).to include patient_name
end

Then(/^I should see the zoom control toggle displays as "(.*?)" in header$/) do |status|
  case status
  when 'enabled'
    expect(@MultiPatientView_Screen.zoomControl_status).to be_truthy
  when 'disabled'
    expect(@MultiPatientView_Screen.zoomControl_status).to be_falsey
  end
end

Then(/^I should see the selected patient monitor open below Multi Patient View in split screen mode$/) do
  sleep 2
  expect(@MultiPatientView_Screen.fullPatientMonitors.count).to eql 1
end

When(/^I click on any condensed monitor above$/) do
  @MultiPatientView_Screen.condensedPatientMonitors[1].click
  sleep 2
end

Then(/^I should see Group By Sort By, Filter Units and Search in header$/) do
  expect(@PatientList_Screen.group_sort_link['link_obj']).to be_truthy
  expect(@PatientList_Screen.filter_units_link['link_obj']).to be_truthy
  expect(@PatientList_Screen.search_container).to be_truthy
end

Then(/^I should see Group By Sort By, Filter Units links disabled$/) do
  expect(@PatientList_Screen.group_sort_link['disabled']).to be_truthy
  expect(@PatientList_Screen.filter_units_link['disabled']).to be_truthy
end

Then(/^I should see Group By Sort By, Filter Units links not display$/) do
  group_sort_exists = true
  filter_units_exists = true

  begin
    gsl = @PatientList_Screen.group_sort_link
    puts "found gsl #{gsl.displayed?}"
  rescue
    group_sort_exists = false
    puts "group sort does not exist"
  end

  begin
    fl = @PatientList_Screen.filter_units_link
    puts "found gsl #{fl.displayed?}"
  rescue
    filter_units_exists = false
    puts "filter units does not exist"
  end

  expect(group_sort_exists).to be_falsey
  expect(filter_units_exists).to be_falsey
end

Then(/^I should see Group By Sort By links disabled$/) do
  expect(@PatientList_Screen.group_sort_link['disabled']).to be_truthy
end

Then(/^I should see Filter Units links enabled$/) do
  sleep 4
  expect(@PatientList_Screen.filter_units_link['disabled']).to be_falsey
end

Then(/^I should see patients demographics, location, alarms, and (\d+) waveform with parameters in each condensed monitor$/) do |_numb_waveforms|
  if @expected_mpv_monitors.to_i >= 40
    expect(@MultiPatientView_Screen.condensedPatientMonitors.count).to eql 40
  else
    expect(@MultiPatientView_Screen.condensedPatientMonitors.count).to eql @expected_mpv_monitors.to_i
  end
end

And(/^I should get the single lead header objects for patient "(.*?)"$/) do | which_patient |
  $patient_header_info = @MultiPatientView_Screen.single_lead_patient_info(which_patient)
end

And(/^I should see the name field display on the single lead view for patient "(.*?)"$/) do | which_patient |
  expect($patient_header_info['name']).to be_truthy
  puts "patient name on the single lead view #{$patient_header_info['name'].text}"
end

And(/^I should see location field display on the single lead view for patient "(.*?)"$/) do | which_patient |
  expect($patient_header_info['location']).to be_truthy
  puts "patient location on the single lead view #{$patient_header_info['location'].text}"
end

And(/^I should get the single lead discrete objects for patient "(.*?)"$/) do | which_patient |
  $patient_discretes = @MultiPatientView_Screen.single_lead_discretes(which_patient)
end

And(/^I should see heart rate field display with title "(.*?)" on the single lead view for patient "(.*?)"$/) do |title, which_patient|
  expect($patient_discretes['hr']).to be_truthy
  is_regexp=title.include?("matches:")
  if is_regexp
    expect($patient_discretes['hr_title'].text).to match title.gsub("matches:","")
  else
    expect($patient_discretes['hr_title'].text).to eql title
  end
  puts "heart rate on the single lead view #{$patient_discretes['heart_rate'].text}"
end

And(/^I should see PVC field display with title "(.*?)" on the single lead view for patient "(.*?)"$/) do |title, which_patient|
  is_regexp=title.include?("matches:")
  if is_regexp
    expect($patient_discretes['pvc_bpm_title'].text).to match title.gsub("matches:","")
  else
    expect($patient_discretes['pvc_bpm_title'].text).to eql title
  end
  puts "PVC on the single lead view #{$patient_discretes['pvc_bpm'].text}"
end

And(/^I should see spo2 field display with title "(.*?)" on the single lead view for patient "(.*?)"$/) do | title, which_patient |
  expect($patient_discretes['spo']).to be_truthy
  expect($patient_discretes['spo_title'].text).to eql title
end

And(/^I should see nbp mm hg field display with title "(.*?)" on the single lead view for patient "(.*?)"$/) do | title, which_patient |
  expect($patient_discretes['nbp_mm_hg']).to be_truthy
  expect($patient_discretes['nbp_mm_hg_title'].text).to eql title
end

And(/^I should see rr bpm field display with title "(.*?)" on the single lead view for patient "(.*?)"$/) do | title, which_patient |
  expect($patient_discretes['rr_bpm']).to be_truthy
  is_regexp=title.include?("matches:")
  if is_regexp
    expect($patient_discretes['rr_bpm_title'].text).to match title.gsub("matches:","")
  else
    expect($patient_discretes['rr_bpm_title'].text).to eql title
  end
end

And(/^I should see pulse rate beat min field display with title "(.*?)" on the single lead view for patient "(.*?)"$/) do | title, which_patient |
  expect($patient_discretes['pulse_rate_beat_min']).to be_truthy
  expect($patient_discretes['pulse_rate_beat_min_title'].text).to eql title
end

And(/^I should see cuff pres field display with title "(.*?)" on the single lead view for patient "(.*?)"$/) do | title, which_patient |
  expect($patient_discretes['cuff_pres']).to be_truthy
  expect($patient_discretes['cuff_pres_title'].text).to eql title
end

Then(/^I should see default sort by Bed left to right then top to bottom$/) do
  # sleep 5
  # (0..@expected_mpv_monitors.to_i - 2).each do |x|
  #   location1 = @MultiPatientView_Screen.condensedPatientMonitors[x].find_element(:class, 'location').text
  #   location2 = @MultiPatientView_Screen.condensedPatientMonitors[x + 1].find_element(:class, 'location').text
  #
  #   begin
  #     bed1 = location1[location1.index('•') + 2..location1.length]
  #     bed2 = location2[location2.index('•') + 2..location2.length]
  #   rescue StandardError
  #     # continue if values return null
  #   end
  #
  #   puts "location 1 = #{location1}"
  #   puts "location 2 = #{location2}"
  #
  #   index_one = location1.index(' ')
  #   index_two = location2.index(' ')
  #   first_unit = location1[0..index_one]
  #   second_unit = location2[0..index_two]
  #
  #   bed_index_one = bed1.index(/[(\d|\-)]/)
  #   bed_index_two = bed2.index(/[(\d|\-)]/)
  #   next if (bed_index_one.nil? or bed_index_two.nil?)
  #
  #   bed_pre_one = bed1[0..(bed_index_one -1)]
  #   bed_pre_two = bed2[0..(bed_index_two -1)]
  #
  #   puts "bed_pre_one = #{bed_pre_one}"
  #   puts "bed_pre_two = #{bed_pre_two}"
  #
  #   bed1_value = bed1[bed_index_one+1,100]
  #   bed2_value =bed2[bed_index_two+1,100]
  #
  #   puts bed1_value
  #   puts bed2_value
  #
  #   #if location1 == "ICU1 • B850" && location2 == "PIIC-iX • SIM5"
  #   puts  "Comparing [#{location1}] <= [#{location2}]."
  #   if first_unit == second_unit
  #     if bed_pre_one == bed_pre_two
  #       expect(bed1_value.to_i).to be <= bed2_value.to_i
  #     else
  #       puts "the beds are not similar"
  #       expect(bed_pre_one).to be < bed_pre_two
  #     end
  #   else
  #     puts "the units are different"
  #     expect(first_unit).to be < second_unit
  #   end
  # end
end

Then(/^I should see condensed monitors sorted by bed regardless of previous patient list sort$/) do
  (0..@expected_mpv_monitors.to_i - 2).each do |x|
    location1 = @MultiPatientView_Screen.condensedPatientMonitors[x].find_element(:class, 'location').text
    location2 = @MultiPatientView_Screen.condensedPatientMonitors[x + 1].find_element(:class, 'location').text
    bed1 = location1[location1.index('•') + 2..location1.length]
    bed2 = location2[location2.index('•') + 2..location2.length]

    puts "location 1 = #{location1}"
    puts "location 2 = #{location2}"

    index_one = location1.index(' ')
    index_two = location2.index(' ')
    first_unit = location1[0..index_one]
    second_unit = location2[0..index_two]

    bed_index_one = bed1.index(/[0-9]/)
    bed_index_two = bed2.index(/[0-9]/)

    bed_pre_one = bed1[0..(bed_index_one - 1)]
    bed_pre_two = bed2[0..(bed_index_two - 1)]

    puts "bed_pre_one = #{bed_pre_one}"
    puts "bed_pre_two = #{bed_pre_two}"

    bed1_value = bed1.scan(/\d+/).first
    bed2_value = bed2.scan(/\d+/).first

    puts bed1_value
    puts bed2_value

    if first_unit == second_unit
      if bed_pre_one == bed_pre_two
        expect(bed1_value.to_i).to be <= bed2_value.to_i if bed2_value.nil? == false
      else
        puts "the beds are not similar"
      end
    else
      puts "the units are different"
    end
  end
    #expect(bed1).to be <= bed

end

Then(/^I should see Filter Units link disabled$/) do
  expect(@PatientList_Screen.filter_units_link['disabled']).to be_truthy
end

Then(/^I should see Group By Sort By link disabled$/) do
  expect(@PatientList_Screen.group_sort_link['disabled']).to be_truthy
end

Then(/^I should see Filter Units link enabled$/) do
  expect(@PatientList_Screen.filter_units_link['disabled']).to be_falsey
end

Then(/^I should see a total of "(.*?)" patients in the "(.*?)" unit$/) do |totalpatients, unit|
  count = 0

  (0..@expected_mpv_monitors.to_i - 1).each do |x|
    location = @MultiPatientView_Screen.condensedPatientMonitors[x].find_element(:class, 'location').text

    count += 1 if location.include? unit
  end

  expect(count).to eql totalpatients.to_i
end

Then(/^I should see the zoom control toggle in header$/) do
  expect(@MultiPatientView_Screen.zoomControl_slider).to be_truthy
end

Then(/^I should see condensed monitor control button in header$/) do
  expect(@MultiPatientView_Screen.condensedMonitorView_button).to be_truthy
end

Then(/^I should see condensed monitor control button is enabled in the header$/) do
  sleep 2
  # expect(@MultiPatientView_Screen.condensedMonitorView_button.find_element(:xpath, '..').attribute('className')).to include 'active'
  #expect(@MultiPatientView_Screen.condensedMonitorView_button.text).to eq 'multi'

  #expect(@MultiPatientView_Screen.dualMonitorView_button.find_element(:xpath, '..').attribute('className')).to_not include 'active'
  expect(@MultiPatientView_Screen.side_nav_button(2).text).to eq "2"
  expect(@MultiPatientView_Screen.side_nav_button(4).text).to eq "4"
  expect(@MultiPatientView_Screen.side_nav_button(6).text).to eq "6"
  #expect(@MultiPatientView_Screen.side_nav_button(9).text).to eq "9"


  #expect(@MultiPatientView_Screen.quadMonitorView_button.find_element(:xpath, '..').attribute('className')).to_not include 'active'
  #expect(@MultiPatientView_Screen.sixMonitorView_button.find_element(:xpath, '..').attribute('className')).to_not include 'active'
  #puts "found the six"
  #expect(@MultiPatientView_Screen.nineMonitorView_button.find_element(:xpath, '..').attribute('className')).to_not include 'active'
  #puts "found the nine"

  #expect(@MultiPatientView_Screen.twelveMonitorView_button.find_element(:xpath, '..').attribute('className')).to_not include 'active'
  #expect(@MultiPatientView_Screen.sixteenMonitorView_button.find_element(:xpath, '..').attribute('className')).to_not include 'active'
end

Then(/^I should see dual monitor control button in header$/) do
  expect(@MultiPatientView_Screen.side_nav_button(2)).to be_truthy
end

Then(/^I should see quad monitor control button in header$/) do
  expect(@MultiPatientView_Screen.side_nav_button(4)).to be_truthy
end

When(/^I click the dual monitor control button in the header$/) do
  sleep 4
  @MultiPatientView_Screen.side_nav_button(2).click
  sleep 2
end

Then(/^I should see (\d+) view monitor control button in header$/) do |int|
  case int.to_i
  when 6
    expect(@MultiPatientView_Screen.side_nav_button(6)).to be_truthy
  when 9
    expect(@MultiPatientView_Screen.side_nav_button(9)).to be_truthy
  when 12
    expect(@MultiPatientView_Screen.side_nav_button(12)).to be_truthy
  when 16
    expect(@MultiPatientView_Screen.side_nav_button(16)).to be_truthy
  end
end

Then(/^I should not see (\d+) view monitor control button in header$/) do |int|
  case int.to_i
  when 6
    expect(@MultiPatientView_Screen.side_nav_button(6)).to be_falsey
  when 9
    expect(@MultiPatientView_Screen.side_nav_button(9)).to be_falsey
  when 12
    expect(@MultiPatientView_Screen.side_nav_button(12)).to be_falsey
  when 16
    expect(@MultiPatientView_Screen.side_nav_button(16)).to be_falsey
  end
end

When(/^I click the Patient List button on the vertical toolbar$/) do
  @MultiPatientView_Screen.side_nav_button('patient-list').click
end

Then(/^I should see the Patient List slide out open$/) do
  expect(@MultiPatientView_Screen.mpv_patient_list_slideout_component.displayed? === true)
end

Then(/^I should see the Multi-Patient View census reordered$/) do
  steps %(
    When I get multi patient view patient order
  )
  expect(@mpv_name_array.should_not == @filtered_mpv_name_array)
  expect(@slideout_name_array.should == @mpv_name_array)
end

When(/^I get the slide out patient list order$/) do
  @wait.until { @MultiPatientView_Screen.mpv_patient_list_slideout_component.displayed? == true }
  @slideout_array = []
  @slideout_name_array = []

  # counter starts at patient #0
  (0..@MultiPatientView_Screen.dragable_patients_array.count-1).each do |i|
    @slideout_array.push(@MultiPatientView_Screen.dragable_patients_array[i]['location'].text)
    @slideout_name_array.push(@MultiPatientView_Screen.dragable_patients_array[i]['name'])
  end
end

Then(/^I should see the slide out patient list in the same order as the Multi-Patient View screen$/) do
  steps %(
    When I get the slide out patient list order
  )
  expect(@slideout_array.should == @filtered_mpv_array)
  expect(@slideout_name_array.should == @filtered_mpv_name_array)
end

When(/^I get multi patient view patient order$/) do
  @wait.until { @MultiPatientView_Screen.multi_patient_window.displayed? == true }

  @mpv_array = []
  @mpv_name_array = []

  (0..@MultiPatientView_Screen.multipatients_array.count-1).each do |i|
    @mpv_array.push(@MultiPatientView_Screen.multipatients_array[i]['location'].text)
    @mpv_name_array.push(@MultiPatientView_Screen.multipatients_array[i]['name'])
  end
end

When(/^I click the (\d+) view monitor control button in the header$/) do |int|
  button_number = int.to_i
  @MultiPatientView_Screen.side_nav_button(button_number).click
  sleep(1)
end

When(/^I should see (\d+) view monitor control button is enabled in the header$/) do |int|
  button_number = int.to_i
  button = @MultiPatientView_Screen.side_nav_button(button_number)
  class_value = button.attribute("class").strip
  expect(button.text).to eq button_number.to_s
  expect(class_value).to eq "selected"
end

When(/^I should see dual monitor control button is enabled in the header$/) do
  sub_nav_buttons = @MultiPatientView_Screen.sub_nav_buttons

  expect(sub_nav_buttons['patient_list'].attribute('className')).to_not include 'selected'
  expect(sub_nav_buttons['single_lead'].attribute('className')).to_not include 'selected'
  expect(sub_nav_buttons['dual_lead'].attribute('className')).to include 'selected'
  expect(sub_nav_buttons['quad_lead'].attribute('className')).to_not include 'selected'
  expect(sub_nav_buttons['six_lead'].attribute('className')).to_not include 'selected'
  # expect(sub_nav_buttons['nine_lead'].attribute('className')).to_not include 'selected'
end

Then(/^I should see (\d+) full monitors on the screen of the first (\d+) patients in previous screen$/) do |total_monitors, _int|
  @wait.until { @MultiPatientView_Screen.dualMonitorView_button.displayed? == true }

  sleep 5

  if @expected_mpv_monitors.to_i < total_monitors.to_i
    expect(@MultiPatientView_Screen.fullPatientMonitors.count).to eql @expected_mpv_monitors.to_i
  else
    expect(@MultiPatientView_Screen.fullPatientMonitors.count).to eql total_monitors.to_i
  end
end

When(/^I click the quad monitor control button in the header$/) do
  @MultiPatientView_Screen.quadMonitorView_button.click
end

When(/^I should see quad monitor control button is enabled in the header$/) do
  expect(@MultiPatientView_Screen.condensedMonitorView_button.find_element(:xpath,
                                                                           '..').attribute('className')).to_not include 'active'
  expect(@MultiPatientView_Screen.dualMonitorView_button.find_element(:xpath,
                                                                      '..').attribute('className')).to_not include 'active'
  expect(@MultiPatientView_Screen.quadMonitorView_button.attribute('className')).to include 'selected'
end

Then(/^I should see Group By Sort By, Filter Units links enabled$/) do
  expect(@PatientList_Screen.group_sort_link['disabled']).to be_falsey
  expect(@PatientList_Screen.filter_units_link['disabled']).to be_falsey
end

Then(/^I should see the (\d+) full monitors should split the screen half vertical half horizontal$/) do |_int|
  expect(@MultiPatientView_Screen.fullPatientMonitors.count).to be > 2
  expect(@MultiPatientView_Screen.fullPatientMonitors.count).to be <= 4
end

Then(/^I should see the (\d+) full monitors should split the screen in half$/) do |_int|
  expect(@MultiPatientView_Screen.fullPatientMonitors.count).to eql 2
end

Then(/^I should see Patient Name Last, First, Age Gender, Unit, Bed on first row for each monitor$/) do
  monitors = @MultiPatientView_Screen.fullPatientMonitors.count
  # patientInfo = @selenium.find_elements(:class, 'patient-info')
  patientInfo = @selenium.find_elements(:css, 'div.patient-list-item:not(.outside)')
  (0..patientInfo.count - 1).each do |x|
    puts patientInfo[x].text if INFO == true
  end

  expect(patientInfo.count).to eql monitors
end

Then(/^I should see Navigation bar with Select Time and Live for each monitor for "(.*?)" patients$/) do | patient_count |
  objs = @MultiPatientView_Screen.time_live_button_object(patient_count.to_i)
  puts objs[0][0].text
  puts objs[0][1].text
  puts objs[1][0].text
  puts objs[1][1].text
  puts objs[2][0].text
  puts objs[2][1].text
  puts objs[3][0].text
  puts objs[3][1].text
end

Then(/^I should not see the Select Time and Live buttons on the Navigation bar on any patients monitor$/) do
  expect(@MultiPatientView_Screen.found_time_live_button_object).to eql false
end

Then(/^I should see Navigation bar with Select Time and Live for each monitor$/) do
  sleep 2
  monitors = @selenium.find_elements(:css, 'div.monitor.widget')

  (0..monitors.count - 1).each do |x|
    spans = monitors[x].find_element(:class, 'sub-nav').find_elements(:css, 'span')
    links = spans[1].find_elements(:css, 'a')
    expect(links[0].text).to eql 'Select Time'
    expect(links[1].text).to eql 'Live'
  end
end

Then(/^I should "(.*?)" patient "(.*?)" condensed monitor in Multi Patient View$/) do |visibility, patient|
  active_list = @MultiPatientView.condensedMonitorView_button
  expect(active_list.attribute('className')).to include 'selected'
  patient = process_param(patient)
  name_array = []
  @MultiPatientView.condensedPatientMonitors.each do |monitor|
    name = monitor.find_element(:class, 'name')
    name_array.push(name.text)
  end
  if visibility == "see"
    expect(name_array.to_s).to include patient
  elsif visibility == "not see"
    expect(name_array.to_s).not_to include (patient)
  end
end

When(/^I click on patient "(.*?)" condensed monitor close button$/) do |patient|
  condensed_monitor = @MultiPatientView.condensedMonitorView_button
  expect(condensed_monitor.attribute('className')).to include 'selected'
  patient = process_param(patient)
  monitor = @MultiPatientView.condensedPatientMonitors.find{|x| x.text.include?(patient)}
  if monitor.nil?
    puts "this isn't the user you want"
  else
    monitor.find_element(:class, 'icon-x').click
  end
end

When(/^I click the condensed monitor control button in the header$/) do
  @MultiPatientView_Screen.condensedMonitorView_button.click
end

Then(/^I should not ST discrete blocks display on condensed monitors$/) do
  # monitors = @MultiPatientView_Screen.fullPatientMonitors.count
  discretes = @selenium.find_elements(:class, 'discretes')
  (0..discretes.count - 1).each do |x|
    # log discretes[x].text
    expect(discretes[x].text).to_not include 'ST mm'
  end
end

Then(/^I should see the (\d+) full monitors should split into (\d+) rows and (\d+) monitors on each row$/) do |int, _int2, _int3|
  case int.to_i
  when 6
    expect(@selenium.find_elements(:class, 'split-6')).to be_truthy
  when 8
    expect(@selenium.find_elements(:class, 'split-8')).to be_truthy
  when 12
    expect(@selenium.find_elements(:class, 'split-12')).to be_truthy
  when 16
    expect(@selenium.find_elements(:class, 'split-16')).to be_truthy
  end
end

Then(/^I should see the Hide PHI button in header$/) do
  expect(@MultiPatientView_Screen.hidePHI_button).to be_truthy
end

When(/^I click to "(.*?)" the Hide PHI button$/) do |status|
  if (status == 'disable') && @MultiPatientView_Screen.hidePHI_button.attribute('className').include?('active')
    @MultiPatientView_Screen.hidePHI_button.click
  elsif (status == 'enable') && @MultiPatientView_Screen.hidePHI_button.attribute('className').include?('active')
    # do nothing
  else
    @MultiPatientView_Screen.hidePHI_button.click
  end
end

Then(/^I should see the Hide PHI button highlighted$/) do
  expect(@MultiPatientView_Screen.hidePHI_button.attribute('className')).to include 'active'
end

Then(/^I should see the Hide PHI button not highlighted$/) do
  expect(@MultiPatientView_Screen.hidePHI_button.attribute('className')).to_not include 'active'
end

Then(/^I should see the all patients name switch to displaying only the first three letters of the patient first and last name$/) do
  names = @selenium.find_elements(:class, 'name-age')
  (0..names.count - 1).each do |x|
    next if names[x].text.empty?

    if INFO == true
      puts names[x].text
      puts names[x].text.length
    end
    expect(names[x].text.length).to be <= 11
  end
end

Then(/^I should see the full patient names in the displaying on screen$/) do
  names = @selenium.find_elements(:class, 'name-age')
  (0..names.count - 1).each do |x|
    next if names[x].text.empty?

    if INFO == true
      puts names[x].text
      puts names[x].text.length
    end
    expect(names[x].text.length).to be > 11
  end
end

When(/^I move the zoom control to (\d+) percent zoom$/) do |zoom|
  @originalMonitorSize = @MultiPatientView_Screen.condensedPatientMonitors[0].rect
  min = @MultiPatientView_Screen.zoomControl_slider.attribute('min')
  max = @MultiPatientView_Screen.zoomControl_slider.attribute('max')
  zoomPercentage = zoom.to_f / 100

  case zoom
  when 100
    @MultiPatientView_Screen.zoomControl_slider.send_keys(:left) while @MultiPatientView_Screen.zoomControl_slider.attribute('value').to_f != max.to_f
  when 0
    @MultiPatientView_Screen.zoomControl_slider.send_keys(:right) while @MultiPatientView_Screen.zoomControl_slider.attribute('value').to_f != min.to_f
  else
    range = max.to_f - min.to_f
    newZoomValue = (range.to_f * zoomPercentage.to_f) + min.to_f
    if INFO == true
      puts zoomPercentage.to_f
      puts range
      puts newZoomValue
    end

    if newZoomValue > @MultiPatientView_Screen.zoomControl_slider.attribute('value').to_f
      @MultiPatientView_Screen.zoomControl_slider.send_keys(:right) while @MultiPatientView_Screen.zoomControl_slider.attribute('value').to_f != newZoomValue
    elsif newZoomValue < @MultiPatientView_Screen.zoomControl_slider.attribute('value').to_f
      @MultiPatientView_Screen.zoomControl_slider.send_keys(:left) while @MultiPatientView_Screen.zoomControl_slider.attribute('value').to_f != newZoomValue
    end
  end
end

When(/^I should see the zoom control at (\d+) percent zoom$/) do |zoom|
  min = @MultiPatientView_Screen.zoomControl_slider.attribute('min')
  max = @MultiPatientView_Screen.zoomControl_slider.attribute('max')
  zoomPercentage = zoom.to_f / 100
  range = max.to_f - min.to_f
  newZoomValue = (range.to_f * zoomPercentage.to_f) + min.to_f
  expect(@MultiPatientView_Screen.zoomControl_slider.attribute('value').to_f).to eq newZoomValue.to_f
end

Then(/^I should see the Multi Patient View screen with condensed monitors "(.*?)" in size$/) do |size|
  @newMonitorSize = @MultiPatientView_Screen.condensedPatientMonitors[0]
  if INFO == true
    puts @originalMonitorSize
    puts @newMonitorSize
  end
  case size
  when 'increase'
    expect(@newMonitorSize[:width]).to be > @originalMonitorSize[:width]
    expect(@newMonitorSize[:height]).to be > @originalMonitorSize[:height]
  when 'decrease'
    expect(@newMonitorSize[:width]).to be < @originalMonitorSize[:width]
    expect(@newMonitorSize[:height]).to be < @originalMonitorSize[:height]
  end
  raise StandardError, "Implement proper mechanism for zoom verification"
end

  Then(/^I should see the same amount of patients in Multi Patient View as I do in Patient List View$/) do
    LPV_count = $patient_count
    MPV_count = @MultiPatientView_Screen.bodySensorObservationsList_count

    puts "The patient list count is #{LPV_count}"
    puts "The multi patient list count is #{MPV_count}"

    expect(LPV_count).to == MPV_count
  end

  Then(/^I should "([^"]*)" Multi-Patient View button in main navigation$/) do |visibility|
    mpv_button = @PatientList_Screen.multiPatientView_link['link_obj']
    puts mpv_button.text
    case visibility
    when "see"
      puts "expected to be true"
      @wait.until { mpv_button.displayed? == true }
      expect(mpv_button.displayed? === true)
    when "not see"
      sleep 2
      begin
        puts "expected to be false"
        puts "found mpv #{mpv_button.displayed?}"
      rescue
        puts "group sort does not exist"
        expect(mpv_button).to be_falsey
      end

    end
  end


Then(/^I should see Condensed View screen for the Main Census$/) do
  @wait.until { @MultiPatientView_Screen.multi_patient_window.displayed? == true }
  expect(@MultiPatientView_Screen.condensedMonitorView_button).to be_truthy
end

When(/^I click on the "(.*?)" button$/) do |button|
  @MultiPatientView_Screen.side_nav_button(button).click
end

When(/^I should see the Dual View screen$/) do
  expect(@MultiPatientView_Screen.fullPatientMonitors.count).to eql 2
end

When(/^I should see the six view screen$/) do
  expect(@MultiPatientView_Screen.fullPatientMonitors.count).to eql 6
end

When(/^I should see the quad view screen$/) do
  expect(@MultiPatientView_Screen.fullPatientMonitors.count).to eql 4
end

When(/^I should see the nine view screen$/) do
  expect(@MultiPatientView_Screen.fullPatientMonitors.count).to eql 9
end

When(/^I click the "(.*?)" button in the main header$/) do |button|
  link = @Header_bar.as_one_site_name.text
  @Header_bar.as_one_site_name.click if link.include?(process_param(button))
end

Then(/^I should see "(.*?)" condensed monitors on c3po MPV screen$/) do |monitorCount|
  @wait.until { @MultiPatientView_Screen.multi_patient_window.displayed? == true }
  @selenium.manage.timeouts.implicit_wait = DEFAULT_EXPLICIT_WAIT
  monitorsCount = @MultiPatientView_Screen.condensedPatientMonitors.count
  puts "No of monitors on screen: #{monitorsCount}"
  expect(@MultiPatientView_Screen.condensedPatientMonitors.count).to eql monitorCount.to_i
end

Then(/^I should see each condensed monitor contains patients demographics, location, alarms, and 1 waveform$/) do
  @wait.until { @MultiPatientView_Screen.multi_patient_window.displayed? == true }
  @MultiPatientView_Screen.eachC3poCondensedMonitorDetailsIsDisplayed
end

When(/^I click side navigation menu "(.*?)" in MPV screen$/) do |sideMenuOption|
  case sideMenuOption.downcase
  when "patient list"
    @MultiPatientView_Screen.sub_nav_buttons['patient_list'].click
  when "multi"
    @MultiPatientView_Screen.sub_nav_buttons['multi'].click
  when "2"
    @MultiPatientView_Screen.sub_nav_buttons['dual_lead'].click
  when "4"
    @MultiPatientView_Screen.sub_nav_buttons['quad_lead'].click
  when "6"
    @MultiPatientView_Screen.sub_nav_buttons['six_lead'].click
  when "9"
    @MultiPatientView_Screen.sub_nav_buttons['nine_lead'].click
  when "12"
    @MultiPatientView_Screen.sub_nav_buttons['twelve_lead'].click
  when "16"
    @MultiPatientView_Screen.sub_nav_buttons['sixteen_lead'].click
  end
end


When(/^I click "(.*?)" on patient list tab in MPV screen$/) do |tabName|
  @wait.until { @MultiPatientView_Screen.multi_patient_window.displayed? == true }
  #TODO: get rid of hard-coded sleep
  sleep(2)
  @MultiPatientView_Screen.mpv_patientListTabs(tabName)
end

Then(/^I should see that the order of the monitors reflect the order in the "(.*?)" slide out list$/) do |patientList|
  @mpv_list_collection = @MultiPatientView_Screen.multipatients_array
  @mpv_names = @mpv_list_collection.map { |y| y["name"] }
  @mpv_names_split = @mpv_list_collection.map { |x| x["name"].split(" ") }
  @census_list_collection = @MultiPatientView_Screen.census_patient_list
  @census_names = @census_list_collection.map { |y| y["name"] }
  @census_names_split = @census_list_collection.map { |x| x["name"].split(" ") }

  expect(@census_names[0..@mpv_list_collection.length-1].to_s).to eql @mpv_names.to_s
end

Then(/^I should see patient names, zoom control, demographics, location, alarms, and 1 waveform if monitor screen displayed$/) do
  @wait.until { @MultiPatientView_Screen.multi_patient_window.displayed? == true }
  zoom = 50
  window = true
  window = @selenium.find_element(:css, '.surveil-patient') rescue  false
  if window == false
    puts "Monitors are not Present"
  else
    puts "Verifying monitors"
    @MultiPatientView_Screen.eachC3poCondensedMonitorDetailsIsDisplayed
    @MultiPatientView_Screen.verifyPatientName
    min = @MultiPatientView_Screen.zoomControl_slider.attribute('min')
    max = @MultiPatientView_Screen.zoomControl_slider.attribute('max')
    zoomPercentage = zoom.to_f / 100
    range = max.to_f - min.to_f
    newZoomValue = (range.to_f * zoomPercentage.to_f) + min.to_f
    expect(@MultiPatientView_Screen.zoomControl_slider.attribute('value').to_f).to eq newZoomValue.to_f
  end
end
