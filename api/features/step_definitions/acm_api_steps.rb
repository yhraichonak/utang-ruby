Before do
  @Acm_api = Acm_api.new
end

Then(/^I try acwa db stuff$/) do  
    server = 'ASTQAFEDHOST03'
    database = 'acwaservices'
    username = 'acwarealtimeuser'
    password = 'XXXXX'
    
    client = TinyTds::Client.new username: username, password: password, 
        host: server, port: 1433, database: database, azure: false
    
    puts "** Reading data from FratRecords table **"
    
    tsql = "SELECT * FROM FratRecords WHERE  [Asmpid] = '74d44abc-0884-4ff5-a2c8-a67951c67bee' ORDER BY CreatedTimestamp DESC"
    result = client.execute(tsql)
   # client.close
    puts result.count
    result.each do |row|
        puts row
    end
    puts "======="
    result = result.to_a
    puts result[0]["Id"]
    puts result[0]["UserName"]
    puts result[0]["CreatedTimestamp"]
    puts result[0]["Asmpid"]
    puts result[0]["Unit"]
    puts result[0]["Location"]
    puts result[0]["SiteId"]
    puts "======="    
end

Then(/^I try db stuff$/) do
    #client = TinyTds::Client.new username: 'acwarealtimeuser', password: 'XXXXX', host: 'ASTDEVSQL01P'
    #result = client.execute("SELECT * FROM [datatypes]")
    #puts result
    ##
    #require 'sequel'
    #DB = Sequel.connect('sqlserver://ASTDEVSQL01P/acwarealtime', user: 'acwarealtimeuser', password: 'XXXXX')
    #DB.fetch("SELECT * FROM RuleConditions") do |row|
    #  puts row[:name]
    #end
    
      #require 'tiny_tds'
      server = 'ASTDEVSQL01P'
      database = 'acwarealtime'
      username = 'acwarealtimeuser'
      password = 'XXXXX'
      
      client = TinyTds::Client.new username: username, password: password, 
          host: server, port: 1433, database: database, azure: false
      
      puts "** Reading data from AlertRules table **"
      
      tsql = "SELECT * FROM AlertRules ORDER BY InsertTimestamp DESC"
      result = client.execute(tsql)
     # client.close
      puts result.count
      result.each do |row|
          puts row
      end
      puts "======="
      result = result.to_a
      puts result[0]["Id"]
      puts result[0]["EventLabel"]
      puts result[0]["AlertText"]
      puts result[0]["InsertTimestamp"]
      puts "======="
      
      time_needed = result[0]["InsertTimestamp"]
      ##
      puts "** Reading data from RuleConditions table **"
      
      tsql = "SELECT * FROM RuleConditions"
      result = client.execute(tsql)
     # client.close
      puts result.count
      result.each do |row|
          #puts row
      end
      
      result = result.to_a
      puts "======="
      #puts result[0]
      puts result[0]["Id"]
      puts result[0]["AlertRuleId"]
      puts result[0]["DurationSeconds"]
      puts result[0]["Percentage"]
      puts result[0]["SuspensionSeconds"]
      puts result[0]["IsSuppressAll"]
      puts result[0]["Unit"]
      puts result[0]["Bed"]
      puts result[0]["InsertTimestamp"]
      puts result[0]["Site"]
      puts "======="
      
      puts "%%%%%%%%%%%%%%%%%%%"
      puts time_needed
      puts time_needed.to_date
      
      d = Date.strptime(time_needed, '%a, %d %b %Y %H:%M:%S %Z') 
      
      puts "++++++++++++"
      puts d
      puts "++++++++++++"
      
      puts "%%%%%%%%%%%%%%%%%%%"
      
      tsql = "SELECT * FROM RuleConditions where InsertTimestamp = '#{time_needed}'"
      result = client.execute(tsql)
     # client.close
      puts result.count
      result.each do |row|
          #puts row
      end
      
      result = result.to_a
      puts "^^^^^^^^^^^"
      #puts result[0]
      puts result[0]["Id"]
      puts result[0]["AlertRuleId"]
      puts result[0]["DurationSeconds"]
      puts result[0]["Percentage"]
      puts result[0]["SuspensionSeconds"]
      puts result[0]["IsSuppressAll"]
      puts result[0]["Unit"]
      puts result[0]["Bed"]
      puts result[0]["InsertTimestamp"]
      puts result[0]["Site"]
      puts "^^^^^^^^^^^"
      
  end
  

