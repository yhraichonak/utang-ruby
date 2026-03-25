Before do
  @GS_api = GS_api.new
end

Then(/^it should signon ios device with username tag$/) do
  payload = JSON.generate(:deviceId => $ios_device_id, :deviceModel => $iphone_type, :username => $ios_app_email, :password => $app_password)
  user_agent = "iOS"
  response = @GS_api.site_logon(payload, user_agent)

  expect(response["model"]["registrationCode"]).to match ("(.*)-(.*)")
  $IOS_REG_CODE = response["model"]["registrationCode"]
  puts $IOS_REG_CODE
end

Then(/^it should signon new ios device with username tag$/) do
  payload = JSON.generate(:deviceId => $new_ios_device_id, :deviceModel => $iphone_type, :username => $ios_app_email, :password => $app_password)
  user_agent = "iOS"
  response = @GS_api.site_logon(payload, user_agent)

  expect(response["model"]["registrationCode"]).to match ("(.*)-(.*)")
  $NEW_IOS_REG_CODE = response["model"]["registrationCode"]
  puts $NEW_IOS_REG_CODE
end

Then(/^it should signon new android device with username tag$/) do
  payload = JSON.generate(:deviceId => $new_android_id, :deviceModel => $android_type, :username => $ios_app_email, :password => $app_password)
  user_agent = "android"
  response = @GS_api.site_logon(payload, user_agent)

  expect(response["model"]["registrationCode"]).to match ("(.*)-(.*)")
  $NEW_ANDROID_REG_CODE = response["model"]["registrationCode"]
  puts $NEW_ANDROID_REG_CODE
end

Then(/^it should signon windows device with username tag$/) do
  payload = JSON.generate(:deviceId => $windows_device_id, :deviceModel => "windows", :username => $ios_app_email, :password => $app_password)
  user_agent = "windows"
  response = @GS_api.site_logon(payload, user_agent)
  
  expect(response["model"]["registrationCode"]).to match ("(.*)-(.*)")
  $WINDOWS_REG_CODE = response["model"]["registrationCode"]
  puts $WINDOWS_REG_CODE
end

Then(/^it should signon other ios device with tester9657648$/) do
  payload = JSON.generate(:deviceId => $other_device_id, :deviceModel => $iphone_type, :username => $other_email, :password => $app_password)
  user_agent = "iOS"
  response = @GS_api.site_logon(payload, user_agent)

  expect(response["model"]["registrationCode"]).to match ("(.*)-(.*)")
  $OTHER_REG_CODE = response["model"]["registrationCode"]
  puts $OTHER_REG_CODE
end

Then(/^it should not signon other ios device with invalid password$/) do
  payload = JSON.generate(:deviceId => $other_device_id, :deviceModel => $iphone_type, :username => $other_email, :password => "BADPASSWORD")
  user_agent = "iOS"
  response = @GS_api.site_logon(payload, user_agent)

  expect(response["responseCode"]).to eq 200
	expect(response["error"]["title"]).to eq "LoginFailed"
	expect(response["error"]["description"]).to eq "Login failed, please Sign In again"
end

Then(/^it should not signon with invalid username$/) do
  payload = JSON.generate(:deviceId => $other_device_id, :deviceModel => $iphone_type, :username => "BADUSER", :password => "BADPASSWORD")
  user_agent = "iOS"
  response = @GS_api.site_logon(payload, user_agent)
  
  expect(response["responseCode"]).to eq 200
	expect(response["error"]["title"]).to eq "LoginFailed"
	expect(response["error"]["description"]).to eq "Login failed, please Sign In again"
end

