Before do
  @ConversationList_screen = ConversationList_screen.new selenium, appium
  @smContactList_screen = SMContactList_screen.new selenium, appium
  @Conversation_screen = Conversation_screen.new selenium, appium
  @Keyboard = Keyboard.new selenium, appium
  $r_num = rand(9999999..999999999)
end

Then(/^I delete the iOS automated messages$/) do
    server = 'QA-FED-HOST-2'
    database = 'utangServer'
    username = 'utangServerUser'
    password = 'utang'

    client = TinyTds::Client.new :username => username, :password => password,
        :host => server, :port => 1433, :database => database, :azure => false

    tsql = "DELETE FROM [utangServer].[dbo].[Message] WHERE [Text] LIKE '%iOS test%' "
    result = client.execute(tsql)
    result.each do |row|
        puts row
    end
end

Then(/^I should see the Secure Messaging Conversation Center$/) do
  found = false

  for i in 0..5
	begin
		if(@ConversationList_screen.navigation_bar.displayed?)
			expect(@ConversationList_screen.navigation_bar.displayed?).to be_truthy
			break
		else

      if found == true
        break
      end
		end
	rescue StandardError => e
		i
	end
	if found == true
        break
  end
  end
end

When(/^I click the New button$/) do
  #  for i in 0..5
  #	begin
  #		if(@ConversationList_screen.add_button.displayed?)
  #			element = @ConversationList_screen.add_button
  #			Common.click_center_of_object(element)
  #			break
  #		else

  #		end
  #	rescue StandardError => e
  #		i
  #	end
  #  end

  element = @ConversationList_screen.add_button
  puts element.name
  Common.click_center_of_object(element)
end

When(/^I click the "(.*?)" conversation$/) do |person|
  patient=process_param(person)
  @wait.until { @Conversation_screen.conversation_table.displayed? == true}
  sleep(2)
  for i in 0..5
	begin
    convo = @ConversationList_screen.conversation_tableCell(patient)
    #element = @ConversationList_screen.conversation_tableCell(person)
    #Common.click_center_of_object(element)
    convo.click
    puts "just clicked the converstaion for #{patient}"

	rescue StandardError => e
		i
		puts "did not find it"
	end
  end
end

Then(/^I should see the Contact List for all privileged utang users$/) do

  expect(@smContactList_screen.header_staticText.displayed?).to be_truthy

end

When(/^I select "(.*?)" from the user list$/) do |which_patient|
  patient=process_param(which_patient)

  contact_textbox = @smContactList_screen.searc_field
  puts "i found the textbox #{contact_textbox.visible}"
  Common.click_center_of_object(contact_textbox)


  if $debug_flag == "debug"
    puts "clicked in the text field"
  end

  begin
    found = false

		for i in 0..3
      value = @Login_screen.keyboard.visible
      if $debug_flag == "true"
        puts "the value of the keyboard visible = #{value}"
      end
			if value.to_boolean == true
        found = true
				break
			else
				KEYBOARD.toggle_hardware_keyboard

			end

			value = @Login_screen.keyboard.visible

			if value.to_boolean == true
        found = true
				break
			end
      if found == true
        break
      end
		end

  rescue StandardError => e

  end
  puts "about to enter user name"


  contact_textbox.send_keys(patient)
  puts 'just entered the user'


  puts "about to click the name = #{patient}"
  element = @smContactList_screen.contact_tableCell(patient)
  puts "just clicked the name"
  if $debug_flag == "debug"
    puts "the conctact name is: #{element.text}"
  end
  Common.click_center_of_object(element)
end

Then(/^I should see that users Conversation window$/) do
end

And(/^I should see "(.*?)" in the list of messages$/) do |message|
  expect(@Conversation_screen.conversation_tableCells(message)).to be_truthy
end

