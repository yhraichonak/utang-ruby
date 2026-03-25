require "restclient"
Dir[File.dirname(__FILE__) + "/../*.rb"].each { |file| require file }

class Common_api
  def initialize
    $COMMON_API_URL= "http://#{get_param("COMMON_SERVER_IP")}:#{get_param("COMMON_SERVER_COMMON_API_PORT")}"
  end

  def self.generate_patient_alarm_async(api_url,session, alarm_text, severity, duration)
    url = "#{api_url}/Common/AddAlarm?sessionId=#{session}&text=#{alarm_text}&severity=#{severity}&state=%s&start=%s"
    current_time_raw = Time.now
    duration = duration.to_i - 5
    exec_url = url % ["start", current_time_raw.utc.strftime("%Y-%m-%dT%H:%M:%SZ")]
    puts exec_url
    RestClient::Request.execute(:method => :post, :url => exec_url)
    sleep 2
    i = 2
    while i <= duration
      exec_url = url % ["existing", current_time_raw.utc.strftime("%Y-%m-%dT%H:%M:%SZ")]
      puts exec_url
      RestClient::Request.execute(:method => :post, :url => exec_url)
      sleep 2
      i += 2
    end
    exec_url = url % ["ended", current_time_raw.utc.strftime("%Y-%m-%dT%H:%M:%SZ")]
    puts exec_url
    RestClient::Request.execute(:method => :post, :url => exec_url)
  end

  def generate_patient_alarm(session, alarm_text, severity, duration)
    url = "#{$COMMON_API_URL}/Common/AddAlarm?sessionId=#{session}&text=#{alarm_text}&severity=#{severity}&state=%s&start=%s"
    current_time_raw = Time.now
    duration = duration.to_i - 5
    exec_url = url % ["start", current_time_raw.utc.strftime("%Y-%m-%dT%H:%M:%SZ")]
    log_info(exec_url)
    RestClient::Request.execute(:method => :post, :url => exec_url)
    sleep 2
    i = 2
    while i <= duration
      exec_url = url % ["existing", current_time_raw.utc.strftime("%Y-%m-%dT%H:%M:%SZ")]
      log_info(exec_url)
      RestClient::Request.execute(:method => :post, :url => exec_url)
      sleep 2
      i += 2
    end
    exec_url = url % ["ended", current_time_raw.utc.strftime("%Y-%m-%dT%H:%M:%SZ")]
    log_info(exec_url)
    RestClient::Request.execute(:method => :post, :url => exec_url)
  end

  def get_session_by_mrn(mrn)
    begin
      r = RestClient::Request.execute(:method => :get, :url => "#{$COMMON_API_URL}/sessions")
      JSON.parse(r.to_s)['model'].find { |t| t["mrn"].include?(mrn) }["sessionId"]
    rescue => e
      log_exception("Error on attempt to find Session ID by MRN #{mrn}")
    end
  end
end