Then(/^it should return the site list for test@test.com new iOS device$/) do
  user_agent = "iOS"
  response = @GS_api.site_list($new_ios_device_id, $NEW_IOS_REG_CODE, user_agent)
  
  if $DEBUG_FLAG == "debug"
    puts response
  end
    
  expect(response["responseCode"]).to eq 0
	count = response["model"]["sites"].count
	
	for i in 0..(count - 1)
			if(response["model"]["sites"][i]["name"] == "35 QA Cardio PM")
				expect(response["model"]["sites"][i]["name"]).to eq "35 QA Cardio PM"
				expect(response["model"]["sites"][i]["licensedModules"][0]["name"]).to eq "Cardio"
				expect(response["model"]["sites"][i]["licensedModules"][1]["name"]).to eq "PM"
				#expect(response["model"]["sites"][i]["facilityId"]).to eq "QA35"
			elsif(response["model"]["sites"][i]["name"] == "50 QA Integration")
				expect(response["model"]["sites"][i]["name"]).to eq "50 QA Integration"
				expect(response["model"]["sites"][i]["licensedModules"][0]["name"]).to eq "Cardio"
				expect(response["model"]["sites"][i]["licensedModules"][1]["name"]).to eq "PM"
			elsif(response["model"]["sites"][i]["name"] == "39 QA GE WEB - CSG 231")
				expect(response["model"]["sites"][i]["name"]).to eq "39 QA GE WEB - CSG 231"
				expect(response["model"]["sites"][i]["licensedModules"][0]["name"]).to eq "OB"
				expect(response["model"]["sites"][i]["licensedModules"][1]["name"]).to eq "PM"
				#expect(response["model"]["sites"][i]["facilityId"]).to eq "QA39"
			elsif(response["model"]["sites"][i]["name"] == "34 QA Cardio PM")
        expect(response["model"]["sites"][i]["siteId"]).to eq 1763
        expect(response["model"]["sites"][i]["name"]).to eq "34 QA Cardio PM"
				expect(response["model"]["sites"][i]["licensedModules"][0]["name"]).to eq "Cardio"
				#expect(response["model"]["sites"][i]["licensedModules"][1]["name"]).to eq "OB"
				expect(response["model"]["sites"][i]["licensedModules"][1]["name"]).to eq "PM"
				#expect(response["model"]["sites"][i]["facilityId"]).to eq "QA34"
			end
	end
end

Then(/^it should not return the site list with empty reg code$/) do
  user_agent = "iOS"
  response = @GS_api.site_list($new_ios_device_id, "", user_agent)
  
  expect(response["responseCode"]).to eq 700
	expect(response["error"]["title"]).to eq "SignOnRequired"
	expect(response["error"]["description"]).to eq "Please Sign On"
end

Then(/^it should not return the site list with empty device_id$/) do
  user_agent = "iOS"
  response = @GS_api.site_list("", $NEW_IOS_REG_CODE, user_agent)
  if $DEBUG_FLAG == "debug"
    puts response
  end
  expect([0, 700]).to include response["responseCode"]
	#expect(response["error"]["title"]).to eq "SignOnRequired"
	#expect(response["error"]["description"]).to eq "Please Sign On"
end

Then(/^it should not return the site list with ivalid device_id$/) do
  user_agent = "iOS"
  response = @GS_api.site_list("INVALID-DEVICE", $NEW_IOS_REG_CODE, user_agent)
  if $DEBUG_FLAG == "debug"
    puts response
  end
  expect(response["responseCode"]).to eq 700
	expect(response["error"]["title"]).to eq "SignOnRequired"
	expect(response["error"]["description"]).to eq "Please Sign On"
end

Then(/^it should not return the site list with empty device_id and reg code$/) do
  user_agent = "iOS"
  response = @GS_api.site_list("", $NEW_IOS_REG_CODE, user_agent)
  if $DEBUG_FLAG == "debug"
    puts response
  end
  expect([0, 700]).to include response["responseCode"]
	#expect(response["error"]["title"]).to eq "SignOnRequired"
	#expect(response["error"]["description"]).to eq "Please Sign On"
end

