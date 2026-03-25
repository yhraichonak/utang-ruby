# frozen_string_literal: true

Before do
  @Summary_Screen = Summary_Screen.new @selenium
  @PM_Navigation_Menu = PM_Navigation_Menu.new @selenium
end

Then(/^I should see the patient summary screen$/) do
  @wait.until { @Summary_Screen.general_info_tile.displayed? == true }
  expect(@Summary_Screen.main_nav).to be_truthy unless MAIN_NAV_HIDDEN

  if @CARDIO_PL == true
    steps %(
        And I should see the cardio patient info in the header
  )
  else # using PM patient list
    steps %(
        And I should see the pm patient info in the header
  )
  end

  begin
    @selenium.manage.timeouts.implicit_wait = 0.5
    @sum_doc_tile_count = @Summary_Screen.documents_tile['total_doc_count'].text
  rescue Selenium::WebDriver::Error::NoSuchElementError
    # patients with no documents, tile will not be displayed
  end

  begin
    @sum_tile_ecg_count = @Summary_Screen.ecg_count['count_tile'].to_i if @sum_tile_ecg_count.nil?
  rescue Selenium::WebDriver::Error::NoSuchElementError
    # skip patient has no ecgs
  end
  @selenium.manage.timeouts.implicit_wait = DEFAULT_IMPLICIT_WAIT

  expect(@Summary_Screen.general_info_tile.displayed?).to be_truthy
end

Then(/^I should see the ECGs tile$/) do
  @wait.until { @Summary_Screen.ecg_tile }
  expect(@Summary_Screen.ecg_tile.text).to include "ECGs"
end

Then(/^I should see the ECG 12 lead screen$/) do
  @wait.until { @Summary_Screen.ecg_tile }
  expect(@Summary_Screen.ecg_tile.text).to include "ECGs"
end

When(/^I click on the ECG tile$/) do
  @wait.until { @Summary_Screen.ecg_tile }
  @Summary_Screen.ecg_tile.click
end

Then(/^I should see the same ECG count from patient list on ECG tile$/) do
  expect(@Summary_Screen.ecg_count['count_header'].to_i).to eq @sum_tile_ecg_count
  expect(@Summary_Screen.ecg_count['count_tile'].to_i).to eq @sum_tile_ecg_count
end

When(/^I click on the Monitor tile$/) do
  @wait.until { @Summary_Screen.monitor_tile.displayed? == true }
  @Summary_Screen.monitor_tile.click
end

When(/^I click on the Events tile$/) do
  @wait.until { @Summary_Screen.events_tile.displayed? == true }
  @Summary_Screen.events_tile.click
end

When(/^I click back navigation arrow on patient summary screen$/) do
  @PM_Navigation_Menu.back_button.click
end

Then(/^I should see General Info tile$/) do
  expect(@Summary_Screen.general_info_tile.displayed?).to be_truthy
end

When(/^I click General Info tile$/) do
  @wait.until { @Summary_Screen.general_info_tile.displayed? == true }
  @Summary_Screen.general_info_tile.click
end

Then(/^I should see patient General Information$/) do
  sleep 5
  expect(@Summary_Screen.general_info_window['window_obj'].displayed?).to be_truthy
  expect(@Summary_Screen.general_info_window['patient_name'].text.gsub(/\s+/,
                                                                       '')).to include @patient_header_name.gsub(
                                                                         /\s+/, ''
                                                                       )
  expect(@patient_header_mrn).to include @Summary_Screen.general_info_window['mrn'].text
  expect(@patient_header_age_sex).to include @Summary_Screen.general_info_window['age'].text
  expect(@Summary_Screen.general_info_window['gender'].text).to include @patient_header_gender unless @patient_header_gender == 'U'

  if defined?(@Summary_Screen.general_info_window['race']).nil?
    expect(@patient_header_age_sex).to include @Summary_Screen.general_info_window['race'].text
  end

  expect(@patient_header_age).to include @Summary_Screen.general_info_window['age'].text unless @patient_header_age.nil?
end

