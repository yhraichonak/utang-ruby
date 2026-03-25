Before do
  @Secure_Messaging_api = Secure_Messaging_api.new
end

Then(/^it should return the contact list$/) do
  response = @Secure_Messaging_api.contact_list
  
  if $DEBUG_FLAG == "debug"
    puts response
  end
  
  value = ""
  for i in 0..response["model"].count
	if response["model"][i]["name"] == "User, utang"
	  value = i
	  break
	end
  end
  
  expect(response["model"][value]["name"]).to eq "User, utang"
  
end

Then(/^it should return the conversation list$/) do
  response = @Secure_Messaging_api.conversation_list

#  i_value = 0
#  
#  for i in 0..response["model"].count
#	if(response["model"][i]["participant"]["name"] == "Trejo, Ray")
#	  i_value = i
#	  break
#	end

# end
  expect(response["model"][0]["participant"]["name"]).not_to be_empty
  $CONVERSATION_ID = response["model"][0]["conversationId"]
  puts $CONVERSATION_ID
  $CONTACT_ID = response["model"][0]["participant"]["contactId"]
  puts $CONTACT_ID
end

Then(/^it should return the conversation by contact id$/) do
  response = @Secure_Messaging_api.conversation_by_recipient_id($CONTACT_ID)
  
  expect(response["model"]["conversationId"]).to eq $CONVERSATION_ID
  expect(response["error"]).to be_nil
end

Then(/^it should return the conversation by conversation id$/) do
  response = @Secure_Messaging_api.conversation_by_conversation_id($CONVERSATION_ID)

  expect(response["model"]["participants"][1]["contactId"]).to eq $CONTACT_ID
  expect(response["error"]).to be_nil
  $CONTACT_ID_2 = response["model"]["participants"][0]["contactId"]
end

Then(/^it should send a message$/) do
  r = Random.new
  r = r.rand(99999999...9999999999)
  $MSG_RANDOM_NUMBER =  r
  payload = '{"conversationId": ' + $CONVERSATION_ID.to_s + ', "messages": ["Hello Message: ' + $MSG_RANDOM_NUMBER.to_s + '"]}'
  payload = JSON.generate(payload)

  response = @Secure_Messaging_api.send_message(payload)
  expect(response["model"]["conversationId"]).to eq $CONVERSATION_ID
  expect(response["error"]).to be_nil
end

Then(/^it should return the new message in the conversation$/) do
  response = @Secure_Messaging_api.conversation_by_conversation_id($CONVERSATION_ID)
  value = 0
  for i in 0..response["model"]["messages"].count
    if(response["model"]["messages"][i]["message"] == "Hello Message: #{$MSG_RANDOM_NUMBER}")
      value = i
      break
    end
  end
  
  expect(response["model"]["messages"][value]["message"]).to eq "Hello Message: #{$MSG_RANDOM_NUMBER}"  
end