Then(/^it should post the ACM rules$/) do #"(.*?)" and key name "(.*?)"$/) do | site_id, key_name |
  # original response payload = '{"responseCode"=>0, "model"=>[{"EventLabel"=>"VTach", "AlertText"=>"VTach", "RuleConditions"=>[{"DurationSeconds"=>1, "Percentage"=>100, "SuspensionSeconds"=>60, "IsSuppressAll"=>false, "Facility"=>"Facility X", "Unit"=>nil, "Bed"=>nil}, {"DurationSeconds"=>1, "Percentage"=>100, "SuspensionSeconds"=>60, "IsSuppressAll"=>false, "Facility"=>"Facility X", "Unit"=>"ACM", "Bed"=>nil}, {"DurationSeconds"=>1, "Percentage"=>100, "SuspensionSeconds"=>60, "IsSuppressAll"=>false, "Facility"=>"Facility X", "Unit"=>"ACM", "Bed"=>"ACM1"}, {"DurationSeconds"=>5, "Percentage"=>3, "SuspensionSeconds"=>12, "IsSuppressAll"=>false, "Facility"=>"Site-34", "Unit"=>"ICU1", "Bed"=>nil}], "alarmFrequencySeconds"=>0}, {"EventLabel"=>"Brady", "AlertText"=>"Brady", "RuleConditions"=>[{"DurationSeconds"=>1, "Percentage"=>100, "SuspensionSeconds"=>60, "IsSuppressAll"=>false, "Facility"=>"Facility Y", "Unit"=>nil, "Bed"=>nil}], "alarmFrequencySeconds"=>0}, {"EventLabel"=>"Asystole", "AlertText"=>"Asystole", "RuleConditions"=>[{"DurationSeconds"=>1, "Percentage"=>100, "SuspensionSeconds"=>60, "IsSuppressAll"=>false, "Facility"=>"Facility Y", "Unit"=>nil, "Bed"=>nil}], "alarmFrequencySeconds"=>0}, {"EventLabel"=>"Tachy", "AlertText"=>"Tachy", "RuleConditions"=>[{"DurationSeconds"=>1, "Percentage"=>100, "SuspensionSeconds"=>60, "IsSuppressAll"=>false, "Facility"=>"Facility Y", "Unit"=>nil, "Bed"=>nil}], "alarmFrequencySeconds"=>0}, {"EventLabel"=>"VFib/VTac", "AlertText"=>"VFib/VTac", "RuleConditions"=>[{"DurationSeconds"=>1, "Percentage"=>100, "SuspensionSeconds"=>60, "IsSuppressAll"=>false, "Facility"=>"Facility Y", "Unit"=>nil, "Bed"=>nil}], "alarmFrequencySeconds"=>0}, {"EventLabel"=>"Leads Fail", "AlertText"=>"Leads Fail", "RuleConditions"=>[{"DurationSeconds"=>1, "Percentage"=>100, "SuspensionSeconds"=>60, "IsSuppressAll"=>true, "Facility"=>"Facility Z", "Unit"=>nil, "Bed"=>nil}], "alarmFrequencySeconds"=>0}], "error"=>nil}'
  payload = '[   
    {
        "EventLabel": "VTach",
        "AlertText": "VTach",
        "RuleConditions": [
            {
                "DurationSeconds": 1,
                "Percentage": 100,
                "SuspensionSeconds": 60,
                "IsSuppressAll": false,
                "Site": "Facility X",               
                "Unit": null,
                "Bed": null
            },
            {
                "DurationSeconds": 1,
                "Percentage": 100,
                "SuspensionSeconds": 60,
                "IsSuppressAll": false,
                "Site": "Facility X",               
                "Unit": "ACM",
                "Bed": null
            },
            {
                "DurationSeconds": 1,
                "Percentage": 100,
                "SuspensionSeconds": 60,
                "IsSuppressAll": false,
                "Site": "Facility X",               
                "Unit": "ACM",
                "Bed": "ACM1"
            },
            {
                "DurationSeconds": 5,
                "Percentage": 3,
                "SuspensionSeconds": 12,
                "IsSuppressAll": false,
                "Site": "Site-34",               
                "Unit": "ICU1",
                "Bed": "B850"
            }
        ]       
    },
    {
        "EventLabel": "Brady",
        "AlertText": "Brady",
        "RuleConditions": [
            {
                "DurationSeconds": 1,
                "Percentage": 100,
                "SuspensionSeconds": 60,
                "IsSuppressAll": false,
                "Site": "Facility Y",               
                "Unit": null,
                "Bed": null
            }       
        ]       
    },
    {
        "EventLabel": "Asystole",
        "AlertText": "Asystole",
        "RuleConditions": [
            {
                "DurationSeconds": 1,
                "Percentage": 100,
                "SuspensionSeconds": 60,
                "IsSuppressAll": false,
                "Site": "Facility Y",               
                "Unit": null,
                "Bed": null
            }       
        ]       
    },
    {
        "EventLabel": "Tachy",
        "AlertText": "Tachy",
        "RuleConditions": [
            {
                "DurationSeconds": 1,
                "Percentage": 100,
                "SuspensionSeconds": 60,
                "IsSuppressAll": false,
                "Site": "Facility Y",               
                "Unit": null,
                "Bed": null
            }       
        ]       
    },
    {
        "EventLabel": "VFib/VTac",
        "AlertText": "VFib/VTac",
        "RuleConditions": [
            {
                "DurationSeconds": 1,
                "Percentage": 100,
                "SuspensionSeconds": 60,
                "IsSuppressAll": false,
                "Site": "Facility Y",               
                "Unit": null,
                "Bed": null
            }       
        ]       
    },
    {
        "EventLabel": "Leads Fail",
        "AlertText": "Leads Fail",
        "RuleConditions": [
            {
                "DurationSeconds": 1,
                "Percentage": 100,
                "SuspensionSeconds": 60,
                "IsSuppressAll": true,
                "Site": "Facility Z",               
                "Unit": null,
                "Bed": null
            }       
        ]       
    }   
]'
  
  #payload = payload.to_json
  response = @Acm_api.acm_rules_update(payload)
  
  if $DEBUG_FLAG == "debug"
    puts response
  end
    
  expect(response["responseCode"]).to eq 0
