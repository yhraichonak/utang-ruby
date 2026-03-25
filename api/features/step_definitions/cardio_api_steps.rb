Before do
  @Fed_api = Fed_api.new
  @Cardio_api = Cardio_api.new
  @Pm_api = Pm_api.new 
end

Then(/^it should return "(.*?)" search results for DOB "(.*?)"$/) do | module_name, dob,  table |
  case module_name
  when "PM"
    module_id = $PM_MODULE_ID
  when "CARDIO"
    module_id = $CARDIO_MODULE_ID
    param_one = "searchkey3"
  end
    
  search_results = @Fed_api.one_param_search(param_one, dob, module_id)
  
  expect(search_results["responseCode"]).to eq 0
  expect(search_results["error"]).to be_nil
  
  patients = table.hashes
  
  expect(patients[0][:firstName]).to eq search_results["model"]["patients"][0]["firstName"].upcase
  expect(patients[0][:lastName]).to eq search_results["model"]["patients"][0]["lastName"].upcase
  expect(patients[0][:mrn]).to eq search_results["model"]["patients"][0]["mrn"]
  expect(patients[0][:status]).to eq search_results["model"]["patients"][0]["status"]
  expect(patients[0][:moduleId].to_s).to eq search_results["model"]["patients"][0]["moduleSpecificData"][0]["moduleId"].to_s
  expect(patients[0][:location]).to eq search_results["model"]["patients"][0]["moduleSpecificData"][0]["location"]
  expect(patients[0][:unit]).to eq search_results["model"]["patients"][0]["moduleSpecificData"][0]["unit"]

  date_of_birth = Date.parse(search_results["model"]["patients"][0]["dateOfBirth"])
  formatted_dob = date_of_birth.strftime("%m/%d/%Y")
  expect(dob).to eq formatted_dob
end

Then(/^it should return "(.*?)" ecg list for patient "(.*?)" "(.*?)"$/) do | module_name, value_one, value_two, table |
  case module_name
  when "PM"
    module_id = $PM_MODULE_ID
  when "CARDIO"
    module_id = $CARDIO_MODULE_ID
  end
  
  param_one = "firstname"
  param_two = "lastname"
  
  ecgs = table.hashes
  
  search_results = @Fed_api.two_param_search(param_one, value_one, param_two, value_two, module_id)
  puts search_results
  asmpid = search_results["model"]["patients"][0]["asmpid"]
    
  ecg_list = @Cardio_api.ecg_list(asmpid)
  puts "+++"
  puts ecg_list
  puts "+++"
        
  expect(ecg_list["model"][0]["ecgId"].to_s).to eq ecgs[0][:ecgId]
  expect(ecg_list["model"][0]["diagnosis"]).to eq ecgs[0][:diagnosis]
  
 # expect(ecg_list["model"][1]["ecgId"].to_s).to eq ecgs[1][:ecgId]
 # expect(ecg_list["model"][1]["diagnosis"]).to eq ecgs[1][:diagnosis]
end


Then(/^it should return "(.*?)" ecg information for ecg id "(.*?)"$/) do | module_name, ecg_id, table |
  case module_name
  when "PM"
    module_id = $PM_MODULE_ID
  when "CARDIO"
    module_id = $CARDIO_MODULE_ID
  end
  
  ecg_info = table.hashes

  ecg = @Cardio_api.get_ecg(ecg_id)

  expect(ecg_info[0][:ecgId]).to eq ecg["model"]["ecgId"].to_s
  expect(ecg_info[0][:diagnosis]).to eq ecg["model"]["ecgDetails"]["diagnosis"]
end

Then(/^it should return "(.*?)" ecg request edit for ecg id "(.*?)"$/) do | module_name, ecg_id, table |
  case module_name
  when "PM"
    module_id = $PM_MODULE_ID
  when "CARDIO"
    module_id = $CARDIO_MODULE_ID
  end
  
  ecg_info = table.hashes

  response = @Cardio_api.request_edit_ecg(ecg_id)
  puts response
  expect(response["responseCode"]).to eq 0
  expect(response["model"]["allowEdit"].to_s).to eq ecg_info[0][:allowEdit]
  if ecg_info[0][:userMessage].include? "matches"
    expect(response["model"]["userMessage"].to_s).to match ecg_info[0][:userMessage].gsub("matches:", "")
  else
    expect(response["model"]["userMessage"].to_s).to eq ecg_info[0][:userMessage]
  end
end

Then(/^it should return "(.*?)" serial presentation for ecgs "(.*?)" "(.*?)"$/) do | module_name, ecg_one, ecg_two, table |
  case module_name
  when "PM"
    module_id = $PM_MODULE_ID
  when "CARDIO"
    module_id = $CARDIO_MODULE_ID
  end

  ecgs = table.hashes
  
  search_results = @Cardio_api.serial_presentation(ecg_one, ecg_two)
  
  expect(search_results["model"]["ecgList"][0]["ecgId"].to_s).to eq ecgs[0][:ecgId]
  expect(search_results["model"]["ecgList"][0]["ecgDetails"]["diagnosis"]).to eq ecgs[0][:diagnosis]
  
  expect(search_results["model"]["ecgList"][1]["ecgId"].to_s).to eq ecgs[1][:ecgId]
  expect(search_results["model"]["ecgList"][1]["ecgDetails"]["diagnosis"]).to eq ecgs[1][:diagnosis]
end

Then(/^it should return "(.*?)" statement library$/) do | module_name, table |
  case module_name
  when "PM"
    module_id = $PM_MODULE_ID
  when "CARDIO"
    module_id = $CARDIO_MODULE_ID
  end

  statements = table.hashes
  
  response = @Cardio_api.statement_library
  
  expect(response["model"]["statementLibrary"][0]["code"]).to eq statements[0][:code]
  expect(response["model"]["statementLibrary"][0]["text"]).to eq statements[0][:statement]
  
  expect(response["model"]["statementLibrary"][1]["code"]).to eq statements[1][:code]
  expect(response["model"]["statementLibrary"][1]["text"]).to eq statements[1][:statement]
end