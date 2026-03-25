Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class Secure_Messaging_api 

def initialize

end
  
def contact_list
  url =  "#{$QA_FED_WEB}/aso/contacts/getbysiteid?siteid=#{SITE_ID}"
  headers = {:x_auth_token => $xAuthToken, :content_type => :json}    
  response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)    
  response = JSON.parse(response)

  return response
end

def contact_id(contact_name)
  @response=contact_list()
  return @response["model"].find{|x| x['name'].include?(contact_name)}['contactId']
end
def conversation_list
  url =  "#{$QA_FED_WEB}/aso/messaging/conversations?siteid=#{SITE_ID}"
  headers = {:x_auth_token => $xAuthToken, :content_type => :json}    
  response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)    
  response = JSON.parse(response)
  if $DEBUG_FLAG == "debug"
    puts url
    puts response
  end
  return response
end

def conversation_by_recipient_id(contact_id)
  url =  "#{$QA_FED_WEB}/aso/messaging/conversationid?siteid=#{SITE_ID}&recipientContactId=#{contact_id}"
  headers = {:x_auth_token => $xAuthToken, :content_type => :json}    
  response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)    
  response = JSON.parse(response)

  return response
end

def conversation_by_conversation_id(contact_id)
  url =  "#{$QA_FED_WEB}/aso/messaging/conversation?siteid=#{SITE_ID}&conversationid=#{contact_id}"
  headers = {:x_auth_token => $xAuthToken, :content_type => :json}    
  response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)    
  response = JSON.parse(response)

  return response
end

def send_message(payload)
  url =  "#{$QA_FED_WEB}/aso/post/messaging/sendmessage?siteid=#{SITE_ID}"

  headers = {:x_auth_token => $xAuthToken, :content_type => :json}   
  response = RestClient::Request.execute(:url => url, :method => :post, :headers => headers, :payload => payload, :verify_ssl => false)    
  response = JSON.parse(response)
  	
  return response
end

end