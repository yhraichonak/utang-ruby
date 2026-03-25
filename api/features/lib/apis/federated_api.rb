Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class Fed_api 
  def initialize
    
  end
  
  def version
    url =  "#{$QA_FED_WEB}/version"
    response = RestClient::Request.execute(:url => url, :method => :get, :verify_ssl => false)    
    response = JSON.parse(response)
    if $DEBUG_FLAG == "debug"
      puts response
    end
    return response
  end
  
  def status
    url =  "#{$QA_FED_WEB}/status"
    if $DEBUG_FLAG == "debug"
      puts url
    end
    headers = {:x_auth_token => $xAuthToken, :content_type => :json}
    response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)    
    response = JSON.parse(response)
    if $DEBUG_FLAG == "debug"
      puts response
    end
    return response
  end

  def logon_status
    url =  "#{$QA_FED_WEB}/logon/status"
    if $DEBUG_FLAG == "debug"
      puts url
    end
    headers = {:x_auth_token => $xAuthToken, :content_type => :json}
    response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)    
    response = JSON.parse(response)
    if $DEBUG_FLAG == "debug"
      puts response
    end
    return response
  end

  def do_site_logon(username, password)
    url =  "#{$QA_FED_WEB}/logon?siteid=#{SITE_ID}"

    if $DEBUG_FLAG == "debug"
      puts url
    end
    payload = JSON.generate({:Username => username, :Password => password})

    if $DEBUG_FLAG == "debug"
      puts payload
    end
    headers = {:content_type => :json}
    response = RestClient::Request.execute(:url => url, :method => :post, :headers => headers, :payload => payload, :verify_ssl => false)  #:headers => headers, :payload => payload, :verify_ssl => false)
    response = JSON.parse(response)
    if $DEBUG_FLAG == "debug"
      puts response
    end
    return response
  end

  def site_default_logon
    return do_site_logon($QA_USERNAME,$QA_PASSWORD)
  end
  def site_super_logon
    return do_site_logon(SUPER_USERNAME,SUPER_PASSWORD)
  end
  def site_logon(username, password)
    return do_site_logon(username,password)
  end

  def execute_get_with_query_params(rel_url, query_params)
    return do_execute_get_with_query_params(rel_url, query_params, "3")
  end

  def do_execute_get_with_query_params(rel_url, query_params, moduleId)
    return do_execute_get_with_query_params_and_payload(rel_url, query_params, moduleId, nil)
  end
  def do_execute_get_with_query_params_and_payload(rel_url, query_params, moduleId, payload)
    if moduleId.nil?
      moduleId="3"
    end
    if query_params.nil?
      url =  "#{$QA_FED_WEB}/#{rel_url}?siteid=#{SITE_ID}&moduleId=#{moduleId}"
    else
      url =  "#{$QA_FED_WEB}/#{rel_url}?siteid=#{SITE_ID}&moduleId=#{moduleId}&#{query_params}"
    end
    headers = {:x_auth_token => $xAuthToken, :content_type => :json}
    response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :payload => payload, :verify_ssl => false)  #:headers => headers, :payload => payload, :verify_ssl => false)
    response = JSON.parse(response)
    return response
  end

  def execute_get(rel_url)
    return execute_get_with_query_params(rel_url, nil)
  end

  def execute_post(rel_url, payload)
    return execute_post_with_query(rel_url, nil, payload)
  end
  def execute_post_document(rel_url, payload, rel_url_2)
    com_url = rel_url + payload + rel_url_2
    url =  "#{$QA_FED_WEB}/#{com_url}?siteid=#{SITE_ID}"
    headers = {:x_auth_token => $xAuthToken, :content_type => :json}
    response = RestClient::Request.execute(:url => url, :method => :post, :payload => payload, :headers => headers, :verify_ssl => false)
    response = JSON.parse(response)
    return response
  end
  def execute_post_with_query(rel_url, query_params, payload)
    url =  "#{$QA_FED_WEB}/#{rel_url}?siteid=#{SITE_ID}"
    if (!query_params.nil?)
      url=url+"&#{query_params}"
    end
    headers = {:x_auth_token => $xAuthToken, :content_type => :json}
    response = RestClient::Request.execute(:url => url, :method => :post, :payload => payload, :headers => headers, :verify_ssl => false)
    response = JSON.parse(response)
    return response
  end
  def user_configuration(username)
    url =  "#{$QA_FED_WEB}/aso/configuration/userconfiguration?adusername=#{username}&siteid=#{SITE_ID}"

    if $DEBUG_FLAG == "debug"
      puts url
    end

    headers = {:x_auth_token => $xAuthToken, :content_type => :json}  
    response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)  #:headers => headers, :payload => payload, :verify_ssl => false)    
    response = JSON.parse(response)
    
    if $DEBUG_FLAG == "debug"
      puts response
    end

    return response
  end
  
  def site_logon_with_parameters(username, password)
    url =  "#{$QA_FED_WEB}/logon?siteid=#{SITE_ID}"
    
    puts url
    
    if $DEBUG_FLAG == "debug"
      puts url
    end
    
    payload = JSON.generate({:Username => username, :Password => password})
    puts payload
    
    if $DEBUG_FLAG == "debug"
      puts payload
    end
    
    headers = {:content_type => :json}    
    response = RestClient::Request.execute(:url => url, :method => :post, :headers => headers, :payload => payload, :verify_ssl => false)  #:headers => headers, :payload => payload, :verify_ssl => false)    
    response = JSON.parse(response)
    
    if $DEBUG_FLAG == "debug"
      puts response
    end
    return response
  end

  def list_of_lists
    url =  "#{$QA_FED_WEB}/patientlist/configuration?siteId=#{SITE_ID}"
    headers = {:x_auth_token => $xAuthToken, :content_type => :json}
    r = RestClient::Request.execute(:method => :get, :url => url, :headers => headers, :verify_ssl => false)
    r = JSON.parse(r)
	    
    return r
  end
  
  def search_configuration
    url =  "#{$QA_FED_WEB}/configuration/searchfields?siteId=#{SITE_ID}"
    headers = {:x_auth_token => $xAuthToken, :content_type => :json}
    r = RestClient::Request.execute(:method => :get, :url => url, :headers => headers, :verify_ssl => false)
    r = JSON.parse(r)
	
    return r
  end
  
  def search_fields
    url =  "#{$QA_FED_WEB}/configuration/searchfields?siteId=#{SITE_ID}"
    headers = {:x_auth_token => $xAuthToken, :content_type => :json}
    r = RestClient::Request.execute(:method => :get, :url => url, :headers => headers, :verify_ssl => false)
    r = JSON.parse(r)
	
    return r   
  end
  
  def patient_list(module_id, list_type)    #Census
    url =  "#{$QA_FED_WEB}/patientlist?listtype=#{list_type}&moduleId=#{module_id}&siteId=#{SITE_ID}"
    headers = {:x_auth_token => $xAuthToken, :content_type => :json}
    resp = RestClient::Request.execute(:method => :get, :url => url, :headers => headers, :verify_ssl => false)
    resp = JSON.parse(resp)
   
    return resp
  end
    
  def patient_summary(asmpid)
    url =  "#{$QA_FED_WEB}/patient/summary?siteId=#{SITE_ID}&asmpid=#{asmpid}"
    headers = {:x_auth_token => $xAuthToken, :content_type => :json}
    r = RestClient::Request.execute(:method => :get, :url => url, :headers => headers, :verify_ssl => false)
    r = JSON.parse(r)
	
    return r   
  end
  
  def one_param_search(param_one, value_one, module_id)
    headers = {:x_auth_token => $xAuthToken, :content_type => :json}
    one_param_search_url =  "#{$QA_FED_WEB}/patientlist?moduleId=#{module_id}&siteId=#{SITE_ID}&listtype=search&#{param_one}=#{value_one}"
    r = RestClient::Request.execute(:method => :get, :url => one_param_search_url, :headers => headers, :verify_ssl => false)
    r = JSON.parse(r)
    puts '+++++++'
    puts r 
    puts '+++++++'
    #firstname lastname
    if $DEBUG_FLAG == "debug"
      puts one_param_search_url
      puts r
    end
    return r 
  end
  
  def two_param_search(param_one, value_one, param_two, value_two, module_id)
    value_one=process_param(value_one)
    value_two=process_param(value_two)
    if module_id == 1
      if param_one == "firstname"
        param_one = "searchkey1"
      end
      
      if param_one == "lastname"
        param_one = "searchkey2"
      end
    end
        
    url =  "#{$QA_FED_WEB}/patientlist?siteId=#{SITE_ID}&listtype=search&moduleId=#{module_id}&#{param_one}=#{value_one}&#{param_two}=#{value_two}"
    #puts url
    headers = {:x_auth_token => $xAuthToken, :content_type => :json}
    r = RestClient::Request.execute(:method => :get, :url => url, :headers => headers, :verify_ssl => false)
    r = JSON.parse(r)
    #firstname lastname
    return r 
  end

  def three_param_search(param_one, value_one, param_two, value_two, param_three, value_three, module_id)
    url =  "#{$QA_FED_WEB}/patientlist?siteId=#{SITE_ID}&listtype=search&moduleId=#{module_id}&#{param_one}=#{value_one}&#{param_two}=#{value_two}&#{param_three}=#{value_three}"
    headers = {:x_auth_token => $xAuthToken, :content_type => :json}
    r = RestClient::Request.execute(:method => :get, :url => url, :headers => headers, :verify_ssl => false)
    r = JSON.parse(r)
    #firstname lastname
    return r 
  end
end