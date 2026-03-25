Before do
  @Fed_api = Fed_api.new
  @RulesEngine_api = RulesEngine_api.new 
end

Then(/^it should create and view "(.*?)" for "(.*?)"$/) do | location, site_name |
  if site_name == "34 QA Cardio PM"
    site_id = 1763
  elsif  site_name == "Automation Site"
    site_id = 4751
  end
  
  random_num = Common.rd_number
  
  $location_name = "#{location}_#{random_num}"
  payload = '{ "Name":"' + $location_name + '","SiteId":"' + site_id.to_s + '",'\
              '"AcknowledgementRequired":false,'\
              '"IncludeEmsEcgs":false,'\
               '"OnlyEmsEcgs":"false",'\
               '"dxStmtCodeOrString":"Statement",'\
               '"conditionTypes":"DxStmt",'\
               '"DiagnosticStatements":"SNF",'\
               '"ToBePostedConditions": [{"conditionType":"QTC","conditionValue":"100","conditionId":1000,"conditionDisplay":"Select One"}]}'
  create_response = @RulesEngine_api.save_location(payload)
  
  $location_one_id = create_response["model"]["id"]	
  
  get_response = @RulesEngine_api.get_location_by_id($location_one_id)
    
  expect(get_response["responseCode"]).to eq 0
  expect(get_response["model"]["id"]).to eq $location_one_id
  expect(get_response["model"]["name"]).to eq $location_name
  expect(get_response["model"]["siteId"]).to eq site_id
end

Then(/^it should get locations for site "(.*?)"$/) do | site_name |

  if site_name == "34 QA Cardio PM"
    site_id = 1763
  elsif  site_name == "Automation Site"
    site_id = 4751
  end

  response = @RulesEngine_api.get_location_by_site_id(site_id)

  expect(response["model"][0]["name"]).to include "location_one"
  expect(response["model"][0]["siteId"]).to eq site_id

end

Then(/^it should create and view by name "(.*?)" and site "(.*?)"$/) do | location, site_name |
  if site_name == "34 QA Cardio PM"
    site_id = 1763
    elsif site_name == "Automation Site"
    site_id = 4751
  end
  random_num = Common.rd_number
  
  $location_two_name = "#{location}_#{random_num}" 
  
  payload = '{"Id":0,"Name":"' + $location_two_name + '","SiteId":"' + site_id.to_s + '"}'	
  create_response = @RulesEngine_api.save_location(payload)
  
  location_id = create_response["model"]["id"].to_s	

  get_response = @RulesEngine_api.get_location_by_site_and_name(site_id.to_s, $location_two_name.to_s)

  expect(get_response["responseCode"]).to eq 0
  expect(get_response["model"][0]["id"].to_s).to eq location_id
  expect(get_response["model"][0]["name"]).to eq $location_two_name
  expect(get_response["model"][0]["siteId"]).to eq site_id
end

Then(/^it should create "(.*?)" for "(.*?)" then update to "(.*?)"$/) do | location, site_name, update_location | 
  if site_name == "34 QA Cardio PM"
    site_id = 1763
    elsif site_name == "Automation Site"
    site_id = 4751
  end
  random_num = Common.rd_number
  
  $location_three_name = "#{location}_#{random_num}" 
  
  payload = '{"Id":0,"Name":"' + $location_three_name + '","SiteId":"' + site_id.to_s + '"}'	
  create_response = @RulesEngine_api.save_location(payload)
   
  location_three_id = create_response["model"]["id"]	 
  
  get_response = @RulesEngine_api.get_location_by_id(location_three_id)  
  
  expect(get_response["responseCode"]).to eq 0
  expect(get_response["model"]["id"].to_s).to eq location_three_id.to_s
  expect(get_response["model"]["name"]).to eq $location_three_name
  expect(get_response["model"]["siteId"].to_s).to eq site_id.to_s
  
  $update_location_name = "#{update_location}_#{random_num}"
  
  new_payload = '{"id":' + location_three_id.to_s + ',"name":"' + $update_location_name + '","siteId":' + site_id.to_s + '}'
    
  update_response = @RulesEngine_api.save_location(new_payload)
  expect(update_response["responseCode"]).to eq 0
   
  get_response = @RulesEngine_api.get_location_by_id(location_three_id)
    
  expect(get_response["responseCode"]).to eq 0
  expect(get_response["model"]["id"]).to eq location_three_id
  expect(get_response["model"]["name"]).to eq $update_location_name
  expect(get_response["model"]["siteId"]).to eq site_id  
end

