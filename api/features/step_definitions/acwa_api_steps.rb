Before do
    @Acwa_api = Acwa_api.new
end

Then(/^it should return the ACWA status$/) do | table |
    response = @Acwa_api.get_status

    values = table.hashes
    expect(response["machineName"]).to eq values[0]["machineName"]   
end

Then(/^it should return the ACWA version$/) do | table |
    response = @Acwa_api.get_version

    values = table.hashes

    expect(response["applicationVersion"]).to eq values[0]["applicationVersion"]  
    expect(response["domainVersion"]).to eq values[0]["domainVersion"]  
    expect(response["algorithms"][0]["name"]).to eq values[0]["name"]  
    expect(response["algorithms"][0]["version"]).to eq values[0]["version"]  
    expect(response["algorithms"][0]["date"]).to eq values[0]["date"]  
    expect(response["algorithms"][0]["info"]).to eq values[0]["info"]  
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

Then(/^it should return the FRAT records headers$/) do 
    response = @Acwa_api.get_frat_records_headers

    expect(response[0]["userName"]).to eql "User1"
    expect(response[0]["siteId"]).to eql "Site1"
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