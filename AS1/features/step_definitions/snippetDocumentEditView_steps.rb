# frozen_string_literal: true

Before do
  @SnippetDocEdit_Screen = SnippetDocEdit_Screen.new @selenium
  @SnippetTool_Screen = SnippetTool_Screen.new @selenium
  @PM_Navigation_Menu = PM_Navigation_Menu.new @selenium
end

Then(/^I should see the Snippet Document Edit View$/) do
  @wait = Selenium::WebDriver::Wait.new(timeout: 30)
  case @snippet_duration
  when '120 seconds'
    puts 'Gathering Data progress bar......' if INFO == true
    @wait = Selenium::WebDriver::Wait.new(timeout: 120)
  when '60 seconds'
    puts 'Gathering Data progress bar......' if INFO == true
    @wait = Selenium::WebDriver::Wait.new(timeout: 60)
  end

  begin
    retries ||= 0
    @wait.until { @SnippetDocEdit_Screen.waveform_div.displayed? == true }
  rescue Selenium::WebDriver::Error::StaleElementReferenceError
    retry if (retries += 1) < 3
  end

  @wait = Selenium::WebDriver::Wait.new(timeout: DEFAULT_EXPLICIT_WAIT)
  if @snippet_worklist_workflow != true
    steps %(
      And I should see the pm patient info in the header
    )
  end

  expect(@SnippetDocEdit_Screen.createStatement_window.displayed?).to be_truthy
  # expect(@SnippetDocEdit_Screen.snippet_doc_type_selector.text).to eql "EVENT"

  expect(@SnippetDocEdit_Screen.preview_button.displayed?).to be_truthy
  expect(@SnippetDocEdit_Screen.save_button.displayed?).to be_truthy
  expect(@SnippetDocEdit_Screen.cancel_button.displayed?).to be_truthy

  # expect(@SnippetDocEdit_Screen.event_description_input.displayed?).to be_truthy
  expect(@SnippetDocEdit_Screen.measurement_input('HR').displayed?).to be_truthy
  # expect(@SnippetDocEdit_Screen.measurement_input("PR").displayed?).to be_truthy
  # expect(@SnippetDocEdit_Screen.measurement_input("QRS").displayed?).to be_truthy
  # expect(@SnippetDocEdit_Screen.measurement_input("QT").displayed?).to be_truthy
  expect(@SnippetDocEdit_Screen.all_leads_toggle['toggle_obj'].displayed?).to be_truthy

  @snippet_document_edit_heart_rate_value = @SnippetDocEdit_Screen.snippet_document_edit_heart_rate_value
  puts "the snippet document edit heart rate value = #{@snippet_document_edit_heart_rate_value}"
end

And(/^the the Heart Rate from Monitor screen matches the Snippet Document Edit View screen$/) do
  expect(@monitor_heart_rate_value).to eql @snippet_document_edit_heart_rate_value
end

And(/^the the Heart Rate from Snippet Tools screen matches the Snippet Document Edit View screen$/) do
  expect(@snippet_tool_screen_heart_rate_value).to eql "HR: #{@snippet_document_edit_heart_rate_value}"
end

When(/^I click the Cancel button on Snippet Document Edit View$/) do
  sleep 2
  Selenium::WebDriver::Wait.new(timeout: DEFAULT_EXPLICIT_WAIT*3)
                           .until { @SnippetDocEdit_Screen.preview_button.enabled? == true }
  @SnippetDocEdit_Screen.cancel_button.click
end

When(/^I click the Back button on Snippet Document Edit View$/) do
  sleep 2
  @wait.until { @SnippetDocEdit_Screen.preview_button.enabled? == true }
  @SnippetDocEdit_Screen.back_button.click
end

When(/^I click the Save button on Snippet Document Edit screen$/) do
  @wait.until { @SnippetDocEdit_Screen.save_button.enabled? == true }
  sleep 2
  @SnippetDocEdit_Screen.save_button.click
end

