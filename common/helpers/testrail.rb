require 'net/http'
require 'net/https'
require 'uri'
require 'json'

module TestRail
  class APIClient
    @url = ''
    @user = ''
    @password = ''

    attr_accessor :user, :password

    def initialize(base_url)
      base_url += '/' unless base_url.match(%r{/$})
      @url = "#{base_url}index.php?/api/v2/"
    end

    def send_get(uri)
      _send_request('GET', uri, nil)
    end

    def send_post(uri, data)
      _send_request('POST', uri, data)
    end

    private

    def _send_request(method, uri, data)
      url = URI.parse(@url + uri)
      puts "TestRail API #{method}: url=#{url}; data= #{data}"
      if method == 'POST'
        request = Net::HTTP::Post.new("#{url.path}?#{url.query}")
        request.body = JSON.dump(data)
      else
        request = Net::HTTP::Get.new("#{url.path}?#{url.query}")
      end
      request.basic_auth(@user, @password)
      request.add_field('Content-Type', 'application/json')

      conn = Net::HTTP.new(url.host, url.port)
      if url.scheme == 'https'
        conn.use_ssl = true
        conn.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end
      response = conn.request(request)

      result = if response.body && !response.body.empty?
                 JSON.parse(response.body)
               else
                 {}
               end

      if response.code != '200'
        error = if result&.key?('error')
                  "\"#{result['error']}\""
                else
                  'No additional error message received'
                end
        raise APIError, format('TestRail API returned HTTP %s (%s)', response.code, error)
      end

      result
    end
  end

  class APIError < StandardError
  end
end
