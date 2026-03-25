Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class Pm_api 
  def initialize
    
  end
    
  def events(asmpid)
    url =  "#{$QA_FED_WEB}/pm/events?siteId=#{SITE_ID}&asmpid=#{asmpid}"
    #puts url
    headers = {:x_auth_token => $xAuthToken, :content_type => :json}
    r = RestClient::Request.execute(:method => :get, :url => url, :headers => headers, :verify_ssl => false)
    r = JSON.parse(r)
    if $DEBUG_FLAG == "debug"
      puts url
      puts r
    end
	
    return r   
  end
    
  def monitor_config(asmpid)
    url =  "#{$QA_FED_WEB}/pm/config?siteId=#{SITE_ID}&asmpid=#{asmpid}"
    headers = {:x_auth_token => $xAuthToken, :content_type => :json}
    r = RestClient::Request.execute(:method => :get, :url => url, :headers => headers, :verify_ssl => false)
    r = JSON.parse(r)
    if $DEBUG_FLAG == "debug"
      puts url
      puts r
    end
    return r 
  end
  
  def measurements(asmpid)
    url =  "#{$QA_FED_WEB}/pm/measurements?siteId=#{SITE_ID}&asmpid=#{asmpid}&seconds=16"
    headers = {:x_auth_token => $xAuthToken, :content_type => :json}
    r = RestClient::Request.execute(:method => :get, :url => url, :headers => headers, :verify_ssl => false)
    r = JSON.parse(r)
    if $DEBUG_FLAG == "debug"
      puts url
      puts r
    end
    return r 
  end
  
  def trends(asmpid, keys)
    url =  "#{$QA_FED_WEB}/pm/trends?siteId=#{SITE_ID}&asmpid=#{asmpid}&keys=#{keys}"
    headers = {:x_auth_token => $xAuthToken, :content_type => :json}
    r = RestClient::Request.execute(:method => :get, :url => url, :headers => headers, :verify_ssl => false)
    r = JSON.parse(r)
    if $DEBUG_FLAG == "debug"
      puts url
      puts r
    end
    return r 
  end
end 