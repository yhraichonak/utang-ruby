Before do
  @Amp_api = Amp_api.new
end

Then(/^it should return a valid shared security key for site "(.*?)" and key name "(.*?)"$/) do | site_id, key_name |
  payload = JSON.generate(:siteId => site_id, :keyName => key_name)
  response = @Amp_api.shared_security_key(payload)
  if $DEBUG_FLAG == "debug"
    puts response
  end
  expect(response["responseCode"]).to eq 0
  expect(response["model"]).to eq('Sh4r3d_K3y_F0r_t3st1ing_0nly_32B')
end

Then(/^it should not return a valid shared security key for site "(.*?)" and key name "(.*?)"$/) do | site_id, key_name |
  payload = JSON.generate(:siteId => site_id, :keyName => key_name)
  response = @Amp_api.shared_security_key(payload)
  if $DEBUG_FLAG == "debug"
    puts response
  end
  expect(response["responseCode"]).to eq 101
  expect(response["error"]["title"]).to eq("ResourceNotFound")
  expect(response["error"]["description"]).to eq("Requested resource was not found")
end

Then(/^it should return all enterprise users$/) do
  response = @Amp_api.return_all_users
  if $DEBUG_FLAG == "debug"
    puts response
  end
  expect(response["responseCode"]).to eq 0
  expect(response["model"].to_s).to include('"fullName"=>"utang Username"')
  expect(response["model"].to_s).to include('"userName"=>"username"')
  expect(response["model"].to_s).to include('"fullName"=>"utang User"')
  expect(response["model"].to_s).to include('"userName"=>"utang"')

end

Then(/^it should return true for a valid user "(.*?)" for site "(.*?)" and reg code "(.*?)"$/) do | ad_username, site_id, reg_code |
  payload = JSON.generate(:siteId => site_id, :adUsername => ad_username, :regCode => reg_code)
  response = @Amp_api.enterprise_user_verification(payload)
  if $DEBUG_FLAG == "debug"
    puts response
  end
  expect(response["responseCode"]).to eq 0
  expect(response["model"]).to be true
  expect(response["error"]).to be nil
end

Then(/^it should return false for a valid user "(.*?)" for site "(.*?)" and reg code "(.*?)"$/) do | ad_username, site_id, reg_code |
  payload = JSON.generate(:siteId => site_id, :adUsername => ad_username, :regCode => reg_code)
  response = @Amp_api.enterprise_user_verification(payload)

  expect(response["responseCode"]).to eq 0
  expect(response["model"]).to be false
  expect(response["error"]).to be nil
end

Then(/^it should return module instance configuration with id "(.*?)"$/) do | module_id, table |
  expectedData = table.hashes
  response = @Amp_api.module_instance_configuration(module_id)
  
  if $DEBUG_FLAG == "debug"
    puts response
  end
  
  if(response["responseCode"] == 0)
	expect(response["responseCode"]).to eq 0
	expect(response["model"]["hasEditsAndConfirms"].to_s).to eq expectedData[0]["hasEditsAndConfirms"].to_s
	expect(response["model"]["hasEditsAndConfirmsInbox"].to_s).to eq expectedData[0]["hasEditsAndConfirmsInbox"].to_s
	expect(response["model"]["siteVirtualizationEnabled"].to_s).to eq expectedData[0]["siteVirtualizationEnabled"].to_s
	expect(response["model"]["mmivEnabled"].to_s).to eq expectedData[0]["mmivEnabled"].to_s
	expect(response["model"]["moduleInstanceId"].to_s).to eq expectedData[0]["moduleInstanceId"].to_s
	expect(response["model"]["moduleInstanceName"].to_s).to eq expectedData[0]["moduleInstanceName"].to_s
	expect(response["model"]["moduleInstanceBaseUrl"].to_s).to eq expectedData[0]["moduleInstanceBaseUrl"].to_s
	expect(response["model"]["siteId"].to_s).to eq expectedData[0]["siteId"].to_s
	expect(response["model"]["siteName"].to_s).to eq expectedData[0]["siteName"].to_s
	expect(response["model"]["dualAuthenticationEnabled"].to_s).to eq expectedData[0]["dualAuthenticationEnabled"].to_s
  else
	expect(response["responseCode"]).to eq(101)
	expect(response["error"]["title"]).to eq "ResourceNotFound"
  end
end

