Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class GS_api 

  def initialize

  end
  
  def site_logon(payload, user_agent)
    url =  "#{$SERVER_URL}/SignOn"
    headers = {:content_type => :json, :authorization => $gs_creds, :user_agent => user_agent}    
    response = RestClient::Request.execute(:url => url, :method => :post, :headers => headers, :payload => payload, :verify_ssl => false)    
    response = JSON.parse(response)
    
    puts "++++++"
    puts headers
    puts url
    puts payload
    puts response
    puts "++++++"
  	
    return response
  end
  
  def site_list(device_id, reg_code, user_agent)
    url =  "#{$SERVER_URL}/sitelist?deviceid=#{device_id}&registrationCode=#{reg_code}"
    headers = {:content_type => :json, :authorization => $gs_creds, :user_agent => user_agent}    
    response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)    
    response = JSON.parse(response)

    return response
  end
  
  def check_device(device_id, reg_code, user_agent)
    url =  "#{$SERVER_URL}/checkdevice?deviceid=#{device_id}&registrationCode=#{reg_code}"
    headers = {:content_type => :json, :authorization => $gs_creds, :user_agent => user_agent}    
    response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)    
    response = JSON.parse(response)

    return response
  end
  
  def get_device(reg_code, user_agent)
    url =  "#{$SERVER_URL}/device?regcode=#{reg_code}"
    headers = {:content_type => :json, :authorization => $gs_creds, :user_agent => user_agent}    
    response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)    
    response = JSON.parse(response)

    return response
  end
  
  def httpclient_configurations(device_id, reg_code, user_agent)
    url =  "#{$SERVER_URL}/httpclientconfigurations?deviceid=#{device_id}&registrationCode=#{reg_code}"
    headers = {:content_type => :json, :authorization => $gs_creds, :user_agent => user_agent}    
    response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)    
    response = JSON.parse(response)

    return response
  end
  
  def pushnotification_registration(payload, user_agent)
    url =  "#{$SERVER_URL}/PushNotificationRegistration"
    headers = {:content_type => :json, :authorization => $gs_creds, :user_agent => user_agent}    
    response = RestClient::Request.execute(:url => url, :method => :post, :headers => headers, :payload => payload, :verify_ssl => false)    
    response = JSON.parse(response)
  	
    return response
  end
  
  def user_account(payload, user_agent)
    url =  "#{$SERVER_URL}/useraccount"
    headers = {:content_type => :json, :authorization => $gs_creds, :user_agent => user_agent}    
    response = RestClient::Request.execute(:url => url, :method => :post, :headers => headers, :payload => payload, :verify_ssl => false)    
    response = JSON.parse(response)
  	
    return response
  end
  
  def eula(user_agent)
    url =  "#{$SERVER_URL}/eula"
    headers = {:content_type => :json, :authorization => $gs_creds, :user_agent => user_agent}    
    response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)    
    response = JSON.parse(response)

    return response
  end
  
  def update_site(payload, reg_code, user_agent)
    url =  "#{$SERVER_URL}/site?registrationCode=#{reg_code}"
    headers = {:content_type => :json, :authorization => $gs_creds, :user_agent => user_agent}    
    response = RestClient::Request.execute(:url => url, :method => :post, :headers => headers, :payload => payload, :verify_ssl => false)    
    response = JSON.parse(response)
  	
    return response
  end
  
  def next_http_client_config(reg_code, user_agent)
    url =  "#{$SERVER_URL}/HttpClientConfigurationId/NextId?registrationCode=#{reg_code}"
    headers = {:content_type => :json, :authorization => $gs_creds, :user_agent => user_agent}    
    response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)
    #puts response
    #response = JSON.parse(response)

    return response
  end
  
  def next_site(reg_code, user_agent)
    url =  "#{$SERVER_URL}/siteid/NextId?registrationCode=#{reg_code}"
    headers = {:content_type => :json, :authorization => $gs_creds, :user_agent => user_agent}    
    response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)    
    #response = JSON.parse(response)

    return response
  end
  
  def update_client_configuration(payload, reg_code, user_agent)
    url =  "#{$SERVER_URL}/HttpClientConfigurations?registrationCode=#{reg_code}"
    headers = {:content_type => :json, :authorization => $gs_creds, :user_agent => user_agent}    
    response = RestClient::Request.execute(:url => url, :method => :post, :headers => headers, :payload => payload, :verify_ssl => false)    
    response = JSON.parse(response)
  	
    return response
  end
  
  def add_reg_to_site(payload, reg_code, user_agent)
    url =  "#{$SERVER_URL}/devicesite?registrationCode=#{reg_code}"
    headers = {:content_type => :json, :authorization => $gs_creds, :user_agent => user_agent}    
    response = RestClient::Request.execute(:url => url, :method => :post, :headers => headers, :payload => payload, :verify_ssl => false)    
    response = JSON.parse(response)
  	
    return response
  end
  
  def password_reset(payload, user_agent)
    url =  "#{$SERVER_URL}/passwordreset"
    headers = {:content_type => :json, :authorization => $gs_creds, :user_agent => user_agent}    
    response = RestClient::Request.execute(:url => url, :method => :post, :headers => headers, :payload => payload, :verify_ssl => false)    
    response = JSON.parse(response)
  	
    return response
  end
end