end

Then(/^it should return the ACM rules$/) do #"(.*?)" and key name "(.*?)"$/) do | site_id, key_name |
  response = @Acm_api.acm_rules
  
  if $DEBUG_FLAG == "debug"
    puts response
  end
  
  expect(response["responseCode"]).to eq 0
  expect(response["model"].count).to be > 0
end

Then(/^it should return the ACM QA rules$/) do #"(.*?)" and key name "(.*?)"$/) do | site_id, key_name |
  response = @Acm_api.acm_qa_rules
  
  if $DEBUG_FLAG == "debug"
    puts response
  end
  
  expect(response["responseCode"]).to eq 0
  expect(response["model"].count).to be > 0
  $ACM_QA_FLAG = true
end

Then(/^it should return the ACM FED rules$/) do #"(.*?)" and key name "(.*?)"$/) do | site_id, key_name |
  response = @Acm_api.acm_fed_rules
  
  if $DEBUG_FLAG == "debug"
    puts response
  end
  
  expect(response["responseCode"]).to eq 0
  expect(response["model"].count).to be > 0
  $ACM_FED_FLAG = true
end

Then(/^it should return the ACM FED QA rules$/) do #"(.*?)" and key name "(.*?)"$/) do | site_id, key_name |
  response = @Acm_api.acm_fed_qa_rules
  
  if $DEBUG_FLAG == "debug"
    puts response
  end
  
  expect(response["responseCode"]).to eq 0
  expect(response["model"].count).to be > 0
  $ACM_FED_QA_FLAG = true
end

