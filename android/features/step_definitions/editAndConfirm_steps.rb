Before do
  @EditAndConfirm_window = EditAndConfirm_window.new selenium, appium
  @StatementEditor_window = StatementEditor_window.new selenium, appium
  @Alert_window = Alert_window.new selenium, appium
  @EditConfirmPrompt_window = EditConfirmPrompt_window.new selenium, appium
  @AreYouSurePrompt_window = AreYouSurePrompt_window.new selenium, appium
end

Then(/^I should check the ecg status$/) do
  if(@EditConfirmPrompt_window.continue_button.exists)
    @EditConfirmPrompt_window.continue_button.click
    sleep(2)
  end

  #Then "Edit/Confirm" window appears with message of "This test was already confirmed by Morgan, Chris. Do you wish to continue?"
  #When I click the alert continue button on Edit/Confirm window
end

Then(/^I should see the Edit\/Confirm screen$/) do
  wait_for(10) { @EditAndConfirm_window.confirm_button.exists == true }
end

Then(/^I should see the Edit\/Confirm statement window with following statements in order$/) do |table|
  # for i in 0..5
	#   sleep 1
	# begin
	# 	@EditAndConfirm_window.statementMessage_text(1)
	# rescue
	# 	i
	# end
  # end

  @wait.until { @EditAndConfirm_window.confirm_button.exists }
  row = 1
  expectedData = table.hashes
  expectedData.each do |statement|
    debug_statement = @EditAndConfirm_window.statementMessage_text(row)
    @EditAndConfirm_window.statementMessage_text(row).text.should include statement[:diag_statement]
    #@EditAndConfirm_window.statementDelete_button(row).attribute("enabledd").should be true
    #@EditAndConfirm_window.statementReorder_image(row).attribute("enabledd").should be true
    row += 1
  end
  #@EditAndConfirm_window.addStatement_button.exists.should be true
end

Then(/^I should see the Edit\/Confirm statement window$/) do
  expect(@EditAndConfirm_window.addStatement_button.attribute('displayed')).to eql 'true'
end

When(/^I click the add statement button$/) do
  @EditAndConfirm_window.addStatement_button.click
end

Then(/^the statement editor window should display$/) do
  @StatementEditor_window.windowTitleBar.text.should eql 'Statement Editor'
  @StatementEditor_window.cancel_button.exists.should be true
  @StatementEditor_window.ok_button.exists.should be true
end

When(/^I type "(.*?)" into the statement editor window$/) do |text|
  @StatementEditor_window.statementEditor_textView.click
  DeviceExtensions.string_to_key_conversion(text)
  sleep(0.5)
end

When(/^I click on row (\d+) of search results$/) do |arg1|
  wait_for(3){ @StatementEditor_window.button_panel.displayed? == true }
  x = 550
  y = 625
  if arg1 > 1
    extra_rows = arg1 - 1
    y = y + 100 * extra_rows
  end
  obj = @StatementEditor_window.statementEditor_textView
  obj_coordinates = obj.location
  obj_size = obj.size
  value = (obj_size[:height] * 1.33333)
  value = value.to_f.round

  # Appium::TouchAction.new.tap(:x => x, :y => y, :duration => 100).perform
  @selenium.action.move_to_location(x,y).click.perform
  # action_builder = @selenium.action
  # touch = action_builder.add_pointer_input(:touch, 'finger')
  # touch.create_pointer_move(duration: 0, x: x, y: y)
  # touch.create_pointer_down(:left)
  # touch.create_pause(0.1)
  # touch.create_pointer_up(:left)
  # action_builder.perform
  # sleep(2)
end

When(/^I click the ok button in statement editor window$/) do
  @StatementEditor_window.ok_button.click
end

When(/^I hold and drag statement on row "(.*?)" to row "(.*?)" on screen$/) do |row_from, row_to|
  sleep(1)

  locationFrom = @EditAndConfirm_window.statementReorder_image(row_from.to_i)
  locationTo = @EditAndConfirm_window.statementReorder_image(row_to.to_i)

  dnd = Appium::TouchAction.new
  dnd.long_press(:element => locationFrom).move_to(:element => locationTo).release.perform

  sleep(2)
