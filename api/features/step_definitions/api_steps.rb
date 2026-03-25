Dir[File.dirname(__FILE__) + "/../../../common/**/*.rb"].each {|file| require file }
require 'jsonpath'
Before do
  @Fed_api = Fed_api.new
  @FedHost_api = FedHost_api.new
  @Cardio_api = Cardio_api.new
  @Pm_api = Pm_api.new
  @Sm_api = Secure_Messaging_api.new
end

Given(/^I login to the api with a valid credential$/) do
  @response = @Fed_api.site_default_logon
  expect(@response["model"]["registrationCode"]).to match ("(.*)-(.*)")
  $xAuthToken = @response["model"]["xAuthToken"]
end


Given(/^Remember \"(.*)\" value as \"(.*)\" test data value$/) do |value, var_name|
  $TEST_DATA_MAP[var_name] = process_param(value)
end


Given(/^User is able to login into the system with valid credentials$/) do
  steps %(Given I login to the api with a valid credential)
end

Given(/^User is logged into the system with valid credentials$/) do
  steps %(Given I login to the api with a valid credential)
end

Given(/^unprivileged user is logged into the system$/) do
  @response = @Fed_api.site_logon(get_param("UU_USERNAME"),get_param("UU_PASSWORD"))
  expect(@response["model"]["registrationCode"]).to match ("(.*)-(.*)")
  $xAuthToken = @response["model"]["xAuthToken"]
end

Given(/^User is logged into the system as superuser$/) do
  @response = @Fed_api.site_super_logon
  expect(@response["model"]["registrationCode"]).to match ("(.*)-(.*)")
  $xAuthToken = @response["model"]["xAuthToken"]
end

Given(/^The user notification has been configured for the asmpid \"(.*)\"$/) do |asmpid|
  raise "ECG Notification presetup not yet implemented"
end

Given(/^User tries to log on with username \"(.*)\" and password \"(.*)\"$/) do |username, password|
  @response = @Fed_api.do_site_logon process_param(username),process_param(password)
end


Then(/^I should (|not )receive an xAuthToken$/) do |do_receive|
  if do_receive.include? "not"
    expect(@response["model"]).to be_nil
  else
    expect(@response["model"]["xAuthToken"]).not_to be_empty
  end
end

Then(/^it should login to the api$/) do
  @response = @Fed_api.site_default_logon
  expect(@response["model"]["registrationCode"]).to match ("(.*)-(.*)")
  $xAuthToken = @response["model"]["xAuthToken"]
end

Then(/^it should login to the api as user \"(.*)\" with password \"(.*)\"$/) do |username, password|
  @response = @Fed_api.do_site_logon process_param(username),process_param(password)
  expect(@response["model"]["registrationCode"]).to match ("(.*)-(.*)")
  $xAuthToken = @response["model"]["xAuthToken"]
end

Given(/^API: user config for user \"(.*)\" with password \"(.*)\" is updated with$/) do |username, password, userconfig|
  steps %(
Then it should login to the api as user "#{username}" with password "#{password}"
When user updates user configuration
"""
#{userconfig}
"""
)
end

Given(/^API: user config for user \"(.*)\" with password \"(.*)\" is set to$/) do |username, password, userconfig|
  userconfig=process_param(userconfig)
  steps %(
Then it should login to the api as user "#{username}" with password "#{password}"
When user sets user configuration
"""
#{userconfig}
"""
)
end

When(/^relogin as user \"(.*)\" with password \"(.*)\"$/) do |username, password|
  @response = @Fed_api.do_site_logon process_param(username),process_param(password)
  expect(@response["model"]["registrationCode"]).to match ("(.*)-(.*)")
  $xAuthToken = @response["model"]["xAuthToken"]
end


When(/^user executes (cardio\/requestedit|aso\/document\/Document|patientlist|patient|patient\/summary|cardio\/ecg|cardio\/ecglist|cardio\/requestedit|aso\/snippets\/ValidateSnippetParameters) GET request with query params \"(.*)\"$/) do | request_rel_url, query_params |
  @response = @Fed_api.execute_get_with_query_params(request_rel_url, process_param(query_params))
end

When(/^user executes (cardio\/setuseravailabilitynotifications|pm\/trends|pm\/multimeasurements|pm\/measurements|pm\/config|pm\/events|aso\/document\/nursereport|aso\/messaging\/conversationid) GET request with query params \"(.*)\"$/) do | rel_url, query_params |

  query_params=process_param(query_params)
  m = query_params.match(/\[(.*?)\.<contactId>\]/)
  if m
    target_contact=m[1]
    contact_id=get_contact_id(target_contact)
    query_params = query_params.gsub("[#{target_contact}.<contactId>]", contact_id.to_s)
  end
   @response = @Fed_api.do_execute_get_with_query_params(rel_url , process_param(query_params),nil)
end

When(/^user searches for patients with params \"(.*)\"$/) do |query_params|
  @response = @Fed_api.do_execute_get_with_query_params("patientlist", process_param("listtype=search&#{query_params}"),"1")
end

When(/^user executes (cardio\/v2\/getusersavailablefornotifications|cardio\/v2\/getecgnotificationstatus|cardio\/v2\/getallecgstatus|cardio\/statementlibrary|cardio\/isuseravailablefornotifications|patientlist|version|patientlist\/configuration|aso\/configuration\/userconfiguration|logon\/status|aso\/document\/documentlabels|aso\/snippeteventdescriptionlibrary\/get|aso\/document\/reportlocations|services\/ahi\/resource\/alltext|services\/ahi\/AnalysisResult\/.*|configuration\/searchfields|aso\/contacts\/getbysiteid|aso\/messaging\/conversations) GET request$/) do | request_rel_url |
  @response = @Fed_api.execute_get(process_param(request_rel_url))
end

When(/^user sends secure message from user \"(.*)\" to user \"(.*)\" with body$/) do |source_user, target_user, body|
  body_json=JSON.parse(body)
  body_json["conversationId"]=get_conversation_id(source_user,target_user)
  @Fed_api.execute_post_with_query("aso/post/messaging/sendmessage","sitId=#{SITE_ID}",JSON.pretty_generate(body_json));
end

When(/^user sends secure message to user \"(.*)\" with body$/) do |target_user, body|
  body_json=JSON.parse(body)
  body_json["conversationId"]=get_conversation_id($QA_USERNAME,target_user)
  @Fed_api.execute_post_with_query("aso/post/messaging/sendmessage","sitId=#{SITE_ID}",JSON.pretty_generate(body_json));
end

When(/^user sends secure messages \"(.*)\" to user \"([^\"]*)\"$/) do |messages, target_user|
  payload="{\"conversationId\":#{get_conversation_id($QA_USERNAME,target_user)},\"messages\" : #{messages}}"
  response=@Fed_api.execute_post_with_query("aso/post/messaging/sendmessage","sitId=#{SITE_ID}",payload)
end

When(/^user gets conversation details with user \"([^\"]*)\"$/) do |target_user|
  @response = @Fed_api.do_execute_get_with_query_params("aso/messaging/conversation" , "conversationid=#{get_conversation_id($QA_USERNAME,target_user)}",nil)
end

When(/^user gets conversation details with user \"([^\"]*)\" with query params \"(.*)\"$/) do |target_user, query_params|
  conversation_id=get_conversation_id($QA_USERNAME,target_user)
  @conversation = @Fed_api.do_execute_get_with_query_params("aso/messaging/conversation" , "conversationid=#{conversation_id}",nil)
  m = query_params.match(/\[(.*?)\.<messageId>\]/)
  if m
    target_message=m[1]
    message_id=@conversation['model']['messages'].filter{|m|  m["message"].include?(target_message)}.last["messageId"]
    query_params = query_params.gsub("[#{target_message}.<messageId>]", message_id.to_s)
  end
  @response = @Fed_api.do_execute_get_with_query_params("aso/messaging/conversation" , "conversationid=#{conversation_id}&#{query_params}",nil)
end

When(/^user deletes conversation with user \"([^\"]*)\"$/) do |target_user|
  conversation_id=get_conversation_id($QA_USERNAME,target_user)
  @response = @FedHost_api.delete_conversation( SITE_ID,$QA_USERNAME,conversation_id)
end
When(/^user deletes conversation with userId \"([^\"]*)\"$/) do |contact_id|
  conversation_id=get_conversation_id_by_contact_id($QA_USERNAME,contact_id)
  @response = @FedHost_api.delete_conversation( SITE_ID,$QA_USERNAME,conversation_id)
end

Then(/^verify conversation with user \"([^\"]*)\" is (absent|present) in all conversations list$/) do |target_user,presense|
  contact_id=get_contact_id(process_param(target_user))
  @response = @Fed_api.execute_get("aso/messaging/conversations")
  expect(@response["model"].find{|m| m["participant"].to_s.include?("\"contactId\"=>#{contact_id}")}).to eq nil
end

When(/^verify the last user message to user \"(.*)\" attributes$/) do |target_user, message_attributes|
  @response = @Fed_api.execute_get(process_param("aso/messaging/conversations"))
  target_user=process_param(target_user)
  conversation=@response["model"].find{|t| t["participant"].to_s.include?(target_user)}
  target_message=JSON.parse(process_param(message_attributes))
  verify_response(target_message, conversation)
end
def get_conversation_id(source_user,target_user)
  target_user=process_param(target_user)
  contact_id=@Sm_api.contact_id(target_user)
  return get_conversation_id_by_contact_id(source_user,contact_id)
end

def get_conversation_id_by_contact_id(source_user,contact_id)
  source_user=process_param(source_user)
  conversation_id=@FedHost_api.get_conversation_id(SITE_ID,source_user,contact_id,true)
  return conversation_id
end
def get_contact_id(target_user)
  return @Sm_api.contact_id(process_param(target_user))
end

When(/^user updates user configuration$/) do |attributes|
  steps %(
When user executes aso/configuration/userconfiguration GET request
)
  attributes=process_param(attributes)
  if attributes.include?("[param.api_my_patients]")
    my_patients=@response['model']['userPreferences']['client']['pm']['multiPatients']
    attributes=attributes.gsub("[param.api_my_patients]",my_patients.to_s)
  end
  attributes_map=JSON.parse(process_param(attributes))
  #
  # attributes_map.each do |k, v|
  #   command="source_json#{k}=#{v}"
  #   eval(command)
  # end
  # puts JSON.pretty_generate(attributes_map)
  @response = @Fed_api.execute_post("aso/post/configuration/userconfiguration",JSON.pretty_generate(attributes_map))
end


When(/^user sets user configuration$/) do |attributes_body|
  attributes_body=process_param(attributes_body)
  @response = @Fed_api.execute_post("aso/post/configuration/userconfiguration", attributes_body)
end


When(/^user executes aso\/lists GET request for test site$/) do
  @response = @Fed_api.execute_get("aso/lists/#{SITE_ID}")
end

When(/^user executes logon\/status GET request with session token "(.*)"$/) do |session_token|
  $xAuthToken=session_token
  @response = @Fed_api.execute_get("logon/status")
end

When(/^user executes (aso\/post\/operationlog\/logoperation|logon|aso\/post\/configuration\/userconfiguration|aso\/post\/operationlog\/logoperation|aso\/post\/snippets\/savesnippet) POST request from response with attributes$/) do |request_rel_url, attributes|
  source_json= @response['model']
  attributes_map=JSON.parse(process_param(attributes))
  attributes_map.each do |k, v|
    command="source_json#{k}='#{v}'"
    eval(command)
    @response = @Fed_api.execute_post(request_rel_url,source_json)
  end
end

When(/^user executes (aso\/post\/operationlog\/logoperation|logon|aso\/post\/configuration\/userconfiguration|aso\/post\/operationlog\/logoperationa|aso\/post\/snippets\/99999\/approve|aso\/post\/snippets\/99999\/reject) POST request with attributes$/) do |request_rel_url, attributes|
  @response = @Fed_api.execute_post(request_rel_url,process_param(attributes))
end

When(/^user executes (cardio\/post\/ecg\/confirm|cardio\/post\/ecgacknowledgment|aso\/post\/snippets|aso\/post\/snippets\/savesnippet|aso\/post\/snippets\/previewsnippet) POST request with query params "(.*)" and attributes$/) do | request_rel_url, query_params, attributes |
  @response = @Fed_api.execute_post_with_query(request_rel_url,process_param(query_params),process_param(attributes))
end

When(/^user executes (cardio\/post\/ecgacknowledgment|aso\/post\/snippets\/savesnippet|aso\/post\/snippets\/previewsnippet) POST request with query params "(.*)"$/) do | request_rel_url, query_params |
  @response = @Fed_api.execute_post_with_query(request_rel_url,process_param(query_params),"{}")
end

When(/^user executes cardio\/post\/ecgacknowledgment POST request with query params "(.*)" for the configured notification$/) do | request_rel_url, query_params |
  @response = @Fed_api.execute_post_with_query(request_rel_url,process_param(query_params)+"&notificationid="+@notificationid,"{}")
end


When(/^user executes (aso\/post\/snippets\/) (.*) (\/approve|\/reject) POST request$/) do |request_rel_url, document_id, request_rel_url_2|
  @response = @Fed_api.execute_post_document(request_rel_url, process_param(document_id), request_rel_url_2)
end

Then(/^user verifies the user config attributes$/) do | attributes |
  steps %(
When user executes aso/configuration/userconfiguration GET request
When system should return user config
"""
#{process_param(attributes)}
"""
 )
end


Then(/^a snippet has been created by the user for asmpid "(.*)"/) do |asmpid|
  asmpid=process_param(asmpid)
  steps %(
  And user executes aso/post/snippets/savesnippet POST request with query params "asmpid=#{asmpid}" and attributes
  """
 {
  "snippetDetails": {
    "siteName": "[props.COMMON_SITENAME]", "unit": "[props.DP_UNIT]", "firstName": "[props.DP_FNAME]",
    "lastName": "[props.DP_LNAME]", "mrn": "[props.DP_MRN]", "gender": "[props.DP_SEX_FULL]", "dob": "[props.DP_AGE]",
    "location": "[props.DP_BED]", "hr": "80", "qtc": "--", "pr": "--", "qrs": "--", "qt": "--", "discretes": [],
    "isDualLead": false, "isAllLeads": false, "lead0": "1814", "lead1": "1815", "userModifiedMeasurements": false,
    "eventDescription": "AT EVENT", "snippetDocumentTypeId": "3", "eventDescriptionDetails": ["NSR"]
  },
  "snippetLead": [
    {
      "leadImage": "iVBORw0KGgoAAAANSUhEUgAABXgAAAF8CAYAAAB11dMyAAAAAXNSR0IArs4c6QAAIABJREFUeF7s3X+UXWV9L/7Ps8+ARIgMFpFalSCmX2ptSdTaLmNhuO299ettIRlSe9vVlhDvUhMpP9pqvb3XEu0qSO33ijc/4KoFInzNreTH5N7W0K5vZYgCldtCEGy1UQjaCpJGBgiEi+fs57v2YSbNj9mTTObMmWTmddaaRTj7OZ/P87z2/uu9nvXsFD4ECBAgQIAAAQIECBAgQIAAAQIECBAgcEwKpGNy1iZNgAABAgQIECBAgAABAgQIECBAgAABAiHg9RAQIECAAAECBAgQIECAAAECBAgQIEDgGBUQ8B6jN860CRAgQIAAAQIECBAgQIAAAQIECBAgIOD1DBAgQIAAAQIECBAgQIAAAQIECBAgQOAYFRDwHqM3zrQJECBAgAABAgQIECBAgAABAgQIECAg4PUMECBAgAABAgQIECBAgAABAgQIECBA4BgVEPAeozfOtAkQIECAAAECBAgQIECAAAECBAgQICDg9QwQIECAAAECBAgQIECAAAECBAgQIEDgGBUQ8B6jN860CRAgQIAAAQIECBAgQIAAAQIECBAgIOD1DBAgQIAAAQIECBAgQIAAAQIECBAgQOAYFRDwHqM3zrQJECBAgAABAgQIECBAgAABAgQIECAg4PUMECBAgAABAgQIECBAgAABAgQIECBA4BgVEPAeozfOtAkQIECAAAECBAgQIECAAAECBAgQICDg9QwQIECAAAECBAgQIECAAAECBAgQIEDgGBUQ8B6jN860CRAgQIAAAQIECBAgQIAAAQIECBAgIOD1DBAgQIAAAQIECBAgQIAAAQIECBAgQOAYFRDwHqM3zrQJECBAgAABAgQIECBAgAABAgQIECAg4PUMECBAgAABAgQIECBAgAABAgQIECBA4BgVSPn9/TdOxdzLHFMSLjfWbLxkKtarJwECBAgQIECAAAECBAgQIECAAAECBDotkMpl/d9MRfpybeEcJ+SIOSnF1+vGlBGRcpydI++IlJ6vG5ciTq+u5YjHx+qXIubkUfoV+/wo5/yuFGkwUjwxBkq7X+zTL63esKTTiOoRIECAAAECBAgQIECAAAECBAgQIEBgKgRSXt5/UxpjV2v+rV9+RbRav5zWbFwz1gTzskXvj56ez6eV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uW1kzHE3DIx61vC45fyAAAECBAgQIECAAAECBAgQIECAAAECUyxQ7eDdEkVxbf08cm9Zln1F0Rg74C3zwiiqF7Wl+oA3ly8GvKnYG7ge3Pfw+uVWuSE1YkVEURvwxij90qr1At4pfui0J0CAAAECBAgQIECAAAECBAgQIECgMwKOaOiMoyoECBAgQIAAAQIECBCKKg3VAAAgAElEQVQgQIAAAQIECBDouoCAt+vkGhIgQIAAAQIECBAgQIAAAQIECBAgQKAzAgLezjiqQoAAAQIECBAgQIAAAQIECBAgQIAAga4LCHi7Tq4hAQIECBAgQIAAAQIECBAgQIAAAQIEOiMg4O2MoyoECBAgQIAAAQIECBAgQIAAAQIECBDouoCAt+vkGhIgQIAAAQIECBAgQIAAAQIECBAgQKAzAgLezjiqQoAAAQIECBAgQIAAAQIECBAgQIAAga4LpNay/nVFT+Oy2s6t5qlliguKoufGMWdXNpdGKjZHKnbVjWs1ywXVtUZPcddE++VW66HUiKURjXvH0y+tvG1n15U1JECAAAECBAgQIECAAAECBAgQIECAwCQIVDt474mcbx2j9kllijcVObaO2T/FuZHjvojYXTsuxdz2tRzbJ9ovp7g65fhMRDw8nn7p+k2rJ8FRSQIECBAgQIAAAQIECBAgQIAAAQIECHRdwBENXSfXkAABAgQIECBAgAABAgQIECBAgAABAp0REPB2xlEVAgQIECBAgAABAgQIECBAgAABAgQIdF1AwNt1cg0JECBAgAABAgQIECBAgAABAgQIECDQGQEBb2ccVSFAgAABAgQIECBAgAABAgQIECBAgEDXBQS8XSfXkAABAgQIECBAgAABAgQIECBAgAABAp0REPB2xlEVAgQIECBAgAABAgQIECBAgAABAgQIdF1AwNt1cg0JECBAgAABAgQIECBAgAABAgQIECDQGQEBb2ccVSFAgAABAgQIECBAgAABAgQIECBAgEDXBVK5vP+eFHFLbeecZ0dK8yNi6yFmd25E3BcRu2vHpZjbvpZj+0T75cjXpEifjoiHx9Mvrdm4puvKGhIgQIAAAQIECBAgQIAAAQIECBAgQGASBFJrWf+6oqdxWW3tVvPUMsUFRdFz45j9y+bSSMXmSMWu2nHNckErIho9xV2H22/3D5pptLEnFunBMuV372nFvXW1ZkVa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vH9LyvljtQWL6I0y9UXkgTGbFmlhRB6MMoZqx6ViXvtaLrc1c06jjUspelNOfeUh+jVSsSFHuaLM8WBdv2K4X5nLbSNjjrthoPYFb51CVYcAAQIECBAgQIAAAQIECBAgQIAAAQLdEKh28G6Jori2vlnuLcuyrygaYwe8ZV4YRQxGpPqAN5cvBryp2Bu4Htz38PrlVrkhNWJFRFEb8MYo/dKq9QLebjxZehAgQIAAAQIECBAgQIAAAQIECBAgMOkCjmiYdGINCBAgQIAAAQIECBAgQIAAAQIECBAgMDkCAt7JcVWVAAECBAgQIECAAAECBAgQIECAAAECky4g4J10Yg0IECBAgAABAgQIECBAgAABAgQIECAwOQIC3slxVZUAAQIECBAgQIAAAQIECBAgQIAAAQKTLiDgnXRiDQgQIECAAAECBAgQIECAAAECBAgQIDA5AgLeyXFVlQABAgQIECBAgAABAgQIECBAgAABApMuIOCddGINCBAgQIAAAQIECBAgQIAAAQIECBAgMDkCqbWsf13R07istnyreWqZ4oKi6LlxzCmUzaWRis2Ril2145rlglZENHqKuybaL7daD6VGLI1o3DuefmnlbTsnh1JVAgQIECBAgAABAgQIECBAgAABAgQIdFeg2sF7T+R8a13bMsfsKGJ+kWPrmFNLcW7kuC8idteOSzG3fS3H9on2yymuTjk+ExEPj6dfun7T6u4S60aAAAECBAgQIECAAAECBAgQIECAAIHJEZiCIxqakVYNDNYtJ79v0WlRpMVpzcY1Yy25XN7/WCpicVq1sXY3cL50cV/E2P0mh1VVAgQIECBAgAABAgQIECBAgAABAgQITL6AgHfyjXUgQIAAAQIECBAgQIAAAQIECBAgQIDApAgIeCeFVVECBAgQIECAAAECBAgQIECAAAECBAhMvoCAd/KNdSBAgAABAgQIECBAgAABAgQIECBAgMCkCAh4J4VVUQIECBAgQIAAAQIECBAgQIAAAQIECEy+gIB38o11IECAAAECBAgQIECAAAECBAgQIECAwKQICHgnhVVRAgQIECBAgAABAgQIECBAgAABAgQITL6AgHfyjXUgQIAAAQIECBAgQIAAAQIECBAgQIDApAikcnn/PSniltrqOc+OlOZHxNZDzODciLgvInbXjksxt30tx/aJ9suRr0mRPh0RD4+nX1qzcc2kSCpKgAABAgQIECBAgAABAgQIECBAgACBLguk1rL+dUVP47Lavq3mqWWKC4qi58Yx51Y2l0YqNkcqdtWOa5YLWhHR6CnuOtx+u3/QTKONPbFID5Ypv3tPK+6tqzUr0oJIKe/J5d0jY2bfsOmJLhtrR4AAAQIECBAgQIAAAQIECBAgQIAAgUkRcETDpLAqSoAAAQIECBAgQIAAAQIECBAgQIAAgckXEPBOvrEOBAgQIECAAAECBAgQIECAAAECBAgQmBQBAe+ksCpKgAABAgQIECBAgAABAgQIECBAgACByRcQ8E6+sQ4ECBAgQIAAAQIECBAgQIAAAQIECBCYFAEB76SwKkqAAAECBAgQIECAAAECBAgQIECAAIHJF+h+wNtsRrphYLBuafl9i06LIi1OazauGWv55fL+x1IRi9OqjXfV1rp0cV8cot/kE+tAgAABAgQIECBAgAABAgQIECBAgACByREQ8E6Oq6oECBAgQIAAAQIECBAgQIAAAQIECBCYdIFULl+0JeX4WG2nInqjTH0ReWDM2RRpYUQejDKGaselYl5EKyKnbc2c02jjUorelFNfeYh+jVRsyFGuKHM8WNevaPcro8yxbWTMcWPsHp50bQ0IECBAgAABAgQIECBAgAABAgQIECDQQYFqB++WKIpr62vm3rIs+4qiMXbAW+aFUcRgRKoPeHM5r90nFXsD14P7Hl6/3Co3pEasiChqA94YpV9atb72eIgOuipFgAABAgQIECBAgAABAgQIECBAgACBSRdwRMOkE2tAgAABAgQIECBAgAABAgQIECBAgACByREQ8E6Oq6oECBAgQIAAAQIECBAgQIAAAQIECBCYdAEB76QTa0CAAAECBAgQIECAAAECBAgQIECAAIHJEUit5f03NdZsvKSufH7fotOiSIvTmo1rxppCXrbo/dHT8/m08radtbUuXdzXbDZjrBedHW6/cnn/Y6mIxWnVxrsm0m9yWFUlQIAAAQIECBAgQIAAAQIECBAgQIDA5AsIeCffWAcCBAgQIECAAAECBAgQIECAAAECBAhMioCAd1JYFSVAgAABAgQIECBAgAABAgQIECBAgMDkCwh4J99YBwIECBAgQIAAAQIECBAgQIAAAQIECEyKQPWStb+IIq6urZ7zKWXE+UVKG8ecQc79UaQvRo6h2nFlmt++VuT7J9ovl7E5p/ThIuWvjqffWGf2ToqwogQIECBAgAABAgQIECBAgAABAgQIEJgkgVQu738uIp4ao34RkU+ISNW4MT75pRHp+YgoawelOL59LccLE+8Xp7XD5DRGrVH6FWs2/vAkWSpLgAABAgQIECBAgAABAgQIECBAgACBrgo4oqGr3JoRIECAAAECBAgQIECAAAECBAgQIECgcwIC3s5ZqkSAAAECBAgQIECAAAECBAgQIECAAIGuCgh4u8qtGQECBAgQIECAAAECBAgQIECAAAECBDonIODtnKVKBAgQIECAAAECBAgQIECAAAECBAgQ6KqAgLer3JoRIECAAAECBAgQIECAAAECBAgQIECgcwIC3s5ZqkSAAAECBAgQIECAAAECBAgQIECAAIGuCgh4u8qtGQECBAgQIECAAAECBAgQIECAAAECBDonIODtnKVKBAgQIECAAAECBAgQIECAAAECBAgQ6KpAKpf135NS3FLbNefZkdL8iNh6iJmdGxH3RcTu2nEp5kYZESm2T7RfjnxNivTpiHh4PP3Smo1ruiqsGQECBAgQIECAAAECBAgQIECAAAECBCZJILWW9a8rehqX1dZvNU8tU1xQFD03jjmHsrk0UrE5UrGrdlyzXBBFylGkuw+33+4fNNNoY08s0oNlyu/e04p762rNirQgUsp7crm33+wbNj0xSZbKEiBAgAABAgQIECBAgAABAgQIECBAoKsCjmjoKrdmBAgQIECAAAECBAgQIECAAAECBAgQ6JyAgLdzlioRIECAAAECBAgQIECAAAECBAgQIECgqwIC3q5ya0aAAAECBAgQIECAAAECBAgQIECAAIHOCQh4O2epEgECBAgQIECAAAECBAgQIECAAAECBLoqIODtKrdmBAgQIECAAAECBAgQIECAAAECBAgQ6JyAgLdzlioRIECAAAECBAgQIECAAAECBAgQIECgqwLTPuAt3/N772j85E99qKuqmhEgQIAAAQIECBAgQIAAAQIECBAgQKALAqlcvmhLyvGxvb3O+NGT4mfOPWvv/z//3Enx+GPzY85ZX9pvPk8PPRtb1n/zX3/3+t+MeW/9Vpz1Yz8c//zo9jjwejUwFfPi9W94ebzpZ3aVs06aHbNmnRS7vvd4vmfrt/K3t+9uD0nRm3Lqy+/ofyid3Hvivj3zju3fy1/Z+nj1XSMVG/KPvuG/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vS9r2/nPl8SfXvfK+NDHb96nZzMi/p+hoaGLR3YDV9faO4d7e9emlJaMjBXwztyH2coJECBAgAABAgQIECBAgAABAgQIzDSBQwa8o4EM7+p9ICLOqYLcamdudR7ugZ+rrroqVqxYUX391I4dO06ugt0777xzVOMLL7wwBgYGIr7zrUXxsQ++Kq3ZuGbfgSPB7chu4L3jIxallAYEvDPt0bVeAgQIECBAgAABAgQIECBAgAABAgRqA94quK123o72qXbt9vb2Vkltld5W4erJI7t2q5emVS9Cq3boVuOGP/OHx51RjavGtM/OjWiPq3b17t0lXBPwVmNzzryXIl0AABD/SURBVDt27NhxRvX79m9e+9rdqdGYPVoQPDL/kbmmlF7cMuxDgAABAgQIECBAgAABAgQIECBAgACBaSIwWsBbpbLX7V1fs3lcPP3kK+Llr/juAWvellK6IudcnbW7JL6/c3n0/tCsKIpXVzt2I6JKcKvwdyCltKM97mt/96E440ffESe1M9lzhutVO4F3DJ/JOxDL+p+LIi0+cAfvcMB7RURUf2fE88/leOw7K9Przr78gID3X+f/7DO9kSPipNmD1VynyT2zDAIECBAgQIAAAQIECBAgQIAAAQIECLQFDgp4D3TJ71t0Wl3gul+wumzR+6On5/Np5W0762zzpYv7ms1mHHfDQPWCtVE/h+qXc652DV8Vf7Vxd/yv//cdadXGuybSz3NAgAABAgQIECBAgAABAgQIECBAgACBY1XgWAx4q6MW7sgrP/L99I9fvUDAe6w+euZNgAABAgQIECBAgAABAgQIECBAgMBEBY65gLdacM45xwd/83ux59mLBLwTfQT8ngABAgQIECBAgAABAgQIECBAgACBY1Uglcv670kpbqldQM6zI6XqJWlbD7HIcyPivojYXTsuxdwoq4MhYvuE+n3oT34jf+x33pAifToiHh5Pv9HO9j1Wb555EyBAgAABAgQIECBAgAABAgQIECAwswVSa1n/uqKncVktQ6t5apnigqLouXFMqrK5NFKxOVKxq3Zcs1wQRcpRpLsPt9/uHzTTgWNP+v2Pvy1/7IP/vUz53XtacW9drVmRFkRKeU8u9/abfcOmJ2b2Lbd6AgQIECBAgAABAgQIECBAgAABAgSmi8AxeURDhV8u738sFbHYEQ3T5VG0DgIECBAgQIAAAQIECBAgQIAAAQIExisg4B2vmPEECBAgQIAAAQIECBAgQIAAAQIECBA4SgQEvEfJjTANAgQIECBAgAABAgQIECBAgAABAgQIjFdAwDteMeMJECBAgAABAgQIECBAgAABAgQIECBwlAgIeI+SG2EaBAgQIECAAAECBAgQIECAAAECBAgQGK+AgHe8YsYTIECAAAECBAgQIECAAAECBAgQIEDgKBEQ8B4lN8I0CBAgQIAAAQIECBAgQIAAAQIECBAgMF6BVC7v354ivlz7wxwnRIo5EfH1A8eU+3yRIs7OOXZEiufraqWI06trOeLxsfqlFHPyKP32/U2K+JWIdEeO/MR4+jXWbLxkvEjGEyBAgAABAgQIECBAgAABAgQIECBA4GgUeDHgTfsGvGnvPMuIFDlOSBFzcjo44N0vcM1xdo68I1I6RMCbI0caO+A9rH75XRFpMKc4KOAt2hly9UmnR7Rj6Bf75Ygk4D0an0NzIkCAAAECBAgQIECAAAECBAgQIEDgCAQc0XAEaH5CgAABAgQIECBAgAABAgQIECBAgACBo0FAwHs03AVzIECAAAECBAgQIECAAAECBAgQIECAwBEICHiPAM1PCBAgQIAAAQIECBAgQIAAAQIECBAgcDQICHiPhrtgDgQIECBAgAABAgQIECBAgAABAgQIEDgCAQHvEaD5CQECBAgQIECAAAECBAgQIECAAAECBI4GAQHv0XAXzIEAAQIECBAgQIAAAQIECBAgQIAAAQJHICDgPQI0PyFAgAABAgQIECBAgAABAgQIECBAgMDRIJDy8os+F43i8trJtJqnlikuKIqeG8eccNlcGqnYHKnYVTuuWS6IIuUo0t0T7ZdbrYdSI5ZGNO4dT7+08radRwO8ORAgQIAAAQIECBAgQIAAAQIECBAgQGCiAikv678nIt9aV6jMMTuKmF/k2DpmsxTnRo77ImJ37bgUc6OMiBTbJ9ovp7g65fhMRDw8nn7p+k2rJ4rm9wQIECBAgAABAgQIECBAgAABAgQIEDgaBBzRcDTcBXMgQIAAAQIECBAgQIAAAQIECBAgQIDAEQgIeI8AzU8IECBAgAABAgQIECBAgAABAgQIECBwNAgIeI+Gu2AOBAgQIECAAAECBAgQIECAAAECBAgQOAIBAe8RoPkJAQIECBAgQIAAAQIECBAgQIAAAQIEjgYBAe/RcBfMgQABAgQIECBAgAABAgQIECBAgAABAkcgIOA9AjQ/IUCAAAECBAgQIECAAAECBAgQIECAwNEgIOA9Gu6CORAgQIAAAQIECBAgQIAAAQIECBAgQOAIBAS8R4DmJwQIECBAgAABAgQIECBAgAABAgQIEDgaBFK5rP+elOKW2snkPDtSmh8RWw8x4XMj4r6I2F07LsXcKCMixfaJ9suRr0mRPh0RD4+nX1qzcc3RAG8OBAgQIECAAAECBAgQIECAAAECBAgQmKhAyssv+lw0istrC7Wap5YpLiiKnhvHbFY2l0YqNkcqdtWOa5YLokg5inT34fbb/YNmGm3siUV6sEz53XtacW9drVmRFkRKeU8u9/abfcOmJyaK5vcECBAgQIAAAQIECBAgQIAAAQIECBA4GgQc0XA03AVzIECAAAECBAgQIECAAAECBAgQIECAwBEIHNMBbyvyLx+3ZtOX69adL13c12w247gbBgaPwMZPCBAgQIAAAQIECBAgQIAAAQIECBAgcFQLCHiP6ttjcgQIECBAgAABAgQIECBAgAABAgQIEKgXEPB6OggQIECAAAECBAgQIECAAAECBAgQIHCMCgh4j9EbZ9oECBAgQIAAAQIECBAgQIAAAQIECBAQ8HoGCBAgQIAAAQIECBAgQIAAAQIECBAgcIwKCHiP0Rtn2gQIECBAgAABAgQIECBAgAABAgQIEEjl8v4tqSiurafIvWVZ9hVFY2BMrjIvjCIGI9JQ7bhczisjokjFthfHNEcb2luWqa8o8pj9cqvYkBrlioh4sL5fMa+MMooUw/0i0qqBQbedAAECBAgQIECAAAECBAgQIECAAAEC00FgigPe0QgPL1DOrXJDasSKiGKMgPfAQLkKeNcLeKfDk2sNBAgQIECAAAECBAgQIECAAAECBAiEIxo8BAQIECBAgAABAgQIECBAgAABAgQIEDhGBQS8x+iNM20CBAgQIECAAAECBAgQIECAAAECBAgIeD0DBAgQIECAAAECBAgQIECAAAECBAgQOEYFBLzH6I0zbQIECBAgQIAAAQIECBAgQIAAAQIECAh4PQMECBAgQIAAAQIECBAgQIAAAQIECBA4RgUEvMfojTNtAgQIECBAgAABAgQIECBAgAABAgQICHg9AwQIECBAgAABAgQIECBAgAABAgQIEDhGBVJeftHnolFcXjv/VvPUMsUFRdFz45hrLJtLIxWbIxW7asc1ywVRpBxFunui/XKr9VCZ8rsbRc9XxtMvrbxt5zF6r0ybAAECBAgQIECAAAECBAgQIECAAAEC+wmkvKz/noh8a51LmWN2FDG/yLF1TLsU50aO+yJid+24FHOjjIgU2yfaL6e4OuX4TEQ8PJ5+6fpNqz0DBAgQIECAAAECBAgQIECAAAECBAgQmA4CjmiYDnfRGggQIECAAAECBAgQIECAAAECBAgQmJECAt4ZedstmgABAgQIECBAgAABAgQIECBAgACB6SAg4J0Od9EaCBAgQIAAAQIECBAgQIAAAQIECBCYkQIC3hl52y2aAAECBAgQIECAAAECBAgQIECAAIHpICDgnQ530RoIECBAgAABAgQIECBAgAABAgQIEJiRAgLeGXnbLZoAAQIECBAgQIAAAQIECBAgQIAAgekgIOCdDnfRGggQIECAAAECBAgQIECAAAECBAgQmJECAt4ZedstmgABAgQIECBAgAABAgQIECBAgACB6SCQyuX9z0bEU7WLSVFEjhMi4rmxFpwiXppTPB85yjFqHR+5ffWFifaLiFdGxJOHqHVQv2LNxldNhxtnDQQIECBAgAABAgQIECBAgAABAgQIEEjlskVfSKnn6jqKVpSnNFL0RS42jcVVRtlfpPTFyGmodlzO88soo0iN+w+3XzPnNNrYRio35Yg/KHPxYF2tIuf5kXIuo9g2Mua469d/yW0nQIAAAQIECBAgQIAAAQIECBAgQIDAdBBwRMN0uIvWQIAAAQIECBAgQIAAAQIECBAgQIDAjBQQ8M7I227RBAgQIECAAAECBAgQIECAAAECBAhMBwEB73S4i9ZAgAABAgQIECBAgAABAgQIECBAgMCMFBDwzsjbbtEECBAgQIAAAQIECBAgQIAAAQIECEwHAQHvdLiL1kCAAAECBAgQIECAAAECBAgQIECAwIwUEPDOyNtu0QQIECBAgAABAgQIECBAgAABAgQITAcBAe90uIvWQIAAAQIECBAgQIAAAQIECBAgQIDAjBRI5fL+Lakorq1ffe4ty7KvKBoDYwqVeWEUMRiRhmrH5XJeGRFFKra9OKY52tDeskx9RZHH7JdbxYbUKFdExIP1/Yp5ZZRRpBjuF5FWDQzOyDtt0QQIECBAgAABAgQIECBAgAABAgQITDuBKQ54R/M8vEA5t8oNqRErIooxAt4DA+Uq4F0v4J12j7EFESBAgAABAgQIECBAgAABAgQIEJiZAo5omJn33aoJECBAgAABAgQIECBAgAABAgQIEJgGAgLeaXATLYEAAQIECBAgQIAAAQIECBAgQIAAgZkpIOCdmffdqgkQIECAAAECBAgQIECAAAECBAgQmAYCAt5pcBMtgQABAgQIECBAgAABAgQIECBAgACBmSkg4J2Z992qCRAgQIAAAQIECBAgQIAAAQIECBCYBgIC3mlwEy2BAAECBAgQIECAAAECBAgQIECAAIGZKSDgnZn33aoJECBAgAABAgQIECBAgAABAgQIEJgGAikvv+hz0Sgur11Lq3lqmeKCoui5ccz1ls2lkYrNkYpdteOa5YIoUo4i3T3RfrnVeig1YmlE497x9Esrb9s5De6bJRAgQIAAAQIECBAgQIAAAQIECBAgQCBSXtZ/T0S+tc6izDE7iphf5Ng6pleKcyPHfRGxu3ZcirlRRkSK7RPtl1NcnXJ8JiIeHk+/dP2m1e47AQIECBAgQIAAAQIECBAgQIAAAQIEpoOAIxqmw120BgIECBAgQIAAAQIECBAgQIAAAQIEZqSAgHdG3naLJkCAAAECBAgQIECAAAECBAgQIEBgOggIeKfDXbQGAgQIECBAgAABAgQIECBAgAABAgRmpICAd0bedosmQIAAAQIECBAgQIAAAQIECBAgQGA6CAh4p8NdtAYCBAgQIEDg/2/nbm0iiKIoAN/7wBCyjhYoAL0JJSCgA1BgKIMONgiCIUFCaAEBCQKDJDRAgttkBbPzcCiGn+DefP5lbs533BFDgAABAgQIECBAgAABAqMUMPCOsnahCRAgQIAAAQIECBAgQIAAAQIECBBoQcDA20KLMhAgQIAAAQIECBAgQIAAAQIECBAgMEoBA+8oaxeaAAECBAgQIECAAAECBAgQIECAAIEWBLI/3L3PjIvBMLVOInMrIm5/CLwdEY8RMR98l7EZfURkPP/3Xo16UmuclcyXv9zL2dWsheJkIECAAAECBAgQIECAAAECBAgQIECAQNajvctYKceDFMtuo8/YKWX1/FuuvtuPLDeR5W3wXddPo2SNkne/vTd/7/Krt+sln/qsB4tlPAx9ay1yGpl1UfvPe5PT61e1EyBAgAABAgQIECBAgAABAgQIECBAoAUBv2hooUUZCBAgQIAAAQIECBAgQIAAAQIECBAYpYCBd5S1C02AAAECBAgQIECAAAECBAgQIECAQAsCBt4WWpSBAAECBAgQIECAAAECBAgQIECAAIFRChh4R1m70AQIECBAgAABAgQIECBAgAABAgQItCDwAWIxYFyBX02WAAAAAElFTkSuQmCC",
      "beginTime": "06:34:43","endTime": "06:34:43", "beginDate": "05/24/2023","endDate": "05/24/2023"
    }
  ]
}
  """
When user executes aso/document/nursereport GET request with query params "fromDate=2023-05-11&units=[props.DP_UNIT]&includePurgePending=false"
  )
  ENV['COMMON_DOCUMENT_ID']=@response["model"].find{|t| t['asmpid'].include?(asmpid)}["documentId"].to_s
end

# steps %(Given I login to the api with a valid credential)
Then(/^a snippet has been created by unprivileged user for asmpid "(.*)"/) do |asmpid|
  steps %(Given unprivileged user is logged into the system
And a snippet has been created by the user for asmpid "#{asmpid}")
end

Then(/^system should return lists/) do |patient_data|
  patient_data_json=JSON.parse(process_param(patient_data))
  actual_element= @response['model']['patients'].select{|pat| pat['mrn'].include? patient_data_json['mrn'] }
  verify_response(patient_data_json, actual_element)
end


Then(/^system should return patient$/) do |patient_data|
  patient_data_json=JSON.parse(process_param(patient_data))
  actual_element= @response['model']['patients'].select{|pat| pat['mrn'].include? patient_data_json['mrn'] }
  verify_response(patient_data_json, actual_element)
end

Then(/^system should return user$/) do | user_data |
  user_data_json=JSON.parse(process_param(user_data))
  actual_element= @response['model'].select{|usr| usr['userName'].include? user_data_json['userName'] }
  verify_response(user_data_json, actual_element)
end

Then(/^system should return contact$/) do |contact_data|
  contact_data_json=JSON.parse(process_param(contact_data))
  actual_element= @response['model'].select{|con| con['name'].include? contact_data_json['name'] }
  verify_response(contact_data_json, actual_element)
end

Then(/^system should return (\d) patients$/) do |patient_number|
  expect(@response['model']['patients'].count).to eq patient_number.to_i
end

Then(/^system should return custom list \"(.*)\"/) do |list_name|
  actual_element= @response['model']['lists'].select{|lst| lst['listName'].include? list_name }
  expect(actual_element).not_to be_nil
end

Then(/^system should return group$/) do |patient_data|
  patient_data_json=JSON.parse(process_param(patient_data))
  actual_element= @response['model']['groups'].select{|pat| pat['sublabel'].include? patient_data_json['sublabel'] }
  verify_response(patient_data_json, actual_element)
end

Then(/^system should return patient summary$/) do |patient_data|
  patient_data_json=JSON.parse(process_param(patient_data))
  actual_element= @response['model']
  verify_response(patient_data_json, actual_element)
end

Then(/^system should return measurement$/) do |measurement_data|
  patient_data_json=JSON.parse(process_param(patient_data))
  actual_element= @response['model']
  verify_response(patient_data_json, actual_element)
end

Then(/^system should return data$/) do |response_date|
  patient_data_json=JSON.parse(process_param(response_date))
  verify_response(patient_data_json, @response)
end

Then(/^system should return no data$/) do
  expect(@response).to eql nil
end

Then(/^verify cardio ECG "(.*)" statement with asmpId "(.*)"$/) do | ecg_id, asmpId, statement_data |

  ecg_id=process_param(ecg_id)
  asmpId=process_param(asmpId)
  statement_data=JSON.parse(process_param(statement_data))

  steps %(
    When user executes cardio/ecg GET request with query params "asmpid=#{asmpId}&ecgid=#{ecg_id}"
  )
  verify_response(statement_data, @response)
end


Then(/^system should return response$/) do | response |
  response_data_json=JSON.parse(process_param(response))
  verify_response(response_data_json, @response)
end

Then(/^system should return patient list configuration$/) do |patient_data|
  patient_data_json=JSON.parse(process_param(patient_data))
  verify_response(patient_data_json, @response['model'])
end

Then(/^system should return version/) do |version_data|
  patient_data_json=JSON.parse(process_param(version_data))
  verify_response(patient_data_json, @response['model'])
end

Then(/^system should return user config/) do |user_config|
  expected_data_json=JSON.parse(process_param(user_config))
  actual_element= @response['model']
  verify_response(expected_data_json, actual_element)
end

Then(/^system should create operation log item in DB with text \"(.*)\"$/) do |operation_log_item_text|
  operation_log_item_text=process_param(operation_log_item_text)
  sql_query="select * from OperationLog where ExtraContext like '%#{operation_log_item_text}%'"
  db_response=DB_Client.new.execute_sql(get_param("COMMON_SERVER_DB_ADDRESS"),
                                        get_param("COMMON_SERVER_DB_PORT"),
                                        get_param("COMMON_SERVER_DB_USER"),
                                        get_param("COMMON_SERVER_DB_PASSWORD"),
                                        get_param("COMMON_SERVER_DB_SCHEMA"),
                                        sql_query).to_a
  expect(db_response).not_to( be_empty, "Empty list returned on SQL-request [#{sql_query}]")
end

def verify_response(required_repsonse_attributes,actual_response_attributes)

  required_repsonse_attributes.each do |k, v|
    # puts "Key=#{k}, Value=#{v}"


    if k.end_with?("]")
      path = JsonPath.new("$..#{k.split("[").first}")
      actual_value=path.on(actual_response_attributes)
      index=k.split("[").last.gsub("]","")
      actual_value=actual_value[index.to_i]
    else
      path = JsonPath.new("$..#{k}")
      actual_value=path.first(actual_response_attributes)
    end
    v=v.to_s
    if v.include? "matches:"
      expect(actual_value.to_s).to( match(v.gsub("matches:", "")),"Json value [#{k}] is not proper. Actual [#{actual_value}] expected matches: [#{v}]")
    elsif v.include? "contains:"
      expect(actual_value.to_s).to( include(v.gsub("contains:", "")),"Json value [#{k}] is not proper. Actual [#{actual_value}] expected contains: [#{v}]")
    else
      expect(actual_value.to_s.strip.downcase).to( eq(v.to_s.downcase), "Json value [#{k}] is not proper. Actual [#{actual_value}] expected [#{v}]")
    end
  end
end


Then(/^it should return logon status$/) do
  @response = @Fed_api.logon_status
  #expect(@response["model"]["registrationCode"]).to match ("(.*)-(.*)")
  #$xAuthToken = @response["model"]["xAuthToken"]
end

Then(/^it should return user configuration for "(.*?)"$/) do |username|
  @response = @Fed_api.user_configuration(username)
  #expect(@response["model"]["registrationCode"]).to match ("(.*)-(.*)")
  #$xAuthToken = @response["model"]["xAuthToken"]
end


Then(/^it should not login to the api with "(.*?)" and "(.*?)"$/) do |user, pass|
  @response = @Fed_api.site_logon_with_parameters(user, pass)

  expect(@response["responseCode"]).to eq 200
  expect(@response["model"]).to be_nil
  expect(@response["error"]).to be_nil
end

When(/^I execute a version API call$/) do
  @response = @Fed_api.version
end

Then(/^it should return the api version$/) do
  expect(@response["error"]).to be_nil
  expect(@response["model"]["apiVersion"]).to eq $CURRENT_API_VERSION
end

When(/^I execute a status API call$/) do
  @response = @Fed_api.status
end

Then(/^it should return the "(.*?)" api status$/) do |module_name|
  if module_name == "CARDIO"

    expect(@response["moduleStatuses"]["cardio"]["httpStatusCode"]).to eq 200
    expect(@response["moduleStatuses"]["cardio"]["content"]["responseCode"]).to eq 0
  elsif module_name == "PM"

    #puts @response["moduleStatuses"]["pm"]["httpStatusCode"]
    expect(@response["moduleStatuses"]["pm"]["httpStatusCode"]).to eq 200
    expect(@response["moduleStatuses"]["pm"]["content"]["responseCode"]).to eq 0
  end
end

When(/^I execute a "(.*?)" patient list API call$/) do |module_name|
  case module_name
  when "PM"
    module_id = $PM_MODULE_ID
    list_type = "Census"
  when "CARDIO"
    module_id = $CARDIO_MODULE_ID
    list_type = "mostrecent"
  end

  @response = @Fed_api.patient_list(module_id, list_type)
end

Then(/^it should return the list of lists$/) do
  count = @response["model"]["lists"].count
  for i in 0..(count - 1)
	   value = @response["model"]["lists"][i]["title"]
	if(value) == "MOST RECENT"
		 expect(@response["model"]["lists"][i]["moduleId"]).to eq 1
	elsif(value) == "EMS"
		 expect(@response["model"]["lists"][i]["moduleId"]).to eq 1
	elsif(value) == "API USER"
		 expect(@response["model"]["lists"][i]["moduleId"]).to eq 1
	elsif(value) == "Test Name"
		 expect(@response["model"]["lists"][i]["moduleId"]).to eq 1
	elsif(value) == "Census"
		 expect(@response["model"]["lists"][i]["moduleId"]).to eq 3
	elsif(value) == "Snippet Worklist"
		 expect(@response["model"]["lists"][i]["moduleId"]).to eq 3
	elsif(value) == "SECURE MESSAGING"
		 expect(@response["model"]["lists"][i]["moduleId"]).to eq 0
	elsif(value) == "NOTIFICATIONS"
		 expect(@response["model"]["lists"][i]["moduleId"]).to eq 0
		break
	end
  end
end

When(/^I execute a search configuration API call$/) do
  @response = @Fed_api.search_fields
end

Then(/^it should return the search configuration$/) do
  expect(@response["error"]).to be_nil

  expect(@response["model"][0]["fieldId"]).to eq "searchkey2"
  expect(@response["model"][0]["label"]).to eq "Last"

  expect(@response["model"][1]["fieldId"]).to eq "searchkey1"
  expect(@response["model"][1]["label"]).to eq "First"

  expect(@response["model"][2]["fieldId"]).to eq "searchkey3"
  expect(@response["model"][2]["label"]).to eq "DOB"

  expect(@response["model"][3]["fieldId"]).to eq "searchkey4"
  expect(@response["model"][3]["label"]).to eq "Age"

  expect(@response["model"][4]["fieldId"]).to eq "searchkey5"
  expect(@response["model"][4]["label"]).to eq "MRN/PID"
end

When(/^I execute a list of lists API call$/) do
  @response = @Fed_api.list_of_lists
end

Then(/^it should return the "(.*?)" patient list$/) do |module_name|
  expect(@response["responseCode"]).to eq 0
	expect(@response["error"]).to be_nil

  expect(@response["model"]["patients"].count).to be >= 1

  if module_name == "PM"
    #puts patient_list["model"]["patients"].count
    for i in 0..(@response["model"]["patients"].count - 1)
      #puts patient_list["model"]["patients"][i]["firstName"]
      if(@response["model"]["patients"][i]["firstName"] == "QA1")
        expect(@response["model"]["patients"][i]["lastName"]).to eq "QA1"
      end
    end
  end
end

When(/^I execute a one param search API call to search for "(.*?)" under "(.*?)" for the "(.*?)" module$/) do |value, param, module_name|
  value=process_param(value)
  case param
  when "last name"
    case module_name
    when "PM"
      param_one = "lastname"
    when "CARDIO"
      param_one = "searchkey2"
    end
  when "first name"
    case module_name
    when "PM"
      param_one = "firstname"
    when "CARDIO"
      param_one = "searchkey1"
    end
  when "mrn"
    case module_name
    when "PM"
      param_one = "mrn"
    when "CARDIO"
      param_one = "searchkey5"
    end
  when "bed"
    case module_name
    when "PM"
      param_one = "bed"
    when "CARDIO"
    end
  when "unit"
    case module_name
    when "PM"
      param_one = "unit"
    when "CARDIO"
    end
  end

  case module_name
  when "PM"
    module_id = $PM_MODULE_ID
  when "CARDIO"
    module_id = $CARDIO_MODULE_ID
  end

  @response = @Fed_api.one_param_search(param_one, value, module_id)
end

When(/^I execute a two param search API call to search for "(.*?)" under "(.*?)" and "(.*?)" under "(.*?)" for the "(.*?)" module$/) do |value_one, param_one, value_two, param_two, module_name|
  case module_name
  when "PM"
    module_id = $PM_MODULE_ID
  when "CARDIO"
    module_id = $CARDIO_MODULE_ID
  end

  @response = @Fed_api.two_param_search(param_one,process_param(value_one), param_two, process_param(value_two), module_id)
end

When(/^I execute a three param search API call to search for "(.*?)" under "(.*?)" and "(.*?)" under "(.*?)" and "(.*?)" under "(.*?)" for the "(.*?)" module$/) do |value_one, param_one, value_two, param_two, value_three, param_three, module_name|
  value_one=process_param(value_one)
  value_two=process_param(value_two)
  value_three=process_param(value_three)
  case module_name
  when "PM"
    module_id = $PM_MODULE_ID
  when "CARDIO"
    module_id = $CARDIO_MODULE_ID
  end

  @response = @Fed_api.three_param_search(param_one, value_one, param_two, value_two, param_three, value_three, module_id)
end

Then(/^it should return "(.*?)" search results for last name of "(.*?)"$/) do |module_name, last_name, table|
  expect(@response["responseCode"]).to eq 0
  expect(@response["error"]).to be_nil

  patients = table.hashes
  if(module_name =="PM")
    expect(process_param(patients[0][:firstName])).to eq @response["model"]["patients"][0]["firstName"]
    expect(process_param(patients[0][:lastName])).to eq @response["model"]["patients"][0]["lastName"]
    expect(process_param(patients[0][:mrn])).to eq @response["model"]["patients"][0]["mrn"]
    expect(process_param(patients[0][:status])).to eq(@response["model"]["patients"][0]["status"])

    expect(process_param(patients[0][:moduleId].to_s)).to eq @response["model"]["patients"][0]["moduleSpecificData"][0]["moduleId"].to_s
    expect(process_param(patients[0][:location])).to eq @response["model"]["patients"][0]["moduleSpecificData"][0]["location"]
    expect(process_param(patients[0][:unit])).to eq @response["model"]["patients"][0]["moduleSpecificData"][0]["unit"]
  elsif(module_name =="CARDIO")
    expect(process_param(patients[0][:firstName])).to eq @response["model"]["patients"][0]["firstName"].upcase
    expect(process_param(patients[0][:lastName])).to eq @response["model"]["patients"][0]["lastName"].upcase
    expect(process_param(patients[0][:mrn])).to eq @response["model"]["patients"][0]["mrn"]
    expect(process_param(patients[0][:age])).to eq @response["model"]["patients"][0]["age"]
    expect(process_param(patients[0][:gender])).to eq @response["model"]["patients"][0]["gender"]

    expect(process_param(patients[0][:moduleId].to_s)).to eq @response["model"]["patients"][0]["moduleSpecificData"][0]["moduleId"].to_s
    expect(process_param(patients[0][:location])).to eq @response["model"]["patients"][0]["moduleSpecificData"][0]["location"]
    expect(process_param(patients[0][:hospital])).to eq @response["model"]["patients"][0]["moduleSpecificData"][0]["hospital"]
    expect(process_param(patients[0][:diagnosis])).to eq @response["model"]["patients"][0]["moduleSpecificData"][0]["diagnosis"]
  end
end

Then(/^it should return "(.*?)" search results for first name of "(.*?)"$/) do |module_name, first_name, table|
  expect(@response["responseCode"]).to eq 0
  expect(@response["error"]).to be_nil

  patients = table.hashes

  if(module_name =="PM")
    expect(process_param(patients[0][:firstName])).to eq @response["model"]["patients"][0]["firstName"]
    expect(process_param(patients[0][:lastName])).to eq @response["model"]["patients"][0]["lastName"]
    expect(process_param(patients[0][:mrn])).to eq @response["model"]["patients"][0]["mrn"]
    expect(process_param(patients[0][:status])).to eq(@response["model"]["patients"][0]["status"])

    expect(process_param(patients[0][:moduleId].to_s)).to eq @response["model"]["patients"][0]["moduleSpecificData"][0]["moduleId"].to_s
    expect(process_param(patients[0][:location])).to eq @response["model"]["patients"][0]["moduleSpecificData"][0]["location"]
    expect(process_param(patients[0][:unit])).to eq @response["model"]["patients"][0]["moduleSpecificData"][0]["unit"]
  elsif(module_name =="CARDIO")
    expect(process_param(patients[0][:firstName])).to eq @response["model"]["patients"][0]["firstName"]
    expect(process_param(patients[0][:lastName])).to eq @response["model"]["patients"][0]["lastName"]
    expect(process_param(patients[0][:mrn])).to eq @response["model"]["patients"][0]["mrn"]
    expect(process_param(patients[0][:age])).to eq @response["model"]["patients"][0]["age"]
    expect(process_param(patients[0][:gender])).to eq @response["model"]["patients"][0]["gender"]

    expect(process_param(patients[0][:moduleId].to_s)).to eq @response["model"]["patients"][0]["moduleSpecificData"][0]["moduleId"].to_s
    expect(process_param(patients[0][:location])).to eq @response["model"]["patients"][0]["moduleSpecificData"][0]["location"]
    expect(process_param(patients[0][:hospital])).to eq @response["model"]["patients"][0]["moduleSpecificData"][0]["hospital"]
    expect(process_param(patients[0][:diagnosis])).to eq @response["model"]["patients"][0]["moduleSpecificData"][0]["diagnosis"]
  end
end

Then(/^it should return "(.*?)" results for two parameter search "(.*?)" of "(.*?)" and "(.*?)" of "(.*?)"$/) do |module_name, param_one, value_one, param_two, value_two, table|
  expect(@response["responseCode"]).to eq 0
  expect(@response["error"]).to be_nil

  patients = table.hashes

  expect(process_param(patients[0][:firstName])).to eq @response["model"]["patients"][0]["firstName"]
  expect(process_param(patients[0][:lastName])).to eq @response["model"]["patients"][0]["lastName"]
  expect(process_param(patients[0][:mrn])).to eq @response["model"]["patients"][0]["mrn"]
  expect(process_param(patients[0][:status])).to eq @response["model"]["patients"][0]["status"]
  expect(process_param(patients[0][:moduleId].to_s)).to eq @response["model"]["patients"][0]["moduleSpecificData"][0]["moduleId"].to_s
  expect(process_param(patients[0][:location])).to eq @response["model"]["patients"][0]["moduleSpecificData"][0]["location"]
  expect(process_param(patients[0][:unit])).to eq @response["model"]["patients"][0]["moduleSpecificData"][0]["unit"]
end

Then(/^it should return "(.*?)" results for three parameter search "(.*?)" of "(.*?)" and "(.*?)" of "(.*?)" and "(.*?)" of "(.*?)"$/) do |module_name, param_one, value_one, param_two, value_two, param_three, value_three, table|
  expect(@response["responseCode"]).to eq 0
  expect(@response["error"]).to be_nil

  patients = table.hashes

  expect(process_param(patients[0][:firstName])).to eq @response["model"]["patients"][0]["firstName"]
  expect(process_param(patients[0][:lastName])).to eq @response["model"]["patients"][0]["lastName"]
  expect(process_param(patients[0][:mrn])).to eq @response["model"]["patients"][0]["mrn"]
  expect(process_param(patients[0][:status])).to eq @response["model"]["patients"][0]["status"]
  expect(process_param(patients[0][:moduleId].to_s)).to eq @response["model"]["patients"][0]["moduleSpecificData"][0]["moduleId"].to_s
  expect(process_param(patients[0][:location])).to eq @response["model"]["patients"][0]["moduleSpecificData"][0]["location"]
  expect(process_param(patients[0][:unit])).to eq @response["model"]["patients"][0]["moduleSpecificData"][0]["unit"]
end

Then(/^it should return "(.*?)" patient summary for "(.*?)" "(.*?)"$/) do |module_name, value_one, value_two, table|
  patients = table.hashes
  asmpid = @response["model"]["patients"][0]["asmpid"]

  summary_results = @Fed_api.patient_summary(asmpid)

  expect(summary_results["model"]["tiles"]["demographics"]["title"]).to eq "GENERAL INFO"
  expect(summary_results["model"]["tiles"]["demographics"]["model"]["fields"][0]["label"]).to eq "Patient Name"
  expect(summary_results["model"]["tiles"]["demographics"]["model"]["fields"][0]["value"]).to eq "#{process_param(value_two)},#{process_param(value_one)}"
  expect(summary_results["model"]["tiles"]["demographics"]["model"]["fields"][1]["label"]).to eq "MRN"
  expect(summary_results["model"]["tiles"]["demographics"]["model"]["fields"][1]["value"]).to eq  process_param( patients[0][:mrn])
  expect(summary_results["model"]["tiles"]["demographics"]["model"]["fields"][2]["label"]).to eq "DOB"
  expect(summary_results["model"]["tiles"]["demographics"]["model"]["fields"][3]["label"]).to eq "Gender"
  expect(summary_results["model"]["tiles"]["demographics"]["model"]["fields"][4]["label"]).to eq "Age"
end

Then(/^it should return "(.*?)" search results for mrn "(.*?)"$/) do |module_name, mrn, table|

  expect(@response["responseCode"]).to eq 0
  expect(@response["error"]).to be_nil
  expect(@response["model"]["patients"][0]["mrn"]).to eq process_param(mrn)

  patients = table.hashes

  if(module_name == "PM")
    expect(process_param(patients[0][:firstName])).to eq @response["model"]["patients"][0]["firstName"]
    expect(process_param(patients[0][:lastName])).to eq @response["model"]["patients"][0]["lastName"]
    expect(process_param(patients[0][:mrn])).to eq @response["model"]["patients"][0]["mrn"]
    expect(process_param(patients[0][:status])).to eq @response["model"]["patients"][0]["status"]
    expect(process_param(patients[0][:moduleId].to_s)).to eq @response["model"]["patients"][0]["moduleSpecificData"][0]["moduleId"].to_s
    expect(process_param(patients[0][:location])).to eq @response["model"]["patients"][0]["moduleSpecificData"][0]["location"]
    expect(process_param(patients[0][:unit])).to eq @response["model"]["patients"][0]["moduleSpecificData"][0]["unit"]
  elsif(module_name =="CARDIO")
    expect(process_param(patients[0][:firstName])).to eq @response["model"]["patients"][0]["firstName"]
    expect(process_param(patients[0][:lastName])).to eq @response["model"]["patients"][0]["lastName"]
    expect(process_param(patients[0][:mrn])).to eq @response["model"]["patients"][0]["mrn"]
    expect(process_param(patients[0][:age])).to eq @response["model"]["patients"][0]["age"]
    expect(process_param(patients[0][:gender])).to eq @response["model"]["patients"][0]["gender"]

    expect(process_param(patients[0][:moduleId].to_s)).to eq @response["model"]["patients"][0]["moduleSpecificData"][0]["moduleId"].to_s
    expect(process_param(patients[0][:location])).to eq @response["model"]["patients"][0]["moduleSpecificData"][0]["location"]
    expect(process_param(patients[0][:hospital])).to eq @response["model"]["patients"][0]["moduleSpecificData"][0]["hospital"]
    expect(process_param(patients[0][:diagnosis])).to eq @response["model"]["patients"][0]["moduleSpecificData"][0]["diagnosis"]
  end
end

Then(/^it should return "(.*?)" search results for Age "(.*?)"$/) do |module_name, age, table|
  case module_name
  when "PM"
    module_id = $PM_MODULE_ID
    param_one = "mrn"
  when "CARDIO"
    module_id = $CARDIO_MODULE_ID
    param_one = "searchkey4"
  end

  @response = @Fed_api.one_param_search(param_one, age, module_id)

  expect(@response["responseCode"]).to eq 0
  expect(@response["error"]).to be_nil

  patients = table.hashes

  expect(patients[0][:firstName]).to eq @response["model"]["patients"][0]["firstName"].upcase
  expect(patients[0][:lastName]).to eq @response["model"]["patients"][0]["lastName"].upcase
  expect(patients[0][:mrn]).to eq @response["model"]["patients"][0]["mrn"]
  expect(patients[0][:status]).to eq @response["model"]["patients"][0]["status"]
  expect(patients[0][:moduleId].to_s).to eq @response["model"]["patients"][0]["moduleSpecificData"][0]["moduleId"].to_s
  expect(patients[0][:location]).to eq @response["model"]["patients"][0]["moduleSpecificData"][0]["location"]
  expect(patients[0][:unit]).to eq @response["model"]["patients"][0]["moduleSpecificData"][0]["unit"]
end

Then(/^I should execute the first step def$/) do

  url =  "#{$QA_FED_WEB}/patientlist/?listtype='Search'&moduleId=#{$PM_MODULE_ID}&siteId=#{SITE_ID}"
  headers = {:x_auth_token => $xAuthToken, :content_type => :json}
  r = RestClient::Request.execute(:method => :get, :url => url, :headers => headers, :verify_ssl => false)
  r = JSON.parse(r)
  puts r

  for i in 0..(r["model"].count - 1)
    puts r["model"][i]["label"]
  end

end