Then(/^it should return the site list for test@test.com new android device/) do
  user_agent = "android"
  response = @GS_api.site_list($new_android_id, $NEW_ANDROID_REG_CODE, user_agent)
  
  expect(response["responseCode"]).to eq 0
	count = response["model"]["sites"].count
	
	for i in 0..(count - 1)
			if(response["model"]["sites"][i]["name"] == "35 QA Cardio PM")
				expect(response["model"]["sites"][i]["name"]).to eq "35 QA Cardio PM"
				expect(response["model"]["sites"][i]["licensedModules"][0]["name"]).to eq "Cardio"
				expect(response["model"]["sites"][i]["licensedModules"][1]["name"]).to eq "PM"
				#expect(response["model"]["sites"][i]["facilityId"]).to eq "QA35"
			elsif(response["model"]["sites"][i]["name"] == "50 QA Integration")
				expect(response["model"]["sites"][i]["name"]).to eq "50 QA Integration"
				expect(response["model"]["sites"][i]["licensedModules"][0]["name"]).to eq "Cardio"
				expect(response["model"]["sites"][i]["licensedModules"][1]["name"]).to eq "PM"
			elsif(response["model"]["sites"][i]["name"] == "39 QA GE WEB - CSG 231")
				expect(response["model"]["sites"][i]["name"]).to eq "39 QA GE WEB - CSG 231"
				expect(response["model"]["sites"][i]["licensedModules"][0]["name"]).to eq "OB"
				expect(response["model"]["sites"][i]["licensedModules"][1]["name"]).to eq "PM"
				#expect(response["model"]["sites"][i]["facilityId"]).to eq "QA39"
			elsif(response["model"]["sites"][i]["name"] == "34 QA Cardio PM")
				expect(response["model"]["sites"][i]["name"]).to eq "34 QA Cardio PM"
				expect(response["model"]["sites"][i]["siteId"]).to eq 1763
				expect(response["model"]["sites"][i]["licensedModules"][0]["name"]).to eq "Cardio"
				#expect(response["model"]["sites"][i]["licensedModules"][1]["name"]).to eq "OB"
				expect(response["model"]["sites"][i]["licensedModules"][1]["name"]).to eq "PM"
				#expect(response["model"]["sites"][i]["facilityId"]).to eq "QA34"
			end
	end
end

Then(/^it should return the site list for tester9657648@test other iOS device$/) do
  user_agent = "iOS"
  response = @GS_api.site_list($other_device_id, $OTHER_REG_CODE, user_agent)
  
  expect(response["responseCode"]).to eq 0
	count = response["model"]["sites"].count
	
	for i in 0..(count - 1)
			if(response["model"]["sites"][i]["name"] == "35 QA Cardio PM")
				expect(response["model"]["sites"][i]["name"]).to eq "35 QA Cardio PM"
				expect(response["model"]["sites"][i]["licensedModules"][0]["name"]).to eq "Cardio"
				expect(response["model"]["sites"][i]["licensedModules"][1]["name"]).to eq "PM"
				#expect(response["model"]["sites"][i]["facilityId"]).to eq "QA35"
			elsif(response["model"]["sites"][i]["name"] == "50 QA Integration")
				expect(response["model"]["sites"][i]["name"]).to eq "50 QA Integration"
				expect(response["model"]["sites"][i]["licensedModules"][0]["name"]).to eq "Cardio"
				expect(response["model"]["sites"][i]["licensedModules"][1]["name"]).to eq "PM"
			elsif(response["model"]["sites"][i]["name"] == "39 QA GE WEB - CSG 231")
				expect(response["model"]["sites"][i]["name"]).to eq "39 QA GE WEB - CSG 231"
				expect(response["model"]["sites"][i]["licensedModules"][0]["name"]).to eq "OB"
				expect(response["model"]["sites"][i]["licensedModules"][1]["name"]).to eq "PM"
				#expect(response["model"]["sites"][i]["facilityId"]).to eq "QA39"
			elsif(response["model"]["sites"][i]["name"] == "34 QA Cardio PM")
				expect(response["model"]["sites"][i]["name"]).to eq "34 QA Cardio PM"
				expect(response["model"]["sites"][i]["licensedModules"][0]["name"]).to eq "Cardio"
				expect(response["model"]["sites"][i]["licensedModules"][1]["name"]).to eq "OB"
				expect(response["model"]["sites"][i]["licensedModules"][2]["name"]).to eq "PM"
				#expect(response["model"]["sites"][i]["facilityId"]).to eq "QA34"
			end
	end