Then(/^it should create and delete "(.*?)" for "(.*?)"$/) do | location, site_name |
  if site_name == "34 QA Cardio PM"
    site_id = 1763
  elsif site_name == "Automation Site"
    site_id = 4751
  end
  
  random_num = Common.rd_number
  
  $location_name = "#{location}_#{random_num}" 
  
  payload = '{"Id":0,"Name":"' + $location_name + '","SiteId":"' + site_id.to_s + '"}'	
  create_response = @RulesEngine_api.save_location(payload)
  
  location_id = create_response["model"]["id"]	
  
  get_response = @RulesEngine_api.get_location_by_id(location_id)
    
  expect(get_response["responseCode"]).to eq 0
  expect(get_response["model"]["id"]).to eq location_id
  expect(get_response["model"]["name"]).to eq $location_name
  expect(get_response["model"]["siteId"]).to eq site_id
  
  puts "deleting the location id = #{location_id}"
  
  delete_response = @RulesEngine_api.delete_location(location_id)
  
  expect(delete_response["responseCode"]).to eq 0
  expect(delete_response["error"]).to eq nil
  
  get_response = @RulesEngine_api.get_location_by_id(location_id)
  
  expect(get_response["responseCode"]).to eq 100
  expect(get_response["error"]["title"]).to eq "GeneralError"
  expect(get_response["error"]["description"]).to eq "Unexpected error encountered"
  expect(get_response["error"]["details"]).to eq nil 
end

Then(/^it should get all enterprise user groups$/) do    
  user_group_response = @RulesEngine_api.get_enterprise_user_groups
   
  expect(user_group_response["responseCode"]).to eq 0
  expect(user_group_response["model"].count).to be > 0
  
  $user_group_one_id = user_group_response["model"][0]["userGroupId"]	
  $user_group_one_name = user_group_response["model"][0]["name"]	  
end

Then(/^it should get enterprise user group by id$/) do    
  user_group_response = @RulesEngine_api.get_enterprise_user_group_by_id($user_group_one_id)
   
  expect(user_group_response["responseCode"]).to eq 0
  expect(user_group_response["model"]["userGroupId"]).to eq $user_group_one_id
  expect(user_group_response["model"]["name"]).to eq $user_group_one_name  
end

Then(/^it should create and view new enterprise group "(.*?)" and site "(.*?)"$/) do | group, site_name |
  if site_name == "34 QA Cardio PM"
    site_id = 1763
  end
  
  random_num = Common.rd_number
  
  group_name = "#{group}_#{random_num}"
  
  payload = '{"UserGroupId":0,"Name":"' + group_name + '","ModifiedAt":"2014-03-18T16:35:26.7662252Z","Users":[{"UserId":7,"FullName":"aduser",' +
  '"UserName":null,"Devices":[],"NotificationText":null,"IsAvailableForPushNotifications":false,"IsInactive":false,"SiteIds":[]}],"Locations":[' + $location_one_id.to_s + '],"RuleIds":[1],"Sites":[' + site_id.to_s + ']}'
  
  create_response = @RulesEngine_api.create_user_group(payload)

  expect(create_response["responseCode"]).to eq 0
  
  $new_group_id = create_response["model"]
  
  user_group_response = @RulesEngine_api.get_enterprise_user_group_by_id($new_group_id)
   
  expect(user_group_response["responseCode"]).to eq 0
  expect(user_group_response["model"]["userGroupId"]).to eq $new_group_id
  expect(user_group_response["model"]["name"]).to eq group_name  
end

Then(/^it should create and update new enterprise group "(.*?)" and site "(.*?)"$/) do | group, site_name |
  if site_name == "34 QA Cardio PM"
    site_id = 1763
  end
  
  random_num = Common.rd_number
  
  group_name = "#{group}_#{random_num}"
  
  payload = '{"UserGroupId":0,"Name":"' + group_name + '","ModifiedAt":"2014-03-18T16:35:26.7662252Z","Users":[{"UserId":7,"FullName":"aduser",' +
  '"UserName":null,"Devices":[],"NotificationText":null,"IsAvailableForPushNotifications":false,"IsInactive":false,"SiteIds":[]}],"Locations":[' + $location_one_id.to_s + '],"RuleIds":[1],"Sites":[' + site_id.to_s + ']}'
  
  create_response = @RulesEngine_api.create_user_group(payload)

  expect(create_response["responseCode"]).to eq 0
  
  $new_group_id = create_response["model"]
  
  user_group_response = @RulesEngine_api.get_enterprise_user_group_by_id($new_group_id)
   
  expect(user_group_response["responseCode"]).to eq 0
  expect(user_group_response["model"]["userGroupId"]).to eq $new_group_id
  expect(user_group_response["model"]["name"]).to eq group_name
  
  
  $new_group_name = "#{group}_update_#{random_num}"
  
  payload = '{"UserGroupId":' + $new_group_id.to_s + ',"Name":"' + $new_group_name + '","ModifiedAt":"2014-03-18T16:35:26.7662252Z","Users":[{"UserId":7,"FullName":"aduser",' +
  '"UserName":null,"Devices":[],"NotificationText":null,"IsAvailableForPushNotifications":false,"IsInactive":false,"SiteIds":[]}],"Locations":[' + $location_one_id.to_s + '],"RuleIds":[1],"Sites":[' + site_id.to_s + ']}'
  
  create_response = @RulesEngine_api.create_user_group(payload)

  expect(create_response["responseCode"]).to eq 0
  
  $new_group_id = create_response["model"]
  
  user_group_response = @RulesEngine_api.get_enterprise_user_group_by_id($new_group_id)
   
  expect(user_group_response["responseCode"]).to eq 0
  expect(user_group_response["model"]["userGroupId"]).to eq $new_group_id
  expect(user_group_response["model"]["name"]).to eq $new_group_name  