Then(/^it should post the ACM QA rules$/) do #"(.*?)" and key name "(.*?)"$/) do | site_id, key_name |
  # original response payload = '{"responseCode"=>0, "model"=>[{"EventLabel"=>"VTach", "AlertText"=>"VTach", "RuleConditions"=>[{"DurationSeconds"=>1, "Percentage"=>100, "SuspensionSeconds"=>60, "IsSuppressAll"=>false, "Facility"=>"Facility X", "Unit"=>nil, "Bed"=>nil}, {"DurationSeconds"=>1, "Percentage"=>100, "SuspensionSeconds"=>60, "IsSuppressAll"=>false, "Facility"=>"Facility X", "Unit"=>"ACM", "Bed"=>nil}, {"DurationSeconds"=>1, "Percentage"=>100, "SuspensionSeconds"=>60, "IsSuppressAll"=>false, "Facility"=>"Facility X", "Unit"=>"ACM", "Bed"=>"ACM1"}, {"DurationSeconds"=>5, "Percentage"=>3, "SuspensionSeconds"=>12, "IsSuppressAll"=>false, "Facility"=>"Site-34", "Unit"=>"ICU1", "Bed"=>nil}], "alarmFrequencySeconds"=>0}, {"EventLabel"=>"Brady", "AlertText"=>"Brady", "RuleConditions"=>[{"DurationSeconds"=>1, "Percentage"=>100, "SuspensionSeconds"=>60, "IsSuppressAll"=>false, "Facility"=>"Facility Y", "Unit"=>nil, "Bed"=>nil}], "alarmFrequencySeconds"=>0}, {"EventLabel"=>"Asystole", "AlertText"=>"Asystole", "RuleConditions"=>[{"DurationSeconds"=>1, "Percentage"=>100, "SuspensionSeconds"=>60, "IsSuppressAll"=>false, "Facility"=>"Facility Y", "Unit"=>nil, "Bed"=>nil}], "alarmFrequencySeconds"=>0}, {"EventLabel"=>"Tachy", "AlertText"=>"Tachy", "RuleConditions"=>[{"DurationSeconds"=>1, "Percentage"=>100, "SuspensionSeconds"=>60, "IsSuppressAll"=>false, "Facility"=>"Facility Y", "Unit"=>nil, "Bed"=>nil}], "alarmFrequencySeconds"=>0}, {"EventLabel"=>"VFib/VTac", "AlertText"=>"VFib/VTac", "RuleConditions"=>[{"DurationSeconds"=>1, "Percentage"=>100, "SuspensionSeconds"=>60, "IsSuppressAll"=>false, "Facility"=>"Facility Y", "Unit"=>nil, "Bed"=>nil}], "alarmFrequencySeconds"=>0}, {"EventLabel"=>"Leads Fail", "AlertText"=>"Leads Fail", "RuleConditions"=>[{"DurationSeconds"=>1, "Percentage"=>100, "SuspensionSeconds"=>60, "IsSuppressAll"=>true, "Facility"=>"Facility Z", "Unit"=>nil, "Bed"=>nil}], "alarmFrequencySeconds"=>0}], "error"=>nil}'
  payload = '[   
    {
        "EventLabel": "VTach",
        "AlertText": "VTach",
        "RuleConditions": [
            {
                "DurationSeconds": 1,
                "Percentage": 100,
                "SuspensionSeconds": 60,
                "IsSuppressAll": false,
                "Site": "Facility X",               
                "Unit": null,
                "Bed": null
            },
            {
                "DurationSeconds": 1,
                "Percentage": 100,
                "SuspensionSeconds": 60,
                "IsSuppressAll": false,
                "Site": "Facility X",               
                "Unit": "ACM",
                "Bed": null
            },
            {
                "DurationSeconds": 1,
                "Percentage": 100,
                "SuspensionSeconds": 60,
                "IsSuppressAll": false,
                "Site": "Facility X",               
                "Unit": "ACM",
                "Bed": "ACM1"
            },
            {
                "DurationSeconds": 5,
                "Percentage": 3,
                "SuspensionSeconds": 12,
                "IsSuppressAll": false,
                "Site": "Site-34",               
                "Unit": "ICU1",
                "Bed": "B850"
            }
        ]       
    },
    {
        "EventLabel": "Brady",
        "AlertText": "Brady",
        "RuleConditions": [
            {
                "DurationSeconds": 1,
                "Percentage": 100,
                "SuspensionSeconds": 300,
                "IsSuppressAll": false,
                "Site": "Site-34",               
                "Unit": null,
                "Bed": null
            }       
        ]       
    },
    {
        "EventLabel": "Asystole",
        "AlertText": "Asystole",
        "RuleConditions": [
            {
                "DurationSeconds": 1,
                "Percentage": 100,
                "SuspensionSeconds": 60,
                "IsSuppressAll": false,
                "Site": "Facility Y",               
                "Unit": null,
                "Bed": null
            }       
        ]       
    },
    {
        "EventLabel": "Tachy",
        "AlertText": "Tachy",
        "RuleConditions": [
            {
                "DurationSeconds": 1,
                "Percentage": 100,
                "SuspensionSeconds": 60,
                "IsSuppressAll": false,
                "Site": "Facility Y",               
                "Unit": null,
                "Bed": null
            }       
        ]       
    },
    {
        "EventLabel": "VFib/VTac",
        "AlertText": "VFib/VTac",
        "RuleConditions": [
            {
                "DurationSeconds": 1,
                "Percentage": 100,
                "SuspensionSeconds": 60,
                "IsSuppressAll": false,
                "Site": "Facility Y",               
                "Unit": null,
                "Bed": null
            }       
        ]       
    },
    {
        "EventLabel": "Leads Fail",
        "AlertText": "Leads Fail",
        "RuleConditions": [
            {
                "DurationSeconds": 1,
                "Percentage": 100,
                "SuspensionSeconds": 60,
                "IsSuppressAll": true,
                "Site": "Facility Z",               
                "Unit": null,
                "Bed": null
            }       
        ]       
    }   
]'
  
  #payload = payload.to_json
  response = @Acm_api.acm_qa_rules_update(payload)
  
  if $DEBUG_FLAG == "debug"
    puts response
  end
  
  expect(response["responseCode"]).to eq 0