Then(/^it should return module instance configuration with id "(.*?)" snippet$/) do | module_id, table |
  expectedData = table.hashes
  response = @Amp_api.module_instance_configuration(module_id)
  
  if $DEBUG_FLAG == "debug"
    puts response
  end
  #{"responseCode"=>0, "model"=>{"snippetsEnabled"=>false, "dualLead"=>false, "snippetsWorklistEnabled"=>false, "maxShifts"=>0, "snippetsShowStatementCodes"=>false, "snippetsEnableDescriptionFreeText"=>false, "snippetsEnableEditMeasurements"=>false, "multiPatientViewEnabled"=>false, "moduleInstanceId"=>105, "moduleInstanceName"=>"34 QA Cardio PM", "moduleInstanceBaseUrl"=>"https://10.10.160.132/56/fed-web/api", "siteId"=>4104, "siteName"=>"MuseNX", "dualAuthenticationEnabled"=>false, "mostRecentPatientListLength"=>0}, "error"=>nil}
 
  if(response["responseCode"] == 0)
	expect(response["responseCode"]).to eq 0
	expect(response["model"]["snippetsEnabled"].to_s).to eq expectedData[0]["snippetsEnabled"].to_s
	expect(response["model"]["dualLead"].to_s).to eq expectedData[0]["dualLead"].to_s
	expect(response["model"]["moduleInstanceId"].to_s).to eq expectedData[0]["moduleInstanceId"].to_s
	expect(response["model"]["moduleInstanceName"].to_s).to eq expectedData[0]["moduleInstanceName"].to_s
	expect(response["model"]["moduleInstanceBaseUrl"].to_s).to eq expectedData[0]["moduleInstanceBaseUrl"].to_s
	expect(response["model"]["siteId"].to_s).to eq expectedData[0]["siteId"].to_s
	expect(response["model"]["siteName"].to_s).to eq expectedData[0]["siteName"].to_s
	expect(response["model"]["dualAuthenticationEnabled"].to_s).to eq expectedData[0]["dualAuthenticationEnabled"].to_s
  else
	expect(response["responseCode"]).to eq(101)
	expect(response["error"]["title"]).to eq "ResourceNotFound"
  end
end

Then(/^it should return module instance user configuration with module id "(.*?)" and user "(.*?)"$/) do | module_id, ad_username, table |
  expectedData = table.hashes
  payload = JSON.generate(:moduleInstanceId => module_id, :adUsername => ad_username)
  response = @Amp_api.module_instance_user_configuration(payload)
  
  if(response["responseCode"] == 0)
	expect(response["responseCode"]).to eq 0
	expect(response["model"]["activeDirectoryUsername"].to_s).to eq expectedData[0]["activeDirectoryUsername"].to_s
	expect(response["model"]["userFullName"].to_s).to eq  expectedData[0]["userFullName"].to_s
	expect(response["model"]["moduleInstanceId"].to_s).to eq expectedData[0]["moduleInstanceId"].to_s
	expect(response["model"]["moduleInstanceName"].to_s).to eq expectedData[0]["moduleInstanceName"].to_s
	expect(response["model"]["hasEditsAndConfirmsCapability"].to_s).to eq expectedData[0]["hasEditsAndConfirmsCapability"].to_s
	expect(response["model"]["canConfirmOutOfInbasket"].to_s).to eq expectedData[0]["canConfirmOutOfInbasket"].to_s
	expect(response["model"]["isAvailableForNotifications"].to_s).to eq expectedData[0]["isAvailableForNotifications"].to_s
  else
	expect(response["responseCode"]).to eq(101)
	expect(response["error"]["title"]).to eq "ResourceNotFound"
  end
end

Then(/^it should return enterprise user vendor credentials with user "(.*?)" vendor system "(.*?)" and module instance "(.*?)"$/) do | ad_username, vendor_system, mod_instance, table |
  expectedData = table.hashes
  payload = JSON.generate(:adUsername => ad_username, :vendorSystemName => vendor_system, :moduleInstanceId => mod_instance)
  response = @Amp_api.module_instance_user_configuration(payload)
  
  #puts response
 
  if(response["responseCode"] == 0)
	expect(response["responseCode"]).to eq 0
	expect(response["model"]["username"].to_s).to eq expectedData[0]["username"].to_s
	expect(response["model"]["password"].to_s).to eq expectedData[0]["password"].to_s
	#expect(response["model"]["vendorSystemId"].to_s).to eq expectedData[0]["vendorSystemId"].to_s
	#expect(response["model"]["vendorSystemName"].to_s).to eq expectedData[0]["vendorSystemName"].to_s
	expect(response["model"]["moduleInstanceId"].to_s).to eq expectedData[0]["moduleInstanceId"].to_s
	expect(response["model"]["moduleInstanceName"].to_s).to eq expectedData[0]["moduleInstanceName"].to_s
	
	#expect(response["model"]["id"].to_s).to eq expectedData[0]["id"].to_s
  else
    if(response["responseCode"] == 100)
      expect(response["responseCode"].to_i).to eq(100)
      expect(response["error"]["title"]).to eq("GeneralError")
    elsif(response["responseCode"] == 101)
      expect(response["responseCode"].to_i).to eq(101)
      expect(response["error"]["title"]).to eq("ResourceNotFound")
    end
  end
end