Before do
  @Acwa_api = Acwa_api.new
end

Then(/^it should logon to get the x-auth-token$/) do
  response = @Acwa_api.logon
  expect(response['responseCode']).to eq 0
   
  $xAuthToken = response["model"]["xAuthToken"]
end

Then(/^it should get the patient id for "(.*?)"$/) do |patient_name|
  $patient_mpid = @Acwa_api.get_patient_id(patient_name) 
  puts "mpid = #{$patient_mpid}" 
end

Then(/^it should return the FRAT records header for recent patient$/) do 
  response = @Acwa_api.get_frat_records_headers
  puts "mpid = #{$patient_mpid}"
  #frat_records = Array.new(events.count){Array.new(9)}
  frat_records = Array.new
  for i in 0..(response.count - 1)
    r = response[i]['asmpid']
    puts r
    if r == $patient_mpid
       frat_records.push(response[i])
    end
  end

  puts frat_records.count
  puts frat_records[0]

end

Then(/^it should return the FRAT records summary for the latest id$/) do
  response = @Acwa_api.get_frat_records_by_id_summary($latest_frat_id)
  $ecg_lead_one = response['ecgSegments'][0]['ecgLead']
  $ecg_lead_two = response['ecgSegments'][1]['ecgLead']
  puts "ecg lead one  = #{$ecg_lead_one}"
  puts "ecg lead two  = #{$ecg_lead_two}"
end

Then(/^it should return the FRAT records with the latest id$/) do
  $latest_frat_record_object = @Acwa_api.get_frat_records_by_id($latest_frat_id)
  puts "record id = #{$latest_frat_record_object['id']}"
  puts "username = #{$latest_frat_record_object['userName']}"
  puts "create timestamp = #{$latest_frat_record_object['createdTimestamp']}"
  puts "asmpid = #{$latest_frat_record_object['asmpid']}"
  puts "unit = #{$latest_frat_record_object['unit']}"
  puts "location = #{$latest_frat_record_object['location']}"
  puts "patient id = #{$latest_frat_record_object['patientInfo']['id']}"
  puts "mrn = #{$latest_frat_record_object['patientInfo']['mrn']}"
  puts "name = #{$latest_frat_record_object['patientInfo']['name']}"
  puts "dob = #{$latest_frat_record_object['patientInfo']['dateOfBirth']}"
  puts "age = #{$latest_frat_record_object['patientInfo']['age']}"
  puts "gender = #{$latest_frat_record_object['patientInfo']['gender']}"
  puts "client name = #{$latest_frat_record_object['clientInfo']['name']}"
  puts "version = #{$latest_frat_record_object['clientInfo']['version']}"
  puts "build date = #{$latest_frat_record_object['clientInfo']['buildDate']}"
  puts "site id = #{$latest_frat_record_object['siteId']}"

  #puts "ecg lead one seconds = #{$latest_frat_record_object['ecgSegments'][$ecg_lead_one]['ecgLead']}"
  $sample_rate = $latest_frat_record_object['ecgSegments'][$ecg_lead_one]['sampleRate']
  puts "the sameple rate = #{$sample_rate}"

  $ecg_one_wave_data = $latest_frat_record_object['ecgSegments'][$ecg_lead_one]['waveData']
  $ecg_two_wave_data = $latest_frat_record_object['ecgSegments'][$ecg_lead_two]['waveData']
  puts "ecg one wave count = #{$ecg_one_wave_data.count}"
  puts "ecg two wave count = #{$ecg_two_wave_data.count}"

  $ecg_one_wave_length_seconds = $latest_frat_record_object['ecgSegments'][$ecg_lead_one]['waveLengthSeconds']
  $ecg_two_wave_length_seconds = $latest_frat_record_object['ecgSegments'][$ecg_lead_two]['waveLengthSeconds']
  puts "ecg one seconds = #{$ecg_one_wave_length_seconds}"
  puts "ecg two seconds = #{$ecg_two_wave_length_seconds}"
end

And(/^the sample rate should be "(.*?)" $/) do |sample_rate|
  expect($sample_rate).to eql sample_rate.to_i
end

And(/^there should be "(.*?)" seconds of wave data for ecg "(.*?)"$/) do |seconds, which_ecg| 
  case which_ecg
  when 'one'
    calculated_value = $ecg_one_wave_data.count / $sample_rate        
    puts "wave data / sample rate = #{calculated_value}"
  when 'two'
    calculated_value = $ecg_two_wave_data.count / $sample_rate    
    puts "wave data / sample rate = #{calculated_value}"
  end

  expect(calculated_value).to eql seconds.to_i
end

And(/^each value of the wave data should be of type Integer for ecg "(.*?)"$/) do |which_ecg| 
  case which_ecg
  when 'one'
    wave_data = $ecg_two_wave_data
  when 'two'
    wave_data = $ecg_two_wave_data
  end
  
  for i in 0..(wave_data.count - 1)
    #puts wave_data[i].is_a? Integer
    expect(wave_data[i]).to be_a_kind_of(Integer)
  end
end

And(/^each value of the wave data should be negative or positive for ecg "(.*?)"$/) do |which_ecg| 
  case which_ecg
  when 'one'
    wave_data = $ecg_two_wave_data
  when 'two'
    wave_data = $ecg_two_wave_data
  end
  
  for i in 0..(wave_data.count - 1)
    #puts wave_data[i].positive?
    if wave_data[i].positive?
      expect(wave_data[i]).to be > 0
    elsif wave_data[i].negative?
      expect(wave_data[i]).to be < 0
    else
      expect(wave_data[i]).to eql 0
    end
  end