end

Then(/^it should post the ACM FED rules$/) do #"(.*?)" and key name "(.*?)"$/) do | site_id, key_name |
  # original response payload = '{"responseCode"=>0, "model"=>[{"EventLabel"=>"VTach", "AlertText"=>"VTach", "RuleConditions"=>[{"DurationSeconds"=>1, "Percentage"=>100, "SuspensionSeconds"=>60, "IsSuppressAll"=>false, "Facility"=>"Facility X", "Unit"=>nil, "Bed"=>nil}, {"DurationSeconds"=>1, "Percentage"=>100, "SuspensionSeconds"=>60, "IsSuppressAll"=>false, "Facility"=>"Facility X", "Unit"=>"ACM", "Bed"=>nil}, {"DurationSeconds"=>1, "Percentage"=>100, "SuspensionSeconds"=>60, "IsSuppressAll"=>false, "Facility"=>"Facility X", "Unit"=>"ACM", "Bed"=>"ACM1"}, {"DurationSeconds"=>5, "Percentage"=>3, "SuspensionSeconds"=>12, "IsSuppressAll"=>false, "Facility"=>"Site-34", "Unit"=>"ICU1", "Bed"=>nil}], "alarmFrequencySeconds"=>0}, {"EventLabel"=>"Brady", "AlertText"=>"Brady", "RuleConditions"=>[{"DurationSeconds"=>1, "Percentage"=>100, "SuspensionSeconds"=>60, "IsSuppressAll"=>false, "Facility"=>"Facility Y", "Unit"=>nil, "Bed"=>nil}], "alarmFrequencySeconds"=>0}, {"EventLabel"=>"Asystole", "AlertText"=>"Asystole", "RuleConditions"=>[{"DurationSeconds"=>1, "Percentage"=>100, "SuspensionSeconds"=>60, "IsSuppressAll"=>false, "Facility"=>"Facility Y", "Unit"=>nil, "Bed"=>nil}], "alarmFrequencySeconds"=>0}, {"EventLabel"=>"Tachy", "AlertText"=>"Tachy", "RuleConditions"=>[{"DurationSeconds"=>1, "Percentage"=>100, "SuspensionSeconds"=>60, "IsSuppressAll"=>false, "Facility"=>"Facility Y", "Unit"=>nil, "Bed"=>nil}], "alarmFrequencySeconds"=>0}, {"EventLabel"=>"VFib/VTac", "AlertText"=>"VFib/VTac", "RuleConditions"=>[{"DurationSeconds"=>1, "Percentage"=>100, "SuspensionSeconds"=>60, "IsSuppressAll"=>false, "Facility"=>"Facility Y", "Unit"=>nil, "Bed"=>nil}], "alarmFrequencySeconds"=>0}, {"EventLabel"=>"Leads Fail", "AlertText"=>"Leads Fail", "RuleConditions"=>[{"DurationSeconds"=>1, "Percentage"=>100, "SuspensionSeconds"=>60, "IsSuppressAll"=>true, "Facility"=>"Facility Z", "Unit"=>nil, "Bed"=>nil}], "alarmFrequencySeconds"=>0}], "error"=>nil}'
  payload = '[   
    {
        "EventLabel": "VTach",
        "AlertText": "VTach",
        "RuleConditions": [
            {
                "DurationSeconds": 1,
                "Percentage": 100,
                "SuspensionSeconds": 60,
                "IsSuppressAll": false,
                "Site": "Facility X",               
                "Unit": null,
                "Bed": null
            },
            {
                "DurationSeconds": 1,
                "Percentage": 100,
                "SuspensionSeconds": 60,
                "IsSuppressAll": false,
                "Site": "Facility X",               
                "Unit": "ACM",
                "Bed": null
            },
            {
                "DurationSeconds": 1,
                "Percentage": 100,
                "SuspensionSeconds": 60,
                "IsSuppressAll": false,
                "Site": "Facility X",               
                "Unit": "ACM",
                "Bed": "ACM1"
            },
            {
                "DurationSeconds": 5,
                "Percentage": 3,
                "SuspensionSeconds": 12,
                "IsSuppressAll": false,
                "Site": "Site-34",               
                "Unit": "ICU1",
                "Bed": "B850"
            }
        ]       
    },
    {
        "EventLabel": "Brady",
        "AlertText": "Brady",
        "RuleConditions": [
            {
                "DurationSeconds": 1,
                "Percentage": 100,
                "SuspensionSeconds": 60,
                "IsSuppressAll": false,
                "Site": "Facility Y",               
                "Unit": null,
                "Bed": null
            }       
        ]       
    },
    {
        "EventLabel": "Asystole",
        "AlertText": "Asystole",
        "RuleConditions": [
            {
                "DurationSeconds": 1,
                "Percentage": 100,
                "SuspensionSeconds": 60,
                "IsSuppressAll": false,
                "Site": "Facility Y",               
                "Unit": null,
                "Bed": null
            }       
        ]       
    },
    {
        "EventLabel": "Tachy",
        "AlertText": "Tachy",
        "RuleConditions": [
            {
                "DurationSeconds": 1,
                "Percentage": 100,
                "SuspensionSeconds": 60,
                "IsSuppressAll": false,
                "Site": "Facility Y",               
                "Unit": null,
                "Bed": null
            }       
        ]       
    },
    {
        "EventLabel": "VFib/VTac",
        "AlertText": "VFib/VTac",
        "RuleConditions": [
            {
                "DurationSeconds": 1,
                "Percentage": 100,
                "SuspensionSeconds": 60,
                "IsSuppressAll": false,
                "Site": "Facility Y",               
                "Unit": null,
                "Bed": null
            }       
        ]       
    },
    {
        "EventLabel": "Leads Fail",
        "AlertText": "Leads Fail",
        "RuleConditions": [
            {
                "DurationSeconds": 1,
                "Percentage": 100,
                "SuspensionSeconds": 60,
                "IsSuppressAll": true,
                "Site": "Facility Z",               
                "Unit": null,
                "Bed": null
            }       
        ]       
    }   
]'
  
  #payload = payload.to_json
  response = @Acm_api.acm_fed_rules_update(payload)
  
  if $DEBUG_FLAG == "debug"
    puts response
  end
  
  expect(response["responseCode"]).to eq 0
