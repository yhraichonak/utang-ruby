# frozen_string_literal: true

Before do
  @ECG_Screen = ECG_Screen.new @selenium
  @EditConfirm_window = EditConfirm_window.new @selenium
end

Then(/^I should see the ecg list on ECG screen$/) do
  @wait.until { @ECG_Screen.ecg_list_drawer.displayed? == true }
  @wait.until { @ECG_Screen.ecg_list_object }
  expect(@ECG_Screen.ecg_list_drawer).to be_truthy

  ecg_list_object = @ECG_Screen.ecg_list_object
  count = ecg_list_object['ecg_count']

  @ecg_list_details_date = ecg_list_object['ecg_date']
  @ecg_list_details_time = ecg_list_object['ecg_time']
  @ecg_list_details_diag = ecg_list_object['ecg_diagnosis']
  @ecg_list_details_analysis = ecg_list_object['ecg_analysis']

  if INFO == true
    puts @sum_tile_ecg_count
    puts count
    puts @ecg_list_details_diag[0]
    puts @ecg_list_details_date[0]
    puts @ecg_list_details_time[0]
  end

  if (!@sum_tile_ecg_count.nil?) && @sum_tile_ecg_count.to_i.positive?
    (0..count - 1).each do |_i|
      expect(@sum_tile_ecg_count).to eq count
      # expect($ECG_DIAGNOSIS[i]).to eq @ecg_list_details_diag[i]
      # expect($ECG_DATE[i]).to eq "#{Date.strptime(@ecg_list_details_date[i], '%m/%d/%y').strftime("%-m/%d/%Y")} #{@ecg_list_details_time[i]}"
    end
  end
end

Then(/^I should see the ecg list close automatically$/) do
  @wait.until { !@ECG_Screen.ecg_list_drawer.attribute('className').include? 'open' }
end

Then(/^I should see the patient ECG screen$/) do
  # adding catch for alert window when Undo Edits from E/C
  begin
    retries ||= 0
    expect(@ECG_Screen.ecg_toolbar).to be_truthy
    ecg_header_info = @ECG_Screen.ecg_header_info
  rescue Selenium::WebDriver::Error::UnexpectedAlertOpenError
    @selenium.action.send_keys(:return).perform
    retry if (retries += 1) < 3
  end

  if INFO == true
    puts ecg_header_info['date']
    puts @ecg_list_details_date
    puts @ecg_list_details_time
  end
  expect(ecg_header_info['date']).to include @ecg_list_details_date
  expect(ecg_header_info['date']).to include @ecg_list_details_time
  expect(ecg_header_info['diagnosis']).to include @ecg_list_details_diag
end

When(/^I click on row "(.*?)" on ecg list$/) do |row|
  # @ecg_list_first_row = row

  ecg_list_details = @ECG_Screen.ecg_list_details(row.to_i)
  @ecg_list_details_date = ecg_list_details['date']
  @ecg_list_details_time = ecg_list_details['time']
  @ecg_list_details_diag = ecg_list_details['diagnosis']
  @ecg_list_details_analysis = ecg_list_details['analysis']

  puts @ecg_list_details_diag if INFO == true

  begin
    @ECG_Screen.ecg_list(row).click
  rescue StandardError
    puts 'ecg drawer closed' if INFO == true
  end
end

When(/^I click on ecg containing "(.*?)" on ecg list$/) do |ecg_text|
  ecg_list = @ECG_Screen.ecg_list_all
  ecg_list_details = {}
  (0..ecg_list.count - 1).each do |i|
    if @ECG_Screen.ecg_list_details(i)['diagnosis'].include? ecg_text
      ecg_list_details = @ECG_Screen.ecg_list_details(i)

      @wait.until { (@ECG_Screen.list_option_toolbar.attribute('className').include? 'selected') == false }
      @ECG_Screen.list_option_toolbar.click
      @wait.until { @ECG_Screen.list_option_toolbar.attribute('className').include? 'selected'}
      @ECG_Screen.ecg_list(i).click
    end
  end
  @ecg_list_details_date = ecg_list_details['date']
  @ecg_list_details_time = ecg_list_details['time']
  @ecg_list_details_diag = ecg_list_details['diagnosis']
  @ecg_list_details_analysis = ecg_list_details['analysis']

  puts @ecg_list_details_diag if INFO == true
end

Then(/^I should see the ecg description containing "(.*?)"$/) do |ecg_text|
  expect(@ecg_list_details_diag).to include(ecg_text.to_str)
end