end

Then(/^it should create and delete new enterprise group "(.*?)" and site "(.*?)"$/) do | group, site_name |
  if site_name == "34 QA Cardio PM"
    site_id = 1763
  end
  
  random_num = Common.rd_number
  
  group_name = "#{group}_#{random_num}"
  
  payload = '{"UserGroupId":0,"Name":"' + group_name + '","ModifiedAt":"2014-03-18T16:35:26.7662252Z","Users":[{"UserId":7,"FullName":"aduser",' +
  '"UserName":null,"Devices":[],"NotificationText":null,"IsAvailableForPushNotifications":false,"IsInactive":false,"SiteIds":[]}],"Locations":[' + $location_one_id.to_s + '],"RuleIds":[1],"Sites":[' + site_id.to_s + ']}'
  
  create_response = @RulesEngine_api.create_user_group(payload)

  expect(create_response["responseCode"]).to eq 0
  
  delete_group_id = create_response["model"]
  
  user_group_response = @RulesEngine_api.get_enterprise_user_group_by_id(delete_group_id)
   
  expect(user_group_response["responseCode"]).to eq 0
  expect(user_group_response["model"]["userGroupId"]).to eq delete_group_id
  expect(user_group_response["model"]["name"]).to eq group_name
  
  delete_response = @RulesEngine_api.delete_user_group(delete_group_id)
  
  expect(delete_response["responseCode"]).to eq 0
  
  get_deleted_user_group_response = @RulesEngine_api.get_enterprise_user_group_by_id(delete_group_id)
   
  expect(get_deleted_user_group_response["responseCode"]).to eq 100
  expect(get_deleted_user_group_response["error"]["title"]).to eq "GeneralError"
  expect(get_deleted_user_group_response["error"]["description"]).to eq "Unexpected error encountered"
end

Then(/^it should get all notification rules$/) do 
  get_notifications_response = @RulesEngine_api.get_notification_rules
    
  expect(get_notifications_response["responseCode"]).to eq 0
  expect(get_notifications_response["model"].count).to be > 0
  
  $notification_rule_id = get_notifications_response["model"][0]["ruleId"]
  $notification_rule_name = get_notifications_response["model"][0]["name"]
end

Then(/^it should get the first notification rules by id$/) do 
  get_notifications_response = @RulesEngine_api.get_notification_rule_by_id($notification_rule_id)  
  
  expect(get_notifications_response["responseCode"]).to eq 0
  expect(get_notifications_response["model"]["ruleId"]).to eq $notification_rule_id
  expect(get_notifications_response["model"]["name"]).to eq $notification_rule_name 
end

Then(/^it should create and view new notification rule "(.*?)" for site "(.*?)"$/) do | rule_name, site_name |
  if site_name == "34 QA Cardio PM"
    site_id = 1763
  elsif site_name == "Automation Site"
    site_id = 4751
  end
  
  random_num = Common.rd_number
  
  $new_notification_rule_name = "#{rule_name}_#{random_num}" 
  
  payload = '{"RuleId":0,"Name":"' + $new_notification_rule_name + '","PriorityNumber":122,"ModifiedAt":"2014-03-18T13:34:16.6244886Z","SiteId":"' + site_id.to_s + '","Conditions":[]}'
  create_response = @RulesEngine_api.create_notification_rule(payload)
  
  $new_rule_one_id = create_response["model"]
  
  get_notifications_response = @RulesEngine_api.get_notification_rule_by_id($new_rule_one_id)  
  
  expect(get_notifications_response["responseCode"]).to eq 0
  expect(get_notifications_response["model"]["ruleId"]).to eq $new_rule_one_id
  expect(get_notifications_response["model"]["name"]).to eq $new_notification_rule_name   
end


