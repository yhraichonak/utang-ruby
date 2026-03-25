Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }
require 'rest-client'
class Client_API
  def initialize

  end

  def debug_response(response)
    puts "HTTP response: status=#{response.code}; body=#{response.body}"
  end
  def debug_request(type, url)
    puts "HTTP request: type=#{type}; url=#{url}"
  end
  def start_flight(flight_id)
    url =  "#{$CLIENT_API_URL}aircommand/flights/#{flight_id}/start"
    headers = {:content_type => :json}
    response = RestClient::Request.execute(:url => url, :method => :put, :headers => headers, :verify_ssl => false)
    debug_request("PUT", url)
    debug_response(response)
    response = JSON.parse(response)
    return response
  end
  def delay_flight(flight_id)
    url =  "#{$CLIENT_API_URL}aircommand/flights/#{flight_id}/flightdelay"
    headers = {:content_type => :json}
    response = RestClient::Request.execute(:url => url, :method => :put, :headers => headers, :verify_ssl => false)
    debug_request("PUT", url)
    debug_response(response)
    response = JSON.parse(response)
    return response
  end

end