end

Then(/^it should return the FRAT records headers$/) do 
  response = @Acwa_api.get_frat_records_headers
  puts response
end


Then(/^it should return the ACWA status$/) do |table|
  response = @Acwa_api.get_status

  values = table.hashes
  expect(response['machineName']).to eq values[0]['machineName']
end

Then(/^it should return the ACWA version$/) do |table|
  response = @Acwa_api.get_version
  values = table.hashes

  expect(response['applicationVersion']).to eq values[0]['applicationVersion']
  expect(response['domainVersion']).to eq values[0]['domainVersion']
  expect(response['algorithms'][0]['name']).to eq values[0]['name']
  expect(response['algorithms'][0]['version']).to eq values[0]['version']
  expect(response['algorithms'][0]['date']).to eq values[0]['date']
  expect(response['algorithms'][0]['info']).to eq values[0]['info']
end

Then(/^it should return the ACWA rules$/) do 
    response = @Acwa_api.get_acm_rules

    expect(response["responseCode"]).to eq 0
    expect(response["model"].count).to be >= 0
end

Then(/^it should return the FRAT even descriptions$/) do | table |
    response = @Acwa_api.get_frat_descriptions

    values = table.hashes

    expect(response[0]["majorCategory"]).to eq values[0]["majorCategory"] 
    expect(response[0]["minorCategory"]).to eq values[0]["minorCategory"]
    #expect(response[0]["freeText"]).to eq values[0]["freeText"] 
    expect(response[1]["majorCategory"]).to eq values[1]["majorCategory"] 
    expect(response[1]["minorCategory"]).to eq values[1]["minorCategory"] 
    #expect(response[1]["freeText"]).to eq values[1]["freeText"] 
end

Then(/^it should return the FRAT users$/) do 
    response = @Acwa_api.get_frat_users

    #expect(response["responseCode"]).to eq 0
    #expect(response["model"].count).to be >= 0
end

Then(/^it should return the FRAT records full$/) do 
    response = @Acwa_api.get_frat_records_full

    expect(response[0]["siteId"]).to eq "Site1"
    expect(response[0]["ecgSegments"]["II"]["ecgLead"]).to eq "II"
    expect(response[0]["ecgSegments"]["II"]["order"]).to eq 0
    expect(response[0]["ecgSegments"]["II"]["sampleRate"]).to eq 240
    expect(response[0]["ecgSegments"]["II"]["waveLengthSeconds"]).to eq 60
    
    expect(response[0]["ecgSegments"]["II"]["waveGroup"]["lineColor"]).to eq "#2EAE2A"
    expect(response[0]["ecgSegments"]["II"]["waveGroup"]["maxRange"]).to eq 800
    expect(response[0]["ecgSegments"]["II"]["waveGroup"]["minRange"]).to eq -800
    expect(response[0]["ecgSegments"]["II"]["waveGroup"]["mvPerPoint"]).to eq 0.001
    expect(response[0]["ecgSegments"]["II"]["waveGroup"]["title"]).to eq "ECG-II"

    expect(response[0]["ecgSegments"]["V1"]["ecgLead"]).to eq "V1"
    expect(response[0]["ecgSegments"]["V1"]["order"]).to eq 1   
    expect(response[0]["ecgSegments"]["V1"]["sampleRate"]).to eq 240   
    expect(response[0]["ecgSegments"]["V1"]["waveLengthSeconds"]).to eq 60  
    
    expect(response[0]["ecgSegments"]["V1"]["waveGroup"]["lineColor"]).to eq "#2EAE2A"
    expect(response[0]["ecgSegments"]["V1"]["waveGroup"]["maxRange"]).to eq 800
    expect(response[0]["ecgSegments"]["V1"]["waveGroup"]["minRange"]).to eq -800
    expect(response[0]["ecgSegments"]["V1"]["waveGroup"]["mvPerPoint"]).to eq 0.001
    expect(response[0]["ecgSegments"]["V1"]["waveGroup"]["title"]).to eq "ECG-II"
end

Then(/^it should return the FRAT records$/) do 
    response = @Acwa_api.get_frat_records

    expect(response[0]).to eql "/acwa/frat/records/ad985f36-b059-45a2-90a0-527d3440ab00"
end

Then(/^it should return the FRAT records ids$/) do
    response = @Acwa_api.get_frat_records_ids
    #ad985f36-b059-45a2-90a0-527d3440ab00
    #expect(response["responseCode"]).to eq 0
    #expect(response["model"].count).to be >= 0
end

Then(/^it should return the FRAT records by id "(.*?)"$/) do | id | 
    response = @Acwa_api.get_frat_records_by_id(id)
    #ad985f36-b059-45a2-90a0-527d3440ab00
    #expect(response["responseCode"]).to eq 0
    #expect(response["model"].count).to be >= 0
end

Then(/^it should return the FRAT records summary by id "(.*?)"$/) do | id | 
    response = @Acwa_api.get_frat_records_by_id_summary(id)
    #ad985f36-b059-45a2-90a0-527d3440ab00
    #expect(response["responseCode"]).to eq 0
    #expect(response["model"].count).to be >= 0
end