end

Then(/^it should check device for ios device$/) do
  user_agent = "iOS"
  response = @GS_api.check_device($ios_device_id, $IOS_REG_CODE, user_agent)

  expect(response["responseCode"]).to eq 0
	expect(response["model"]).to be_nil
	expect(response["error"]).to be_nil
end

Then(/^it should check device for android device$/) do
  user_agent = "android"
  response = @GS_api.check_device($new_android_id, $NEW_ANDROID_REG_CODE, user_agent)
  
  expect(response["responseCode"]).to eq 0
	expect(response["model"]).to be_nil
	expect(response["error"]).to be_nil
end

Then(/^it should not check device for android device invalid reg code$/) do
  user_agent = "android"
  response = @GS_api.check_device($new_android_id, "BADREGCODE", user_agent)
  
  expect(response["responseCode"]).to eq 700
	expect(response["error"]["title"]).to eq "SignOnRequired"
	expect(response["error"]["description"]).to eq "Please Sign On"
end

Then(/^it should not check device for android device invalid device$/) do
  user_agent = "android"
  response = @GS_api.check_device("INVALIDID", $NEW_ANDROID_REG_CODE, user_agent)
  
  expect(response["responseCode"]).to eq 700
	expect(response["error"]["title"]).to eq "SignOnRequired"
	expect(response["error"]["description"]).to eq "Please Sign On"
end

Then(/^it should get device from registration code$/) do
  user_agent = "iOS"
  response = @GS_api.get_device($IOS_REG_CODE, user_agent)

  expect(response["responseCode"]).to eq 0
  expect(response["model"]["id"]).to eq $ios_device_id
	expect(response["model"]["currentRegistrationCode"]).to eq $IOS_REG_CODE
	expect(response["model"]["isDisabled"]).to be false
	expect(response["model"]["pushNotificationToken"]).to match "(.*)"
	expect(response["model"]["mobilePlatform"]).to eq 1
end

Then(/^it return the client configuration$/) do
  user_agent = "iOS"
  response = @GS_api.httpclient_configurations($ios_device_id, $IOS_REG_CODE, user_agent)
  
  expect(response["responseCode"]).to eq 0
	expect(response["model"]["httpClientConfigurations"][0]["httpClientConfigId"]).to eq 0
	expect(response["model"]["httpClientConfigurations"][0]["baseURL"]).to eq "https://10.10.0.127/Fed-Web/api"
end

Then(/^it should register test user for push notification android device qa$/) do
  payload = JSON.generate(:deviceId => $new_android_id, :pushNotificationToken => $push_not_token_android, :registrationCode => $NEW_ANDROID_REG_CODE, :build => "qa")
  user_agent = "android"
  response = @GS_api.pushnotification_registration(payload, user_agent)
  
  expect(response["responseCode"]).to eq 0
	expect(response["model"]).to be_nil
	expect(response["error"]).to be_nil	
end

Then(/^it should register test user for push notification android device prod$/) do
  payload = JSON.generate(:deviceId => $new_android_id, :pushNotificationToken => $push_not_token_android, :registrationCode => $NEW_ANDROID_REG_CODE, :build => "production")
  user_agent = "android"
  response = @GS_api.pushnotification_registration(payload, user_agent)
  
  expect(response["responseCode"]).to eq 0
	expect(response["model"]).to be_nil
	expect(response["error"]).to be_nil	
end

Then(/^it should create a new user$/) do
  $NEW_ANDROID_USERNAME = "test#{$user_num.to_s}@test.com"
  payload = JSON.generate(:username => $NEW_ANDROID_USERNAME, :password => $app_password, :firstname => "Test#{$user_num.to_s}", :lastname => "User#{$user_num.to_s}", :phonenumber => "111-222-3333", :hospitalname => "hosp", :state => "TX", :devicetype => "android")
  user_agent = "android"
  response = @GS_api.user_account(payload, user_agent)
  
  expect(response["responseCode"]).to eq 0
	expect(response["model"]).to be_nil
	expect(response["error"]).to be_nil	
end

