# frozen_string_literal: true
Dir[File.dirname(__FILE__) + "/../../../../common/**/*.rb"].each {|file| require file }
Dir[File.dirname(__FILE__) + "/../../../../api/**/*.rb"].each {|file| require file }
ENVIRONMENT = ENV.fetch('ENVIRONMENT', '34')
APP_BUILD_NUMBER = ENV.fetch('APP_BUILD_NUMBER', '224')
AUTOMATION_IP = get_param("COMMON_SERVER_IP")
BRANCH = get_param("COMMON_BRANCH")
BROWSER = ENV.fetch('BROWSER', 'chrome')
HEADLESS = ENV.fetch('HEADLESS', 'false')
AUTOMATION_IP = get_param("COMMON_SERVER_IP")
qtc = ENV.fetch('QTC', 'true')
info = ENV.fetch('INFO', 'false') # NOTE: for debugging use env variables INFO='true' and/or DEBUG='true'
saucelabs = ENV.fetch('SAUCELABS', 'false')
grid = ENV.fetch('GRID', 'false')
grid_ip = ENV.fetch('GRID_IP', 'localhost')
localhost = ENV.fetch('LOCALHOST', 'false')

PATIENT = ENV.fetch('PATIENT', nil)
CARDIO_PATIENT = ENV.fetch('CARDIO_PATIENT', nil)
NO_ECG_PATIENT = ENV.fetch('NO_ECG_PATIENT', nil)

if ENV['THREAD_INDEX'].nil?
  THREAD_INDEX=""
  if ENV['TEST_ENV_NUMBER'] == ""
    THREAD_INDEX="1"
  else unless ENV['TEST_ENV_NUMBER'].nil?
         THREAD_INDEX = ENV['TEST_ENV_NUMBER']
       end
  end
else
  THREAD_INDEX= ENV['THREAD_INDEX']
end
SUPER_ALL_USERNAME = process_param("[props.SU#{THREAD_INDEX}_USERNAME]")
SUPER_NONE_USERNAME = ENV.fetch('SUPER_NONE_USERNAME', 'super-none')
USERNAME = ENV.fetch('USERNAME', nil)
PASSWORD =  process_param("[props.SU#{THREAD_INDEX}_PASSWORD]")

TEST_ENV_NUMBER = ENV.fetch('TEST_ENV_NUMBER', nil)

$app_version = ENV.fetch('APP_VERSION', '3.5.1')
$app_build_number = ENV.fetch('APP_BUILD_NUMBER', '54')
#when brnach is ends with -build - use build number as suffix for branch name
if BRANCH.downcase.include? "-build"
  BRANCH="#{BRANCH}/#{APP_BUILD_NUMBER}"
end

TESTRAIL_ID = ENV.fetch('TESTRAIL_ID', nil)
@CARDIO_PL = false
QTC_CONFIG = qtc == 'true'
INFO = info == 'false'
SAUCELABS = saucelabs == 'true'
GRID = grid == 'true'
LOCALHOST = localhost == 'true'

MAIN_NAV_HIDDEN = false
DEFAULT_IMPLICIT_WAIT = 10
DEFAULT_EXPLICIT_WAIT = 20

AMP_USER ||= get_param("AMP_USERNAME")
AMP_PASSWORD ||= get_param("AMP_PASSWORD")
AUTHENTICATED_AMP34_URL ||= "http://#{AMP_USER}:#{AMP_PASSWORD}@10.10.160.133/Amp/"
AUTHENTICATED_AMP35_URL ||= "http://#{AMP_USER}:#{AMP_PASSWORD}@10.10.160.133/35/amp/"

AUTOMATION_URL ||= process_param("[props.COMMON_SERVER_URL]")
AUTHENTICATED_AMPAUTOMATION_URL ||=  process_param("[props.AMP_AUTHENTICATED_URL]")

if LOCALHOST == true
  SITE34_URL ||= 'http://site34.local.utangtech.com'
  SITE35_URL ||= 'http://site35.local.utangtech.com'
  SITE39_URL ||= 'http://site39.local.utangtech.com'
else
  SITE34_URL ||= "http://site34.asttesthost01.utangtech.com/as1/#{BRANCH}"
  SITE35_URL ||= "http://site35.asttesthost01.utangtech.com/as1/#{BRANCH}"
  SITE39_URL ||= "http://site39.asttesthost01.utangtech.com/as1/#{BRANCH}"
  AUTOMATION_URL ||= "http://site39.asttesthost01.utangtech.com/as1/#{BRANCH}"
  #SITE34_URL ||= "http://asttesthost01/site34/#{BRANCH}"
  #SITE35_URL ||= "http://asttesthost01/site35/#{BRANCH}"
  #SITE35_URL ||= "http://asttesthost01/site39/#{BRANCH}"

  SIMULATOR_URL ||= "http://pysim.asttesthost01.utangtech.com/as1/#{BRANCH}"

  SITE_ACWA_INITIAL_URL ||= "http://asttesthost01/acwa_initial/#{BRANCH}/#/"
  SITE_ACWA_REVIEWER_URL ||= "http://asttesthost01/acwa_reviewer/#{BRANCH}/#/"

  SITE_MINDRAY_URL ||= "http://asttesthost01/mindray/#{BRANCH}"
  SITE_NIHON_KHODEN_URL ||= "http://asttesthost01/nihon_khoden/#{BRANCH}"
  SITE_MUSE9_URL ||= "http://asttesthost01/muse9/#{BRANCH}"
  SITE_MUSENX_URL ||= "http://asttesthost01/musenx/#{BRANCH}"
  SITE_ACWA_REVIEWER_URL ||= "http://asttesthost01/acwa_reviewer/#{BRANCH}"
  SITE_ACWA_INITIAL_URL ||= "http://asttesthost01/acwa_initial/#{BRANCH}"
  SITE_BIOINTELLISENSE_URL ||= "http://asttesthost01/biointellisense/#{BRANCH}"
end

case ENVIRONMENT
when 'acwa_initial'
  DB_SERVER ||= 'ASTQAFEDHOST03'
  DB_NAME ||= 'acwaservices'
  DB_USERNAME ||= 'acwarealtimeuser'
  DB_PASSWORD ||= 'XXXXX'
end

$ACWA_SERVER_URL ||= "http://10.10.160.135/acwa"
$ACWA_FED_SERVER_URL ||= "http://10.10.160.135/integration/fed-web/api"
SERVER_HARDENING_URL ||= 'http://10.0.20.21/as1-wc/#/'
OSU_URL ||= "http://osu-int.dev-host-03.utangtech.com/#{BRANCH}"
SIMULATOR_URL ||= "http://asttesthost01//Simulator/#{BRANCH}" # "http://simulator.dev-host-03.utangtech.com/#{BRANCH}"
SIMULATOR6_URL ||= "http://asttesthost01//Simulator/#{BRANCH}"

# ex. of grid ips: 10.10.170.112, 10.10.160.13
GRID_HUB_URL ||= "http://#{grid_ip}:4444/wd/hub"
# GRID_HUB_URL = 'http://10.10.160.13:4444/wd/hub'
# GRID_HUB_URL = 'http://localhost:4444/wd/hub'

SITE_34_SHARE_DIRECTORY ||= '/Volumes/bin/'
SITE_35_SHARE_DIRECTORY ||= '/Volumes/site35_bin/'