When(/^I click the Preview button on Snippet Document Edit View$/) do
  @wait.until { @SnippetDocEdit_Screen.preview_button.enabled? == true }
  @SnippetDocEdit_Screen.preview_button.click
end

Then(/^I should see Snippet Not Saved window$/) do
  @selenium.manage.timeouts.implicit_wait = DEFAULT_EXPLICIT_WAIT
  @wait.until { @SnippetDocEdit_Screen.snippet_not_saved_window.enabled? == true }
  expect(@SnippetDocEdit_Screen.snippet_not_saved_window.text).to eql 'Canceled: Snippet not saved'
end

When(/^I click the Ok button in Snippet Not Saved window$/) do
  retries ||= 0
  @SnippetDocEdit_Screen.snippet_not_saved_leave_button.click
rescue StandardError
  sleep 0.5
  retry if (retries += 1) < 3
end

Then(/^I should see the measurement values "(.*?)" from monitor tool$/) do |value|
  if @measure_button_on == true
    case value
    when 'HR'
      expect(@SnippetDocEdit_Screen.measurement_input(value).attribute('value')).to be == @snippet_hr_value

      puts "------------"
      puts "in the first HR value = #{@SnippetDocEdit_Screen.measurement_input(value).attribute('value')}"
      puts "the snippet hr value = #{@snippet_hr_value}"
      puts "------------"

    when 'PR'
      expect(@SnippetDocEdit_Screen.measurement_input('PR').attribute('value')).to be == @snippet_pr_value
    when 'QRS'
      expect(@SnippetDocEdit_Screen.measurement_input('QRS').attribute('value')).to be == @snippet_qrs_value
    when 'QT'
      expect(@SnippetDocEdit_Screen.measurement_input('QT').attribute('value')).to be == @snippet_qt_value
    when 'QTc'
      if QTC_CONFIG == true
        if @snippet_qtc_value == '--'
          expect(@SnippetDocEdit_Screen.measurement_input('QTc').attribute('value')).to eql ''
        else
          expect(@SnippetDocEdit_Screen.measurement_input('QTc').attribute('value')).to be == @snippet_qtc_value
        end
      end
    end

  else
    case value
    when 'HR'
      expect(@SnippetDocEdit_Screen.measurement_input(value).attribute('value')).to be == @snippet_hr_value
      puts "++++++++++"
      puts "in the else HR value = #{@SnippetDocEdit_Screen.measurement_input(value).attribute('value')}"
      puts "the snippet hr value = #{@snippet_hr_value}"
      puts "++++++++++"
    when 'PR'
      expect(@SnippetDocEdit_Screen.measurement_input(value).attribute('value')).to eql ''
    when 'QRS'
      expect(@SnippetDocEdit_Screen.measurement_input(value).attribute('value')).to eql ''
    when 'QT'
      expect(@SnippetDocEdit_Screen.measurement_input(value).attribute('value')).to eql ''
    when 'QTc'
      expect(@SnippetDocEdit_Screen.measurement_input(value).attribute('value')).to eql '' if QTC_CONFIG == true
    end
  end
end

Then(/^I should see the measurement placeholder "(.*?)" from monitor tool$/) do |value|
  # if value == 'QTc'
    expect(@SnippetDocEdit_Screen.measurement_input(value).attribute('placeholder')).to eql '--'
  # else
  #   expect(@SnippetDocEdit_Screen.measurement_input(value).attribute('placeholder')).to eql '0'
  # end
end

Then(/^I should see the Measurement Values measured to the one hundreths place$/) do
  def valid_format?(value)
    pattern = /^\d+\.\d{2}$/  # Regular expression pattern for "0.00" format
    !!value.match(pattern)
  end
  values = %w[PR QRS QT]

  values.each do |value|
    expect(valid_format?(@SnippetDocEdit_Screen.measurement_input(value).attribute('value'))).to eq(true)
  end
end

When(/^I click the All Leads button "(.*?)"$/) do |expected_status|
  button_status = @SnippetDocEdit_Screen.all_leads_toggle['buttonOn']
  case expected_status
  when 'Off'
    expected_status = false
  when 'On'
    expected_status = true
  end
  @SnippetDocEdit_Screen.all_leads_toggle['toggle_obj'].click if expected_status != button_status