end

When(/^I click the 'X' button on row "(.*?)"$/) do |row|
  @EditAndConfirm_window.statementDelete_button(row.to_i).click
end

When(/^I click the Cancel button on top of Edit\/Confirm statement window$/) do
  @EditAndConfirm_window.cancel_button.click
end

When(/^I click the Alert No button on Edit\/Confirm statement window$/) do
  @Alert_window.no_button.click
end

When(/^I click the Confirm button on top of Edit\/Confirm statement window$/) do
  @EditAndConfirm_window.confirm_button.click
end

Then(/^alert window appears with title of "(.*?)" and message of "(.*?)"$/) do |title, description|
  @EditConfirmPrompt_window.alert_title.text.should eql title
  @EditConfirmPrompt_window.alert_description.text.should eql description
end

When(/^I click the Alert "(.*?)" button on Edit\/Confirm statement window$/) do |arg1|
  sleep(2)
  if arg1 == 'Yes'
    @EditConfirmPrompt_window.continue_button.click
  else
    @EditConfirmPrompt_window.cancel_button.click
  end
  sleep(2)
end

When(/^I click the Alert "(.*?)" button on the Are you sure window$/) do |arg1|
  sleep(2)
  if arg1 == 'Yes'
    @AreYouSurePrompt_window.alert_yes.click
  else
    @AreYouSurePrompt_window.alert_no.click
  end
  sleep(2)
end

When(/^The "(.*?)" window appears with message of "(.*?)"$/) do |title, description|
  sleep(2)
  @EditConfirmPrompt_window.alert_title.text.should eql title
  @EditConfirmPrompt_window.alert_description.text.should eql description

end

When(/^The Edit and Confirm window displays with message of "(.*?)"$/) do |description|
  sleep(1) # Hard coded sleep is needed because of the DOM refreshing
  wait_for(10) { @EditConfirmPrompt_window.alert_title.text.should eql 'Edit/Confirm' }
  wait_for(10) { @EditConfirmPrompt_window.edit_confirm_progress_bar.exists == false }
  @EditConfirmPrompt_window.alert_description.text.should eql description
rescue
  retry
end

When(/^The Edit and Confirm window displays with a message including "(.*?)"$/) do |description|
  sleep(10) # Hard coded sleep is needed because of the loading status
  wait_for(10) { @EditConfirmPrompt_window.alert_title.text.should eql 'Edit/Confirm' }
  @EditConfirmPrompt_window.alert_description.text.should include description
end

When(/^the Are You Sure window displays with message of "(.*?)"$/) do |description|
  @wait.until { !!@AreYouSurePrompt_window.alert_title.attribute('displayed')}
  @AreYouSurePrompt_window.alert_title.text.should eql 'Are you sure?'
  @AreYouSurePrompt_window.alert_description.text.should eql description
end

Then(/^The Edit and Confirm cancellation window displays$/) do
  sleep(1) # Hard coded sleep is needed because of the DOM refreshing
  wait_for(10) { @EditConfirmPrompt_window.alert_title.displayed? == true }
  @EditConfirmPrompt_window.alert_title.text.should eql 'Are you sure?'
end

When(/^I click the alert OK button on Are You Sure window$/) do
  @EditConfirmPrompt_window.are_you_sure_ok_button.click
end

When(/^I click the alert OK button on Saving Statements window$/) do
  @EditConfirmPrompt_window.saving_statements_ok_button.click
end

When(/^I click the alert OK button on Test Was Not Confirmed window$/) do
  @EditConfirmPrompt_window.cancel_button.click
end

When(/^I click the alert OK button on Edit\/Confirm window$/) do
  @EditConfirmPrompt_window.edit_confirm_ok_button.click
end

When(/^I click the alert continue button on Edit\/Confirm window$/) do
  @wait.until { !!@EditConfirmPrompt_window.continue_button.attribute('displayed') }
  @EditConfirmPrompt_window.continue_button.click
end

When(/^I click the alert cancel button on Edit\/Confirm window$/) do
  @wait.until { !!@EditConfirmPrompt_window.cancel_button.attribute('displayed') }
  @EditConfirmPrompt_window.cancel_button.click
end
