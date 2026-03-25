Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class Acm_api 

  def initialize
  
  end
  
  def acm_rules_update(payload)
    #url =  "#{$ACM_SERVER_URL}/services/acwa/acmrules"
    url =  "#{$ACM_SERVER_URL}/acmrules"
  
    #puts url
    #headers = {:x_auth_token => "testtoken", :content_type => 'application/json'}
    headers = {:content_type => 'application/json'}
    #headers = {:x_auth_token => "testtoken"}
    response = RestClient::Request.execute(:url => url, :method => :post, :headers => headers, :payload => payload, :verify_ssl => false) 
    #response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)    
    response = JSON.parse(response)
    #puts response
    return response
  end 
    
  def acm_rules
    #url =  "#{$ACM_SERVER_URL}/services/acwa/acmrules"
    url =  "#{$ACM_SERVER_URL}/acmrules"
    
    if $DEBUG_FLAG == "debug"
      puts url
    end
    
    headers = {:x_auth_token => "testtoken", :content_type => :json}
    #headers = {:x_auth_token => "testtoken"}    
    response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)    
    response = JSON.parse(response)
    #puts response
    return response
  end
  
  def acm_qa_rules
    #url =  "#{$ACM_SERVER_URL}/services/acwa/acmrules"
    url =  "#{$ACM_QA_SERVER_URL}/acmrules"
    
    if $DEBUG_FLAG == "debug"
      puts url
    end
    
    headers = {:x_auth_token => "testtoken", :content_type => :json}
    #headers = {:x_auth_token => "testtoken"}    
    response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)    
    response = JSON.parse(response)
    #puts response
    return response
  end
  
  def acm_qa_rules_update(payload)
    #url =  "#{$ACM_SERVER_URL}/services/acwa/acmrules"
    url =  "#{$ACM_QA_SERVER_URL}/acmrules"
  
    #puts url
    #headers = {:x_auth_token => "testtoken", :content_type => 'application/json'}
    headers = {:content_type => 'application/json'}
    #headers = {:x_auth_token => "testtoken"}
    response = RestClient::Request.execute(:url => url, :method => :post, :headers => headers, :payload => payload, :verify_ssl => false) 
    #response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)    
    response = JSON.parse(response)
    #puts response
    return response
  end 
  
  def acm_fed_rules_update(payload)
    #url =  "#{$ACM_SERVER_URL}/services/acwa/acmrules"
    url =  "#{$ACM_FED_SERVER_URL}/services/acwa/post/acmrules?x-auth-token=testtoken"
    #puts url
    #headers = {:x_auth_token => "testtoken", :content_type => 'application/json'}
    headers = {:content_type => 'application/json'}
    #headers = {:x_auth_token => "testtoken"}
    response = RestClient::Request.execute(:url => url, :method => :post, :headers => headers, :payload => payload, :verify_ssl => false) 
    #response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)    
    response = JSON.parse(response)
    #puts response
    return response
  end 
  
  def acm_fed_rules
    url =  "#{$ACM_FED_SERVER_URL}/services/acwa/acmrules"
    
    if $DEBUG_FLAG == "debug"
      puts url
    end
    
    #url =  "#{$ACM_SERVER_URL}/acmrules"
    headers = {:x_auth_token => "testtoken", :content_type => :json}
    #headers = {:x_auth_token => "testtoken"}    
    response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)    
    response = JSON.parse(response)
    #puts response
    return response
  end
  
  def acm_fed_qa_rules_update(payload)
    #url =  "#{$ACM_SERVER_URL}/services/acwa/acmrules"
    url =  "#{$ACM_FED_QA_SERVER_URL}/services/acwa/post/acmrules?x-auth-token=testtoken"
    #puts url
    #headers = {:x_auth_token => "testtoken", :content_type => 'application/json'}
    headers = {:content_type => 'application/json'}
    #headers = {:x_auth_token => "testtoken"}
    response = RestClient::Request.execute(:url => url, :method => :post, :headers => headers, :payload => payload, :verify_ssl => false) 
    #response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)    
    response = JSON.parse(response)
    #puts response
    return response
  end 
  
  def acm_fed_qa_rules
    url =  "#{$ACM_FED_QA_SERVER_URL}/services/acwa/acmrules"
    
    if $DEBUG_FLAG == "debug"
      puts url
    end
    
    #url =  "#{$ACM_SERVER_URL}/acmrules"
    headers = {:x_auth_token => "testtoken", :content_type => :json}
    #headers = {:x_auth_token => "testtoken"}    
    response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)    
    response = JSON.parse(response)
    #puts response
    return response
  end

end