end

Then(/^the All Leads toggle is switched "(.*?)"$/) do |status|
  case status
  when true
    expect(@SnippetDocEdit_Screen.all_leads_toggle['buttonOn']).to be_truthy
  when false
    expect(@SnippetDocEdit_Screen.all_leads_toggle['buttonOn']).to be_falsey
  end
end

Then(/^I should see date and timestamp in "(.*?)" format$/) do |format|
  # expect(DateTime.strptime(snippet_date, time)).to be_truthy

  date = @SnippetDocEdit_Screen.edit_snippet_timestamp.text
  if INFO == true
    puts format
    puts date
  end

  startFirstTime = date.index('(')
  endFirstTime = date.index('–')
  startEndTime = date.index('–')
  endEndTime = date.index(')')

  snippetDate = date[0, startFirstTime]
  snippetStartTime = date[startFirstTime + 1, endFirstTime - startFirstTime - 1]
  snippetEndTime = date[startEndTime + 1, endEndTime - startEndTime - 1]

  expect(DateTime.strptime(snippetDate, '%m/%d/%Y')).to be_truthy
  expect(DateTime.strptime(snippetStartTime, '%H:%M:%S')).to be_truthy
  expect(DateTime.strptime(snippetEndTime, '%H:%M:%S')).to be_truthy
end

Then(/^the snippet length is same as duration selector from monitor tool$/) do
  if INFO == true
    puts @snippet_duration
    puts @SnippetDocEdit_Screen.leads_time.text
  end

  case @snippet_duration
  when '10 seconds'
    duration = '10s'
  when '6 seconds'
    duration = '6s'
  when '30 seconds'
    duration = '30s'
  when '60 seconds'
    duration = '60s'
  when '120 seconds'
    duration = '120s'
  end
  expect(duration).to eql @SnippetDocEdit_Screen.leads_time.text
end

When(/^I enter "(.*?)" in "(.*?)" measurement value$/) do |value, measurement_name|
  @wait.until { @SnippetDocEdit_Screen.measurement_input(measurement_name) }
  @SnippetDocEdit_Screen.measurement_input(measurement_name).clear
  @SnippetDocEdit_Screen.measurement_input(measurement_name).send_keys value

  case measurement_name
  when 'HR'
    @hr_value = value
  when 'PR'
    @pr_value = value
  when 'QRS'
    @qrs_value = value
  when 'QT'
    @qt_value = value
  when 'QTc'
    @qtc_value = value
  end
end

Then(/^I should see the "(.*?)" field (is|maybe) (editable|not editable)$/) do |field, strict, action|

    if action == 'editable'
      expect(@SnippetDocEdit_Screen.measurement_input(field).attribute('readonly')).to be_falsey
    else
      expect(@SnippetDocEdit_Screen.measurement_input(field).attribute('readonly')).to be_truthy
      expect(@SnippetDocEdit_Screen.measurement_input(field).style('background-color')).to eql('rgba(229, 229, 229, 1)')
    end
end

Then(/^I should see the measurement values entered$/) do
  expect(@SnippetDocEdit_Screen.measurement_input('HR').attribute('value')).to be == @hr_value unless @hr_value.nil?

  expect(@SnippetDocEdit_Screen.measurement_input('PR').attribute('value')).to be == @pr_value unless @pr_value.nil?

  expect(@SnippetDocEdit_Screen.measurement_input('QRS').attribute('value')).to be == @qrs_value unless @qrs_value.nil?

  expect(@SnippetDocEdit_Screen.measurement_input('QT').attribute('value')).to be == @qt_value unless @qt_value.nil?

  expect(@SnippetDocEdit_Screen.measurement_input('QTc').attribute('value')).to be == @qtc_value unless @qtc_value.nil?
end

When(/^I click into the Event Description field$/) do
  @SnippetDocEdit_Screen.patient_name_header.click
  @SnippetDocEdit_Screen.event_description_dropdown_arrow.click
