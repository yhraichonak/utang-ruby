require 'rest-client'
require 'json'
require 'base64'
require 'date'
require 'time'

#require 'active_support/all'
require 'rspec/expectations'
require 'rspec/core'

require 'tiny_tds'




Dir[File.dirname(__FILE__) + "/../../../common/**/*.rb"].each {|file| require file }
Dir[File.dirname(__FILE__) + "/../lib/helpers/*.rb"].each {|file| require file }

include RSpec::Matchers
include Common

$HOME = Dir.pwd

$REPORTS_HOME = "#{$HOME}/reports"

if(File.exist?($REPORTS_HOME))

else
  puts "making reports directory"
  FileUtils.mkdir_p($REPORTS_HOME)
end

  $ENVIRONMENT = ENV.fetch("ENVIRONMENT", '34')
  SITE_NAME =  $ENVIRONMENT
  $DEBUG_FLAG = ENV.fetch("DEBUG_FLAG", 'info')
  $SERVER_URL = "https://10.10.160.230/GS/api"
  #$QA_FED_WEB = "https://10.10.160.132/fed-web-34/api"

  if $ENVIRONMENT == '34'
    $QA_FED_WEB = "https://10.10.160.132/fed-web/api"
    $QA_FED_HOST = "http://10.10.160.133/34/fed-host/api"
  elsif $ENVIRONMENT == '35'
    $QA_FED_WEB = "https://10.10.160.132/35/fed-web/api"
    $QA_FED_HOST = "http://10.10.160.133/35/fed-host/api"
  elsif $ENVIRONMENT.downcase == 'automation'
    $QA_FED_WEB = "http://10.106.5.18/fed-web/api"
    $FED_WEB_AUTOMATION = "http://10.106.5.18/fed-web/api"
    $QA_FED_HOST = "http://10.106.5.18/fed-host/api"
  elsif $ENVIRONMENT.downcase == 'automation2'
    $QA_FED_WEB = "http://10.106.5.18/fed-web2/api"
    $FED_WEB_AUTOMATION = "http://10.106.5.18/fed-web2/api"
  end


  $FED_HOST_34 = "https://10.10.160.133/34/fed-host/api"


  $FED_HOST_35 = "https://10.10.160.133/35/fed-host/api"

  $FED_HOST_AUTOMATION = "https://10.106.5.18/fed-host/api"

  $ACM_QA_SERVER_URL = "http://10.10.170.103/acwa/api"
  $ACM_FED_QA_SERVER_URL = "http://10.10.170.103/fedweb/api"

  $ACM_SERVER_URL = "http://10.10.160.43/acwa/api"
  $ACM_FED_SERVER_URL = "http://10.10.160.43/fed-web/api"

  $ACWA_SERVER_URL = "http://10.10.160.135/acwa"
  $ACWA_FED_SERVER_URL = "http://10.10.160.135/fed-web"

  $ALERT_MAANGER_URL = "https://devapi.utangtech.com/alertmanagerdev"

  # $RULES_ENGINE_SERVER_URL = "http://10.10.160.133/amp/api"
  #$AMP_SERVER_URL = "http://10.10.160.133/amp/api"
  # $MPID_SERVER_URL = "http://10.10.160.133/asmpi/api"
$AMP_USERNAME = "ampuser"
$AMP_PASSWORD = "A1rstr1p!"
  $RULES_ENGINE_SERVER_URL = "http://10.106.5.18/amp/api"
  $AMP_SERVER_URL = "http://10.106.5.18/amp"
  $AMP_SERVER_URL_AUTH = "http://#{$AMP_USERNAME}:#{$AMP_PASSWORD}@10.106.5.18/amp"
  $AMP_SERVER_API_URL = "#{$AMP_SERVER_URL}/api"
  $MPID_SERVER_URL = "http://10.106.5.18/asmpi/api"
  $QA_USERNAME = get_param("DU_USERNAME")
  $QA_PASSWORD = get_param("DU_PASSWORD")

  $QA_34_SITE_ID = "1763"
  # $QA_34_SITE_ID = "4186"

  $PM_MODULE_ID = 3
  $CARDIO_MODULE_ID = 1
  $CURRENT_API_VERSION = "6.2.1.0"


  $gs_creds = "Basic " + Base64.encode64("%s:%s" % ["astglobal", "Gl0b@lS3rv!c3s"])
  $user_num = Common.rd_number
  $ios_app_email = "test@test.com"
  $android_email = "tester4024132@test.com"
  $other_email = "tester9657648@test.com"
  $app_password = "XXXXX"
  $ios_device_id = "4248F3D9-A8DA-5DE9-B785-EE0A2FB9EE1E"
  $other_device_id = "0763C3A1-13D4-4B50-A8C0-2C3D34FA9703"
  $android_id = "40d91de0d8b52641"
  $android_id2 = "33be2b0b087843b"
  $new_ios_device_id = "A621C86B-B8DA-469F-8728-03FB644CAF40"
  $new_android_id = "b00ec59a1e661707"
  $empty_reg_code = ""
  $iphone_type = "iPhone"
  $android_type = "android"
  $push_not_token = "330437C66770F6FBE59F1D0FA475B0B5A0091F56A011E80C5F8A4A15BD48A15B"
  $push_not_token_android = "2dd094ea-32ca-4651-8c93-ee200b0bfd26"
  $password_reset_token = "12D62200-914C-4DE3-B9EB-902F2A8CD8D1"
  $windows_device_id = "windows%20device%2001=="

  #UNDEFINED_MODULE_ID = -1
  #GLOBAL_MODULE_ID = 0
  #CARDIO_MODULE_ID = 1
  #EMR_MODULE_ID = 2
  #PM_MODULE_ID = 3
  #OUTPATIENT_MODULE_ID = 4
  #OB_MODULE_ID = 5

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    #c.syntax = :expect             # disables `should`
    # or
    #c.syntax = :should             # disables `expect`
    # or
    c.syntax = [:should, :expect]  # default, enables both `should` and `expect`
  end


end

Before do |scenario|

  if ENV['TEST_ENV_NUMBER'].nil? || ENV['TEST_ENV_NUMBER'].empty?
    worker='1'
  else
    worker=ENV['TEST_ENV_NUMBER']
  end
  $logger.info 'THREAD #'+worker+': ['+Time.now.to_s+'] Test started: '+ scenario.name
end

After do |_scenario|
  if ENV['TEST_ENV_NUMBER'].nil? || ENV['TEST_ENV_NUMBER'].empty?
    worker='1'
  else
    worker=ENV['TEST_ENV_NUMBER']
  end
  $logger.info  'THREAD #'+worker+': ['+Time.now.to_s+'] Test finished: '+ _scenario.name+' - ['+_scenario.status.to_s.upcase+']'
  $logger.info _scenario.location.to_s
end

Before('@unapproved_snippet_created') do
  steps %(
  And a snippet has been created by unprivileged user for asmpid "[props.DP_ASMPID]"
)
  end
