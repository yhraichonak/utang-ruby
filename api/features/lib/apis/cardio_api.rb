Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class Cardio_api  
  def initialize
   
  end

  def ecg_list(asmpid)
    url =  "#{$QA_FED_WEB}/cardio/ecglist?siteId=#{SITE_ID}&asmpid=#{asmpid}"
    headers = {:x_auth_token => $xAuthToken, :content_type => :json}
    r = RestClient::Request.execute(:method => :get, :url => url, :headers => headers, :verify_ssl => false)
    r = JSON.parse(r)
	
    return r   
  end
  
  def get_ecg(ecg_id)
    url =  "#{$QA_FED_WEB}/cardio/ecg?siteId=#{SITE_ID}&ecgid=#{ecg_id}"
    headers = {:x_auth_token => $xAuthToken, :content_type => :json}
    r = RestClient::Request.execute(:method => :get, :url => url, :headers => headers, :verify_ssl => false)
    r = JSON.parse(r)
	
    return r   
  end
  
  def request_edit_ecg(ecg_id)
    url =  "#{$QA_FED_WEB}/cardio/requestedit?siteId=#{SITE_ID}&ecgid=#{ecg_id}"
    headers = {:x_auth_token => $xAuthToken, :content_type => :json}
    r = RestClient::Request.execute(:method => :get, :url => url, :headers => headers, :verify_ssl => false)
    r = JSON.parse(r)
	
    return r   
  end
  
  def serial_presentation(ecg_one, ecg_two)
    url =  "#{$QA_FED_WEB}/cardio/ecg?siteId=#{SITE_ID}&ecgid=#{ecg_one}&ecg2id=#{ecg_two}"
    headers = {:x_auth_token => $xAuthToken, :content_type => :json}
    r = RestClient::Request.execute(:method => :get, :url => url, :headers => headers, :verify_ssl => false)
    r = JSON.parse(r)
	
    return r   
  end

  def statement_library
    url =  "#{$QA_FED_WEB}/cardio/statementlibrary?siteId=#{SITE_ID}"
    puts url
    headers = {:x_auth_token => $xAuthToken, :content_type => :json}
    r = RestClient::Request.execute(:method => :get, :url => url, :headers => headers, :verify_ssl => false)
    r = JSON.parse(r)
	
    return r   
  end  
end 