Then(/^it should not create an existing user$/) do
  payload = JSON.generate(:username => $ios_app_email, :password => $app_password, :firstname => "Test", :lastname => "User20", :phonenumber => "111-222-3333", :hospitalname => "hosp", :state => "TX", :devicetype => "Apple iOS")
  user_agent = "android"
  response = @GS_api.user_account(payload, user_agent)
  
 	expect(response["responseCode"]).to eq 210
	expect(response["error"]["title"]).to eq "UserNameAlreadyExists"
	expect(response["error"]["description"]).to eq "UserAccount has already been created using the specified username"
end

Then(/^it should signon with new android user created$/) do
  payload = JSON.generate(:deviceId => $android_id2, :deviceModel => $android_type, :username => $NEW_ANDROID_USERNAME, :password => $app_password)
  user_agent = "android"
  response = @GS_api.site_logon(payload, user_agent)

  expect(response["model"]["registrationCode"]).to match ("(.*)-(.*)")
  $NEW_ANDROID_USER_REG_CODE = response["model"]["registrationCode"]
  puts $NEW_ANDROID_USER_REG_CODE
end

Then(/^it should check device for new android user created$/) do
  user_agent = "android"
  response = @GS_api.check_device($android_id2, $NEW_ANDROID_USER_REG_CODE, user_agent)
  
  expect(response["responseCode"]).to eq 0
	expect(response["model"]).to be_nil
	expect(response["error"]).to be_nil
end

Then(/^it should return the site list for new android user created/) do
  user_agent = "android"
  response = @GS_api.site_list($android_id2, $NEW_ANDROID_USER_REG_CODE, user_agent)
  
  expect(response["responseCode"]).to eq 0
	expect(response["model"]["sites"].count).to be >= 1
	expect(response["error"]).to be_nil
end

Then(/^it should return the client configuration for new android user created$/) do
  user_agent = "iOS"
  response = @GS_api.httpclient_configurations($android_id2, $NEW_ANDROID_USER_REG_CODE, user_agent)
  
  expect(response["responseCode"]).to eq 0
  expect(response["error"]).to be_nil
end

Then(/^it should return the eula$/) do
  user_agent = "iOS"
  response = @GS_api.eula(user_agent)

	expect(response["responseCode"]).to eq 0
	expect(response["model"]["eulaLink"]).to eq "http://utang.com/eula.html"
end

Then(/^it should update the site information$/) do
  payload = JSON.generate(:id => 1025, :name => "TestSiteNameTEST", :logoUrl => "logoUrl.html", :clientTimeout => 6, :httpClientConfigurationId => 1012)
  user_agent = "iOS"
  response = @GS_api.update_site(payload, $NEW_ANDROID_USER_REG_CODE, user_agent)
  
	expect(response["responseCode"]).to eq 0
	expect(response["model"]["id"]).to eq 1025
	expect(response["model"]["name"]).to eq "TestSiteNameTEST"
	expect(response["model"]["timeZoneName"]).to be_nil
	expect(response["model"]["logoUrl"]).to eq "logoUrl.html"
	expect(response["model"]["clientTimeout"]).to eq 6
	expect(response["model"]["httpClientConfigurationId"]).to eq 1012
end

Then(/^it should update the site information back to normal$/) do
  payload = JSON.generate(:id => 1025, :name => "TestSiteName", :logoUrl => "logoUrl.html", :clientTimeout => 5, :httpClientConfigurationId => 1012)
  user_agent = "iOS"
  response = @GS_api.update_site(payload, $NEW_ANDROID_USER_REG_CODE, user_agent)
  
	expect(response["responseCode"]).to eq 0
	expect(response["model"]["id"]).to eq 1025
	expect(response["model"]["name"]).to eq "TestSiteName"
	expect(response["model"]["timeZoneName"]).to be_nil
	expect(response["model"]["logoUrl"]).to eq "logoUrl.html"
	expect(response["model"]["clientTimeout"]).to eq 5
	expect(response["model"]["httpClientConfigurationId"]).to eq 1012
end

