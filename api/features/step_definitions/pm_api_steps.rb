Before do
  @Fed_api = Fed_api.new
  @Cardio_api = Cardio_api.new
  @Pm_api = Pm_api.new 
end

Then(/^it should return "(.*?)" search results for unit "(.*?)"$/) do | module_name, unit |
  expect(@response["responseCode"]).to eq 0
  expect(@response["error"]).to be_nil
  expect(@response["model"]["patients"][0]["moduleSpecificData"][0]["unit"]).to eq process_param(unit)
end

Then(/^it should return "(.*?)" search results for bed "(.*?)"$/) do | module_name, bed |
  expect(@response["responseCode"]).to eq 0
  expect(@response["error"]).to be_nil
  expect(@response["model"]["patients"][0]["moduleSpecificData"][0]["location"]).to eq process_param(bed)
end

Then(/^it should return "(.*?)" events for "(.*?)" "(.*?)"$/) do | module_name, value_one, value_two, table |
  patients = table.hashes

  asmpid = @response["model"]["patients"][0]["asmpid"]
  expect(process_param(patients[0][:mrn])).to eq process_param(@response["model"]["patients"][0]["mrn"])

  events = @Pm_api.events(asmpid)
  
  if(events["model"]["discreteGroups"].nil?)
		expect(events["model"]["discreteGroups"]).to be_nil	
  elsif events["model"]["discreteGroups"].count > 0
    expect(events["model"]["discreteGroups"].count).to be >= 1
  end  
end

Then(/^it should return "(.*?)" measurements for "(.*?)" "(.*?)"$/) do | module_name, value_one, value_two, table |
  patients = table.hashes
  
  asmpid = @response["model"]["patients"][0]["asmpid"]
  expect(process_param(patients[0][:mrn])).to eq @response["model"]["patients"][0]["mrn"]

  response = @Pm_api.measurements(asmpid)
  
  expect(response["responseCode"]).to eq 0
  expect(response["error"]).to be_nil
      
  if(response["model"]["data"].count > 0)
    expect(response["model"]["data"][0]["waveData"].count).to be >= 4
  end
end

Then(/^it should return "(.*?)" trends for "(.*?)" "(.*?)"$/) do | module_name, value_one, value_two, table |
  patients = table.hashes
  
  asmpid = @response["model"]["patients"][0]["asmpid"]
  expect(process_param(patients[0][:mrn])).to eq @response["model"]["patients"][0]["mrn"]
  
  montior_config = @Pm_api.monitor_config(asmpid)
  keys = montior_config["model"]["discreteGroups"][0]["keys"][0]
  
  response = @Pm_api.trends(asmpid, keys)
      
  expect(response["responseCode"]).to eq 0
  expect(response["error"]).to be_nil
  expect(response["model"]["data"][0]["key"]).to eq keys
end

Then(/^it should return "(.*?)" monitor config for "(.*?)" "(.*?)"$/) do | module_name, value_one, value_two, table |
  patients = table.hashes
  
  asmpid = @response["model"]["patients"][0]["asmpid"]
  expect(patients[0][:mrn]).to eq @response["model"]["patients"][0]["mrn"]

  response = @Pm_api.monitor_config(asmpid)

  puts response
  # fed-host
  # fed-web
  # pm
  # cardio
