# frozen_string_literal: true

##### capture network responses from chrome dev tools #####
class Devtools
  def stop_api_capture(selenium)
    selenium.devtools.network.disable
  end

  def api_capture(selenium)
    selenium.devtools.network.enable
    @network_logs = []
    @api_logs = []

    selenium.devtools.network.on(:request_will_be_sent) do |request|
      @network_logs << request
      # filter only api call responses
      if request['request']['url'].include? '/api/'
        puts @api_logs
        puts '======'
        @api_logs << request
        #puts responses['request']['url'] if !responses['request']['url'].include?('/conversations?') && (INFO == true)
      end

    rescue StandardError #=> e
      # do not log if error
      #puts e.message
    end

    { 'api_logs' => @api_logs,
      'network_logs' => @network_logs }
  end
end
#####
