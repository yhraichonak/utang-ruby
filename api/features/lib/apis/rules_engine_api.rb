Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class RulesEngine_api 

  def initialize
  
  end
    
  def save_location(payload)
    url =  "#{$RULES_ENGINE_SERVER_URL}/RuleLocation/SaveLocation"
    puts url
    headers = {:content_type => 'application/json'}    
    response = RestClient::Request.execute(:url => url, :method => :post, :payload => payload, :headers => headers, :verify_ssl => false)    
    response = JSON.parse(response)
    
    if $DEBUG_FLAG == "debug"
      puts url
      puts response
    end
    
    return response
  end
    
  def get_location_by_id(location_id)
    url =  "#{$RULES_ENGINE_SERVER_URL}/RuleLocation/GetRuleLocation?ruleLocationId=#{location_id}"
    puts url
    headers = {:content_type => 'application/json'}    
    
    response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)
        
    response = JSON.parse(response)
    
    if $DEBUG_FLAG == "debug"
      puts url
      puts response
    end
    
    return response
  end
  
  def get_location_by_site_id(site_id)
    url =  "#{$RULES_ENGINE_SERVER_URL}/RuleLocation/GetLocationsBySite?siteId=#{site_id}"
    headers = {:content_type => 'application/json'}    
    
    response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)
        
    response = JSON.parse(response)
    
    if $DEBUG_FLAG == "debug"
      puts url
      puts response
    end
    return response
  end  
  
  def get_location_by_site_and_name(site_id, location_name)
    url =  "#{$RULES_ENGINE_SERVER_URL}/RuleLocation/GetLocationBySiteAndName?siteId=#{site_id}&locationname=#{location_name}"
    headers = {:content_type => 'application/json'}    
    
    response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)
        
    response = JSON.parse(response)
  
    if $DEBUG_FLAG == "debug"
      puts url
      puts response
    end
    
    return response
  end
  
  def delete_location(location_id)
    url =  "#{$RULES_ENGINE_SERVER_URL}/RuleLocation/DeleteLocation?locationid=#{location_id}"
    puts url
    headers = {:content_type => 'application/json'}    
    response = RestClient::Request.execute(:url => url, :method => :delete, :headers => headers, :verify_ssl => false)    
    response = JSON.parse(response)
    
    if $DEBUG_FLAG == "debug"
      puts url
      puts response
    end
    
    return response
  end
  
  def get_enterprise_user_groups
    url =  "#{$RULES_ENGINE_SERVER_URL}/EnterpriseUserGroup"
    puts url
    headers = {:content_type => 'application/json'}    
    
    response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)
        
    response = JSON.parse(response)
    
    if $DEBUG_FLAG == "debug"
      puts url
      puts response
    end
    
    return response
  end
  
  def get_enterprise_user_group_by_id(group_id)
    url =  "#{$RULES_ENGINE_SERVER_URL}/EnterpriseUserGroup?id=#{group_id}"
    puts url
    headers = {:content_type => 'application/json'}    
    
    response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)
        
    response = JSON.parse(response)
    
    if $DEBUG_FLAG == "debug"
      puts url
      puts response
    end
    
    return response
  end
  
  def create_user_group(payload)
    url =  "#{$RULES_ENGINE_SERVER_URL}/EnterpriseUserGroup"
    puts url
    headers = {:content_type => 'application/json'}    
    response = RestClient::Request.execute(:url => url, :method => :post, :payload => payload, :headers => headers, :verify_ssl => false)    
    response = JSON.parse(response)
    
    if $DEBUG_FLAG == "debug"
      puts url
      puts response
    end
    
    return response
  end
  
  def delete_user_group(group_id)
    url =  "#{$RULES_ENGINE_SERVER_URL}/EnterpriseUserGroup?id=#{group_id}"
    puts url
    headers = {:content_type => 'application/json'}    
    response = RestClient::Request.execute(:url => url, :method => :delete, :headers => headers, :verify_ssl => false)    
    response = JSON.parse(response)
    
    if $DEBUG_FLAG == "debug"
      puts url
      puts response
    end
    
    return response
  end
  
  def get_notification_rules
    url =  "#{$RULES_ENGINE_SERVER_URL}/NotificationRule"
    puts url
    headers = {:content_type => 'application/json'}    
    
    response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)
        
    response = JSON.parse(response)
    
    if $DEBUG_FLAG == "debug"
      puts url
      puts response
    end
    
    return response
  end
  
  def get_notification_rule_by_id(rule_id)
    url =  "#{$RULES_ENGINE_SERVER_URL}/NotificationRule?id=#{rule_id}"
    puts url
    headers = {:content_type => 'application/json'}    
    response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)    
    response = JSON.parse(response)
    
    if $DEBUG_FLAG == "debug"
      puts url
      puts response
    end
    
    return response
  end
  
  def create_notification_rule(payload)
    url =  "#{$RULES_ENGINE_SERVER_URL}/NotificationRule"
    puts url
    headers = {:content_type => 'application/json'}    
    response = RestClient::Request.execute(:url => url, :method => :post, :payload => payload, :headers => headers, :verify_ssl => false)    
    response = JSON.parse(response)
    
    if $DEBUG_FLAG == "debug"
      puts url
      puts response
    end
    
    return response
  end
end