Then(/^I should see the 12 waveforms I II III aVR aVL aVF V1 V2 V3 V4 V5 V6 waveforms display$/) do
  @wait.until { @ECG_Screen.three_second_lead_element('I') }

  expect(@ECG_Screen.three_second_lead_element('I')['scale_key'].text).to eq '0.1mV/.04sec'
  expect(@ECG_Screen.three_second_lead_element('I')['title'].text).to eq 'I'
  expect(@ECG_Screen.three_second_lead_element('II')['title'].text).to eq 'II'
  expect(@ECG_Screen.three_second_lead_element('III')['title'].text).to eq 'III'
  expect(@ECG_Screen.three_second_lead_element('aVR')['title'].text).to eq 'aVR'
  expect(@ECG_Screen.three_second_lead_element('aVL')['title'].text).to eq 'aVL'
  expect(@ECG_Screen.three_second_lead_element('aVF')['title'].text).to eq 'aVF'
  expect(@ECG_Screen.three_second_lead_element('V1')['title'].text).to eq 'V1'
  expect(@ECG_Screen.three_second_lead_element('V2')['title'].text).to eq 'V2'
  expect(@ECG_Screen.three_second_lead_element('V3')['title'].text).to eq 'V3'
  expect(@ECG_Screen.three_second_lead_element('V4')['title'].text).to eq 'V4'
  expect(@ECG_Screen.three_second_lead_element('V5')['title'].text).to eq 'V5'
  expect(@ECG_Screen.three_second_lead_element('V6')['title'].text).to eq 'V6'

  expect(@ECG_Screen.ten_second_lead_element['count']).to be >= 12
  expect(@ECG_Screen.ten_second_lead_element('I')['scale_key'].text).to eq '0.1mV/.04sec'
  expect(@ECG_Screen.ten_second_lead_element('I')['title'].text).to eq 'I'
  expect(@ECG_Screen.ten_second_lead_element('II')['title'].text).to eq 'II'
  expect(@ECG_Screen.ten_second_lead_element('III')['title'].text).to eq 'III'
  expect(@ECG_Screen.ten_second_lead_element('aVR')['title'].text).to eq 'aVR'
  expect(@ECG_Screen.ten_second_lead_element('aVL')['title'].text).to eq 'aVL'
  expect(@ECG_Screen.ten_second_lead_element('aVF')['title'].text).to eq 'aVF'
  expect(@ECG_Screen.ten_second_lead_element('V1')['title'].text).to eq 'V1'
  expect(@ECG_Screen.ten_second_lead_element('V2')['title'].text).to eq 'V2'
  expect(@ECG_Screen.ten_second_lead_element('V3')['title'].text).to eq 'V3'
  expect(@ECG_Screen.ten_second_lead_element('V4')['title'].text).to eq 'V4'
  expect(@ECG_Screen.ten_second_lead_element('V5')['title'].text).to eq 'V5'
  expect(@ECG_Screen.ten_second_lead_element('V6')['title'].text).to eq 'V6'
end

Then(/^I should see the serial compare 12 waveforms I II III aVR aVL aVF V1 V2 V3 V4 V5 V6 waveforms display$/) do
  @wait.until { @ECG_Screen.sc_three_second_lead_element('I') }

  expect(@ECG_Screen.sc_three_second_lead_element('I')['scale_key'].text).to eq '0.1mV/.04sec'
  expect(@ECG_Screen.sc_three_second_lead_element('I')['title'].text).to eq 'I'
  expect(@ECG_Screen.sc_three_second_lead_element('II')['title'].text).to eq 'II'
  expect(@ECG_Screen.sc_three_second_lead_element('III')['title'].text).to eq 'III'
  expect(@ECG_Screen.sc_three_second_lead_element('aVR')['title'].text).to eq 'aVR'
  expect(@ECG_Screen.sc_three_second_lead_element('aVL')['title'].text).to eq 'aVL'
  expect(@ECG_Screen.sc_three_second_lead_element('aVF')['title'].text).to eq 'aVF'
  expect(@ECG_Screen.sc_three_second_lead_element('V1')['title'].text).to eq 'V1'
  expect(@ECG_Screen.sc_three_second_lead_element('V2')['title'].text).to eq 'V2'
  expect(@ECG_Screen.sc_three_second_lead_element('V3')['title'].text).to eq 'V3'
  expect(@ECG_Screen.sc_three_second_lead_element('V4')['title'].text).to eq 'V4'
  expect(@ECG_Screen.sc_three_second_lead_element('V5')['title'].text).to eq 'V5'
  expect(@ECG_Screen.sc_three_second_lead_element('V6')['title'].text).to eq 'V6'

  expect(@ECG_Screen.sc_ten_second_lead_element['count']).to be >= 12
  expect(@ECG_Screen.sc_ten_second_lead_element('I')['scale_key'].text).to eq '0.1mV/.04sec'
  expect(@ECG_Screen.sc_ten_second_lead_element('I')['title'].text).to eq 'I'
  expect(@ECG_Screen.sc_ten_second_lead_element('II')['title'].text).to eq 'II'
  expect(@ECG_Screen.sc_ten_second_lead_element('III')['title'].text).to eq 'III'
  expect(@ECG_Screen.sc_ten_second_lead_element('aVR')['title'].text).to eq 'aVR'
  expect(@ECG_Screen.sc_ten_second_lead_element('aVL')['title'].text).to eq 'aVL'
  expect(@ECG_Screen.sc_ten_second_lead_element('aVF')['title'].text).to eq 'aVF'
  expect(@ECG_Screen.sc_ten_second_lead_element('V1')['title'].text).to eq 'V1'
  expect(@ECG_Screen.sc_ten_second_lead_element('V2')['title'].text).to eq 'V2'
  expect(@ECG_Screen.sc_ten_second_lead_element('V3')['title'].text).to eq 'V3'
  expect(@ECG_Screen.sc_ten_second_lead_element('V4')['title'].text).to eq 'V4'
  expect(@ECG_Screen.sc_ten_second_lead_element('V5')['title'].text).to eq 'V5'
  expect(@ECG_Screen.sc_ten_second_lead_element('V6')['title'].text).to eq 'V6'