end

Then(/^I should see a selectable list from the server$/) do
  expect(@SnippetDocEdit_Screen.event_description_listbox('Normal sinus rhythm').displayed?).to be_truthy
end

When(/^I select "(.*?)" from Event Description dropdown$/) do |name|
  @SnippetDocEdit_Screen.event_description_listbox(name).click
end

Then(/^I should see "(.*?)" description in Event Description field$/) do |name|
  # pending "select input box not displaying selenium after selection, works manually"
  expect(@SnippetDocEdit_Screen.event_description_select_input(name).displayed?).to be_truthy
end

When(/^I type "(.*?)" into the Event Description field$/) do |value|
  @selenium.action.send_keys(value).perform
end

Then(/^I should see the value of "(.*?)" in the selectable list from the server$/) do |name|
  expect(@SnippetDocEdit_Screen.event_description_listbox(name).displayed?).to be_truthy
end

Then(/^I should (\d+) events in selectable list$/) do |num_of_events|
  expect(@SnippetDocEdit_Screen.event_description_listbox_count).to eql num_of_events.to_i
end

Then(/^I should see at least (\d+) events in selectable list$/) do |num_of_events|
  expect(@SnippetDocEdit_Screen.event_description_listbox_count).to be >= num_of_events.to_i
end

When(/^I scroll "(.*?)" on the Snippet Document Edit View$/) do |direction|
  # sleep 2
  case direction
  when 'down'
    @SnippetDocEdit_Screen.measurement_input('HR').click
    @selenium.action.send_keys(:page_down).perform
  when 'up'
    @SnippetDocEdit_Screen.measurement_input('HR').click
    @selenium.action.send_keys(:page_up).perform
  end
  sleep 0.5
end

Then(/^I should see a messaging loading bar for snippets data selected in future$/) do
  # no code loading bar handled on viewing snippet doc screen, for test step purposes
end

Then(/^I should see the All Leads, Preview, OK buttons disabled until page loads$/) do
  # no code loading bar handled on viewing snippet doc screen, for test step purposes
end

Then(/^I should see the Description field with header "(.*?)"$/) do |header_text|
  expect(@SnippetDocEdit_Screen.description_header.text).to include header_text
end

Then(/^I should see the Event Description field empty$/) do
  expect(@SnippetDocEdit_Screen.event_description_select_placeholder.text).to eql 'Select...'
end

When(/^I remove the value of "([^"]*)" in the selectable list from the server$/) do |_arg1|
  @selenium.action.send_keys(:backspace).perform
end

Then(/^I should see not "([^"]*)" description in Event Description field$/) do |_arg1|
  expect(@SnippetDocEdit_Screen.event_description_select_placeholder.text).to eql 'Select...'
end

When(/^I select snippet doc type of "(.*?)"$/) do |type|
  puts @SnippetDocEdit_Screen.snippet_doc_type_selector.text
  i = 0
  while i < 5
    if @SnippetDocEdit_Screen.snippet_doc_type_selector.text.include? type
      puts "We found your selection #{type}"
      i += 5
    elsif !@SnippetDocEdit_Screen.snippet_doc_type_selector.text.include? type
      @SnippetDocEdit_Screen.snippet_doc_type_selector.click
      @selenium.action.send_keys(:arrow_down).perform
      @selenium.action.send_keys(:return).perform
      sleep 3
      puts "this is the text: #{@SnippetDocEdit_Screen.snippet_doc_type_selector.text}"
      i += 1
    end
  end
  puts @SnippetDocEdit_Screen.snippet_doc_type_selector.text
  expect(@SnippetDocEdit_Screen.snippet_doc_type_selector.text).to include type
end