end

Then(/^it should post the ACM FED QA rules$/) do #"(.*?)" and key name "(.*?)"$/) do | site_id, key_name |
  # original response payload = '{"responseCode"=>0, "model"=>[{"EventLabel"=>"VTach", "AlertText"=>"VTach", "RuleConditions"=>[{"DurationSeconds"=>1, "Percentage"=>100, "SuspensionSeconds"=>60, "IsSuppressAll"=>false, "Facility"=>"Facility X", "Unit"=>nil, "Bed"=>nil}, {"DurationSeconds"=>1, "Percentage"=>100, "SuspensionSeconds"=>60, "IsSuppressAll"=>false, "Facility"=>"Facility X", "Unit"=>"ACM", "Bed"=>nil}, {"DurationSeconds"=>1, "Percentage"=>100, "SuspensionSeconds"=>60, "IsSuppressAll"=>false, "Facility"=>"Facility X", "Unit"=>"ACM", "Bed"=>"ACM1"}, {"DurationSeconds"=>5, "Percentage"=>3, "SuspensionSeconds"=>12, "IsSuppressAll"=>false, "Facility"=>"Site-34", "Unit"=>"ICU1", "Bed"=>nil}], "alarmFrequencySeconds"=>0}, {"EventLabel"=>"Brady", "AlertText"=>"Brady", "RuleConditions"=>[{"DurationSeconds"=>1, "Percentage"=>100, "SuspensionSeconds"=>60, "IsSuppressAll"=>false, "Facility"=>"Facility Y", "Unit"=>nil, "Bed"=>nil}], "alarmFrequencySeconds"=>0}, {"EventLabel"=>"Asystole", "AlertText"=>"Asystole", "RuleConditions"=>[{"DurationSeconds"=>1, "Percentage"=>100, "SuspensionSeconds"=>60, "IsSuppressAll"=>false, "Facility"=>"Facility Y", "Unit"=>nil, "Bed"=>nil}], "alarmFrequencySeconds"=>0}, {"EventLabel"=>"Tachy", "AlertText"=>"Tachy", "RuleConditions"=>[{"DurationSeconds"=>1, "Percentage"=>100, "SuspensionSeconds"=>60, "IsSuppressAll"=>false, "Facility"=>"Facility Y", "Unit"=>nil, "Bed"=>nil}], "alarmFrequencySeconds"=>0}, {"EventLabel"=>"VFib/VTac", "AlertText"=>"VFib/VTac", "RuleConditions"=>[{"DurationSeconds"=>1, "Percentage"=>100, "SuspensionSeconds"=>60, "IsSuppressAll"=>false, "Facility"=>"Facility Y", "Unit"=>nil, "Bed"=>nil}], "alarmFrequencySeconds"=>0}, {"EventLabel"=>"Leads Fail", "AlertText"=>"Leads Fail", "RuleConditions"=>[{"DurationSeconds"=>1, "Percentage"=>100, "SuspensionSeconds"=>60, "IsSuppressAll"=>true, "Facility"=>"Facility Z", "Unit"=>nil, "Bed"=>nil}], "alarmFrequencySeconds"=>0}], "error"=>nil}'
  payload = '[   
    {
        "EventLabel": "VTach",
        "AlertText": "VTach",
        "RuleConditions": [
            {
                "DurationSeconds": 1,
                "Percentage": 100,
                "SuspensionSeconds": 60,
                "IsSuppressAll": false,
                "Site": "Facility X",               
                "Unit": null,
                "Bed": null
            },
            {
                "DurationSeconds": 1,
                "Percentage": 100,
                "SuspensionSeconds": 60,
                "IsSuppressAll": false,
                "Site": "Facility X",               
                "Unit": "ACM",
                "Bed": null
            },
            {
                "DurationSeconds": 1,
                "Percentage": 100,
                "SuspensionSeconds": 60,
                "IsSuppressAll": false,
                "Site": "Facility X",               
                "Unit": "ACM",
                "Bed": "ACM1"
            },
            {
                "DurationSeconds": 5,
                "Percentage": 3,
                "SuspensionSeconds": 12,
                "IsSuppressAll": false,
                "Site": "Site-34",               
                "Unit": "ICU1",
                "Bed": "B850"
            }
        ]       
    },
    {
        "EventLabel": "Brady",
        "AlertText": "Brady",
        "RuleConditions": [
            {
                "DurationSeconds": 1,
                "Percentage": 100,
                "SuspensionSeconds": 60,
                "IsSuppressAll": false,
                "Site": "Facility Y",               
                "Unit": null,
                "Bed": null
            }       
        ]       
    },
    {
        "EventLabel": "Asystole",
        "AlertText": "Asystole",
        "RuleConditions": [
            {
                "DurationSeconds": 1,
                "Percentage": 100,
                "SuspensionSeconds": 60,
                "IsSuppressAll": false,
                "Site": "Facility Y",               
                "Unit": null,
                "Bed": null
            }       
        ]       
    },
    {
        "EventLabel": "Tachy",
        "AlertText": "Tachy",
        "RuleConditions": [
            {
                "DurationSeconds": 1,
                "Percentage": 100,
                "SuspensionSeconds": 60,
                "IsSuppressAll": false,
                "Site": "Facility Y",               
                "Unit": null,
                "Bed": null
            }       
        ]       
    },
    {
        "EventLabel": "VFib/VTac",
        "AlertText": "VFib/VTac",
        "RuleConditions": [
            {
                "DurationSeconds": 1,
                "Percentage": 100,
                "SuspensionSeconds": 60,
                "IsSuppressAll": false,
                "Site": "Facility Y",               
                "Unit": null,
                "Bed": null
            }       
        ]       
    },
    {
        "EventLabel": "Leads Fail",
        "AlertText": "Leads Fail",
        "RuleConditions": [
            {
                "DurationSeconds": 1,
                "Percentage": 100,
                "SuspensionSeconds": 60,
                "IsSuppressAll": true,
                "Site": "Facility Z",               
                "Unit": null,
                "Bed": null
            }       
        ]       
    }   
]'
  
  #payload = payload.to_json
  response = @Acm_api.acm_fed_qa_rules_update(payload)
  
  if $DEBUG_FLAG == "debug"
    puts response
  end
  
  expect(response["responseCode"]).to eq 0
