require 'rake/clean'
require 'report_builder'
require 'fileutils'
require 'pp'
require 'inifile'
at_modules=["AS1", "ACMS", "api", "iOS", "android"]
threads = ENV['THREADS'] || '4'
browser = ENV['BROWSER'] || 'chrome'
browser_version = ENV['BROWSER_VERSION'] || 'latest'
branch = ENV['BRANCH']
environment = ENV['ENVIRONMENT'] || '34'
tr_execution = ENV['TR_EXECUTION'] || 'UNDEF'
tr_overwrite_same_results = ENV['TR_OVERWRITE'] || 'true'
tr_non_executed_only = ENV['TR_NON_EXECUTED_ONLY'] || 'true'
cucumber_steps = ENV['CUCUMBER_STEPS'] || 'AS1/features/'
api_cucumber_steps = ENV['CUCUMBER_STEPS'] || 'api/features/'
acms_cucumber_steps = ENV['CUCUMBER_STEPS'] || 'ACMS/step_definitions/'
features_path = ENV['FEATURES_PATH'] || 'AS1/features/'
tr_features_filter = features_path.gsub(" ", ",")
tags = ENV['TAGS'] || ''
app_version = ENV['APP_VERSION'] || '4.0.0'
app_build = ENV['APP_BUILD'] || '26'
dry_run = ENV['DRY_RUN'] || 'false'
additional_options = ENV['ADDITIONAL_OPTIONS'] || ''
grid = ENV['GRID'] || 'false'
grid_ip = ENV['GRID_IP'] || 'localhost'
retries = ENV['RETRIES'] || '2'
scenario_name = ENV['SCENARIO_NAME'] || ''

### MOBILE-SPECIFIC ENVS ###
device = ENV['DEVICE'] || 'iPhone 13'
platformVersion = ENV['VERSION'] || '15.0'
siteName = ENV['SITE_NAME'] || '34'
asVersion = ENV['AS_VERSION'] || '6.10.2'
asBuildNumber = ENV['AS_BUILD_NUMBER'] || '0'
biuldType = ENV['BUILD_TYPE'] || 'QA'
installSoftware = ENV['INSTALL_SOFTWARE'] || 'false'
appPath = ENV['APP_PATH'] || ''
features_path_ios = ENV['FEATURES_PATH'] || 'iOS/features/'
features_path_android = ENV['FEATURES_PATH'] || 'android/features/'
steps_path_ios = ENV['CUCUMBER_STEPS'] || 'iOS/features/'
steps_path_android = ENV['CUCUMBER_STEPS'] || 'android/features/'
reports_location=(ENV['REPORT_FOLDER'].nil? || ENV['REPORT_FOLDER'].empty?)?'docs':ENV['REPORT_FOLDER']
### MOBILE-SPECIFIC ENVS END ###

REPORT_ROOT = reports_location.start_with?("/")?
                "#{reports_location}":
                (File.dirname(__FILE__)+"/#{reports_location}")
PARALLEL_JSON_REPORT_DIR = "#{REPORT_ROOT}/reports_parallel"
ALLURE_RESULTS_DIR =  "#{REPORT_ROOT}/allure"
ALLURE_REPORTS_DIR = "#{REPORT_ROOT}/allure-report"
XML_DIR = "#{REPORT_ROOT}/xml_reports"
SCREENSHOTS_DIR = "#{REPORT_ROOT}/screenshots"
THREADS_JSON_DIR = "#{REPORT_ROOT}/threads"

CLEAN.include THREADS_JSON_DIR, PARALLEL_JSON_REPORT_DIR, XML_DIR, SCREENSHOTS_DIR, "#{ALLURE_RESULTS_DIR}/*.xml", "passed*.txt", "failed*.txt"
CLOBBER.include PARALLEL_JSON_REPORT_DIR, ALLURE_RESULTS_DIR, ALLURE_REPORTS_DIR

