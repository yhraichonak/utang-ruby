Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class FedHost_api
  def initialize
    
  end
  

  def get_conversation_id(site_id,adusername, recipient_contact_id,do_create)
    url =  "#{$QA_FED_HOST}/messaging/conversationid"
    response = RestClient::Request.execute(:url => "#{url}?siteId=#{site_id}&recipientContactId=#{recipient_contact_id}&adusername=#{adusername}&sessionid=auto", :method => :get)
    response = JSON.parse(response)
    if (!response['model']['existing']&& do_create)
      response = RestClient::Request.execute(:url => "#{url}?siteId=#{site_id}&recipientContactId=#{recipient_contact_id}&adusername=#{adusername}&sessionid=auto", :method => :get)
      response = JSON.parse(response)
    end
    return response['model']['conversationId']
  end

  def delete_conversation(site_id,adusername, conversation_id)
    url =  "#{$QA_FED_HOST}/messaging/conversation/delete"
    response = RestClient::Request.execute(:url => "#{url}?siteId=#{site_id}&conversationId=#{conversation_id}&adusername=#{adusername}&sessionid=auto", :method => :get)
    return response
  end

end