#   https://10.10.160.132/fed-web/api/patientlist/configuration?siteId=1763&x-auth-token=testtoken
#   https://10.10.160.133/amp/api/site/moduleinstance/1763

  expect(response["error"]).to be_nil
  expect(response["model"]["waveGroups"].count).to be 8
      
	for i in (0..response["model"]["waveGroups"].count - 1)
		if(response["model"]["waveGroups"][i]["key"] == "1814")	
			expect(response["model"]["waveGroups"][i]["key"]).to eq "1814"
			expect(response["model"]["waveGroups"][i]["lineColor"]).to eq "2EAE2A"
			expect(response["model"]["waveGroups"][i]["maxRange"]).to eq "800"
			expect(response["model"]["waveGroups"][i]["minRange"]).to eq "-800"
			expect(response["model"]["waveGroups"][i]["mvPerPoint"]).to eq 0.001
			expect(response["model"]["waveGroups"][i]["title"]).to eq "ECG-II"
		elsif(response["model"]["waveGroups"][i]["key"] == "1815")	
			expect(response["model"]["waveGroups"][i]["key"]).to eq "1815"
			expect(response["model"]["waveGroups"][i]["lineColor"]).to eq "2EAE2A"
			expect(response["model"]["waveGroups"][i]["maxRange"]).to eq "800"
			expect(response["model"]["waveGroups"][i]["minRange"]).to eq "-800"
			expect(response["model"]["waveGroups"][i]["mvPerPoint"]).to eq 0.001
			expect(response["model"]["waveGroups"][i]["title"]).to eq "ECG-V1"
		elsif(response["model"]["waveGroups"][i]["key"] == "1446")	
      		expect(response["model"]["waveGroups"][i]["key"]).to eq "1446"
			expect(response["model"]["waveGroups"][i]["lineColor"]).to eq "E81E1E"
			expect(response["model"]["waveGroups"][i]["maxRange"]).to eq "200"
			expect(response["model"]["waveGroups"][i]["minRange"]).to eq "0"
			expect(response["model"]["waveGroups"][i]["mvPerPoint"]).to be_nil
			expect(response["model"]["waveGroups"][i]["title"]).to eq "ART_IP1"
		elsif(response["model"]["waveGroups"][i]["key"] == "1813")	
			expect(response["model"]["waveGroups"][i]["key"]).to eq "1813"
			expect(response["model"]["waveGroups"][i]["lineColor"]).to eq "2EAE2A"
			expect(response["model"]["waveGroups"][i]["maxRange"]).to eq "800"
			expect(response["model"]["waveGroups"][i]["minRange"]).to eq "-800"
			expect(response["model"]["waveGroups"][i]["mvPerPoint"]).to eq 0.001
			expect(response["model"]["waveGroups"][i]["title"]).to eq "ECG-I"
		elsif(response["model"]["waveGroups"][i]["key"] == "1059")	
			expect(response["model"]["waveGroups"][i]["key"]).to eq "1059"
			expect(response["model"]["waveGroups"][i]["lineColor"]).to eq "2EAE2A"
			expect(response["model"]["waveGroups"][i]["maxRange"]).to eq "800"
			expect(response["model"]["waveGroups"][i]["minRange"]).to eq "-800"
			expect(response["model"]["waveGroups"][i]["mvPerPoint"]).to eq 0.001
			expect(response["model"]["waveGroups"][i]["title"]).to eq "ECG-AVR"
		elsif(response["model"]["waveGroups"][i]["key"] == "1057")	      
			expect(response["model"]["waveGroups"][i]["key"]).to eq "1057"
			expect(response["model"]["waveGroups"][i]["lineColor"]).to eq "2EAE2A"
			expect(response["model"]["waveGroups"][i]["maxRange"]).to eq "800"
			expect(response["model"]["waveGroups"][i]["minRange"]).to eq "-800"
			expect(response["model"]["waveGroups"][i]["mvPerPoint"]).to eq 0.001
			expect(response["model"]["waveGroups"][i]["title"]).to eq "ECG-AVF"
		elsif(response["model"]["waveGroups"][i]["key"] == "1060")	      
			expect(response["model"]["waveGroups"][i]["key"]).to eq "1060"
			expect(response["model"]["waveGroups"][i]["lineColor"]).to eq "2EAE2A"
			expect(response["model"]["waveGroups"][i]["maxRange"]).to eq "800"
			expect(response["model"]["waveGroups"][i]["minRange"]).to eq "-800"
			expect(response["model"]["waveGroups"][i]["mvPerPoint"]).to eq 0.001
			expect(response["model"]["waveGroups"][i]["title"]).to eq "ECG-III"
		elsif(response["model"]["waveGroups"][i]["key"] == "1058")	
			expect(response["model"]["waveGroups"][i]["key"]).to eq "1058"
			expect(response["model"]["waveGroups"][i]["lineColor"]).to eq "2EAE2A"
			expect(response["model"]["waveGroups"][i]["maxRange"]).to eq "800"
			expect(response["model"]["waveGroups"][i]["minRange"]).to eq "-800"
			expect(response["model"]["waveGroups"][i]["mvPerPoint"]).to eq 0.001
			expect(response["model"]["waveGroups"][i]["title"]).to eq "ECG-AVL"
		end
	end
	
	expect(response["model"]["discreteGroups"].count).to be >= 6
	
	for z in (0..response["model"]["discreteGroups"].count - 1)
		if(response["model"]["discreteGroups"][z]["keys"][0] == "1812")		
			expect(response["model"]["discreteGroups"][z]["isEpisodic"]).to be false
			expect(response["model"]["discreteGroups"][z]["keys"][0]).to eq "1812"
			expect(response["model"]["discreteGroups"][z]["layoutDiscreteDirection"]).to eq "layoutDiscretesRight"
			expect(response["model"]["discreteGroups"][z]["textColor"]).to eq "2EAE2A"
			expect(response["model"]["discreteGroups"][z]["title"]).to eq "HR {beat}/min"
			expect(response["model"]["discreteGroups"][z]["viewCategory"]).to eq "single"
		elsif(response["model"]["discreteGroups"][z]["keys"][0] == "1816")	
			expect(response["model"]["discreteGroups"][z]["isEpisodic"]).to be false
			expect(response["model"]["discreteGroups"][z]["keys"][0]).to eq "1816"
			expect(response["model"]["discreteGroups"][z]["layoutDiscreteDirection"]).to eq "layoutDiscretesRight"
			expect(response["model"]["discreteGroups"][z]["textColor"]).to eq "2EAE2A"
			expect(response["model"]["discreteGroups"][z]["title"]).to eq "PVC {beat}/min"
			expect(response["model"]["discreteGroups"][z]["viewCategory"]).to eq "single"
		elsif(response["model"]["discreteGroups"][z]["keys"][0] == "1816")		  
			expect(response["model"]["discreteGroups"][z]["isEpisodic"]).to be true
			expect(response["model"]["discreteGroups"][z]["keys"][0]).to eq "1837"
			expect(response["model"]["discreteGroups"][z]["layoutDiscreteDirection"]).to eq "layoutDiscretesRight"
			expect(response["model"]["discreteGroups"][z]["textColor"]).to eq "E81E1E"
			expect(response["model"]["discreteGroups"][z]["title"]).to eq "NBP mm[Hg]"
			expect(response["model"]["discreteGroups"][z]["viewCategory"]).to eq "comp3"
		elsif(response["model"]["discreteGroups"][z]["keys"][0] == "1816")		  
			expect(response["model"]["discreteGroups"][z]["isEpisodic"]).to be false
			expect(response["model"]["discreteGroups"][z]["keys"][0]).to eq "1414"
			expect(response["model"]["discreteGroups"][z]["layoutDiscreteDirection"]).to eq "layoutDiscretesRight"
			expect(response["model"]["discreteGroups"][z]["textColor"]).to eq "E81E1E"
			expect(response["model"]["discreteGroups"][z]["title"]).to eq "AR1 mm[Hg]"
			expect(response["model"]["discreteGroups"][z]["viewCategory"]).to eq "comp3"
	  	elsif(response["model"]["discreteGroups"][z]["keys"][0] == "1816")	
			expect(response["model"]["discreteGroups"][z]["isEpisodic"]).to be false
			expect(response["model"]["discreteGroups"][z]["keys"][0]).to eq "1878"
			expect(response["model"]["discreteGroups"][z]["layoutDiscreteDirection"]).to eq "layoutDiscretesRight"
			expect(response["model"]["discreteGroups"][z]["textColor"]).to eq "4875B1"
			expect(response["model"]["discreteGroups"][z]["title"]).to eq "RR {resp}/min"
			expect(response["model"]["discreteGroups"][z]["viewCategory"]).to eq "single"
	  	elsif(response["model"]["discreteGroups"][z]["keys"][0] == "1816")	
			expect(response["model"]["discreteGroups"][z]["isEpisodic"]).to be false
			expect(response["model"]["discreteGroups"][z]["keys"][0]).to eq "1817"
			expect(response["model"]["discreteGroups"][z]["layoutDiscreteDirection"]).to eq "layoutDiscretesRight"
			expect(response["model"]["discreteGroups"][z]["textColor"]).to eq "2EAE2A"
			expect(response["model"]["discreteGroups"][z]["title"]).to eq "ST mm"
			expect(response["model"]["discreteGroups"][z]["viewCategory"]).to eq "stcomp"
	  	elsif(response["model"]["discreteGroups"][z]["keys"][0] == "1816")	
			expect(response["model"]["discreteGroups"][z]["isEpisodic"]).to be false
			expect(response["model"]["discreteGroups"][z]["keys"][0]).to eq "1087"
			expect(response["model"]["discreteGroups"][z]["layoutDiscreteDirection"]).to eq "layoutDiscretesBottom"
			expect(response["model"]["discreteGroups"][z]["textColor"]).to eq "E81E1E"
			expect(response["model"]["discreteGroups"][z]["title"]).to eq "ART_PAW1 mm[Hg]"
			expect(response["model"]["discreteGroups"][z]["viewCategory"]).to eq "single"
		elsif(response["model"]["discreteGroups"][z]["keys"][0] == "1816")	
			expect(response["model"]["discreteGroups"][z]["isEpisodic"]).to be true
			expect(response["model"]["discreteGroups"][z]["keys"][0]).to eq "1299"
			expect(response["model"]["discreteGroups"][z]["layoutDiscreteDirection"]).to eq "layoutDiscretesBottom"
			expect(response["model"]["discreteGroups"][z]["textColor"]).to eq "E81E1E"
			expect(response["model"]["discreteGroups"][z]["title"]).to eq "PulseRate {beat}/min"
			expect(response["model"]["discreteGroups"][z]["viewCategory"]).to eq "single"
		elsif(response["model"]["discreteGroups"][z]["keys"][0] == "1816")	
			expect(response["model"]["discreteGroups"][z]["isEpisodic"]).to be false
			expect(response["model"]["discreteGroups"][z]["keys"][0]).to eq "1438"
			expect(response["model"]["discreteGroups"][z]["layoutDiscreteDirection"]).to eq "layoutDiscretesBottom"
			expect(response["model"]["discreteGroups"][z]["textColor"]).to eq "E81E1E"
			expect(response["model"]["discreteGroups"][z]["title"]).to eq "AR1-R {beat}/min"
			expect(response["model"]["discreteGroups"][z]["viewCategory"]).to eq "single"
		elsif(response["model"]["discreteGroups"][z]["keys"][0] == "1816")	
			expect(response["model"]["discreteGroups"][z]["isEpisodic"]).to be true
			expect(response["model"]["discreteGroups"][z]["keys"][0]).to eq "1840"
			expect(response["model"]["discreteGroups"][z]["layoutDiscreteDirection"]).to eq "layoutDiscretesBottom"
			expect(response["model"]["discreteGroups"][z]["textColor"]).to eq "4875B1"
			expect(response["model"]["discreteGroups"][z]["title"]).to eq "CuffPres mm[Hg]"
			expect(response["model"]["discreteGroups"][z]["viewCategory"]).to eq "single"
		end
	end 
end
