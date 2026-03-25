require 'time'
 Dir["#{Dir.getwd}/ACMS/lib/**/*.rb"].each {|file| require file }
 Dir[File.dirname(__FILE__) + "/../../common/**/*.rb"].each {|file| require file }
 Before do
   $ACMS_API_URL = process_param("[props.ACMS_API_URL]")
   $FLIGHT_MANAGER_REL_URL = process_param("[props.ACMS_FM_REL_URL]")
   $FM_API_URL = "#{$ACMS_API_URL}#{$FLIGHT_MANAGER_REL_URL}".gsub("://","__").gsub("//","/").gsub("__","://")
   $CLIENT_API_URL = process_param("[props.ACMS_CLIENT_API_URL]")
   @fm_api = Flight_Manager_API.new
   @client_api = Client_API.new
 end

def get_alerts_by_text_sql(alert_text)
  sql_query = "select * from Alarms where OriginalText = '#{alert_text}'"
  log_info "Executing SQL query #{sql_query}"
  db_response = DB_Client.new.execute_sql(process_param(get_param("COMMON_SERVER_DB_ADDRESS")),
                                        process_param(get_param("COMMON_SERVER_DB_PORT")),
                                        process_param(get_param("COMMON_SERVER_DB_USER")),
                                        process_param(get_param("COMMON_SERVER_DB_PASSWORD")),
                                        process_param(get_param("COMMON_SERVER_DB_SCHEMA")),
                                        sql_query)
  db_response
end

When(/^API: Wait until the alert is processed by Flight Manager$/) do
  alert_wait_timeout = 20
  alert_wait_interval = 0.5
  start_time = Time.now.to_f
  while  ( Time.now.to_f - start_time) < alert_wait_timeout  do
    if ENV['ALARM_DB_VERIFICATION'].nil? || ENV['ALARM_DB_VERIFICATION'].empty? || (ENV['ALARM_DB_VERIFICATION'].downcase == "false")
      matching_alerts = @fm_api.get_matching_alarm_list($GENERATED_ALARM) - $ORIGINAL_MATCHING_ALARMS
    else
      matching_alerts = get_alerts_by_text_sql($GENERATED_ALARM) - $ORIGINAL_MATCHING_ALARMS
    end
    break unless matching_alerts.empty?
    log_info "Waiting for #{alert_wait_interval} more seconds until alert '#{$GENERATED_ALARM}' processed"
    sleep alert_wait_interval
  end
  log_exception "Unable to wait until alert '#{$GENERATED_ALARM}' processed during #{alert_wait_timeout} seconds" unless !matching_alerts.empty?
  GENERATED_ALARM_STRING=$GENERATED_ALARM
  $GENERATED_ALARM = matching_alerts.first
  log_info "Alarm generated: #{$GENERATED_ALARM}"
  $GENERATED_ALARM_FLIGHT = @fm_api.get_alarm_flights($GENERATED_ALARM["id"]).first
  $GENERATED_ALARM_FLIGHTS_MAP[GENERATED_ALARM_STRING]=$GENERATED_ALARM_FLIGHT
  index = 0
  alarm_flight_timeout = get_param("ACMS_FLIGHT_PROCESSION_TIMEOUT").to_i
  while index < alarm_flight_timeout
    if $GENERATED_ALARM_FLIGHT.nil?
      log_info "Alarm flight not yet generated. Waiting for 1 more second"
      sleep(1)
      $GENERATED_ALARM_FLIGHT = @fm_api.get_alarm_flights($GENERATED_ALARM["id"]).first
      $GENERATED_ALARM_FLIGHTS_MAP[GENERATED_ALARM_STRING]=$GENERATED_ALARM_FLIGHT
      # TODO:delete debug call
      @fm_api.get_flights
      index += 1
    else
      break
    end
  end
    if index == alarm_flight_timeout
      log_exception "Unable to wait until Alarm flight is generated during #{alarm_flight_timeout} seconds"
    end
  log_info "Alarm flight generated: #{$GENERATED_ALARM_FLIGHT}"
end

When(/^API: Force stop alert generation script$/) do
  unless $ALARM_PIDS.empty?
    alarm_generator_killer_script="#{process_param("[props.ACMS_TOOLS_PATH]")}/kill_alert_generator.ps1"
    alert_generation_killer_command= "ssh -t -t #{$SSH_CONNECTION_URL} \"PowerShell #{alarm_generator_killer_script}\""
    execute_command_no_wait(alert_generation_killer_command)
  end
  $ALARM_PIDS=[]
