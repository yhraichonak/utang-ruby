Before do
  @Messaging_screen = Messaging_screen.new selenium, appium
  @Menu = Menu.new selenium, appium
  @ChooseContact_window = ChooseContact_window.new selenium, appium
  @Selector_window = Selector_window.new selenium, appium
  @ECG_View_screen = ECG_View_screen.new selenium, appium
  @selenium = selenium
  
  $RANDOM_NUMBER = nil
  $ECG_LINK = nil
  $ECG_RANDOM_NUMBER
end

When(/^I click the more options button$/) do
	@Menu.more_options_button.click
end

When(/^I enter "(.*?)" into the choose contact edit text$/) do |person|
  person = process_param(person)
  @ChooseContact_window.choose_contact_edit_text.send_keys(person)
  sleep(2)
end

Then(/^I should see "(.*?)" in the choose contact edit text$/) do |person|
  person = process_param(person)
  wait_for(5) { expect(@ChooseContact_window.choose_contact_edit_text.text).to eq person }

end

Then(/^I should see the Messaging screen$/) do
  sleep(3)
  expect(@Messaging_screen.title.text).to eq "SECURE MESSAGING"
  # expect(@Messaging_screen.message_list_count).to be > 0
end

When(/^I click the New Message button$/) do
  begin
    retries ||= 0
    sleep(1)
    @Messaging_screen.new_msg_button.click
  rescue
    retry if (retries += 1) < 3
  end
end

Then(/^I should see the Choose Contact window$/) do
  wait_for(5) { @ChooseContact_window.title.text.should eql "Choose Contact" }
end

When(/^I click on "(.*?)"$/) do |person|
  person = process_param(person)
  @ChooseContact_window.contact_list(person).click
end

When(/^I click on the first person in the Contact List$/) do
  @ChooseContact_window.contact_list_by(index=0).click
end

Then(/^I should see the user conversation screen$/) do
  @Messaging_screen.message_field.exists.should be true
end

When (/^I enter "(.*?)" in the message field for "(.*?)"$/) do |message, name|
  name = process_param(name)
  r = Random.new
  r = r.rand(99999...9999999)
  $RANDOM_NUMBER =  r
  @Messaging_screen.message_field.send_keys("#{message}#{name}#{$RANDOM_NUMBER}")
end

When (/^I enter "(.*?)" in the message field$/) do |message|
  r = Random.new
  r = r.rand(99999...9999999)
  $RANDOM_NUMBER =  r
  @Messaging_screen.message_field.send_keys("#{message}#{$RANDOM_NUMBER}")
end

And(/^I click the send message button$/) do
  @Messaging_screen.send_message_button.exists.should be true
  @Messaging_screen.send_message_button.click
end

Then(/^I should see "(.*?)" display in the conversation for "(.*?)"$/) do |message, name|
  name = process_param(name)
  @wait.until { @Messaging_screen.send_message_button.exists.should eq true }
  message = "#{message}#{name}#{$RANDOM_NUMBER}"
  @Messaging_screen.get_last_message_in_list.text.should eql message
end

Then(/^I should see "(.*?)" display in the conversation$/) do |message|
  @wait.until { @Messaging_screen.send_message_button.exists.should eq true }
  message = "#{message}#{$RANDOM_NUMBER}"
  @Messaging_screen.get_last_message_in_list.text.should eql message
end

When(/^I select "(.*?)" from the conversation list/) do |name|
  name = process_param(name)
  @Messaging_screen.conversation_list(name).click
end

When(/^I select the first user from the Messaging screen/) do
  @Messaging_screen.conversation_list_first_user.click
end

Then(/^I should see the conversation window$/) do
  @Messaging_screen.message_field.exists.should be true
  if @Messaging_screen.conversation_message_count > 0
    next
  elsif @Messaging_screen.conversation_container.exists.should be true
    next
  else
    raise "ERROR: Conversation window not displayed."
  end
end

When(/^I click the logout button$/) do
	@Menu.logout_button.click
  sleep(2)
end

When(/^I click hardware back button on the conversation screen$/) do
  while @Messaging_screen.message_field.exists == true
	  selenium.navigate.back
  end
end

Then(/^I should see the site list$/) do
  expect(@Site_List_screen.navigation_bar).to be_truthy
  expect(@Site_List_screen.navigation_bar.text).to eq "Site List"
end

When(/^I click the Share button$/) do
  #@Menu.share_button.exists.should be true
  @Menu.share_button.click
end
  
And(/^click the utang ONE Secure Messaging button$/) do
  #@Menu.as_one_secure_message_button.exists.should be true
  @Menu.as_one_secure_message_button.click
end

Then(/^I should make note of the ecg link$/) do
  $ECG_LINK = @Messaging_screen.message_field.text
  ##puts $ECG_LINK
  r = Random.new
  r = r.rand(99999999...9999999999)

  $ECG_RANDOM_NUMBER =  r
  ##puts $ECG_RANDOM_NUMBER
  sleep(2)
  @Messaging_screen.message_field.send_keys "#{$ECG_LINK} #{$ECG_RANDOM_NUMBER}"
  sleep(2)
end

Then(/^I should see "(.*?)" in the conversation$/) do |message|  
  #@Messaging_screen.get_message(message).text.should eql message
  ##puts "ecg random number = "
  ##puts $ECG_RANDOM_NUMBER
  @Messaging_screen.get_ecg_message($ECG_RANDOM_NUMBER).text.should eql message
end

Then(/^I should see ecg shared in the conversation "(.*?)"$/) do |message|
  @Messaging_screen.get_ecg_message($ECG_RANDOM_NUMBER).text.should eql message
end

When(/^I click on the ecg share link "(.*?)"$/) do |message|
  @Messaging_screen.get_ecg_message($ECG_RANDOM_NUMBER).click
end

Then(/^I should see the complete action using window$/) do
  @Selector_window.selector_title.text.should eql "Complete action using"
end
  
When(/^I click the utang One button$/) do
  @Selector_window.as_one_button.text.should include "utang ONE"
  @Selector_window.as_one_button.click
end

And(/^I click the Just once button$/) do
  #@Selector_window.just_once_button.text.should eql "Just once"
  #@Selector_window.just_once_button.click
end

When(/^I tap off of the list of lists$/) do
  @ECG_View_screen.tap_off_of_list
end
