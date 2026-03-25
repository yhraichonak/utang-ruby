# frozen_string_literal: true

Before do
  @ECG_Screen = ECG_Screen.new @selenium
  @EditConfirm_window = EditConfirm_window.new @selenium
end

Then(/^I see the Edit Confirm window appear on right side of ECG screen$/) do
  begin
    # if already been confirmed message displays
    @selenium.manage.timeouts.implicit_wait = 3
    @selenium.find_element(:class, 'swal2-confirm').click
  rescue StandardError
    # if message doesnt appear, continue
  end
  @selenium.manage.timeouts.implicit_wait = DEFAULT_IMPLICIT_WAIT

  @wait.until { @EditConfirm_window.statement_editor_window }

  expect(@EditConfirm_window.statement_editor_window).to be_truthy

  date_acquisition = @EditConfirm_window.date_acquisition_time.text
  puts @EditConfirm_window.date_acquisition_time.text if INFO == true
  expect(@EditConfirm_window.date_acquisition_time.text).to include @ecg_list_details_date
  expect(@EditConfirm_window.date_acquisition_time.text).to include @ecg_list_details_time

  puts @EditConfirm_window.ecg_measurements['stats'].text if INFO == true

  expect(@EditConfirm_window.ecg_measurements['vhr'].text).to eql @ecg_details_vhr
  expect(@EditConfirm_window.ecg_measurements['pr'].text).to eql @ecg_details_pr
  expect(@EditConfirm_window.ecg_measurements['qrs'].text).to eql @ecg_details_qrs
  expect(@EditConfirm_window.ecg_measurements['prt'].text).to eql @ecg_details_prt

  expect(@EditConfirm_window.ecg_measurements['ahr'].text).to eql @ecg_details_ahr
  expect(@EditConfirm_window.ecg_measurements['qt'].text).to eql @ecg_details_qt
  expect(@EditConfirm_window.ecg_measurements['qtc'].text).to eql @ecg_details_qtc

  @DiagStatementsCount = @EditConfirm_window.sentence_containers.count

  if INFO == true
    puts @DiagStatementsCount
    puts @EditConfirm_window.sentence_containers[0].text
  end
  expect(@EditConfirm_window.sentence_containers[0].text).to include @ecg_list_details_diag

  expect(@EditConfirm_window.appendStatement_button).to be_truthy
  expect(@EditConfirm_window.cancel_button).to be_truthy
  expect(@EditConfirm_window.confirm_button).to be_truthy
end

When(/^I click the Cancel button in Edit Confirm window$/) do
  @EditConfirm_window.cancel_button.click
end

When(/^The Edit Confirm window displays with a message including "(.*?)"$/) do |description|
  wait_for(10) { @EditConfirm_window.edit_confirm_message.displayed? == true }
  @EditConfirm_window.edit_confirm_message.text.should include description
end

Then(/^I should see browser prompt to Undo Edits or cancel request$/) do
  begin
    retries ||= 0
    @alert = @selenium.switch_to.alert
  rescue Selenium::WebDriver::Error::UnexpectedAlertOpenError
    retry if (retries += 1) < 3
  end
  expect(@alert.text).to eql 'Any information you edited will be undone. Are you sure you want to undo edits?'
end

When(/^I click Cancel button in Undo Edits browser prompt window$/) do
  @alert.dismiss
end

When(/^I click Undo Edits button in Undo Edits browser prompt window$/) do
  retries ||= 0
  @alert.accept
  steps %(
    Then I should see the patient list screen
  )
rescue Selenium::WebDriver::Error::UnexpectedAlertOpenError
  retry if (retries += 1) < 3
  @alert = @selenium.switch_to.alert
rescue StandardError
  # click enter to remove alert window if not dismissed
  @selenium.action.send_keys(:return).perform
  retry if (retries += 1) < 3
end

Then(/^I should see prompt to Undo Edits or cancel request$/) do
  @wait.until { @EditConfirm_window.confirm_prompt_window.displayed? == true }

  expect(@EditConfirm_window.confirm_prompt_window.text).to eql 'Any information you edited will be undone. Are you sure you want to undo edits?'
  expect(@EditConfirm_window.confirm_prompt_confirm_button).to be_truthy
  expect(@EditConfirm_window.confirm_prompt_cancel_button).to be_truthy
end

When(/^I click Cancel button in Undo Edits prompt window$/) do
  @EditConfirm_window.undoEdit_prompt_cancel_button.click
end

When(/^I click Undo Edits button in Undo Edits prompt window$/) do
  @EditConfirm_window.undoEdit_prompt_undoEdits_button.click
end

When(/^I click the Confirm button in Edit Confirm window$/) do
  @EditConfirm_window.confirm_button.click
end

Then(/^I should see prompt to Confirm or Cancel$/) do
  @wait.until { @EditConfirm_window.confirm_prompt_window }

  expect(@EditConfirm_window.confirm_prompt_window.text).to eql 'Are you sure you want to confirm this ECG?'
  expect(@EditConfirm_window.confirm_prompt_confirm_button).to be_truthy
  expect(@EditConfirm_window.confirm_prompt_cancel_button).to be_truthy
end

When(/^I click Cancel button in Confirm or Cancel prompt window$/) do
  @EditConfirm_window.confirm_prompt_cancel_button.click