end

Then(/^I should see the 15 waveforms rhythm strips I II III aVR aVL aVF V1 V2 V3 V4 V5 V6 V3R V4R V7 waveforms display$/) do
  @wait.until { @ECG_Screen.ten_second_lead_element('I') }

  expect(@ECG_Screen.ten_second_lead_element['count']).to eq 15

  expect(@ECG_Screen.ten_second_lead_element('I')['title'].text).to eq 'I'
  expect(@ECG_Screen.ten_second_lead_element('II')['title'].text).to eq 'II'
  expect(@ECG_Screen.ten_second_lead_element('III')['title'].text).to eq 'III'
  expect(@ECG_Screen.ten_second_lead_element('aVR')['title'].text).to eq 'aVR'
  expect(@ECG_Screen.ten_second_lead_element('aVL')['title'].text).to eq 'aVL'
  expect(@ECG_Screen.ten_second_lead_element('aVF')['title'].text).to eq 'aVF'
  expect(@ECG_Screen.ten_second_lead_element('V1')['title'].text).to eq 'V1'
  expect(@ECG_Screen.ten_second_lead_element('V2')['title'].text).to eq 'V2'
  expect(@ECG_Screen.ten_second_lead_element('V3')['title'].text).to eq 'V3'
  expect(@ECG_Screen.ten_second_lead_element('V4')['title'].text).to eq 'V4'
  expect(@ECG_Screen.ten_second_lead_element('V5')['title'].text).to eq 'V5'
  expect(@ECG_Screen.ten_second_lead_element('V6')['title'].text).to eq 'V6'
  expect(@ECG_Screen.ten_second_lead_element('V3R')['title'].text).to eq 'V3R'
  expect(@ECG_Screen.ten_second_lead_element('V4R')['title'].text).to eq 'V4R'
  expect(@ECG_Screen.ten_second_lead_element('V7')['title'].text).to eq 'V7'
end

Then(/^I should see the 12 waveforms rhythm strips I II III aVR aVL aVF V1 V2 V3 V4 V5 V6 V3R V4R V7 waveforms display$/) do
  @wait.until { @ECG_Screen.ten_second_lead_element('I') }

  expect(@ECG_Screen.ten_second_lead_element['count']).to be > 12

  expect(@ECG_Screen.ten_second_lead_element('I')['title'].text).to eq 'I'
  expect(@ECG_Screen.ten_second_lead_element('II')['title'].text).to eq 'II'
  expect(@ECG_Screen.ten_second_lead_element('III')['title'].text).to eq 'III'
  expect(@ECG_Screen.ten_second_lead_element('aVR')['title'].text).to eq 'aVR'
  expect(@ECG_Screen.ten_second_lead_element('aVL')['title'].text).to eq 'aVL'
  expect(@ECG_Screen.ten_second_lead_element('aVF')['title'].text).to eq 'aVF'
  expect(@ECG_Screen.ten_second_lead_element('V1')['title'].text).to eq 'V1'
  expect(@ECG_Screen.ten_second_lead_element('V2')['title'].text).to eq 'V2'
  expect(@ECG_Screen.ten_second_lead_element('V3')['title'].text).to eq 'V3'
  expect(@ECG_Screen.ten_second_lead_element('V4')['title'].text).to eq 'V4'
  expect(@ECG_Screen.ten_second_lead_element('V5')['title'].text).to eq 'V5'
  expect(@ECG_Screen.ten_second_lead_element('V6')['title'].text).to eq 'V6'
  expect(@ECG_Screen.ten_second_lead_element('V3R')['title'].text).to eq 'V3R'
  expect(@ECG_Screen.ten_second_lead_element('V4R')['title'].text).to eq 'V4R'
  expect(@ECG_Screen.ten_second_lead_element('V7')['title'].text).to eq 'V7'
end

Then(/^I should see the 15 waveforms rhythm strips I II III aVR aVL aVF V1 V2 V3 V4 V5 V6 X Y Z waveforms display$/) do
  @wait.until { @ECG_Screen.ten_second_lead_element('I') }

  expect(@ECG_Screen.ten_second_lead_element['count']).to eq 15

  expect(@ECG_Screen.ten_second_lead_element('I')['title'].text).to eq 'I'
  expect(@ECG_Screen.ten_second_lead_element('II')['title'].text).to eq 'II'
  expect(@ECG_Screen.ten_second_lead_element('III')['title'].text).to eq 'III'
  expect(@ECG_Screen.ten_second_lead_element('aVR')['title'].text).to eq 'aVR'
  expect(@ECG_Screen.ten_second_lead_element('aVL')['title'].text).to eq 'aVL'
  expect(@ECG_Screen.ten_second_lead_element('aVF')['title'].text).to eq 'aVF'
  expect(@ECG_Screen.ten_second_lead_element('V1')['title'].text).to eq 'V1'
  expect(@ECG_Screen.ten_second_lead_element('V2')['title'].text).to eq 'V2'
  expect(@ECG_Screen.ten_second_lead_element('V3')['title'].text).to eq 'V3'
  expect(@ECG_Screen.ten_second_lead_element('V4')['title'].text).to eq 'V4'
  expect(@ECG_Screen.ten_second_lead_element('V5')['title'].text).to eq 'V5'
  expect(@ECG_Screen.ten_second_lead_element('V6')['title'].text).to eq 'V6'
  expect(@ECG_Screen.ten_second_lead_element('X')['title'].text).to eq 'X'
  expect(@ECG_Screen.ten_second_lead_element('Y')['title'].text).to eq 'Y'
  expect(@ECG_Screen.ten_second_lead_element('Z')['title'].text).to eq 'Z'
