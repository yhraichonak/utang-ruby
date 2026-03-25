Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class Amp_api 

def initialize
  require File.dirname(__FILE__)+'/../../support/env.rb'
end
  
def shared_security_key(payload)
  url =  "#{$AMP_SERVER_API_URL}/SharedSecurityKey?username=#{$AMP_USERNAME}&password=#{$AMP_PASSWORD}"

  headers = {:x_auth_token => $xAuthToken, :content_type => :json}    
  response = RestClient::Request.execute(:url => url, :method => :post, :payload => payload, :headers => headers, :verify_ssl => false)    
  response = JSON.parse(response)
  
  if $DEBUG_FLAG == "debug"
    puts url
    puts response
  end
  
  return response
end

def return_all_users
  url =  "#{$AMP_SERVER_API_URL}/EnterpriseUser?username=#{$AMP_USERNAME}&password=#{$AMP_PASSWORD}"
  headers = {:x_auth_token => $xAuthToken, :content_type => :json}    
  response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)    
  response = JSON.parse(response)
  
  if $DEBUG_FLAG == "debug"
    puts url
    puts response
  end
  
  return response
end

def return_all_sites
  url =  "#{$AMP_SERVER_URL_AUTH}/en-US/Site"
   headers = {:x_auth_token => $xAuthToken, :content_type => :html}
  response = RestClient::Request.execute(:url => url, :method => :get, :verify_ssl => false)
  response = JSON.parse(response)
  return response
end


def enterprise_user_verification(payload)
  url =  "#{$AMP_SERVER_API_URL}/EnterpriseUserVerification?username=#{$AMP_USERNAME}&password=#{$AMP_PASSWORD}"
  headers = {:x_auth_token => $xAuthToken, :content_type => :json}    
  response = RestClient::Request.execute(:url => url, :method => :post, :payload => payload, :headers => headers, :verify_ssl => false)    
  response = JSON.parse(response)
  
  if $DEBUG_FLAG == "debug"
    puts url
    puts response
  end
 
  return response
end

def module_instance_configuration(module_id)
  url =  "#{$AMP_SERVER_API_URL}/ModuleInstanceConfiguration?id=#{module_id}"
  headers = {:x_auth_token => $xAuthToken, :content_type => :json}    
  response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)    
  response = JSON.parse(response)
  
  if $DEBUG_FLAG == "debug"
    puts url
    puts response
  end
  
  return response
end

def module_instance_user_configuration(payload)
  url =  "#{$AMP_SERVER_API_URL}/ModuleInstanceUserConfiguration"
  #puts payload
  
  headers = {:x_auth_token => $xAuthToken, :content_type => :json}    
  response = RestClient::Request.execute(:url => url, :method => :post, :payload => payload, :headers => headers, :verify_ssl => false)    
  response = JSON.parse(response)
  
  if $DEBUG_FLAG == "debug"
    puts payload
    puts url
    puts response
  end
  
  return response
end

def enterprise_user_vendor_credential(payload)
  url =  "#{$AMP_SERVER_API_URL}EnterpriseUserVendorCredential"
  headers = {:x_auth_token => $xAuthToken, :content_type => :json}    
  response = RestClient::Request.execute(:url => url, :method => :post, :payload => payload, :headers => headers, :verify_ssl => false)    
  response = JSON.parse(response)
  
  if $DEBUG_FLAG == "debug"
    puts url
    puts response
  end
  
  return response
end

end