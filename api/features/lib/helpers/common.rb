require 'allure-cucumber'
require 'inifile'
require 'active_support/time'
require 'pp'
require 'logger'
require 'date'
module Common
  #Append $testdata if it is already initialized
  $testdata = IniFile.load('api/testdata.ini').merge!$testdata
  def rd_number
    Random.rand(999999...9999999)
  end

  AllureCucumber.configure do |config|
    config.clean_results_directory = false
    config.results_directory = '/docs/allure'
    config.logging_level = Logger::INFO
    config.logger = Logger.new($stdout, Logger::DEBUG)
    config.environment = 'environment'
    config.link_tms_pattern = 'http://qa-app-01/testrail/index.php?/cases/view/{}'
    config.link_issue_pattern = 'https://utang.atlassian.net/browse/{}'
    config.environment_properties = {
      custom_attribute: 'foo'
    }
  end
  def debug(request, response, status)
    if status == true
      puts ""
      puts ""
      puts "Request: " + request.url
      puts "Response: " + response.gsub(/\s+/, "")
    elsif status == "pretty"
      puts ""
      puts ""
      req =  "Request: " + request.url
      puts req.magenta
      #head = "Header: " + request.processed_headers.to_s
      #puts head.green
      #head = "Header: " + request.headers.to_s
      #puts head.green
      arg = "Arguments: " + request.args.inspect.to_s
      puts arg.green
      response = JSON.parse(response)
      puts puts JSON.pretty_generate(response)
    end
  end
end