scenario_name="--name \"#{scenario_name}\"" if scenario_name.strip != ''
dry_run_option=''
dry_run_option='-d' if dry_run.downcase == 'true'
cucumber_options = "-r " + cucumber_steps +
              +" " + tags +" "+scenario_name+" "+ dry_run_option+" "+additional_options +
              +" --format pretty"+
              +" --retry " +retries+
              +" --format AllureCucumber::CucumberFormatter --out docs/allure"+
              #TODO: temporarily disable not needed reports
              #+" --format json --out=docs/reports/report.json"+
              # +" --format html --out=docs/reports/html_report.html"+
              +" --format junit --out=docs/reports/xml_reports"+
                    +" GRID=#{grid.downcase} GRID_IP=#{grid_ip} "+
                    +" ENVIRONMENT=#{environment}"+
                    +" ENV_CUSTOM_URL=#{ENV['ENV_CUSTOM_URL']}"+
                    +" COMMON_BRANCH=#{branch}"+
                    +" BROWSER=#{browser}"+
                    +" APP_VERSION=#{app_version}"+
                    +" APP_BUILD_NUMBER=#{app_build}"
                            # +" -e AS1/features/pm/snippets/roleSwitching"

cucumber_options_setup = "-r " + cucumber_steps + " --tags @setup  "+additional_options +
                          +" --format pretty  --format AllureCucumber::CucumberFormatter --out docs/allure"+
                          +" --retry #{retries} --format junit --out=docs/reports/xml_reports"+
                          +" ENVIRONMENT=#{environment} ENV_CUSTOM_URL=#{ENV['ENV_CUSTOM_URL']} COMMON_BRANCH=#{branch} BROWSER=#{browser}"+
                          +" APP_VERSION=#{app_version} APP_BUILD_NUMBER=#{app_build}"

threads = '1' if browser == 'ie' # internet explorer driver doesnt support multithreading

task :web_at do
  puts "cucumber  #{features_path} #{cucumber_options}"
  system "rm -fr testsRun.txt failed.txt "
  system "cucumber  #{features_path} #{cucumber_options}"
end

task :at_setup do
  puts "cucumber  #{features_path} #{cucumber_options_setup}"
  begin
    system "cucumber  #{features_path} #{cucumber_options_setup}"
  rescue =>e
    puts "Error occurred on attempt to run :at_setup #{e}"
  end
end


task :at_dry do
  system "rm -fr docs/dry_reports"
  at_modules.each { |at_module|
    system "cucumber -d #{at_module}/ -r #{at_module}/ --format junit --out=docs/dry_reports/#{at_module}"
  }
end

task web_at_full: %i[reset web_at allure_generate]

task :web_at_full_tr do
  Rake::Task["reset"].invoke
  # ENV['TR_RUNTIME_EXPORT'] = 'true'
  Rake::Task["web_at"].invoke
  Rake::Task["allure_generate"].invoke
  Rake::Task["export_tr"].invoke
end

task :web_at_parallel do
   puts "parallel_cucumber -n #{threads} #{features_path} -o ' #{cucumber_options} ' --group-by scenarios"
   system "parallel_cucumber -n #{threads} #{features_path} -o ' #{cucumber_options}' --group-by scenarios"
end

task web_at_parallel_full: %i[reset web_at_parallel allure_generate]

task default_web: %i[reset debug allure_report]

task :createDir do
  puts 'Directories cleaned....creating directories.....'
  FileUtils.mkdir_p THREADS_JSON_DIR
  FileUtils.mkdir_p PARALLEL_JSON_REPORT_DIR
  FileUtils.mkdir_p XML_DIR
  FileUtils.mkdir_p SCREENSHOTS_DIR
  FileUtils.mkdir_p ALLURE_RESULTS_DIR
end