end

Then(/^I should see the lead legend displaying "(.*?)" on first ecg three sec lead$/) do |legend|
  expect(@ECG_Screen.three_second_lead_element('I')['scale_key'].text).to eq legend
end

Then(/^I should see the lead legend displaying "(.*?)" on first ecg rhythm strip lead$/) do |legend|
  expect(@ECG_Screen.ten_second_lead_element('I')['scale_key'].text).to eq legend
end

Then(/^I should see the lead legend displaying "(.*?)" on first ecg three sec lead in serial compare ecg$/) do |legend|
  expect(@ECG_Screen.sc_three_second_lead_element('I')['scale_key'].text).to eq legend
end

Then(/^I should see the lead legend displaying "(.*?)" on first ecg rhythm strip lead in serial compare ecg$/) do |legend|
  expect(@ECG_Screen.sc_ten_second_lead_element('I')['scale_key'].text).to eq legend
end

When(/^I click on the info icon on the ecg toolbar$/) do
  @wait.until { @ECG_Screen.info_toolbar.displayed? == true }
  sleep 2
  drawer_status = if @ECG_Screen.ecg_detail_info_drawer.attribute('className').include? 'open'
                    true
                  else
                    false
                  end

  @ECG_Screen.info_toolbar.click

  if drawer_status == true
    @wait.until { !@ECG_Screen.ecg_detail_info_drawer.attribute('className').include? 'open' }
  else
    @wait.until { @ECG_Screen.ecg_detail_info_drawer.attribute('className').include? 'open' }
  end
end

When(/^I click on the info icon on the ecg toolbar for serial compare ecg$/) do
  @ECG_Screen.second_info_toolbar.click
end

Then(/^the ecg detailed info drawer displays$/) do
  @wait = Selenium::WebDriver::Wait.new(timeout: 5)
  begin
    retries ||= 0
    @wait.until { @ECG_Screen.ecg_detail_info_drawer.attribute('className').include? 'open' }
    @wait.until { @ECG_Screen.ecg_detail_object['patient_info'].text != '' }
  rescue Selenium::WebDriver::Error::TimeoutError
    @ECG_Screen.info_toolbar.click
    retry if (retries += 1) < 3
  end

  @wait = Selenium::WebDriver::Wait.new(timeout: DEFAULT_EXPLICIT_WAIT)

  if INFO == true
    puts @ECG_Screen.ecg_detail_object['patient_info'].text
    puts @ECG_Screen.ecg_detail_object['stats'].text
  end

  @ecg_details_vhr = @ECG_Screen.ecg_detail_object['vhr'].text
  @ecg_details_pr = @ECG_Screen.ecg_detail_object['pr'].text
  @ecg_details_qrs = @ECG_Screen.ecg_detail_object['qrs'].text
  @ecg_details_prt = @ECG_Screen.ecg_detail_object['prt'].text

  @ecg_details_ahr = @ECG_Screen.ecg_detail_object['ahr'].text
  @ecg_details_qt = @ECG_Screen.ecg_detail_object['qt'].text
  @ecg_details_qtc = @ECG_Screen.ecg_detail_object['qtc'].text

  if INFO == true
    puts @ecg_details_vhr
    puts @ecg_details_ahr
  end
  expect(@ECG_Screen.ecg_detail_info_drawer).to be_truthy

  expect(@ECG_Screen.ecg_detail_object['patient_info'].text).to include 'Sex'
  expect(@ECG_Screen.ecg_detail_object['patient_info'].text).to include 'DOB'
  expect(@ECG_Screen.ecg_detail_object['patient_info'].text).to include 'Age'
  expect(@ECG_Screen.ecg_detail_object['patient_info'].text).to include 'Race'

  expect(@ECG_Screen.ecg_detail_object['stats'].text).to include 'V.HR'
  expect(@ECG_Screen.ecg_detail_object['stats'].text).to include 'PR'
  expect(@ECG_Screen.ecg_detail_object['stats'].text).to include 'QRS'
  expect(@ECG_Screen.ecg_detail_object['stats'].text).to include 'PRT'

  expect(@ECG_Screen.ecg_detail_object['stats'].text).to include 'A.HR'
  expect(@ECG_Screen.ecg_detail_object['stats'].text).to include 'QT'
  expect(@ECG_Screen.ecg_detail_object['stats'].text).to include 'QTc'
end

