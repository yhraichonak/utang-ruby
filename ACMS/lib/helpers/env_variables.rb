Dir[File.dirname(__FILE__) + "/../../../common/**/*.rb"].each {|file| require file }

BROWSER = ENV.fetch('BROWSER', 'chrome')
HEADLESS = ENV.fetch('HEADLESS', 'false')

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
