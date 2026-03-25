Before do
  @EditConfirmStatement_window = EditConfirmStatement_window.new selenium, appium
  @AddStatement_window = AddStatement_window.new selenium, appium
end

Then(/^I should see the test was already confirmed window$/) do
  expect(@EditConfirmStatement_window.test_already_condirmed_window.text).to include "This test was already confirmed by Admin"
end

Then(/^I should see the Edit\/Confirm statement window with following statements in order$/) do |table|
  row = 1
  
  #puts @EditConfirmStatement_window.statementMessage_staticText(0).name
  #puts @EditConfirmStatement_window.statementMessage_staticText(1).name
  #puts @EditConfirmStatement_window.statementMessage_staticText(2).name
  
  # if($P_NAME == "test_data: overwrite prompt patient")
	 #expect(@EditConfirmStatement_window.statementMessage_staticText(1).name).to eq QA_Site_34.overwrite_prompt["ecg_one"]
	 #expect(@EditConfirmStatement_window.statementMessage_staticText(2).name).to eq QA_Site_34.overwrite_prompt["ecg_two"]
	 #expect(@EditConfirmStatement_window.statementMessage_staticText(3).name).to eq QA_Site_34.overwrite_prompt["ecg_three"]
  # else

  expectedData = table.hashes
  
  statement_count = @EditConfirmStatement_window.getCountOfStatements
  puts "count of statements = #{statement_count}"
  
	statement_count.should eql expectedData.count
	
	expectedData.each do |statement|
		#puts statement[:diag_statement]
		#puts  @EditConfirmStatement_window.statementMessage_staticText(row).name
		#puts @EditConfirmStatement_window.statementMessageRemove_switch(row).visible
		#puts @EditConfirmStatement_window.statementMessageReorder_button(row).visible
		puts "++"
		puts statement[:diag_statement]
		puts "++"
	  @EditConfirmStatement_window.statementMessage_staticText(row).name.should include statement[:diag_statement]
	  @EditConfirmStatement_window.statementMessageRemove_switch(row).visible.to_s.should eq "true"
	  @EditConfirmStatement_window.statementMessageReorder_button(row).visible.to_s.should eq "true"
	  row += 1
	end

  #end
  
  #need to look into what this is/////??????????????
  #@EditConfirmStatement_window.statementMessageAdd_staticText.exists.should be true
  
end

When(/^I click the add statement button$/) do
  #row = @EditConfirmStatement_window.getCountOfStatements + 1
  
  #if @EditConfirmStatement_window.statementMessageAdd_staticText(1).visible == false
  #  @seleniumDriver.execute_script 'mobile: scroll', :direction => 'down'
  #end
  
  element = @EditConfirmStatement_window.statementMessageAdd_staticText
  Common.click_center_of_object(element)
end

Then(/^the statement add message window should display$/) do
  @AddStatement_window.statementMessageEdit_staticText.nil?.should be false
end

When(/^I type "(.*?)" into the statement add window$/) do |text|
  if desired_capabilities['deviceName'].include? 'iPad'
    @AddStatement_window.statementMessageEdit_staticText.send_keys(text)
     
  else
    @AddStatement_window.statementMessageEdit_staticText.send_keys(text)

    #@AddStatement_window.statementSearchClear_button.click
    #@AddStatement_window.statementMessageEdit_staticText.send_keys(text)
   
  end
end

When(/^I click on row (\d+) of search results$/) do |row|
  if desired_capabilities['deviceName'].include? 'iPad'
    row = row.to_i-1
  end
  
  begin
    element = @AddStatement_window.statementSearchResults_cell(row)
    Common.click_center_of_object(element)
  rescue StandardError => e
    #iPad dont select anything if window doesnt exist
  end
end

When(/^I click the done button in statement add window$/) do
  element = @AddStatement_window.done_button
  Common.click_center_of_object(element)
end

When(/^I hold and drag statement on row (\d+) to row (\d+) on screen$/) do |row_from, row_to|
  #Appium::TouchAction.new.move_to(element: @EditConfirmStatement_window.statementMessageReorder_button(row_from)).perform
  
  #@EditConfirmStatement_window.statementMessageReorder_button(row_from).scrollTo
  #locationFrom = @EditConfirmStatement_window.statementMessageReorder_button(row_from).location
  #locationTo = @EditConfirmStatement_window.statementMessageReorder_button(row_to).location
  
  #selenium.execute_script 'mobile: swipe', :startX => locationFrom[:x], :startY => locationFrom[:y], :endX => locationTo[:x], :endY => locationTo[:y], :duration => 2
  #Appium::TouchAction.new.press(x: 250, y: 650).wait(1).move_to(x: 0, y: -550).release.perform
  #Appium::TouchAction.new.press(x: locationFrom[:x], y: locationFrom[:y]).wait(2000).move_to(x: 0, y: -(locationTo[:y]-locationFrom[:y])).release.perform
  Appium::TouchAction.new.press(:element => @EditConfirmStatement_window.statementMessageReorder_button(row_from.to_i)).wait(3000).move_to(:element => @EditConfirmStatement_window.statementMessageReorder_button(row_to.to_i)).release.perform
  #selenium.execute_script("target.dragFromToForDuration({x:#{locationFrom[:x]}, y:#{locationFrom[:y]}}, {x:#{locationTo[:x]}, y:#{locationTo[:y]}}, 2);")

