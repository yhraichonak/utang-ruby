Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class Acwa_api 

  def initialize
  
  end
  
  def post_acm_rules(payload)    
    url =  "#{$ACWA_SERVER_URL}/acmrules"
    headers = {:content_type => 'application/json'}

    response = RestClient::Request.execute(:url => url, :method => :post, :headers => headers, :payload => payload, :verify_ssl => false) 

    response = JSON.parse(response)

    if $DEBUG_FLAG == "debug"
        puts url
        puts response
    end

    return response
  end 
    
  def get_acm_rules    
    url =  "#{$ACWA_SERVER_URL}/acmrules"
        
    headers = {:x_auth_token => "testtoken", :content_type => :json}
    
    response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)    
    response = JSON.parse(response)
    
    #if $DEBUG_FLAG == "debug"
        puts url
        puts response
    #end

    return response
  end
  
  def get_frat_descriptions   
    url =  "#{$ACWA_SERVER_URL}/frat/eventdescriptions"
        
    headers = {:x_auth_token => "testtoken", :content_type => :json}
    
    response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)    
    response = JSON.parse(response)

    if $DEBUG_FLAG == "debug"
        puts url
        puts response
    end
    
    return response
  end
  
  def get_frat_users  
    url =  "#{$ACWA_SERVER_URL}/frat/users"
        
    headers = {:x_auth_token => "testtoken", :content_type => :json}
    
    response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)    
    response = JSON.parse(response)

    if $DEBUG_FLAG == "debug"
        puts url
        puts response
    end
    
    return response
  end

  def post_frat_users(payload)    
    url =  "#{$ACWA_SERVER_URL}/frat/users"
    headers = {:content_type => 'application/json'}

    response = RestClient::Request.execute(:url => url, :method => :post, :headers => headers, :payload => payload, :verify_ssl => false) 

    response = JSON.parse(response)

    if $DEBUG_FLAG == "debug"
        puts url
        puts response
    end

    return response
  end
  
  def get_frat_records_full  
    url =  "#{$ACWA_SERVER_URL}/frat/records/full"
        
    headers = {:x_auth_token => "testtoken", :content_type => :json}
    
    response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)    
    response = JSON.parse(response)

    if $DEBUG_FLAG == "debug"
        puts url
        puts response
    end
    
    return response
  end

  def get_frat_records_headers  
    url =  "#{$ACWA_SERVER_URL}/frat/records/headers"

    headers = {:x_auth_token => "testtoken", :content_type => :json}
    
    response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)    
    response = JSON.parse(response)
    
    if $DEBUG_FLAG == "debug"
        puts url
        puts response
    end
    
    return response
  end

  def get_frat_records  
    url =  "#{$ACWA_SERVER_URL}/frat/records"
    
    headers = {:x_auth_token => "testtoken", :content_type => :json}
    
    response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)    
    response = JSON.parse(response)

    if $DEBUG_FLAG == "debug"
        puts url
        puts response
    end
    
    return response
  end

  def post_frat_records(payload)    
    url =  "#{$ACWA_SERVER_URL}/frat/records"
    headers = {:content_type => 'application/json'}

    response = RestClient::Request.execute(:url => url, :method => :post, :headers => headers, :payload => payload, :verify_ssl => false) 

    response = JSON.parse(response)

    if $DEBUG_FLAG == "debug"
        puts url
        puts response
    end

    return response
  end

  def delete_frat_records(payload)    
    url =  "#{$ACWA_SERVER_URL}/frat/records"
    headers = {:content_type => 'application/json'}

    response = RestClient::Request.execute(:url => url, :method => :delete, :headers => headers, :payload => payload, :verify_ssl => false) 

    response = JSON.parse(response)

    if $DEBUG_FLAG == "debug"
        puts url
        puts response
    end

    return response
  end

  def get_frat_records_ids  
    url =  "#{$ACWA_SERVER_URL}/frat/records/ids"
    
    headers = {:x_auth_token => "testtoken", :content_type => :json}
    
    response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)    
    response = JSON.parse(response)

    if $DEBUG_FLAG == "debug"
        puts url
        puts response
    end
    
    return response
  end

  def get_frat_records_by_id(id)  
    url =  "#{$ACWA_SERVER_URL}/frat/records/#{id}"
    
    headers = {:x_auth_token => "testtoken", :content_type => :json}
    
    response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)    
    response = JSON.parse(response)

    if $DEBUG_FLAG == "debug"
        puts url
        puts response
    end
    
    return response
  end

  def delete_frat_records_by_id(id)    
    url =  "#{$ACWA_SERVER_URL}/frat/records/#{id}"
    headers = {:content_type => 'application/json'}

    response = RestClient::Request.execute(:url => url, :method => :delete, :headers => headers, :payload => payload, :verify_ssl => false) 

    response = JSON.parse(response)

    if $DEBUG_FLAG == "debug"
        puts url
        puts response
    end

    return response
  end

  def get_frat_records_by_id_summary(id)  
    url =  "#{$ACWA_SERVER_URL}/frat/records/#{id}/summary"
    
    headers = {:x_auth_token => "testtoken", :content_type => :json}
    
    response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)    
    response = JSON.parse(response)

    if $DEBUG_FLAG == "debug"
        puts url
        puts response
    end
    
    return response
  end

  def get_frat_records_by_recordid_edits(recordid)  
    url =  "#{$ACWA_SERVER_URL}/frat/records/#{recordid}/edits"
    
    headers = {:x_auth_token => "testtoken", :content_type => :json}
    
    response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)    
    response = JSON.parse(response)

    if $DEBUG_FLAG == "debug"
        puts url
        puts response
    end
    
    return response
  end

  def post_frat_records_by_recordid_edits(recordid)    
    url =  "#{$ACWA_SERVER_URL}/frat/records/#{recordid}/edits"
    headers = {:content_type => 'application/json'}

    response = RestClient::Request.execute(:url => url, :method => :post, :headers => headers, :payload => payload, :verify_ssl => false) 

    response = JSON.parse(response)

    if $DEBUG_FLAG == "debug"
        puts url
        puts response
    end

    return response
  end

  def get_frat_records_by_recordid_edits_and_editid(recordid, editid)  
    url =  "#{$ACWA_SERVER_URL}/frat/records/#{recordid}/edits/#{editid}"
    
    headers = {:x_auth_token => "testtoken", :content_type => :json}
    
    response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)    
    response = JSON.parse(response)

    if $DEBUG_FLAG == "debug"
        puts url
        puts response
    end
    
    return response
  end

  def put_frat_records_by_recordid_edits_and_editid(recordid, editid)  
    url =  "#{$ACWA_SERVER_URL}/frat/records/#{recordid}/edits/#{editid}"
    
    headers = {:x_auth_token => "testtoken", :content_type => :json}
    
    response = RestClient::Request.execute(:url => url, :method => :put, :headers => headers, :verify_ssl => false)    
    response = JSON.parse(response)

    if $DEBUG_FLAG == "debug"
        puts url
        puts response
    end
    
    return response
  end

  def delete_frat_records_by_recordid_edits_and_editid(recordid, editid)  
    url =  "#{$ACWA_SERVER_URL}/frat/records/#{recordid}/edits/#{editid}"
    
    headers = {:x_auth_token => "testtoken", :content_type => :json}
    
    response = RestClient::Request.execute(:url => url, :method => :delete, :headers => headers, :verify_ssl => false)    
    response = JSON.parse(response)

    if $DEBUG_FLAG == "debug"
        puts url
        puts response
    end
    
    return response
  end

  def get_frat_records_info
    url =  "#{$ACWA_SERVER_URL}/frat/records/info"
    
    headers = {:x_auth_token => "testtoken", :content_type => :json}
    
    response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)    
    response = JSON.parse(response)

    if $DEBUG_FLAG == "debug"
        puts url
        puts response
    end
    
    return response
  end

  def post_qrsprocessor
    url =  "#{$ACWA_SERVER_URL}/qrsprocessor"
    headers = {:content_type => 'application/json'}

    response = RestClient::Request.execute(:url => url, :method => :post, :headers => headers, :payload => payload, :verify_ssl => false) 

    response = JSON.parse(response)

    if $DEBUG_FLAG == "debug"
        puts url
        puts response
    end

    return response
  end

  def get_qrsresults_patients
    url =  "#{$ACWA_SERVER_URL}/qrsresults/patients"
    
    headers = {:x_auth_token => "testtoken", :content_type => :json}
    
    response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)    
    response = JSON.parse(response)

    if $DEBUG_FLAG == "debug"
        puts url
        puts response
    end
    
    return response
  end

  def get_qrsresults_by_id(id)
    url =  "#{$ACWA_SERVER_URL}/qrsresults/#{id}"
    
    headers = {:x_auth_token => "testtoken", :content_type => :json}
    
    response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)    
    response = JSON.parse(response)

    if $DEBUG_FLAG == "debug"
        puts url
        puts response
    end
    
    return response
  end

  def get_qrsresults_info
    url =  "#{$ACWA_SERVER_URL}/qrsresults/info"
    
    headers = {:x_auth_token => "testtoken", :content_type => :json}
    
    response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)    
    response = JSON.parse(response)

    if $DEBUG_FLAG == "debug"
        puts url
        puts response
    end
    
    return response
  end

  def get_qtclock
    url =  "#{$ACWA_SERVER_URL}/qtclock"
    
    headers = {:x_auth_token => "testtoken", :content_type => :json}
    
    response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)    
    response = JSON.parse(response)

    if $DEBUG_FLAG == "debug"
        puts url
        puts response
    end
    
    return response
  end

  def get_status
    url =  "#{$ACWA_SERVER_URL}/status"
   
    headers = {:x_auth_token => "testtoken", :content_type => :json}
    
    response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)    
    response = JSON.parse(response)

    if $DEBUG_FLAG == "debug"
        puts url
        puts response
    end
    
    return response
  end

  def get_version
    url =  "#{$ACWA_SERVER_URL}/version"

    headers = {:x_auth_token => "testtoken", :content_type => :json}
    
    response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)    
    response = JSON.parse(response)

    if $DEBUG_FLAG == "debug"
        puts url
        puts response
    end
    
    return response
  end

  def get_vitals
    url =  "#{$ACWA_SERVER_URL}/vitals"
    
    headers = {:x_auth_token => "testtoken", :content_type => :json}
    
    response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)    
    response = JSON.parse(response)

    if $DEBUG_FLAG == "debug"
        puts url
        puts response
    end
    
    return response
  end

end