Then(/^the ecg detailed info drawer displays for serial compare ecg$/) do
  @wait.until { @ECG_Screen.second_ecg_detail_info_drawer.attribute('className').include? 'open' }
  @ECG_DETAILS_VHR_COMPARE = @ECG_Screen.compare_ecg_detail_object['vhr'].text
  @ECG_DETAILS_AHR_COMPARE = @ECG_Screen.compare_ecg_detail_object['ahr'].text

  if INFO == true
    puts @ECG_DETAILS_VHR_COMPARE
    puts @ECG_DETAILS_AHR_COMPARE
  end
  expect(@ECG_Screen.second_ecg_detail_info_drawer).to be_truthy
end

When(/^I click on 3 sec Lead "(.*?)"$/) do |ecg_name|
  @ECG_Screen.three_second_lead_element(ecg_name)['ecg_cell'].click
end

Then(/^I should see the Lead "(.*?)" zoom lead window$/) do |lead_text|
  ecg = @ECG_Screen.zoom_lead_text(lead_text)
  expect(ecg['title'].text).to eq lead_text
  expect(ecg['scale_key'].text).to eq '0.1mV/.04sec'
  expect(@ECG_Screen.ten_second_lead_element['count']).to eq 1

  expect(@ECG_Screen.ten_second_lead_element(lead_text)['title'].text).to eq lead_text
end

When(/^I click the 12 Lead link$/) do
  @ECG_Screen.twelve_lead_link.click
end

When(/^I click the Single Lead link$/) do
  @ECG_Screen.single_lead_link.click
end

When(/^I click the Compare link$/) do
  @ECG_Screen.compare_link.click
end

Then(/^I should see the second ecg list on the ECG screen$/) do
  expect(@ECG_Screen.second_ecg_toolbar).to be_truthy
end

When(/^I click on row "(.*?)" on the second ecg list$/) do |row|
  begin
    sleep 10 if @ECG_Screen.ecg_loader.displayed? == true
  rescue StandardError
    # do nothing, continue
  end

  # @second_ecg_row = row
  second_ecg_list_details = @ECG_Screen.second_ecg_list_details(row)
  @ecg2_list_details_date = second_ecg_list_details['date']
  @ecg2_list_details_time = second_ecg_list_details['time']
  @ecg2_list_details_diag = second_ecg_list_details['diagnosis']
  @ecg2_list_details_analysis = second_ecg_list_details['analysis']
  puts @ecg2_list_details_diag if INFO == true

  second_ecg_list = @ECG_Screen.second_ecg_list(row)
  @selenium.action.move_to(second_ecg_list).click.perform
end

Then(/^I should see the Serial Compare screen$/) do
  first_banner_details = @ECG_Screen.first_ecg_banner
  second_banner_details = @ECG_Screen.second_ecg_banner

  if INFO == true
    puts first_banner_details['date']
    puts first_banner_details['diagnosis']
    puts second_banner_details['date']
    puts second_banner_details['diagnosis']
  end

  expect(first_banner_details['date']).to include @ecg_list_details_date
  expect(first_banner_details['date']).to include @ecg_list_details_time
  expect(first_banner_details['diagnosis']).to include @ecg_list_details_diag

  expect(second_banner_details['date']).to include @ecg2_list_details_date
  expect(second_banner_details['date']).to include @ecg2_list_details_time
  expect(second_banner_details['diagnosis']).to include @ecg2_list_details_diag
end

When(/^I click the waveform toolbar$/) do
  @ECG_Screen.waveform_toolbar.click
end

When(/^I close the waveform toolbar$/) do
  @ECG_Screen.waveform_toolbar_close.click
end

When(/^I click the Lead "(.*?)" in waveform toolbar$/) do |lead|
  @wait.until { @ECG_Screen.waveform_list.attribute('className').include? 'open' }
  begin
    retries ||= 0
    @ECG_Screen.waveform_toolbar_lead(lead).click
  rescue StandardError
    retry if (retries += 1) < 3
  end
end

When(/^I click the waveform toolbar on second ecg$/) do
  @ECG_Screen.second_waveform_toolbar.click
end

When(/^I close the waveform toolbar on second ecg$/) do
  @ECG_Screen.second_waveform_toolbar_close.click
end

When(/^I click the Lead "(.*?)" in waveform toolbar on second ecg$/) do |lead|
  @wait.until { @ECG_Screen.second_waveform_list.attribute('className').include? 'open' }

  begin
    retries ||= 0
    @ECG_Screen.second_waveform_toolbar_lead(lead).click
  rescue StandardError
    retry if (retries += 1) < 3
  end
end

When(/^I click the next ecg button$/) do
  @ECG_Screen.ecgNext_button.click
end

When(/^I click the previous ecg button$/) do
  @ECG_Screen.ecgPrevious_button.click
end

When(/^I click the next ecg button on second ecg$/) do
  @ECG_Screen.sc_ecgNext_button.click
end

When(/^I click the previous ecg button on second ecg$/) do
  @ECG_Screen.sc_ecgPrevious_button.click
end

When(/^I click on the ecg list button on the ecg toolbar$/) do
  @ECG_Screen.list_option_toolbar.click
end

Then(/^the ecg option list displays$/) do
  expect(@ECG_Screen.ecg_list_drawer.displayed?).to be_truthy
end