end

When(/^I click the minus statement button on row (\d+)$/) do |row|
  element = @EditConfirmStatement_window.statementMessageRemove_switch(row.to_i)
  Common.click_center_of_object(element)
end

When(/^I click the delete statement button on row (\d+)$/) do |row|

	element = @EditConfirmStatement_window.statementMessageDelete_button(row.to_i)
	Common.click_center_of_object(element)
	 #@appiumDriver.action.move_to(button).click.perform
end

When(/^I click the Cancel button on top left of Edit\/Confirm statement window$/) do
  element = @EditConfirmStatement_window.cancel_button
  #Common.click_center_of_object(element)
  element.click
end

Then(/^Undo Edits window displays on screen$/) do

  #@EditConfirmStatement_window.undoEdits_button.visible.should be false
  #
  #if desired_capabilities['deviceName'].include? 'iPhone'
  #  @EditConfirmStatement_window.undoEditsCancel_button.exists.should be true
  #end
  message = "Any information you edited will be undone. Are you sure you want to undo edits?"
  #puts message
  #puts @EditConfirmStatement_window.undo_message_text.text
  expect(@EditConfirmStatement_window.undo_message_text.text).to eq message
end

When(/^I click the Cancel button in Undo Edits window$/) do
  element = @EditConfirmStatement_window.undoEditsCancel_button
  Common.click_center_of_object(element)
end

When(/^I click the Undo Edits button in Undo Edits window$/) do
  element = @EditConfirmStatement_window.undoEdits_button
  Common.click_center_of_object(element)
end

When(/^I click the Confirm button on top right of Edit\/Confirm statement window$/) do
  element = @EditConfirmStatement_window.confirm_button
  Common.click_center_of_object(element)
end

Then(/^alert window appears with title of "(.*?)" and message of "(.*?)"$/) do |title, message|
  for i in 0..5
	begin
		if(@EditConfirmStatement_window.alert_header.displayed?)
			expect(@EditConfirmStatement_window.alert_header.name).to eq title
			if not message == ''
				expect(@EditConfirmStatement_window.alert_description.name).to eq message
			end
			break
		else
		
		end
	rescue StandardError => e
		i
	end
  end  
end

Then(/^the alert window displays with title of test was already confirmed$/) do
 
  message_one = "This test was already confirmed by Morgan, Chris. Do you wish to continue?"
  message_two = "This test was already confirmed by Admin, Dev. Do you wish to continue?"
		
  expect(@EditConfirmStatement_window.alert_header.name).to eq(message_one).or eq(message_two)  
end

When(/^I click the Alert Cancel button on Edit\/Confirm statement window$/) do

  element = @EditConfirmStatement_window.alertCancel_button
  Common.click_center_of_object(element)
end

When(/^I click the Alert Confirm button on Edit\/Confirm statement window$/)  do
  
  for i in 0..5
	begin
		if(@EditConfirmStatement_window.alertConfirm_button.displayed?)
			puts "displayed"
			element = @EditConfirmStatement_window.alertConfirm_button
			Common.click_center_of_object(element)
			break
		else
		
		end
	rescue StandardError => e
		i
	end
  end
end

When(/^I click the Alert Continue button$/)  do
  element = @EditConfirmStatement_window.alert_continue
  Common.click_center_of_object(element)
end

When(/^I click the alert OK button on Edit\/Confirm statement window$/) do
  element = @EditConfirmStatement_window.alertOk_button
  Common.click_center_of_object(element)
end

When(/^I click the alert OK button on Edit\/Confirm statement window for confirmECG.feature$/) do
  element = @EditConfirmStatement_window.alertOk_button
  Common.click_center_of_object(element)
  sleep(30)
end

When(/^I click the alert Continue button on Edit\/Confirm statement window$/) do
  element = @EditConfirmStatement_window.alertContinue_button
  Common.click_center_of_object(element)
 
end