### API TASKS ###
api_options = "-r " + api_cucumber_steps +
              +" " + tags +" "+scenario_name+" "+ dry_run_option+" "+additional_options +
              +" --format pretty"+
              +" --retry " +retries+
              +" --format AllureCucumber::CucumberFormatter --out docs/allure"+
              +" --format junit --out=docs/reports/xml_reports"+
                    +" GRID=#{grid.downcase} GRID_IP=#{grid_ip} "+
                    +" ENVIRONMENT=#{environment}"+
                    +" COMMON_BRANCH=#{branch}"+
                    +" APP_VERSION=#{app_version}"+
                    +" APP_BUILD_NUMBER=#{app_build}"

task :api_at do
  puts "cucumber  #{features_path} #{api_options}"
  system "rm -fr testsRun.txt failed.txt"
  system "cucumber  #{features_path} #{api_options}"
end

task api_at_full: %i[reset api_at allure_generate]
task api_at_full_tr: %i[reset api_at allure_generate export_tr]
### API TASKS END ###
### ACMS TASKS ###
options_acms="-r " + acms_cucumber_steps +
   " " + tags +" "+ scenario_name+" "+dry_run_option+" "+additional_options +
    +" --format pretty"+
    +" --retry " +retries+
    +" --format AllureCucumber::CucumberFormatter --out docs/allure"+
    # +" --format json --out=docs/reports/report.json"+
    +" --format junit --out=docs/reports/xml_reports"+
    +" GRID=#{grid.downcase} GRID_IP=#{grid_ip} "

options_acms_setup="-r  #{acms_cucumber_steps} --tags @setup #{additional_options} --format pretty"

task :acms_at do
  puts "cucumber  #{features_path} #{options_acms}"
  system "rm -fr testsRun.txt failed.txt"
  system "cucumber  #{features_path} #{options_acms}"
end

task :acms_at_prioritized do
  system "rm -fr testsRun.txt failed.txt"
  puts "cucumber  #{features_path} #{options_acms} --tags \"@flight_path\""
  system "cucumber  #{features_path} #{options_acms} --tags \"@flight_path\""
  Rake::Task["acms_restart_services"].execute
  puts "cucumber  #{features_path} #{options_acms} --tags \"not @flight_path\""
  system "cucumber  #{features_path} #{options_acms} --tags \"not @flight_path\""
end

task :acms_restart_services do
  $testdata = IniFile.load('./ACMS/testdata.ini')
  require './common/helpers/props_helper.rb'
  SSH_CONNECTION_URL= process_param("[props.COMMON_SERVER_SSH_CONNECTION]")
  RESTARTSERVICES_COMMAND='ssh -t -t ' + SSH_CONNECTION_URL + ' "PowerShell -command \"cd c:/utang/tool;.\stop_services.ps1\";.\stop_apppools.ps1;.\start_services.ps1;.\start_apppools.ps1"'
  puts RESTARTSERVICES_COMMAND
  system RESTARTSERVICES_COMMAND
end

task :acms_at_setup do
  puts "cucumber  #{features_path} #{options_acms_setup}"
  begin
    system "cucumber  #{features_path} #{options_acms_setup}"
  rescue =>e
    puts "Error occurred on attempt to run :acms_at_setup #{e}"
  end
end

task :acms_at_parallel do
  ENV['SKIP_CLEANUP'] = 'true'
  puts "parallel_cucumber -n #{threads} #{features_path} -o ' #{options_acms} ' --group-by scenarios"
  system "parallel_cucumber -n #{threads} #{features_path} -o ' #{options_acms}' --group-by scenarios"
end


task acms_at_parallel_full: %i[reset acms_at_setup acms_at_parallel allure_generate]

task acms_at_full: %i[reset acms_at allure_generate]
task acms_at_full_prioritized: %i[reset acms_at_prioritized allure_generate]