end

When(/^I click Confirm button in Confirm or Cancel prompt window$/) do
  @EditConfirm_window.confirm_prompt_confirm_button.click
end

Then(/^I should see a Confirmation prompt window appear$/) do
  sleep(0.5) #Hard coded sleep required because the verification step occurs before the previous prompt window closes causing the wrong text to be read
  @wait.until { @EditConfirm_window.confirm_prompt_window }
  expect(@EditConfirm_window.confirm_prompt_window.text).to eql 'Test Has Been Updated'
end

When(/^I click the OK button in Confirmation prompt window$/) do
  @EditConfirm_window.confirm_prompt_confirm_button.click
end

When(/^I click the Append Statement button$/) do
  @EditConfirm_window.appendStatement_button.click
end

Then(/^I should see a new statement row added in the Edit Confirm window$/) do
  expect(@DiagStatementsCount.to_i + 1).to eql @EditConfirm_window.sentence_containers.count

  @DiagStatementsCount = @EditConfirm_window.sentence_containers.count
end

When(/^I type "(.*?)" on the new statement row in the Edit Confirm window$/) do |text|
  sleep 1
  puts @DiagStatementsCount if INFO == true
  @EditConfirm_window.sentence_containers[@DiagStatementsCount.to_i - 1].click
  @selenium.action.send_keys(text).perform
end

Then(/^I should see the statement library selection window appear with values that start with "(.*?)"$/) do |text|
  numbOfSuggestions = @EditConfirm_window.statementLibrary.count
  (0..(numbOfSuggestions - 1)).each do |i|
    # expect(@EditConfirm_window.statementLibrary[i].text).to start_with text
    expect(@EditConfirm_window.statementLibrary[i].text.downcase).to include text.downcase
  end
end

When(/^I select "(.*?)" in statement library selection window$/) do |text|
  numbOfSuggestions = @EditConfirm_window.statementLibrary.count
  (0..(numbOfSuggestions - 1)).each do |i|
    puts @EditConfirm_window.statementLibrary[i].text if INFO == true
    if @EditConfirm_window.statementLibrary[i].text == text
      @EditConfirm_window.statementLibrary[i].click
      break
    end
  end
end

Then(/^I should see "(.*?)" display in new statement row in Edit Confirm window$/) do |text|
  expect(@EditConfirm_window.sentence_containers[@DiagStatementsCount.to_i - 1].text).to include text
end

When(/^I type "(.*?)" on "(.*?)" statement row in the Edit Confirm window$/) do |text, statement_row|
  sleep 1
  @EditConfirm_window.sentence_containers[statement_row.to_i - 1].click
  @selenium.action.send_keys(text).perform
end

Then(/^I should see "(.*?)" display on "(.*?)" statement row in Edit Confirm window$/) do |text, statement_row|
  expect(@EditConfirm_window.sentence_containers[statement_row.to_i - 1].text).to include text
end

Then(/^I should see a total of (\d+) statements in Edit Confirm window$/) do |int|
  expect(@EditConfirm_window.sentence_containers.count.to_i).to eql int.to_i
end

When(/^I click the delete statement icon for the statement "(.*?)"$/) do |text|
  numbOfStatements = @EditConfirm_window.delete_sentences.count
  expect(numbOfStatements).to eql @DiagStatementsCount

  (0..(numbOfStatements - 1)).each do |i|
    puts @EditConfirm_window.sentence_containers[i].text if INFO == true
    if @EditConfirm_window.sentence_containers[i].text.include? text
      @EditConfirm_window.delete_sentences[i].click
      break
    end
  end

  @DiagStatementsCount = @EditConfirm_window.sentence_containers.count
end

Then(/^I should see the statement row with "(.*?)" deleted$/) do |_string|
  numbOfStatements = @EditConfirm_window.delete_sentences.count
  expect(numbOfStatements).to eql @DiagStatementsCount
end

When(/^I move "(.*?)" statement row to row "(.*?)" of Edit Confirm window$/) do |text, row|
  menuObjs = @selenium.find_element(:css, 'div.statement-editor').find_elements(:class, 'icon-menu')

  (0..(@DiagStatementsCount - 1)).each do |i|
    puts @EditConfirm_window.sentence_containers[i].text if INFO == true
    if @EditConfirm_window.sentence_containers[i].text.include? text
      @selenium.action.click_and_hold(menuObjs[i]).move_by(0, -5).move_to(menuObjs[row.to_i - 1]).release.perform
      break
    end
  end
end

Then(/^I should see "(.*?)" display in row "(.*?)" in Edit Confirm window$/) do |text, row|
  sleep(0.5) #Hard coded sleep required because the statement is still in motion during the verification step
  expect(@EditConfirm_window.sentence_containers[row.to_i - 1].text.include? text)
end

Then(/^I should see a cardio message "(.*?)"$/) do |message|
  expect(@EditConfirm_window.edit_confirm_message.text).to eql message
end

When(/^I click Ok in cardio message window$/) do
  @EditConfirm_window.edit_confirm_message_ok_button.click
rescue StandardError
  @EditConfirm_window.edit_confirm_message_cancel_button.click
end

When(/^I click Cancel in cardio message window$/) do
  @EditConfirm_window.edit_confirm_message_cancel_button.click
end