Then(/^the "(.*?)" conversation screen should display$/)  do |name|
  patient=process_param(name)
  for i in 0..5
	begin
		if(@Conversation_screen.navigation_bar(patient).displayed?)
      puts @Conversation_screen.navigation_bar(patient).name
			expect(@Conversation_screen.navigation_bar(patient).name).to eq patient
			break
		else

		end
	rescue StandardError => e
		i
	end
  end
end

Then(/^the message "(.*?)" displays on the screen$/) do |message|
	@appiumDriver.hide_keyboard
  msg = @Conversation_screen.message_text(@msg)

  # puts "trying to find the message"
  # puts @msg
  # puts msg

  expect(msg.displayed?).to be_truthy
  expect(msg.text).to include @msg
end

Then(/^I should see the share monitor message screen$/) do
  expect(@Conversation_screen.message_enter_text.displayed? == true)
  expect(@Conversation_screen.message_share_label.displayed? == true)
end

When(/^I type the message "(.*?)"$/) do |message|
	@msg = "#{message} - #{$r_num}"
  puts "message should be #{@msg}"
  text_field = @Conversation_screen.message_enter_text
  sleep(2)
  @wait.until { text_field.displayed? == true }

	text_field.send_keys @msg
end

When(/^click the Send button$/) do
  @wait.until { @Conversation_screen.send_button.displayed? == true }

  @Conversation_screen.send_button.click
  sleep 2
  # @Keyboard.return_button.click
  # sleep 2
end

Then(/^the message appears on the screen that was just entered to that user$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see the share monitor message for "(.*?)"$/) do |which_patient|
  sleep 5
  button_displayed = @Conversation_screen.send_button.displayed?
  patient=process_param(which_patient)
  @wait.until { button_displayed == true }

  message = "Tap to open monitor for " + patient
  $SHARE_MESSAGE = @Conversation_screen.message_with_share(@msg, message)

  expect($SHARE_MESSAGE.name).to include message
end

When(/^I click on the share message for "(.*?)"$/) do |which_patient|
  patient=process_param(which_patient)
  message = "Tap to open monitor for " + patient
  @appiumDriver.swipe(:direction => "up")
  # @appiumDriver.hide_keyboard unless $is_7x_version
  obj = @Conversation_screen.message_with_share(@msg, message)
  obj.click
end

When(/^I turn the On Call button "(.*?)"$/) do |status|
  @wait.until { @SiteList_screen.notifications_switch.displayed? == true }
  sleep 3
  element = @SiteList_screen.notifications_switch
  value = nil
  puts "value: #{element.value} + status: #{status}"
  if status == "on"
    sleep 2
    value = 1
    if element.value.to_i == 0
      puts "clicking on"
      element.click
      puts "this is the value after click: #{element.value}"
      if element.value.to_i == 0
        element.click
        puts "Second try this is the value: #{element.value}"
      end
    elsif element.value.to_i == 1
      puts "its already on"
    end
  end
  if status == "off"
    sleep 2
    value = 0
    if element.value.to_i == 1
      puts "clicking off"
      sleep 2
      element.click
      puts "this is the value after click: #{element.value}"
      if element.value.to_i == 1
        element.click
        puts "Second try this is the value: #{element.value}"
      end
    elsif element.value.to_i == 0
      puts "its already off"
    end
  end
  expect(element.value.to_i == value)
end

Then(/^I should see the On Call button "(.*?)"$/) do |status|
  element = @SiteList_screen.notifications_switch
  if status == "enabled"
    expect(element.enabled == true)
  elsif status == "disabled"
    expect(element.enabled == false)
  end
end

When(/^I should see ON CALL displayed in List of List window$/) do
  sleep 3
  @wait.until { @ListOfLists_window.list_button("ON CALL") }
	expect(@ListOfLists_window.list_button("ON CALL").displayed? == true)
end

When(/^I should not see ON CALL displayed in List of List window$/) do
  list_text = @ListOfLists_window.list_of_lists_text
  @wait.until { list_text }

	for i in 0..(list_text.count - 1)
    expect(list_text[i].text.include? "ON CALL" ).to be_falsey
  end
end