# old logic below when first item in list wasnt highlighted.
# if type == "PRN"
#  if @SnippetDocEdit_Screen.snippet_doc_type_selector.text == "EVENT"
#    @SnippetDocEdit_Screen.snippet_doc_type_selector.click
#    @selenium.action.send_keys(:arrow_up).perform
#    @selenium.action.send_keys(:arrow_up).perform
#    @selenium.action.send_keys(:arrow_up).perform
#    @selenium.action.send_keys(:return).perform
#  elsif @SnippetDocEdit_Screen.snippet_doc_type_selector.text == "Admission Baseline"
#    @SnippetDocEdit_Screen.snippet_doc_type_selector.click
#    @selenium.action.send_keys(:arrow_up).perform
#    @selenium.action.send_keys(:return).perform
#  elsif @SnippetDocEdit_Screen.snippet_doc_type_selector.text == "Shift Assessment"
#    @SnippetDocEdit_Screen.snippet_doc_type_selector.click
#    @selenium.action.send_keys(:arrow_up).perform
#    @selenium.action.send_keys(:arrow_up).perform
#    @selenium.action.send_keys(:return).perform
#  elsif @SnippetDocEdit_Screen.snippet_doc_type_selector.text == "PRN"
#    # do nothing already selected
#  end
# elsif type == "Admission Baseline"
#  if @SnippetDocEdit_Screen.snippet_doc_type_selector.text == "EVENT"
#    @SnippetDocEdit_Screen.snippet_doc_type_selector.click
#    @selenium.action.send_keys(:arrow_up).perform
#    @selenium.action.send_keys(:arrow_up).perform
#    @selenium.action.send_keys(:return).perform
#  elsif @SnippetDocEdit_Screen.snippet_doc_type_selector.text == "Admission Baseline"
#     # do nothing already selected
#  elsif @SnippetDocEdit_Screen.snippet_doc_type_selector.text == "Shift Assessment"
#    @SnippetDocEdit_Screen.snippet_doc_type_selector.click
#    @selenium.action.send_keys(:arrow_up).perform
#    @selenium.action.send_keys(:return).perform
#  elsif @SnippetDocEdit_Screen.snippet_doc_type_selector.text == "PRN"
#    @SnippetDocEdit_Screen.snippet_doc_type_selector.click
#    @selenium.action.send_keys(:arrow_down).perform
#    @selenium.action.send_keys(:return).perform
#  end
# elsif type == "EVENT"
#  if @SnippetDocEdit_Screen.snippet_doc_type_selector.text == "EVENT"
#     # do nothing already selected
#  elsif @SnippetDocEdit_Screen.snippet_doc_type_selector.text == "Admission Baseline"
#    @SnippetDocEdit_Screen.snippet_doc_type_selector.click
#    @selenium.action.send_keys(:arrow_down).perform
#    @selenium.action.send_keys(:arrow_down).perform
#    @selenium.action.send_keys(:return).perform
#  elsif @SnippetDocEdit_Screen.snippet_doc_type_selector.text == "Shift Assessment"
#    @SnippetDocEdit_Screen.snippet_doc_type_selector.click
#    @selenium.action.send_keys(:arrow_down).perform
#    @selenium.action.send_keys(:return).perform
#  elsif @SnippetDocEdit_Screen.snippet_doc_type_selector.text == "PRN"
#    @SnippetDocEdit_Screen.snippet_doc_type_selector.click
#    @selenium.action.send_keys(:arrow_down).perform
#    @selenium.action.send_keys(:arrow_down).perform
#    @selenium.action.send_keys(:arrow_down).perform
#    @selenium.action.send_keys(:return).perform
#  end
# elsif type == "Shift Assessment"
#  if @SnippetDocEdit_Screen.snippet_doc_type_selector.text == "EVENT"
#    @SnippetDocEdit_Screen.snippet_doc_type_selector.click
#    @selenium.action.send_keys(:arrow_up).perform
#    @selenium.action.send_keys(:return).perform
#  elsif @SnippetDocEdit_Screen.snippet_doc_type_selector.text == "Admission Baseline"
#    @SnippetDocEdit_Screen.snippet_doc_type_selector.click
#    @selenium.action.send_keys(:arrow_down).perform
#    @selenium.action.send_keys(:return).perform
#  elsif @SnippetDocEdit_Screen.snippet_doc_type_selector.text == "Shift Assessment"
#    # do nothing already selected
#  elsif @SnippetDocEdit_Screen.snippet_doc_type_selector.text == "PRN"
#    @SnippetDocEdit_Screen.snippet_doc_type_selector.click
#    @selenium.action.send_keys(:arrow_down).perform
#    @selenium.action.send_keys(:arrow_down).perform
#    @selenium.action.send_keys(:return).perform
#  end
# end