### ACMS TASKS END ###
### MOBILE TASKS ###
options_mobile=
  " " + tags +" "+ scenario_name+" "+dry_run_option+" "+additional_options +
    +" --format pretty"+
    +" --retry " +retries+
    +" --format AllureCucumber::CucumberFormatter --out=#{ALLURE_RESULTS_DIR}"+
    +" --format json --out=#{reports_location}/report.json"+
    +" --format junit --out=#{XML_DIR}"+
    +" GRID=#{grid.downcase} GRID_IP=#{grid_ip} "+
    +" APP_PATH=\"#{appPath}\""+
    +" DEVICE=\"#{device}\"" +
    +" VERSION=\"#{platformVersion}\"" +
    +" BUILD_TYPE=\"#{biuldType}\"" +
    +" DEBUG_FLAG=debug" +
    +" SITE_NAME=#{siteName}" +
    +" AS_VERSION=\"#{asVersion}\""+
    +" AS_BUILD_NUMBER=\"#{asBuildNumber}\""+
    +" INSTALL_SOFTWARE=\"#{installSoftware}\""+
    +" UDI='+B15326010/$$7689/16D20211118-'"

task :ios_at do
  #pp ENV
  system "rm -fr testsRun.txt failed.txt"
  tests_run_command="cucumber -r #{steps_path_ios} #{features_path_ios} #{options_mobile}"
  puts 'Starting iOS tests....'
  puts tests_run_command
  system tests_run_command
end

task :android_at do
  system "rm -fr testsRun.txt failed.txt"
  tests_run_command="cucumber -r #{steps_path_android} #{features_path_android} #{options_mobile}"
  puts 'Starting Android tests....'
  puts tests_run_command
  system tests_run_command
end

task ios_at_full: %i[reset ios_at allure_generate]
task ios_at_full_tr: %i[ios_at_full export_tr_ios]
task android_at_full: %i[reset android_at allure_generate]
task android_at_full_tr: %i[reset android_at allure_generate export_tr_android]
task default_ios: %i[reset ios_at allure_generate]
task default_android: %i[reset android_at allure_generate]
### MOBILE TASKS END ###

#### COMMON AND REPORTING TASKS ####
START_TIME = Time.now.to_i
task :test do
  puts Time.now.strftime('%Y%m%d_%H%M%S').to_s
end

desc 'clean doc directory of artifacts'
task reset: %i[clean clobber createDir]

task :allure_generate do
  system "allure generate #{reports_location}/allure -o #{reports_location}/allure-report/ -c"
end

task :tr_execution_candidates do
  system "ruby ./utils/testrail/testrail_execution_candidates.rb  #{tr_execution} #{tr_non_executed_only} #{tr_features_filter} "
  system "cp -fr tr_exec_candidates.txt #{reports_location}"
end

task :export_tr do
  system "ruby ./utils/testrail/testrail_testResult.rb ./ #{tr_execution} \"MacOS - #{browser}\" #{browser_version} #{environment} #{branch} http://10.106.5.18/ast-wc/#{branch}/#/ #{app_version} #{app_build}"
end

task :export_tr_android do
  system "ruby ./utils/testrail/testrail_testResult.rb ./ #{tr_execution} \"Verified passing.    BUILD INFO: Android: device: #{device}, appVersion: #{asVersion}, appBuild: #{asBuildNumber}, site:#{siteName}\" "
end

task :export_tr_ios do
  system "ruby ./utils/testrail/testrail_testResult.rb ./ #{tr_execution} \"Verified passing.    BUILD INFO: iOS: device: #{device}, platform: #{platformVersion}, appVersion: #{asVersion}, appBuild: #{asBuildNumber}, site:#{siteName}\" "
end

task :export_tr_acms do
  system "ruby ./utils/testrail/testrail_testResult.rb ./ #{tr_execution} \"Verified. App Version: #{app_version}\nBuild Number: #{app_build}\nBrowser: #{browser} #{browser_version}\nAD_URL: [props.ACMS_AD_URL]\nAT_URL: [props.ACMS_AT_URL]\" acms"
end

task :clear_xunit_duplicated do
  system "ruby ./utils/reports/cleanup_xunit_duplicates.rb docs/reports/xml_reports/"
end