When(/^I scroll the ecg scrubber to the "(.*?)"$/) do |direction|
  @selenium.action.move_to(@ECG_Screen.ecgScrubber_div).perform

  case direction
  when 'right'
    # @selenium.action.drag_and_drop_by(@ECG_Screen.ecgScrubber_div,300,0).perform
    @selenium.action.click_and_hold(@ECG_Screen.ecgScrubber_div).move_by(300, 0).release.perform
  when 'left'
    # @selenium.action.drag_and_drop_by(@ECG_Screen.ecgScrubber_div,-300,0).perform
    @selenium.action.click_and_hold(@ECG_Screen.ecgScrubber_div).move_by(-300, 0).release.perform
  end
  sleep(5)
end

When(/^I zoom the ecg zoom lead "(.*?)" by offset "(.*?)"$/) do |direction, offset|
  case direction
  when 'in'
    offset = offset.to_i * -1
    @selenium.action.drag_and_drop_by(@ECG_Screen.ecgScrubberHandleEnd_div, offset, 0).perform
  when 'out'
    @selenium.action.drag_and_drop_by(@ECG_Screen.ecgScrubberHandleEnd_div, offset, 0).perform
  end
  sleep(5)
end

When(/^I scroll the ecg zoom lead "(.*?)"$/) do |direction|
  case direction
  when 'right'
    @selenium.action.drag_and_drop_by(@ECG_Screen.zoom_lead, -300, 0).perform
  when 'left'
    @selenium.action.drag_and_drop_by(@ECG_Screen.zoom_lead, 300, 0).perform
  when 'up'
    @selenium.action.drag_and_drop_by(@ECG_Screen.zoom_lead, 0, 300).perform
  when 'down'
    @selenium.action.drag_and_drop_by(@ECG_Screen.zoom_lead, 0, -300).perform
  end
  sleep(5)
end

Then(/^I should see patient info in ecg screen header$/) do
  expect(@patient_info_p_list).to include @ECG_Screen.patientInfo_header['name']
  expect(@patient_info_mrn_location).to include @ECG_Screen.patientInfo_header['info']
end

When(/^I click on second ecg 3 sec Lead "(.*?)"$/) do |lead|
  @ECG_Screen.sc_three_second_lead_element(lead)['ecg_cell'].click
end

Then(/^I should see the serial compare Lead "(.*?)" zoom lead window$/) do |lead_text|
  ecg = @ECG_Screen.zoom_lead_text(lead_text)
  expect(ecg['title'].text).to eq lead_text
  expect(ecg['scale_key'].text).to eq '0.1mV/.04sec'
  expect(@ECG_Screen.ten_second_lead_element['count']).to eq 1

  expect(@ECG_Screen.ten_second_lead_element(lead_text)['title'].text).to eq lead_text

  second_ecg = @ECG_Screen.second_zoom_lead_text(lead_text)
  expect(second_ecg['title'].text).to eq lead_text
  expect(second_ecg['scale_key'].text).to eq '0.1mV/.04sec'
  expect(@ECG_Screen.sc_ten_second_lead_element['count']).to eq 1

  expect(@ECG_Screen.sc_ten_second_lead_element(lead_text)['title'].text).to eq lead_text
end

When(/^I click on the info icon on the ecg toolbar on second ecg$/) do
  @ECG_Screen.second_info_toolbar.click
end

Then(/^the ecg detailed info drawer displays on second ecg$/) do
  expect(@ECG_Screen.second_ecg_detail_info_drawer).to be_truthy
end

Then(/^I should see the compare link enabled$/) do
  expect(@ECG_Screen.compare_link.enabled?).to be_truthy
end

Then(/^I should see the compare link disabled$/) do
  expect(@ECG_Screen.compare_link.enabled?).to be_falsey
end

Then(/^I should see the following Comparison Statement "(.*?)"$/) do |message|
  expect(@ECG_Screen.serialComparsionStatement_div.text).to eq message
end

Then(/^I should see V.HR and A.HR labels in ECG Details Header are right aligned$/) do
  if INFO == true
    puts @ecg_details_vhr
    puts @ecg_details_ahr
    puts @ECG_Screen.header_stats(0).text
  end
  expect(@ECG_Screen.header_stats(0).text).to include "V.HR (bpm): #{@ecg_details_vhr}"
  expect(@ECG_Screen.header_stats(0).text).to include "A.HR (bpm): #{@ecg_details_ahr}"
end

Then(/^I should see V.HR and A.HR labels in ECG Details Header are right aligned on serial compare ecg$/) do
  if INFO == true
    puts @ECG_DETAILS_VHR_COMPARE
    puts @ECG_DETAILS_AHR_COMPARE
    puts @ECG_Screen.header_stats(1).text
  end
  expect(@ECG_Screen.header_stats(1).text).to include "V.HR (bpm): #{@ECG_DETAILS_VHR_COMPARE}"
  expect(@ECG_Screen.header_stats(1).text).to include "A.HR (bpm): #{@ECG_DETAILS_AHR_COMPARE}"
end

Then(/^I should see calculating distances for the ecg time calipers$/) do
  expect(@ECG_Screen.caliper_distance.displayed?).to be_truthy
  # expect(@ECG_Screen.caliper("left").displayed?).to be_truthy
  # expect(@ECG_Screen.caliper("right").displayed?).to be_truthy
  @first_caliper_distance = @ECG_Screen.caliper_distance.text
  puts @first_caliper_distance if INFO == true
end

