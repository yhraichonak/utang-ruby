Before do
  @Welcome_screen = Welcome_screen.new selenium, appium
  @Menu = Menu.new selenium, appium
end

Then(/^I should see the Test Welcome Screen$/) do
  expect(@Welcome_screen.title_text.text).to eq "WELCOME"
end

Then(/^I should see the AS1 Logo on the Welcome Screen$/) do
  @wait.until { @Welcome_screen.as1_logo.name == "WELCOME_logo.png" }
  expect(@Welcome_screen.as1_logo.name).to eq "WELCOME_logo.png"
end

Then(/^I should see the Welcome screen$/) do
  @wait.until { @Welcome_screen.title_text.displayed? == true }
   begin
    @appiumDriver.alert_accept
    puts "displayed the alert"
  rescue StandardError => e
    if $debug_flag == "debug"
     puts "alert not found #{e}"
    end
  end
   
  expect(@Welcome_screen.title_text.text).to eq "WELCOME"
end

Then(/^I should see WELCOME displayed in the screen header$/) do
  @wait.until { @Welcome_screen.title_text.displayed? == true }  
  expect(@Welcome_screen.title_text.text).to eq "WELCOME"
end

And(/^I should see the "(.*?)" disclaimer "(.*?)"$/) do | which, message |
  @wait.until { @Welcome_screen.title_text.displayed? == true } 
 
  if $device_version == "13.7"
   messages = @Welcome_screen.as1_disclaimer
  else   
   messages = @Welcome_screen.as1_disclaimer14
  end
  
  #puts "+++++++++++"
  #puts messages["message_one"].text
  #puts messages["message_two"].text
  #puts "+++++++++++"
  
  if which == "first"
    expect(messages["message_one"].text).to eq message
    #expect(messages["message_one"].text).to include second_part
  elsif which == "second"
    expect(messages["message_two"].text).eq include message
    #expect(messages["message_two"].text).to include second_part
  else
    expect { raise "oops" }.to raise_error
  end
end

And(/^I should see the Sign In button$/) do
 expect(@Welcome_screen.signIn_button.name).to eq "Sign In"
end

And(/^I should see the Reset Password button$/) do
 expect(@Welcome_screen.reset_password_button.name).to eq "Reset Password"
end

Then(/^I click the Sign In button$/) do
  @wait.until { @Welcome_screen.signIn_button.displayed? == true }
  element = @Welcome_screen.signIn_button
  #Common.click_center_of_object(element) 
  element.click
end

Then(/^I should see the utang Credentials window prompt$/) do
  @wait.until { @Welcome_screen.alert_window.displayed? == true } 
  @Welcome_screen.alert_window.name.should eql "utang Credentials"
end

When(/^I enter "(.*?)" in username field$/) do |username|
  @wait.until { @Welcome_screen.username_textfield.displayed? == true }
	begin	
		for i in 0..5
   value = @Login_screen.keyboard.visible
   #puts value 
			if @Welcome_screen.keyboard.visible.to_s == "true"
				break
			else
				KEYBOARD.toggle_hardware_keyboard		
				break
			end
			
			if @Welcome_screen.keyboard.visible.to_s == 'true'
        puts @Welcome_screen.keyboard.visible
				break
			end
		end
	rescue StandardError => e

	end
	
  @Welcome_screen.username_textfield.send_keys username
end

When(/^I enter "(.*?)" in password field$/) do |password|
  @wait.until { @Welcome_screen.password_textfield.displayed? == true }
  @Welcome_screen.password_textfield.send_keys password
end

Then(/^I click the Sign In cell$/) do  
  @wait.until { @Welcome_screen.signIn_cell.displayed? == true }
  element = @Welcome_screen.signIn_cell  
  element.click  
end

Then(/^the utang Would Like to Send You Notifications Alert window displays$/) do
  @wait.until { @Menu.alert_element.displayed? == true }
  expect(@Menu.alert_element.displayed?).should be
end

When(/^I click the Alert Allow Notifications button$/) do 
  @wait.until { @Menu.allow_button.displayed? == true }
  element = @Menu.allow_button  
  element.click
end

Then(/^the Sign In button displays$/) do
  expect(@Welcome_screen.signIn_button).should be
end

Then(/^the Reset Password button displays$/) do
  expect(@Welcome_screen.resetPassword_button).should be
end

Then(/^the utang logo displays$/) do
  expect(@Welcome_screen.as1_logo).should be
end

Then(/^the utang disclaimer displays$/) do
  expect(@Welcome_screen.as1_disclaimer).should be
  puts @Welcome_screen.as1_disclaimer.value
end

Then(/^WELCOME displays$/) do
  expect(@Welcome_screen.welcome_textView).should be
end