end

And(/^it should return rule "(.*?)" with category "(.*?)" alert text "(.*?)"$/) do | which_rule, category, alert_text |
  if ($ACM_FED_FLAG == true)
    response = @Acm_api.acm_fed_rules
  elsif ($ACM_FED_QA_FLAG == true)
    response = @Acm_api.acm_fed_qa_rules
  elsif ($ACM_QA_FLAG == true)
    response = @Acm_api.acm_qa_rules
  else
    response = @Acm_api.acm_rules
  end
  
  if $DEBUG_FLAG == "debug"
    puts response
  end
  
  expect(response["responseCode"]).to eq 0
  expect(response["model"][(which_rule.to_i - 1)]["EventLabel"]).to eq category
  expect(response["model"][(which_rule.to_i - 1)]["AlertText"]).to eq alert_text
  #expect(response["model"][(which_rule.to_i - 1)]["alarmFrequencySeconds"]).to eq frequency.to_i
end

And(/^it should return rule "(.*?)" with event label "(.*?)" and alert text "(.*?)"$/) do | which_rule, event_label, alert_text |
  if ($ACM_FED_FLAG == true)
    response = @Acm_api.acm_fed_rules
  elsif ($ACM_FED_QA_FLAG == true)
    response = @Acm_api.acm_fed_qa_rules
  elsif ($ACM_QA_FLAG == true)
    response = @Acm_api.acm_qa_rules
  else
    response = @Acm_api.acm_rules
  end
  
  if $DEBUG_FLAG == "debug"
    puts response
  end
  
  expect(response["responseCode"]).to eq 0
  expect(response["model"][(which_rule.to_i - 1)]["EventLabel"]).to eq event_label
  expect(response["model"][(which_rule.to_i - 1)]["AlertText"]).to eq alert_text
  #expect(response["model"][(which_rule.to_i - 1)]["alarmFrequencySeconds"]).to eq frequency.to_i
