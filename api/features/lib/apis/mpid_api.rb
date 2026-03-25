Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class Mpid_api 

def initialize

end
  
def sync(payload)
  url =  "#{$MPID_SERVER_URL}/sync"
  headers = {:content_type => 'application/json'}    
  response = RestClient::Request.execute(:url => url, :method => :post, :payload => payload, :headers => headers, :verify_ssl => false)    
  response = JSON.parse(response)
  puts url
  puts headers
  puts response
  return response
end

def sync_with_mpid(mpid)
  url =  "#{$MPID_SERVER_URL}/sync?id=#{mpid}"
  puts url
  headers = {:content_type => 'application/json'}    
  puts headers
  response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)
      
  response = JSON.parse(response)
  puts response
  return response
end

def return_all_users
  url =  "#{$AMP_SERVER_API_URL}EnterpriseUser?username=#{$AMP_USERNAME}&password=#{$AMP_PASSWORD}"
  headers = {:x_auth_token => $xAuthToken, :content_type => :json}    
  response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)    
  response = JSON.parse(response)

  return response
end

end