Then(/^it should return the next http client configuration id$/) do
  user_agent = "iOS"
  response = @GS_api.next_http_client_config($NEW_ANDROID_USER_REG_CODE, user_agent)
  #puts response
  #response.should match "[0-9][0-9][0-9][0-9]"
  expect(response.to_i).to be > 1
end

Then(/^it should return the next site id$/) do
  user_agent = "iOS"
  response = @GS_api.next_site($NEW_ANDROID_USER_REG_CODE, user_agent)
  
  #response.should match "[0-9][0-9][0-9][0-9]"
  expect(response.to_i).to be > 1
end

Then(/^it should update the client configuration$/) do
  payload = JSON.generate(:id => 1030, :AllowsInvalidSslCertificate => true, :BaseUrl => "http://endPointUrl.com", :login => "test@test.com", :password => "XXXXX")
  user_agent = "iOS"
  response = @GS_api.update_client_configuration(payload, $NEW_ANDROID_USER_REG_CODE, user_agent)
 
	expect(response["responseCode"]).to eq 0
	expect(response["model"]["login"]).to eq "test@test.com"
	expect(response["model"]["password"]).to eq "XXXXX"
	expect(response["model"]["baseUrl"]).to eq "http://endPointUrl.com"
	expect(response["model"]["webUrl"]).to be_nil
	expect(response["model"]["allowsInvalidSslCertificate"]).to be true
end

Then(/^it should update the client configuration to original$/) do
  payload = JSON.generate(:id => 1030, :AllowsInvalidSslCertificate => true, :BaseUrl => "https://10.10.0.118/federated-api-pm/api", :login => "basic_on", :password => "XXXXX")
  user_agent = "iOS"
  response = @GS_api.update_client_configuration(payload, $NEW_ANDROID_USER_REG_CODE, user_agent)
  
	expect(response["responseCode"]).to eq 0
	expect(response["model"]["login"]).to eq "basic_on"
	expect(response["model"]["password"]).to eq "XXXXX"
	expect(response["model"]["baseUrl"]).to eq "https://10.10.0.118/federated-api-pm/api"
	expect(response["model"]["webUrl"]).to be_nil
	expect(response["model"]["allowsInvalidSslCertificate"]).to be true
end

Then(/^it should add reg code to site$/) do
  payload = JSON.generate(:registrationCode => $NEW_ANDROID_USER_REG_CODE, :siteId => 1763)
  user_agent = "android"
  response = @GS_api.add_reg_to_site(payload, $NEW_ANDROID_USER_REG_CODE, user_agent)
 
	expect(response["responseCode"]).to eq 0
	expect(response["model"]).to be_nil
	expect(response["error"]).to be_nil
end

Then(/^it should update the password for test@test.com$/) do
  payload = JSON.generate(:username => "test@test.com", :token => $password_reset_token, :password => "XXXXX6")
  puts payload
  user_agent = "iOS"
  response = @GS_api.password_reset(payload, user_agent)
  puts response
	expect(response["responseCode"]).to eq 0
	expect(response["model"]).to be_nil
	expect(response["error"]).to be_nil
end

Then(/^it should update the password for test@test.com back to original$/) do
  payload = JSON.generate(:username => "test@test.com", :token => $password_reset_token, :password => "XXXXX")
  puts payload
  user_agent = "iOS"
  response = @GS_api.password_reset(payload, user_agent)
  puts response
	expect(response["responseCode"]).to eq 0
	expect(response["model"]).to be_nil
	expect(response["error"]).to be_nil
end

Then(/^it should return the site list for newly added reg code to site/) do
  user_agent = "android"
  response = @GS_api.site_list($android_id2, $NEW_ANDROID_USER_REG_CODE, user_agent)
  
  expect(response["responseCode"]).to eq 0
	expect(response["model"]["sites"].count).to be >= 1
	expect(response["error"]).to be_nil
	expect(response["model"]["sites"][0]["siteId"]).to eq 1763
	expect(response["model"]["sites"][0]["name"]).to eq "34 QA Cardio PM"
	expect(response["model"]["sites"][0]["timeZoneName"]).to eq "America/Chicago"
end