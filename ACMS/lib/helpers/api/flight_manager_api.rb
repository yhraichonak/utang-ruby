Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }
require 'rest-client'
class Flight_Manager_API
  def initialize

  end
  def get_alarm_list
    url =  "#{$FM_API_URL}alarms"
    headers = {:content_type => :json}
    response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)
    debug_request("GET", url)
    debug_response(response)
    response = JSON.parse(response)
    return response
  end

  def debug_response(response)
    puts "HTTP response: status=#{response.code}; body=#{response.body}"
  end
  def debug_request(type, url)
    puts "HTTP request: type=#{type}; url=#{url}"
  end

  def get_alarm_flights(alarm_id)
    url =  "#{$FM_API_URL}flights?alarmId=#{alarm_id}"
    headers = {:content_type => :json}
    response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)
    debug_request("GET", url)
    debug_response(response)
    response = JSON.parse(response)
    return response
  end


  def get_flights()
    url =  "#{$FM_API_URL}flights"
    headers = {:content_type => :json}
    response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)
    debug_request("GET", url)
    debug_response(response)
    response = JSON.parse(response)
    return response
  end


  def get_matching_alarm_list(pattern)
    current_alarms=get_alarm_list
    sorted_alerts=current_alarms.sort_by{ |t| Time.parse(t['updateTimestamp'])}.reverse
    matched_alarms=sorted_alerts.filter{|t| t['originalText'].include?(pattern)}
    return matched_alarms
  end


  def get_the_flight_details(flight_id)
    url =  "#{$FM_API_URL}flights/#{flight_id}"
    headers = {:content_type => :json}
    response = RestClient::Request.execute(:url => url, :method => :get, :headers => headers, :verify_ssl => false)
    debug_request("GET", url)
    debug_response(response)
    response = JSON.parse(response)
    return response
  end

  def escalate_flight(flight_id,escalation_level)
    url =  "#{$FM_API_URL}flights/#{flight_id}/escalate?currentLevel=#{escalation_level}"
    headers = {:content_type => :json}
    response = RestClient::Request.execute(:url => url, :method => :put, :headers => headers, :verify_ssl => false)
    debug_request("PUT", url)
    debug_response(response)
    response = JSON.parse(response)
    return response
  end

  def trigger_response_to_manual_dispatch(dispatch_id, dispatch_response)
    url =  "#{$MESSAGE_BROKER_API_URL}/manual/reply?dispatch=#{dispatch_id}&response=#{dispatch_response}"
    headers = {:content_type => :json}
    response = RestClient::Request.execute(:url => url, :method => :post, :headers => headers, :verify_ssl => false)
    debug_request("POST", url)
    debug_response(response)
    return response
  end

  def get_the_flight_manual_dispatches(flight_id)
    return get_the_flight_details(flight_id)['notifications']
  end


  def clear_flights_data()
    url =  "#{$FM_API_URL}Admin/reset/flightsdata"
    headers = {:content_type => :text}
    RestClient::Request.execute(:url => url, :method => :post, :headers => headers, :verify_ssl => false)
  end
  def clear_db_data()
    url =  "#{$FM_API_URL}Admin/reset/database"
    headers = {:content_type => :text}
    RestClient::Request.execute(:url => url, :method => :post, :headers => headers, :verify_ssl => false)
  end

  def clear_flight_manager_in_memeory_state()
    url =  "#{$FM_API_URL}Admin/reset/flightmanager"
    headers = {:content_type => :text}
    RestClient::Request.execute(:url => url, :method => :post, :headers => headers, :verify_ssl => false)
  end

end