end

And(/^it should return rule "(.*?)" condition "(.*?)" with duration "(.*?)" percentage "(.*?)" suspension "(.*?)" is suppress all "(.*?)" facility "(.*?)" unit "(.*?)" bed "(.*?)"$/) do | which_rule, which_condition, duration, percentage, suspension, is_suppress_all, facility, unit, bed |
#And(/^it should return rule "(.*?)" condition "(.*?)" with duration "(.*?)"(\d+)"(.*?)"(\d+)"(.*?)"false"(.*?)"Facility X"(.*?)""(.*?)""$/) do |arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10|
  if ($ACM_FED_FLAG == true)
    response = @Acm_api.acm_fed_rules
  elsif ($ACM_FED_QA_FLAG == true)
    response = @Acm_api.acm_fed_qa_rules
  elsif ($ACM_QA_FLAG == true)
    response = @Acm_api.acm_qa_rules
  else
    response = @Acm_api.acm_rules
  end
  
  if $DEBUG_FLAG == "debug"
    puts response
  end
  
  expect(response["responseCode"]).to eq 0
  expect(response["model"][(which_rule.to_i - 1)]["RuleConditions"][(which_condition.to_i - 1)]["DurationSeconds"]).to eq duration.to_i
  expect(response["model"][(which_rule.to_i - 1)]["RuleConditions"][(which_condition.to_i - 1)]["Percentage"]).to eq percentage.to_i
  expect(response["model"][(which_rule.to_i - 1)]["RuleConditions"][(which_condition.to_i - 1)]["SuspensionSeconds"]).to eq suspension.to_i
  expect(response["model"][(which_rule.to_i - 1)]["RuleConditions"][(which_condition.to_i - 1)]["IsSuppressAll"].to_s).to eq is_suppress_all
  expect(response["model"][(which_rule.to_i - 1)]["RuleConditions"][(which_condition.to_i - 1)]["Site"]).to eq facility
  expect(response["model"][(which_rule.to_i - 1)]["RuleConditions"][(which_condition.to_i - 1)]["Unit"].to_s).to eq unit
  expect(response["model"][(which_rule.to_i - 1)]["RuleConditions"][(which_condition.to_i - 1)]["Bed"].to_s).to eq bed
 
end