When(/^I click snippet doc type selector$/) do
  @SnippetDocEdit_Screen.snippet_doc_type_selector.click
end

Then(/^I should see the snippet doc type dropdown menu$/) do
  expect(@SnippetDocEdit_Screen.snippet_doc_type_selector_dropdown.displayed?).to be_truthy
end

Then(/^The snippet doc type should display "(.*?)"$/) do |type|
  expect(@SnippetDocEdit_Screen.snippet_doc_type_selector.text.downcase).to eql type.downcase
end

Then(/^I should not see the snippet doc type "([^"]*)" in dropdown when selected$/) do |_arg1|
  @SnippetDocEdit_Screen.snippet_doc_type_selector.click
  count = @SnippetDocEdit_Screen.snippet_doc_type_count
  puts count if INFO == true
  if count == 4
    puts 'showShiftAssessment == true and is visble' if INFO == true
    expect(@SnippetDocEdit_Screen.snippet_doc_type_count).to eql 4
  else
    expect(@SnippetDocEdit_Screen.snippet_doc_type_count).to eql 3
  end
end

Then(/^I should not see "(.*?)" in Description dropdown$/) do |_string|
  count = @SnippetDocEdit_Screen.snippet_doc_type_count
  puts count if INFO == true
  if count == 4
    puts 'showShiftAssessment == true and is visble' if INFO == true
    expect(@SnippetDocEdit_Screen.snippet_doc_type_count).to eql 4
  else
    expect(@SnippetDocEdit_Screen.snippet_doc_type_count).to eql 3
  end
end

When(/^I click the Save button on Snippet Document Edit View$/) do
  @SnippetDocEdit_Screen.save_button.click
end

When(/^I click the Save button on Snippet Document Preview screen$/) do
  @wait.until { @SnippetDocEdit_Screen.snippet_not_saved_leave_button.enabled? == true }
  @SnippetDocEdit_Screen.snippet_not_saved_leave_button.click
end

Then(/^I should see the patient header with the patients information displayed$/) do
  expect(@SnippetDocEdit_Screen.patient_name_header.displayed?).to be_truthy
  expect(@SnippetDocEdit_Screen.patient_information_header.displayed?).to be_truthy
end

Then(/^I should not see the back button in the navigation header$/) do
  begin
    expect(@SnippetDocEdit_Screen.back_button.displayed?).to be_falsey
  rescue StandardError
    # rescue if cant find object - pass
  end
end

Then(/^I should see the Measurements label and values$/) do
  expect(@SnippetDocEdit_Screen.measurement_label.displayed?).to be_truthy
  expect(@SnippetDocEdit_Screen.measurement_input('HR').displayed?).to be_truthy
  expect(@SnippetDocEdit_Screen.measurement_input('PR').displayed?).to be_truthy
  expect(@SnippetDocEdit_Screen.measurement_input('QRS').displayed?).to be_truthy
  expect(@SnippetDocEdit_Screen.measurement_input('QT').displayed?).to be_truthy
  expect(@SnippetDocEdit_Screen.measurement_input('QTc').displayed?).to be_truthy
end

Then(/^I should see the waveform image displaying 2 or less waveforms$/) do
  expect(@SnippetDocEdit_Screen.waveform_div.size.height).to eql process_param("[props.MD_SNIP_DOC_EDIT_WAVE_HEIGHT]").to_i
end

Then(/^I should see the waveform image displaying all the waveforms$/) do
  expect(@SnippetDocEdit_Screen.waveform_div.size.height).to be > process_param("[props.MD_SNIP_DOC_EDIT_WAVE_HEIGHT]").to_i
end