end

When(/^API: Wait until the flight status is (Complete|Escalated|Accepted|InitialSuspense) by Flight Manager$/) do |target_status|
  steps %(When API: Wait until the flight status is #{target_status} by Flight Manager for 60 seconds)
end

When(/^API: Wait until flight status for alert "(.*)" is (Complete|Escalated|Accepted|InitialSuspense) by Flight Manager$/) do |alert_text, target_status|
  steps %(When API: Wait until the flight status for alert "#{alert_text}" is #{target_status} by Flight Manager for 60 seconds)
end

When(/^API: Wait until the flight status is (Complete|Escalated|Accepted|InitialSuspense) by Flight Manager for (\d+) seconds$/) do |target_status, seconds_to_wait|
  wait_timeout = seconds_to_wait
  wait_interval = 0.5
  start_time = Time.now.to_f

  while  (Time.now.to_f - start_time) < wait_timeout  do
    flight_details = @fm_api.get_the_flight_details($GENERATED_ALARM_FLIGHT['id'])
    log_info "Flight status #{flight_details['status']}"
    if flight_details["status"].include?(target_status)
      break
    end
    log_info "Waiting for #{wait_interval} more seconds until the flight '#{$GENERATED_ALARM_FLIGHT['id']}' has status #{target_status}"
    sleep wait_interval
  end
  log_exception "Unable to wait until the flight '#{$GENERATED_ALARM_FLIGHT['id']}' has status #{target_status} during #{wait_timeout} seconds" unless flight_details["status"].include?(target_status)
end


When(/^API: Wait until the flight status for alert "(.*)" is (Complete|Escalated|Accepted|InitialSuspense) by Flight Manager for (\d+) seconds$/) do |alert_text, target_status, seconds_to_wait|
  wait_timeout = seconds_to_wait
  wait_interval = 0.5
  start_time = Time.now.to_f

  while  (Time.now.to_f - start_time) < wait_timeout  do
    flight_details = @fm_api.get_the_flight_details($GENERATED_ALARM_FLIGHTS_MAP[alert_text]['id'])
    log_info "Flight status #{flight_details['status']}"
    if flight_details["status"].include?(target_status)
      break
    end
    log_info "Waiting for #{wait_interval} more seconds until the flight '#{$GENERATED_ALARM_FLIGHTS_MAP[alert_text]['id']}' has status #{target_status}"
    sleep wait_interval
  end
  log_exception "Unable to wait until the flight '#{$GENERATED_ALARM_FLIGHTS_MAP[alert_text]['id']}' has status #{target_status} during #{wait_timeout} seconds" unless flight_details["status"].include?(target_status)
end

When(/^API: Verify the flight attribute \"(.*)\" has value \"(.*)\"$/) do |attribute, value|
    flight_details = @fm_api.get_the_flight_details($GENERATED_ALARM_FLIGHT['id'])
    expect(flight_details[attribute]).to match(value)
    end

When(/^API: Verify flight entry stopped in (\d+) seconds within (\d) second range$/) do |flight_duration, max_deviation|
  flight_details = @fm_api.get_the_flight_details($GENERATED_ALARM_FLIGHT['id'])
  flightplan_duration = Time.parse(flight_details['completedTime']) - Time.parse(flight_details['createdAt'])
  expect(flightplan_duration.round).to be <= (flight_duration + max_deviation.to_i)
end

def find_flight_event(flight_attributes_json, match_attributes)
  if match_attributes.instance_of? String
    flight_attributes_json['flightEvents'].select { |elem| elem.to_s.match? match_attributes }
  else
    flight_attributes_json['flightEvents'].select do |elem|
      match = true
      match_attributes.each do |key, array|
        unless elem[key].to_s.match? array
          match = false
          break
        end
      end
      match
    end
  end
end

When(/^API: Wait for (\d+) seconds until the flight has event with attributes$/) do |seconds_to_wait, attributes|
  attributes = JSON.parse(attributes)
  wait_timeout = seconds_to_wait
  wait_interval = 0.5
  start_time = Time.now.to_f
  while  (Time.now.to_f - start_time) < wait_timeout  do
    flight_details = @fm_api.get_the_flight_details($GENERATED_ALARM_FLIGHT['id'])
    unless find_flight_event(flight_details, attributes).empty?
      break
    end
    log_info "Waiting for #{wait_interval} more seconds until the flight '#{$GENERATED_ALARM_FLIGHT['id']}' has event #{attributes}"
    sleep wait_interval
  end
  log_exception "Unable to wait until the flight '#{$GENERATED_ALARM_FLIGHT['id']}' has event #{attributes} during #{wait_timeout} seconds" if find_flight_event(flight_details, attributes).empty?
end

When(/^API: Verify the flight has event with attributes$/) do |attributes|
  attributes = JSON.parse(attributes)
  flight_details = @fm_api.get_the_flight_details($GENERATED_ALARM_FLIGHT['id'])
  log_exception "Unable to verify the flight '#{$GENERATED_ALARM_FLIGHT['id']}' has event #{attributes}" if find_flight_event(flight_details, attributes).empty?
end

When(/^API: Verify the flight (has|doesn't have) event with attributes '(.*)'$/) do |has, attributes|
  attributes = JSON.parse(attributes)
  flight_details = @fm_api.get_the_flight_details($GENERATED_ALARM_FLIGHT['id'])
  if has.include?("has")
    log_exception "Unable to verify the flight '#{$GENERATED_ALARM_FLIGHT['id']}' has event #{attributes}" if find_flight_event(flight_details, attributes).empty?
  else
    log_exception "Unable to verify the flight '#{$GENERATED_ALARM_FLIGHT['id']}' doesn't have event #{attributes}" unless find_flight_event(flight_details, attributes).empty?
  end
end

  When(/^API: Verify the flight (has|doesn't have) event "(.*)"$/) do |has, matchstring|
    flight_details = @fm_api.get_the_flight_details($GENERATED_ALARM_FLIGHT['id'])
    if has.include?("has")
      log_exception "Unable to verify the flight '#{$GENERATED_ALARM_FLIGHT['id']}' has event #{matchstring}" if find_flight_event(flight_details, matchstring).empty?
    else
      log_exception "Unable to verify the flight '#{$GENERATED_ALARM_FLIGHT['id']}' doesn't have event #{matchstring}" unless find_flight_event(flight_details, matchstring).empty?
    end
  end

When(/^API: Verify the flight has (at least |not more than|)(\d+) events with attributes$/) do |size_validation, count, attributes|
  attributes = JSON.parse(attributes)
  flight_details = @fm_api.get_the_flight_details($GENERATED_ALARM_FLIGHT['id'])
  if size_validation.include?("at least")
    expect(find_flight_event(flight_details, attributes).size).to be >= count,  "Unable to verify the flight '#{$GENERATED_ALARM_FLIGHT['id']}' has at least #{count} events #{attributes}"
  elsif size_validation.include?("not more than")
    expect(find_flight_event(flight_details, attributes).size).to be <= count, "Unable to verify the flight '#{$GENERATED_ALARM_FLIGHT['id']}' has not more than #{count} events #{attributes}"
  else
    expect(find_flight_event(flight_details, attributes)).to have_attributes(size: count), "Unable to verify the flight '#{$GENERATED_ALARM_FLIGHT['id']}' has #{count} events #{attributes}"
  end
end


When(/^API: Wait for (\d+) seconds until the flight the flight has (at least |not more than|)(\d+) events with attributes$/) do |wait_timeout, size_validation, count, attributes|
  attributes = JSON.parse(attributes)
  start_time = Time.now.to_f
  wait_interval = 0.5
  condition_met = false
  while ((Time.now.to_f - start_time) < wait_timeout) && !condition_met do
    flight_details = @fm_api.get_the_flight_details($GENERATED_ALARM_FLIGHT['id'])
    begin
      if size_validation.include?("at least")
        expect(find_flight_event(flight_details, attributes).size).to be >= count,  "Unable to verify the flight '#{$GENERATED_ALARM_FLIGHT['id']}' has at least #{count} events #{attributes}"
      elsif size_validation.include?("not more than")
        expect(find_flight_event(flight_details, attributes).size).to be <= count, "Unable to verify the flight '#{$GENERATED_ALARM_FLIGHT['id']}' has not more than #{count} events #{attributes}"
      else
        expect(find_flight_event(flight_details, attributes)).to have_attributes(size: count), "Unable to verify the flight '#{$GENERATED_ALARM_FLIGHT['id']}' has #{count} events #{attributes}"
      end
      condition_met = true
    rescue RSpec::Expectations::ExpectationNotMetError
      log_info "Waiting for #{wait_interval} more seconds until the flight '#{$GENERATED_ALARM_FLIGHT['id']}' flight detail #{flight_details} #{size_validation} events with attributes #{attributes} is met"
      sleep wait_interval
    end
  end
  log_exception "Unable to wait until the flight '#{$GENERATED_ALARM_FLIGHT['id']}' flight detail #{flight_details} #{size_validation} events with attributes #{attributes} was met during #{wait_timeout} seconds" unless condition_met
end

When(/^API: Verify the difference between event \"(.*)\" and event \"(.*)\" is (\d+) seconds$/) do |event1, event2, timeout|
  event1 = process_param(event1)
  event2 = process_param(event2)
  flight_details = @fm_api.get_the_flight_details($GENERATED_ALARM_FLIGHT['id'])
  event1details = find_flight_event(flight_details,event1)
  event2details = find_flight_event(flight_details,event2)
  actual_duration = (Time.parse(event2details.first['timestamp']) - Time.parse(event1details.first['timestamp'])).round
  expect(actual_duration).to be timeout
end

When(/^API: Verify the difference between event \"(.*)\" and event \"(.*)\" is (\d+) seconds within (\d) seconds range$/) do |event1, event2, timeout, timeout2|
  event1 = process_param(event1)
  event2 = process_param(event2)
  flight_details = @fm_api.get_the_flight_details($GENERATED_ALARM_FLIGHT['id'])
  event1details = find_flight_event(flight_details,event1)
  event2details = find_flight_event(flight_details,event2)
  actual_duration = (Time.parse(event2details.first['timestamp']) - Time.parse(event1details.first['timestamp'])).round
  expect(actual_duration).to be <= (timeout + timeout2.to_i)
end

When(/^API: Wait until the flight is escalated to level (\d+)$/) do |escalation_level|
  wait_timeout = 60
  steps %(When API: Check for flight "escalationLevel" to be "#{escalation_level}" for #{wait_timeout} seconds)
end

When(/^API: Wait until the flight (is|isn't) in cancellation suspense state for (\d+) seconds$/) do |status, timeout|
  boolean = status.to_s.eql? 'is'
  steps %(When API: Check for flight "isInCancellationSuspense" to be "#{boolean}" for #{timeout} seconds)
end

When(/^API: User manually escalates the flight from level (1|2|3)$/) do|original_escalation_level|
  @fm_api.escalate_flight($GENERATED_ALARM_FLIGHT['id'],original_escalation_level)
end

When(/^API: User manually starts the flight$/) do
  @client_api.start_flight($GENERATED_ALARM_FLIGHT['id'])
end

When(/^API: User delays the flight$/) do
  @client_api.delay_flight($GENERATED_ALARM_FLIGHT['id'])
end

When(/^API: Check for flight "(.*)" to be "(.*)" for (\d+) seconds$/) do |flight_detail, detail_condition, wait_timeout|
  start_time = Time.now.to_f
  wait_interval = 0.5
  while (Time.now.to_f - start_time) < wait_timeout do
    flight_details = @fm_api.get_the_flight_details($GENERATED_ALARM_FLIGHT['id'])
    case flight_detail
    when 'status'
      condition_met = flight_details[flight_detail].include?(detail_condition)
    when 'escalationLevel'
      condition_met = flight_details[flight_detail].eql?(detail_condition.to_i)
    when 'isInCancellationSuspense'
      condition_met = flight_details[flight_detail].eql?(!!detail_condition)
    end
    if condition_met
      break
    end
    log_info "Waiting for #{wait_interval} more seconds until the flight '#{$GENERATED_ALARM_FLIGHT['id']}' flight detail #{flight_detail} condition #{detail_condition} is met. The current condition is: #{flight_details[flight_detail]}"
    sleep wait_interval
  end
  log_exception "Unable to wait until the flight '#{$GENERATED_ALARM_FLIGHT['id']}' flight detail #{flight_detail} condition #{detail_condition} was met during #{wait_timeout} seconds" unless condition_met
end

When(/^API: Clear ATC Flights and Alarms records$/) do
  log_info "Cleaning all ATC Flights and Alarms data"
   @fm_api.clear_flights_data
   @fm_api.clear_flight_manager_in_memeory_state
end

When(/^API: Clear ATC DB$/) do
  log_info "Cleaning ATC DB"
  @fm_api.clear_db_data
end
