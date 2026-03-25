require 'rtesseract'
require 'json'
require 'deep_merge'
When(/^User backs up test environment config.json file$/) do
  SSH_CONNECTION_URL= process_param("[props.COMMON_SERVER_SSH_CONNECTION]")
  DEPLOYMENT_DIR= process_param("[props.COMMON_WC_DEPLOYMENT_FOLDER]")
  $WC_CONFIG_FILE_BACKUP="#{DEPLOYMENT_DIR}\\backups\\backup_#{Time.now.strftime("%d_%m_%Y_%H_%M_%S")}\\"
  execute_command("ssh #{SSH_CONNECTION_URL} \"xcopy #{DEPLOYMENT_DIR}\\config.json #{$WC_CONFIG_FILE_BACKUP} /F /R /Y /I\" 2>&1")
end
When(/^I wait "(.*?)" seconds$/) do |seconds|
  sleep seconds.to_i
end

Given(/^Artificial step$/) do
  print("Artificial step")
end

Given(/^Artificial failure/) do
  raise "Artificial error"
end


When(/^(stop|start|restart) WebClient service$/) do |command|
  service_name="utangPatientMonitoring"
  if command.include?("restart")
    steps %(
      When stop WebClient service
      When start WebClient service
      )
  else
      command= "net #{command} #{service_name}"
      SSH_CONNECTION_URL= process_param("[props.COMMON_SERVER_SSH_CONNECTION]")
      execute_command("ssh #{SSH_CONNECTION_URL} \"#{command}\" 2>&1")
  end
end

When(/^(stop|start|restart) WebClient IIS application pool/) do |command|
  # "%windir%\system32\inetsrv\appcmd" stop APPPOOL "ast-wc"
  # "%windir%\system32\inetsrv\appcmd" start APPPOOL "wst-wc"
   log_exception("Not yet implemented")
end

When(/^User restores backed up test environment config.json file$/) do
  SSH_CONNECTION_URL= process_param("[props.COMMON_SERVER_SSH_CONNECTION]")
  DEPLOYMENT_DIR= process_param("[props.COMMON_WC_DEPLOYMENT_FOLDER]")
  execute_command("ssh #{SSH_CONNECTION_URL} \"xcopy #{$WC_CONFIG_FILE_BACKUP}\\config.json #{DEPLOYMENT_DIR}\\ /F /R /Y /I\" 2>&1")
end

When(/^User restores test environment config.json file from "(.*)"$/) do |local_backup|
  SSH_CONNECTION_URL= process_param("[props.COMMON_SERVER_SSH_CONNECTION]")
  DEPLOYMENT_DIR= process_param("[props.COMMON_WC_DEPLOYMENT_FOLDER]")
  local_backup_absolute_path=File.absolute_path(local_backup)
  execute_command("scp #{local_backup_absolute_path}  #{SSH_CONNECTION_URL}:#{DEPLOYMENT_DIR.gsub("\\"){"\\\\"}}\\\\config.json 2>&1")
end

When(/^wait for (\d+) seconds$/) do |timeout|
  sleep(timeout)
end

When(/^User update test environment config.json file with changes$/) do |config_json_update|
  JQ_RULE='reduce inputs as $i (.; .customBedLists += $i.customBedLists)'
  SSH_CONNECTION_URL= process_param("[props.COMMON_SERVER_SSH_CONNECTION]")
  DEPLOYMENT_DIR= process_param("[props.COMMON_WC_DEPLOYMENT_FOLDER]")
  original_config_file="original_config.json"
  execute_command("scp  #{SSH_CONNECTION_URL}:#{DEPLOYMENT_DIR.gsub("\\"){"/"}}/config.json #{original_config_file}  2>&1")
  original_config_json = File.read(original_config_file)
  DeepMerge.deep_merge!(original_config_json,config_json_update)
  JSON.dump(JSON.parse(original_config_json)).merge(JSON.parse(config_json_update))
  log_exception("Not yet implemented deep JSON merge")
end
Given(/^The screen is captured$/) do
  sleep 2
  screenshotFile = Time.now.strftime('%Y-%m-%d_%H.%M.%S.png')
  $CAPTURED_SCREEN="docs/screenshots/#{screenshotFile}"
  @selenium.save_screenshot($CAPTURED_SCREEN) unless @selenium.nil?
  @appiumDriver.screenshot($CAPTURED_SCREEN) unless @appiumDriver.nil?
end

Then(/^User reads screen content$/) do
  steps %(
	Given The screen is captured
	)
  $PARSED_SCREEN = RTesseract.new($CAPTURED_SCREEN).to_s
end

Then(/^Verify screen content matches$/) do  |regexp|
  expect($PARSED_SCREEN).to match(regexp)
end

Then(/^Verify screen content matches "(.*)"$/) do  |regexp|
  expect($PARSED_SCREEN).to match(regexp)
end
