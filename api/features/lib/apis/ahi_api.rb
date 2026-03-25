Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class Ahi_api 
  def initialize
    
  end
    
  def post_patient_list(adusername, sessionid, patient_list)
    url =  "#{$QA_FED_WEB}/services/ahi/AnalysisResult/PostPatientList?adusername=#{adusername}&sessionid=#{sessionid}"
    headers = {:x_auth_token => $xAuthToken, :content_type => :json}
    payload = patient_list.to_s
    r = RestClient::Request.execute(:method => :post, :payload => payload, :url => url, :headers => headers, :verify_ssl => false)
    r = JSON.parse(r)
	
    return r   
  end
    
  def get_patient(asmpid, adusername, sessionid)
    url =  "#{$QA_FED_WEB}/services/ahi/AnalysisResult/#{asmpid}?adusername=#{adusername}&sessionid=#{sessionid}"
    headers = {:x_auth_token => $xAuthToken, :content_type => :json}
    r = RestClient::Request.execute(:method => :get, :url => url, :headers => headers, :verify_ssl => false)
    r = JSON.parse(r)
	
    return r   
  end
    
  def polling
    url =  "#{$QA_FED_WEB}/services/ahi/Polling"
    headers = {:x_auth_token => $xAuthToken, :content_type => :json}
    r = RestClient::Request.execute(:method => :get, :url => url, :headers => headers, :verify_ssl => false)
    r = JSON.parse(r)
	
    return r   
  end
    
  def get_resource(resource_id)
    url =  "#{$QA_FED_WEB}/services/ahi/Resource/#{resource_id}"
    headers = {:x_auth_token => $xAuthToken, :content_type => :json}
    r = RestClient::Request.execute(:method => :get, :url => url, :headers => headers, :verify_ssl => false)
	
    return r   
  end
    
  def all_text
    url =  "#{$QA_FED_WEB}/services/ahi/Resource/AllText"
    headers = {:x_auth_token => $xAuthToken, :content_type => :json}
    r = RestClient::Request.execute(:method => :get, :url => url, :headers => headers, :verify_ssl => false)
    r = JSON.parse(r)
	
    return r   
  end
    
  def status
    url =  "#{$QA_FED_WEB}/services/ahi/status"
    headers = {:x_auth_token => $xAuthToken, :content_type => :json}
    r = RestClient::Request.execute(:method => :get, :url => url, :headers => headers, :verify_ssl => false)
    r = JSON.parse(r)
	
    return r   
  end
end 