Then(/^I should "(.*?)" calculating distances for the ecg time calipers$/) do |option|
  option = process_param(option)
  case option
  when 'see'
    expect(@ECG_Screen.caliper_distance.displayed?).to be_truthy
    @first_caliper_distance = @ECG_Screen.caliper_distance.text
    puts @first_caliper_distance if INFO == true
  when 'not see'
    begin
      expect(@ECG_Screen.caliper_distance.displayed?).to be_falsey
    rescue Selenium::WebDriver::Error::NoSuchElementError
      puts "Element is not present"
    end
  end
end

When(/^I drag the "(.*?)" ecg time caliper to the "(.*?)"$/) do |caliper, direction|
  @org_caliperDistance = @ECG_Screen.caliper_distance.text

  sleep 3
  case direction
  when 'left'
    @selenium.action.drag_and_drop_by(@ECG_Screen.caliper(caliper), -25, 0).perform
    @selenium.action.drag_and_drop_by(@ECG_Screen.caliper(caliper), -25, 0).perform
  when 'right'
    @selenium.action.drag_and_drop_by(@ECG_Screen.caliper(caliper), 25, 0).perform
    @selenium.action.drag_and_drop_by(@ECG_Screen.caliper(caliper), 25, 0).perform
  end
end

Then(/^I should see the ecg time caliper distance "(.*?)"$/) do |status|
  sleep 3
  caliperDistance = @ECG_Screen.caliper_distance.text

  if INFO == true
    puts @org_caliperDistance
    puts caliperDistance
  end

  case status
  when 'increase'
    expect(@org_caliperDistance.to_f).to be < caliperDistance.to_f
  when 'decrease'
    expect(@org_caliperDistance.to_f).to be > caliperDistance.to_f
  else
    expect(@org_caliperDistance.to_f).to eql caliperDistance.to_f
  end
end

When(/^I drag the whole ecg time caliper to the "(.*?)"$/) do |direction|
  @org_caliperDistance = @ECG_Screen.caliper_distance.text
  case direction
  when 'left'
    # @selenium.action.drag_and_drop_by(@ECG_Screen.caliper_distance,-100,1).perform
    @selenium.action.click_and_hold(@ECG_Screen.caliper_distance).move_by(-50, 1).release.perform
  when 'right'
    # @selenium.action.drag_and_drop_by(@ECG_Screen.caliper_distance,100,1).perform
    @selenium.action.click_and_hold(@ECG_Screen.caliper_distance).move_by(50, 1).release.perform
  when 'up'
    # @selenium.action.drag_and_drop_by(@ECG_Screen.caliper_distance,1,-100).perform
    @selenium.action.click_and_hold(@ECG_Screen.caliper_distance).move_by(1, -50).release.perform
  when 'down'
    # @selenium.action.drag_and_drop_by(@ECG_Screen.caliper_distance,1,100).perform
    @selenium.action.click_and_hold(@ECG_Screen.caliper_distance).move_by(1, 50).release.perform
  end
end

Then(/^the ecg time caliper moves to the "(.*?)" of waveform$/) do |direction|
  puts "moved #{direction}" if INFO == true
end

When(/^I click on ECG Time Caliper button$/) do
  @ECG_Screen.timeCaliperToolbar_button.click
end

Then(/^I should see the ECG Time Caliper button "(.*?)"$/) do |string|
  sleep 2
  if string == 'active'
    expect(@ECG_Screen.timeCaliperToolbar_button.attribute('className')).to include 'selected'
    unless @first_caliper_distance.nil?
      expect(@first_caliper_distance).to eql @ECG_Screen.caliper_distance.text
      if INFO == true
        puts @first_caliper_distance
        puts @ECG_Screen.caliper_distance.text
      end
    end
  else
    expect(@ECG_Screen.timeCaliperToolbar_button.attribute('className')).not_to include 'selected'
    expect(@ECG_Screen.timeCaliperToolbar_button.attribute('className')).not_to include 'disabled'
  end
end

Then(/^I should see the ECG Voltage Caliper button "(.*?)"$/) do |string|
  sleep 2
  case string
  when 'active'
    expect(@ECG_Screen.voltageCaliperToolbar_button.attribute('className')).to include 'selected'
    unless @first_caliper_distance.nil?
      expect(@first_caliper_distance).to eql @ECG_Screen.caliper_distance.text
      if INFO == true
        puts @first_caliper_distance
        puts @ECG_Screen.caliper_distance.text
      end
    end
  when 'disabled'
    expect(@ECG_Screen.voltageCaliperToolbar_button.attribute('className')).to include 'disabled'
  else
    expect(@ECG_Screen.voltageCaliperToolbar_button.attribute('className')).not_to include 'selected'
    expect(@ECG_Screen.voltageCaliperToolbar_button.attribute('className')).not_to include 'disabled'
  end
end

Then(/^I should see ECG Toolbar Tools separater$/) do
  expect(@ECG_Screen.toolsToolbar_label.text).to eql 'TOOLS'
end

Then(/^I should see Enable March Out switch as "(.*?)"$/) do |string|
  case string
  when 'ON'
    expect(@ECG_Screen.enableMarchOut_switch['status'].selected?).to be_truthy
  when 'OFF'
    expect(@ECG_Screen.enableMarchOut_switch['status'].selected?).to be_falsey
  end
  puts @ECG_Screen.enableMarchOut_switch['status'].selected? if INFO == true
