Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class Status_api 
  def initialize
    
  end
  
  def fed_web_status()

    url =  "#{$QA_FED_WEB}/status"
    headers = {:content_type => 'application/json', :accept => 'json'}  
    response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)    
    response = JSON.parse(response)
    
    if $DEBUG_FLAG == "debug"
      puts url
      puts response
    end
    
    return response
  end

  def fed_host_status()

    url =  "#{$QA_FED_HOST}/status"
    headers = {:content_type => 'application/json', :accept => 'json'}  
    response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)    
    response = JSON.parse(response)
    
    if $DEBUG_FLAG == "debug"
      puts url
      puts response
    end
    
    return response
  end  
end