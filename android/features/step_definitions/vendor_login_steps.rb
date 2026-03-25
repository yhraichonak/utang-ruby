Before do
  @VendorLogIn_screen = VendorLogIn_screen.new selenium, appium
  @Log_In_screen = Log_In_screen.new selenium, appium
end

And(/^I should complete the vendor login$/) do
  sleep 2
  muse = false
  begin
	if @VendorLogIn_screen.title.exists == true
		if @VendorLogIn_screen.title.text == "Muse"
			muse = true
		else
			muse = false
			break
		end
	end
  rescue => e
	if(e)
		puts "The Vendor Login was not found"
	end
  end

  if(muse == true)
		expect(@VendorLogIn_screen.title.text).to eq "Muse"
		expect(@VendorLogIn_screen.message.text).to eq "Please provide valid Vendor Credentials"

		@VendorLogIn_screen.username_editText.send_keys("allprivileges")
		@VendorLogIn_screen.password_editText.send_keys("XXXXX")
		@VendorLogIn_screen.login_button.click
		sleep 4
  end
end

Then(/^I login with username "(.*?)" and "(.*?)" password$/) do |username, password|
	username=process_param(username)
	password=process_param(password)
	if(@Log_In_screen.username_field.exists)
		steps %{
		Then I should see the Login window
		When I enter username "#{username}"
		And I enter password "#{password}"
		And click Login button
		}
	end
end

Then(/^Vendor login screen displays$/) do
  expect(@VendorLogIn_screen.title.text).to eq "Muse"
	expect(@VendorLogIn_screen.message.text).to eq "Please provide valid Vendor Credentials"
end

And(/^I should complete the invalid vendor login$/) do
  sleep 2
  muse = false
  begin
	if(@VendorLogIn_screen.title.exists == true)
		if(@VendorLogIn_screen.title.text == "Muse")
			muse = true
		else
			muse = false
			break
		end
	end
  rescue => e
	if(e)
		puts "The Vendor Login was not found"
	end
  end

  if(muse == true)
	expect(@VendorLogIn_screen.title.text).to eq "Muse"
	expect(@VendorLogIn_screen.message.text).to eq "Please provide valid Vendor Credentials"

	@VendorLogIn_screen.username_editText.send_keys("devadmin")
	@VendorLogIn_screen.password_editText.send_keys("XXXXX")
	@VendorLogIn_screen.login_button.click
  end

	 #for i in 0..5
	 #	sleep 1

	 #	begin
	 #		if(@VendorLogIn_screen.message.exists)
	 #			expect(@VendorLogIn_screen.title.text).to eq "Muse"
	 #			expect(@VendorLogIn_screen.message.text).to eq "Please provide valid Vendor Credentials"
	 #			break
	 #		end
	 #	rescue
	 #		i
	 #	end
	 #end
end