end

When(/^I click on Enable Marchout Toggle$/) do
  @ECG_Screen.enableMarchOut_switch['switch'].click
end

When(/^I click on ECG Voltage Caliper button$/) do
  @ECG_Screen.voltageCaliperToolbar_button.click
end

Then(/^I should see calculating distances for the ecg voltage calipers$/) do
  expect(@ECG_Screen.caliper_distance.displayed?).to be_truthy
  expect(@ECG_Screen.caliper('top').displayed?).to be_truthy
  expect(@ECG_Screen.caliper('bottom').displayed?).to be_truthy
  @first_caliper_distance = @ECG_Screen.caliper_distance.text
  puts @first_caliper_distance if INFO == true
end

When(/^I drag the whole ecg voltage caliper to the "(.*?)"$/) do |direction|
  @org_caliperDistance = @ECG_Screen.caliper_distance.text
  case direction
  when 'left'
    @selenium.action.click_and_hold(@ECG_Screen.caliper_distance).move_by(-50, 1).release.perform
  when 'right'
    @selenium.action.click_and_hold(@ECG_Screen.caliper_distance).move_by(50, 1).release.perform
  when 'up'
    @selenium.action.click_and_hold(@ECG_Screen.caliper_distance).move_by(1, -50).release.perform
  when 'down'
    @selenium.action.click_and_hold(@ECG_Screen.caliper_distance).move_by(1, 50).release.perform
  end
end

Then(/^I should see the ecg voltage caliper distance "(.*?)"$/) do |status|
  sleep 3
  caliperDistance = @ECG_Screen.caliper_distance.text

  if INFO == true
    puts @org_caliperDistance
    puts caliperDistance
  end

  case status
  when 'increase'
    expect(@org_caliperDistance.to_f).to be < caliperDistance.to_f
  when 'decrease'
    expect(@org_caliperDistance.to_f).to be > caliperDistance.to_f
  else
    expect(@org_caliperDistance.to_f).to eql caliperDistance.to_f
  end
end

Then(/^the ecg voltage caliper moves to the "(.*?)" of waveform$/) do |direction|
  puts "moved #{direction}" if INFO == true
end

When(/^I drag the "(.*?)" ecg voltage caliper "(.*?)" on the screen$/) do |caliper, direction|
  @org_caliperDistance = @ECG_Screen.caliper_distance.text

  sleep 3
  case direction
  when 'up'
    @selenium.action.drag_and_drop_by(@ECG_Screen.caliper(caliper), 0, -25).perform
    @selenium.action.drag_and_drop_by(@ECG_Screen.caliper(caliper), 0, -25).perform
  when 'down'
    @selenium.action.drag_and_drop_by(@ECG_Screen.caliper(caliper), 0, 25).perform
    @selenium.action.drag_and_drop_by(@ECG_Screen.caliper(caliper), 0, 25).perform
  end
end

Then(/^I should see row "(.*?)" selected on ecg list$/) do |row|
  if INFO == true
    puts @ECG_Screen.ecg_list_details(1)['selected']
    puts @ECG_Screen.ecg_list_details(2)['selected']
  end
  expect(@ECG_Screen.ecg_list_details(row)['selected']).to be_truthy
end

When(/^I click on the ecg list button on second ecg$/) do
  @ECG_Screen.second_ecg_list_option_toolbar.click
end

Then(/^I should see row "(.*?)" selected on ecg list on second ecg$/) do |row|
  if INFO == true
    puts @ECG_Screen.second_ecg_list_details(1)['selected']
    puts @ECG_Screen.second_ecg_list_details(2)['selected']
  end
  expect(@ECG_Screen.second_ecg_list_details(row)['selected']).to be_truthy
end

Then(/^I should see the edit button disabled$/) do
  expect(@ECG_Screen.edit_button['disabled']).to be_truthy
end

When(/^I click the Edit button on ECG screen$/) do
  @wait.until { @ECG_Screen.edit_button['disabled'] == false }
  @ECG_Screen.edit_button['button_obj'].click
end

Then(/^I should see the ecg list button disabled$/) do
  expect(@ECG_Screen.list_option_toolbar.attribute('className')).to include 'disabled'
end

When(/^I click on expand statement indicator in ECG header$/) do
  @wait.until { @ECG_Screen.expand_ecgdetails_icon(0).displayed? == true }
  @ECG_Screen.expand_ecgdetails_icon(0).click
end

Then(/^I should see the expanded ECG Details in ECG header$/) do
  @wait.until { @ECG_Screen.expanded_ecg_detail_header }
  if INFO == true
    puts @ECG_Screen.expanded_ecg_detail_header['patient_info'].text
    puts @ECG_Screen.expanded_ecg_detail_header['diagnosis'].text
    puts @ECG_Screen.expanded_ecg_detail_header['stats'].text
  end

  expect(@ECG_Screen.expanded_ecg_detail_header['patient_info'].text).to be_truthy
  expect(@ECG_Screen.expanded_ecg_detail_header['diagnosis'].text).to be_truthy
  expect(@ECG_Screen.expanded_ecg_detail_header['stats'].text).to be_truthy
end
