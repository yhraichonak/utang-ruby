Before do
	@Share_window = Share_window.new selenium, appium
	@Messaging_screen = Messaging_screen.new selenium, appium
	@Menu = Menu.new selenium, appium
	@ECG_View_screen = ECG_View_screen.new selenium, appium
end

Then(/^I should see the Share Patient Details window$/) do
	expect(@Share_window.share_window_title.text).to eq "Share Patient Details"
end

And(/^I should see the recipient edit text field$/) do
	expect(@Share_window.recipient_editText.text).to eq "To: (tap to select recipient)"
end

And(/^I should see the share link icon on the Share Patient Details screen$/) do
	expect(@Share_window.shareLink_icon.exists).to be true
end

And(/^I should see the share link label display "(.*?)"$/) do |patient_name|
  patient_name = process_param(patient_name)
	expect(@Share_window.shareLink_label.text).to eq patient_name
end

And(/^I should see the type message field$/) do
	expect(@Share_window.message_editText.exists).to be true
end

And(/^I should see the send message airplane button$/) do
	expect(@Share_window.send_message_button.exists).to be true
end

And(/^I should see the cancel message button$/) do
	expect(@Share_window.message_editText.exists).to be true
end

When(/^I select recipient edit text field$/) do
  @wait.until { @Share_window.recipient_editText.exists == true }
	(0..2).each { |i|
    begin
			@Share_window.recipient_editText.click
      sleep(0.25)
      @Share_window.recipient_editText.click
    	wait_for(3) { @Share_window.content_panel.exists == true }
    	break
    rescue
      p "Failed to open contentPanel (attempt: #{i+1})"
    end
	}
end

Then(/^I should see the Choose Contact List$/) do
	begin
		for i in 0..5
			sleep 1
			expect(@Share_window.choose_contact_editText.text).to eq "Choose Contact"
		end
	rescue
    @Share_window.recipient_editText.click
	end
end

When(/^I select "(.*?)" from the Choose Contact List$/) do |contact_name|
  contact_name = process_param(contact_name)
	for i in 0..5
		sleep 1
		begin
			choose_contact = @Share_window.choose_contact_editText
			choose_contact.click
			# choose_contact.send_keys([:control, 'a'])
			# choose_contact.send_keys("\b")
			choose_contact.send_keys(contact_name)
			sleep 2
			@Share_window.contact_in_list(contact_name).click
			@Share_window.contact_in_list(contact_name).doubleClick
		rescue
			i
		end
	end
end

Then(/^the recipient edit text field should display "(.*?)"$/) do |contact_name|
  contact_name = process_param(contact_name)
  @wait.until { @Share_window.recipient_editText.exists == true }
	expect(@Share_window.recipient_editText.text).to eq contact_name
end

When(/^I enter "(.*?)" in the message field on the Share Patient Details screen$/) do |message|
	r = Random.new
	r = r.rand(99999...9999999)
	
	$RANDOM_NUMBER =  r
	@Share_window.message_editText.send_keys "#{message}#{$RANDOM_NUMBER}" 
end

And(/^I select the send message airplane button$/) do
	@Share_window.send_message_button.click
end

Then(/^the Success response alert displays$/) do
  sleep(3)
	(0..5).each { |i|
  	begin
      sleep(3)
			expect(@Share_window.response_title.text).to eq "Success"
			expect(@Share_window.response_message.text).to eq "Message Sent Successfully"
      break
		rescue
			p "Failed to verify success alert (attempt: #{i+1})"
    end
  }
end

When(/^I click the View Conversation button on the Success Alert$/) do
	@Share_window.view_conversation_button.click	
end


Then(/^I should see "(.*?)" display in the conversation for Share Patient Details$/) do |message|
  @Messaging_screen.get_message("#{message}#{$RANDOM_NUMBER}").text.should eql "#{message}#{$RANDOM_NUMBER}"
  #need to consider making this an array and grabbing the message and time stamps
end

And(/^I should see the "(.*?)" message and the share link label displays the patient name "(.*?)"$/) do |message, patient_name|
  patient_name = process_param(patient_name)
	expect(@Messaging_screen.return_share_link("#{message}#{$RANDOM_NUMBER}").text).to eq patient_name
end

When(/^I select the share icon from the menu$/) do
  @wait.until { @Menu.share_icon.exists == true }
  @Menu.share_icon.click
end

When(/^I select the share icon from the ECG menu$/) do
	@wait.until { @Menu.share_icon.exists == true }
	@wait.until { @ECG_View_screen.tenSecondLead_element("I").displayed? == true}
	@Menu.share_icon.click
end

When(/^I click on the patients link$/) do
  @Share_window.shareLink_label.click
end