Then(/^I should see the following patient General Information in simulator$/) do |table|
  patients = table.hashes
  patients.each do |patient|
    expect(@Summary_Screen.general_info_window_simulator['weight'].text).to include patient[:weight]
    expect(@Summary_Screen.general_info_window_simulator['admit_date'].text).to include patient[:admit_date]
    expect(@Summary_Screen.general_info_window_simulator['code_status'].text).to include patient[:code_status]
    expect(@Summary_Screen.general_info_window_simulator['location'].text).to include patient[:location]
    expect(@Summary_Screen.general_info_window_simulator['isolation_status'].text).to include patient[:isolation_status]
    expect(@Summary_Screen.general_info_window_simulator['fin'].text).to include patient[:fin]
    expect(@Summary_Screen.general_info_window_simulator['dob'].text).to include patient[:dob]
    expect(@Summary_Screen.general_info_window_simulator['religion'].text).to include patient[:religion]
    expect(@Summary_Screen.general_info_window_simulator['language'].text).to include patient[:language]
    expect(@Summary_Screen.general_info_window_simulator['primary_contact'].text).to include patient[:primary_contact]

    expect('Ronald Blair 1234567890 (HOME)').to include patient[:secondary_contact]
    expect('67').to include patient[:age]
    expect('Skinner, James').to include patient[:primary_md]
  end
end

When(/^I click Ok in General Info window$/) do
  @Summary_Screen.ok_tile_window_button.click
  sleep 5
end

Then(/^I should see the Monitor Tile as "(.*?)" with No Events$/) do |status|
  puts "+++++++++++++"
  puts @Summary_Screen.monitor_tile_info['status'].text
  puts @Summary_Screen.monitor_tile_info['title'].text
  puts @Summary_Screen.monitor_tile_info['results'].text

  puts "+++++++++++++"
  expect(@Summary_Screen.monitor_tile_info['status'].text).to eq status
  expect(@Summary_Screen.monitor_tile_info['title'].text).to include('1d').or include('3d')
  expect(@Summary_Screen.monitor_tile_info['results'].text).to eq 'No Events'
end

Then(/^I should see the Monitor Tile as "(.*?)" with Events$/) do |status|
  expect(@Summary_Screen.monitor_tile_info_with_events['status'].text).to eq status
  expect(@Summary_Screen.monitor_tile_info_with_events['title'].text).to include('1d').or include('3d')
  expect(@Summary_Screen.monitor_tile_info_with_events['results'].count).to be > 0
end

Then(/^I should see the Ecg Tile with No ECGs$/) do
  expect(@Summary_Screen.ecg_tile_no_results['results'].text).to eq 'No ECGs'
end

Then(/^I should see Ventilator tile$/) do
  expect(@Summary_Screen.ventilator_tile.displayed?).to be_truthy
end

When(/^I click on the Ventilator tile$/) do
  @Summary_Screen.ventilator_tile.click
end

Then(/^I should see the following info in Ventilator tile$/) do |table|
  patients = table.hashes
  patients.each do |patient|
    expect(@Summary_Screen.ventilator_tile_simulator['rr'].text).to include patient[:RR]
    expect(@Summary_Screen.ventilator_tile_simulator['ex_vt'].text).to include patient[:Ex_Vt]
    expect(@Summary_Screen.ventilator_tile_simulator['ex_ve'].text).to include patient[:Ex_Ve]
    expect(@Summary_Screen.ventilator_tile_simulator['pip'].text).to include patient[:PIP]
    expect(@Summary_Screen.ventilator_tile_simulator['peep'].text).to include patient[:Peep]
    expect(@Summary_Screen.ventilator_tile_simulator['peep_total'].text).to include patient[:Peep_Total]
  end
end

Then(/^I should see the patient document tile$/) do
  expect(@Summary_Screen.documents_tile['window_obj'].displayed?).to be_truthy
end

When(/^I click on the document tile$/) do
  @wait.until { @Summary_Screen.documents_tile['window_obj'] }
  @Summary_Screen.documents_tile['window_obj'].click
end

Then(/^I should see patient snippet descriptions and date of snippet created$/) do
  @summary_doc_count = @Summary_Screen.documents_tile['doc_count']
  @sum_tile_doc_desc = @Summary_Screen.documents_tile['doc_description']
  @sum_tile_doc_date = @Summary_Screen.documents_tile['doc_date']
  @sum_doc_tile_count = @Summary_Screen.documents_tile['total_doc_count'].text

  x = 0
  while x < @summary_doc_count
    puts "#{@sum_tile_doc_desc[x]} #{@sum_tile_doc_date[x]}" if INFO == true

    expect(@sum_tile_doc_desc[x]).to be_truthy
    expect(@sum_tile_doc_date[x]).to be_truthy
    x += 1
  end
end

Then(/^I should see the document tile with a count of documents$/) do
  @sum_doc_tile_count = @Summary_Screen.documents_tile['total_doc_count'].text
  puts @sum_doc_tile_count if INFO == true
  expect(@sum_doc_tile_count).to be_truthy
end
