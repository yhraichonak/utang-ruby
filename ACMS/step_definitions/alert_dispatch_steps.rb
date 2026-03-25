# frozen_string_literal: true

Dir["#{Dir.getwd}/ACMS/lib/**/*.rb"].each { |file| require file }
Dir["#{Dir.getwd}/ACMS/pages/**/*.rb"].each { |file| require file }
Dir["#{Dir.getwd}/ACMS/support/**/*.rb"].each { |file| require file }
Dir["#{File.dirname(__FILE__)}/../../common/**/*.rb"].each { |file| require file }
require 'time'

Before do
  $ACMS_AD_URL = process_param('[props.ACMS_AD_URL]')
  @ad_login = AlertDispatch_LoginPage.new @selenium
  @common = CommonPage.new @selenium
  @ad_common = AlertDispatch_CommonPage.new @selenium
  @ad_flight_card = AlertDispatch_FlightCard.new @selenium
end

Given(/^AC: User opens login page$/) do
  @selenium.navigate.to $ACMS_AD_URL
  @wait.until { @ad_login.login_form.displayed? }
  expect(@selenium.title).to eq 'AlertDispatch - utang ONE'
end

When (/^AC: User waits for "(.*)" to be displayed in the top right user panel$/) do |username|
  username=process_param(username)
  @wait.until { @ad_common.user_panel.displayed? }
  expect(@ad_common.user_panel.text).to eq username
end

Given(/^AC: User logs in as "(.*)" with password "(.*)"$/) do |username, password|
  username = process_param(username)
  password = process_param(password)
  @ad_login.login_as(username, password)
  steps %(When AC: User waits for "#{username}" to be displayed in the top right user panel)
end

When(/^AC: User enters "(.*)" as username$/) do |username|
  username = process_param(username)
  @ad_login.enter_username(username)
end

When(/^AC: User enters "(.*)" as password$/) do |password|
  password = process_param(password)
  @ad_login.enter_password(password)
end

When(/^AC: User clicks the login button$/) do
  @ad_login.click_login
end

Then(/^AC: User should see the login button is disabled$/) do
  disabled = @ad_login.is_login_disabled
  expect(disabled).to be true
end

Then(/^AC: User should see the login button is enabled$/) do
  disabled = @ad_login.is_login_disabled
  expect(disabled).to be false
end

Then(/^AC: User should see a login error message$/) do
  @wait.until { @ad_login.login_error.displayed? }
end

And (/^AC: User logs out$/) do
  @ad_common.logout
end

Then (/^AC: User should not see any active filters$/) do
  filters = @ad_common.get_current_filters()
  expect(filters).to be_empty
end

Then (/^AC: User should see the Alarm Queue and Alerts sections$/) do
  expect(@ad_common.alarm_queue_panel.displayed?).to be_truthy
  expect(@ad_common.alerts_panel.displayed?).to be_truthy
end

Then (/^AC: User should see all UI elements in the Alarm Queue Chicklet for the generated flight$/) do
  log_info "generated alarm object: #{ $GENERATED_ALARM_FLIGHT }"
  expect(@ad_flight_card.flight_alarm_icon($GENERATED_ALARM_FLIGHT['id']).displayed?).to be_truthy
  expect(@ad_flight_card.alarm_name_label($GENERATED_ALARM_FLIGHT['id']).displayed?).to be_truthy
  expect(@ad_flight_card.date_of_birth($GENERATED_ALARM_FLIGHT['id']).displayed?).to be_truthy
  expect(@ad_flight_card.mrn($GENERATED_ALARM_FLIGHT['id']).displayed?).to be_truthy
  expect(@ad_flight_card.facility($GENERATED_ALARM_FLIGHT['id']).displayed?).to be_truthy
  expect(@ad_flight_card.unit($GENERATED_ALARM_FLIGHT['id']).displayed?).to be_truthy
  expect(@ad_flight_card.room_and_bed($GENERATED_ALARM_FLIGHT['id']).displayed?).to be_truthy
  expect(@ad_flight_card.flight_start_time($GENERATED_ALARM_FLIGHT['id']).displayed?).to be_truthy
  expect(@ad_flight_card.flight_elapsed_time($GENERATED_ALARM_FLIGHT['id']).displayed?).to be_truthy
end

Then (/^AC: User should see the Alarm Queue section 'Prioritize by Severity' checkbox be (checked|unchecked)$/) do |toggleExpectation|
  toggle = @ad_common.isAlarmQueuePrioritizationChecked()
  if toggleExpectation === "checked"
    expect(toggle).to be true
  elsif toggleExpectation === "unchecked"
    expect(toggle).to be false
  end
end

When (/^AC: User toggles the Alarm Queue section "Prioritize by Severity" checkbox$/) do
  @ad_common.toggleAlarmQueuePrioritizationCheckbox()
end

Then (/^AC: User should see the Alerts section 'Prioritize by Severity' checkbox be (checked|unchecked)$/) do |toggleExpectation|
  toggle = @ad_common.isAlertsPrioritizationChecked()
  if toggleExpectation === "checked"
    expect(toggle).to be true
  elsif toggleExpectation === "unchecked"
    expect(toggle).to be false
  end
end

When(/^AC: User toggles the Alerts section "Prioritize by Severity" checkbox$/) do
  @ad_common.toggleAlertsPrioritizationCheckbox
end

Then(/^AC: User waits until the generated alert is present in (Alarm Queue|Alerts) panel$/) do |panel|
  flight_record_update_timeout = 60
  wait_interval = 3
  start_time = Time.now.to_f
  while  ( Time.now.to_f-start_time) < flight_record_update_timeout  do
    @wait.until { @ad_common.get_items_list_panel(panel).displayed?}
    matching_flight_records=@ad_common.get_matching_flight_plan_items(panel, $GENERATED_ALARM_FLIGHT['id'], wait_interval)
    break if not matching_flight_records.empty?
    log_info "Waiting for #{wait_interval} more seconds until flight record '#{ $GENERATED_ALARM_FLIGHT['id']}' appear"
  end
  if matching_flight_records.empty?
    log_exception "Unable to wait until flight plan record '#{$GENERATED_ALARM_FLIGHT['id']}' appear s under #{panel} during #{flight_record_update_timeout} seconds"
  end
end

When(/^AC: User should see "(.*)" alert present in Alerts panel in (Active|Completed) subsection$/) do|alert_text,panel|
  flight_card=@ad_common.get_matching_flight_plan_items_by_text('Alerts', alert_text, 5,panel)[0];
  expect(flight_card).to_not be_nil
end

When(/^AC: User wait until "(.*)" alert appears in Alerts panel in (Active|Completed) subsection$/) do|alert_text,subsection|
  flight_record_update_timeout = 5
  wait_interval = 1
  start_time = Time.now.to_f
  while  (Time.now.to_f-start_time) < flight_record_update_timeout  do
    matching_flight_records=@ad_common.get_matching_flight_plan_items_by_text('Alerts', alert_text, 5,subsection);
    break unless matching_flight_records.empty?
    log_info "Waiting for #{wait_interval} more seconds until flight record '#{alert_text}' appear"
  end
  if matching_flight_records.empty?
    log_exception "Unable to wait until flight '#{alert_text}' appears under #{subsection} during #{flight_record_update_timeout} seconds"
  end
end

When(/^AC: User wait until "(.*)" alert appears in Alarm Queue panel$/) do|alert_text|
  flight_record_update_timeout = 5
  wait_interval = 1
  start_time = Time.now.to_f
  while  (Time.now.to_f-start_time) < flight_record_update_timeout  do
    matching_flight_records=@ad_common.get_matching_flight_plan_items_by_text('Alarm Queue', alert_text, 5);
    break unless matching_flight_records.empty?
    log_info "Waiting for #{wait_interval} more seconds until flight record '#{alert_text}' appear"
  end
  if matching_flight_records.empty?
    log_exception "Unable to wait until flight '#{alert_text}' appears in Alarm Queue panel during #{flight_record_update_timeout} seconds"
  end
end


Then(/^AC: User should see the generated alert present in Alerts panel in (Active|Completed) subsection$/) do |subsection|
  flight_record_update_timeout = 60
  wait_interval = 3
  start_time = Time.now.to_f
  while  (Time.now.to_f-start_time) < flight_record_update_timeout  do
    @wait.until { @ad_common.get_items_list_panel(subsection).displayed?}
    matching_flight_records=@ad_common.get_matching_flight_plan_items('Alerts', $GENERATED_ALARM_FLIGHT['id'], wait_interval, subsection)
    break unless matching_flight_records.empty?
    log_info "Waiting for #{wait_interval} more seconds until flight record '#{ $GENERATED_ALARM_FLIGHT['id']}' appear"
  end
  if matching_flight_records.empty?
    log_exception "Unable to wait until flight plan record '#{$GENERATED_ALARM_FLIGHT['id']}' appear s under #{subsection} during #{flight_record_update_timeout} seconds"
  end
end

Then(/^AC: User should not see the generated alert present in Alerts panel in (Active|Completed) subsection$/) do |subsection|
    matching_flight_records=@ad_common.get_matching_flight_plan_items('Alerts', $GENERATED_ALARM_FLIGHT['id'], 1, subsection)
    unless matching_flight_records.empty?
    log_exception "Plan record '#{$GENERATED_ALARM_FLIGHT['id']}' appeared under #{subsection}"
  end
end
Then(/^AC: User verifies the generated alert is present in (Alarm Queue|Alerts) panel with attributes$/) do |panel, attributes|
  attributes=JSON.parse(attributes)
  steps %(Then AC: User waits until the generated alert is present in #{panel} panel)
  matching_flight_records=@ad_common.get_matching_flight_plan_items(panel, $GENERATED_ALARM_FLIGHT['id'], 3)
  sleep 1
  verify_flight_record(matching_flight_records[0],attributes )
end

Then(/^AC: User verifies the generated alert is present in (Alarm Queue|Alerts) panel with matching text$/) do |panel, rgexp|
  rgexp=rgexp.strip
  steps %(Then AC: User waits until the generated alert is present in #{panel} panel)
  matching_flight_records=@ad_common.get_matching_flight_plan_items(panel, $GENERATED_ALARM_FLIGHT['id'], 3)
  sleep 1
  expect(matching_flight_records[0].text).to(match(rgexp))
end

Then(/^AC: User verifies the generated alert is present in (Alarm Queue|Alerts) panel with (High|Medium|Low) severity$/) do |panel, severity|
  steps %(Then AC: User waits until the generated alert is present in #{panel} panel)
  matching_flight_records=@ad_common.get_matching_flight_plan_items(panel, $GENERATED_ALARM_FLIGHT['id'], 3)
  sleep 1
  expect(matching_flight_records[0].find_element(:css,"img[data-testid='alarm-severity-icon']").attribute("class").to_s).to include(severity.downcase)
end



When(/^AC: User should see "(.*)" alert present in Alerts panel in (Active|Completed) subsection without timer$/) do|alert_text, panel|
  flight_card=@ad_common.get_matching_flight_plan_items_by_text('Alerts', alert_text, 5,panel)[0];
  expect(find_element_no_wait(@selenium, flight_card,:css, "div[data-testid='escalates-in']")).to be(nil)
end


Then(/^AC: User verifies the generated alert has attributes$/) do |attributes|
  attributes=JSON.parse(attributes)
  matching_flight_records=@ad_common.get_matching_flight_plan_items('Alerts', $GENERATED_ALARM_FLIGHT['id'], 3)
  sleep 1
  verify_flight_record(matching_flight_records[0],attributes )
end
Then(/^AC: User verifies the generated alert is present in (Alarm Queue|Alerts) panel$/) do |panel|
  steps %(Then AC: User waits until the generated alert is present in #{panel} panel)
  matching_flight_records=@ad_common.get_matching_flight_plan_items(panel, $GENERATED_ALARM_FLIGHT['id'], 3)
  expect(matching_flight_records).to_not be_nil
end

Then(/^AC: I should see the (Assigned|Escalates) to: label set to "(.*)"$/) do |label, destination|
  destination=process_param(destination)
  matching_flight_records=@ad_common.get_matching_flight_plan_items('Alerts', $GENERATED_ALARM_FLIGHT['id'], 3)
  @wait.until { !matching_flight_records.empty? }
  field=@ad_common.destination_field(label)
  expect(field.first.text).to include(destination)
end

Then(/^AC: User sees the elapsed flight time on the flight entry stop at "(.*)" within (\d+) second range$/) do |time, elapsed_time|
  elapsed_time_label = @ad_flight_card.flight_time_elapsed($GENERATED_ALARM_FLIGHT['id']).text.to_f
  acceptable_times = [time.to_f]
  for i in 1..elapsed_time
    acceptable_times.push(("0.0#{i}".to_f + time.to_f))
  end
  expect(acceptable_times).to include(elapsed_time_label)
end

Then(/^AC: User sees flight entry with text matching$/) do |matching_text|
  matching_text=process_param(matching_text)
  flight_card_text = @ad_flight_card.get_flight_card($GENERATED_ALARM_FLIGHT['id']).text
  expect(flight_card_text).to match(matching_text)
end

Then(/^AC: Flight alert status section is (blue|green|grey|yellow|red) and has (empty-circle|filled-circle|no-icon|tabler-icon-clock|barred-circle) icon with label (Waiting|Accepted|Completed|Suspended|Ended|Delayed|Undeliverable)$/) do |color, icon, label|
  case color
  when 'grey'
    color = 'rgba(212, 212, 212, 1)'
  when 'green'
    color = 'rgba(17, 162, 58, 1)'
  when 'blue'
    color = 'rgba(27, 172, 222, 1)'
  when 'yellow'
    color = 'rgba(255, 242, 179, 1)'
  when 'red'
    color = 'rgba(157, 12, 12, 1)'
  end
  begin
    @wait.until { @ad_flight_card.flight_status_color($GENERATED_ALARM_FLIGHT['id']).style('background-color').eql? color }
    @wait.until { @ad_flight_card.flight_card_status($GENERATED_ALARM_FLIGHT['id']).text != '' }
    status_color = @ad_flight_card.flight_status_color($GENERATED_ALARM_FLIGHT['id']).style('background-color')
    status_label = @ad_flight_card.flight_card_status($GENERATED_ALARM_FLIGHT['id'])
    status_icon = @ad_flight_card.flight_status_icon($GENERATED_ALARM_FLIGHT['id'], icon)
    expect(status_icon).not_to(be_nil, "No status icon matching #{icon} found on Alarm card")
    expect(status_label.text).to include label.upcase
    expect(status_color).to eql color
  rescue Selenium::WebDriver::Error::StaleElementReferenceError
    @wait.until { @ad_flight_card.flight_status_color($GENERATED_ALARM_FLIGHT['id']).style('background-color').eql? color }
    @wait.until { @ad_flight_card.flight_card_status($GENERATED_ALARM_FLIGHT['id']).text != '' }
    status_color = @ad_flight_card.flight_status_color($GENERATED_ALARM_FLIGHT['id']).style('background-color')
    status_label = @ad_flight_card.flight_card_status($GENERATED_ALARM_FLIGHT['id'])
    status_icon = @ad_flight_card.flight_status_icon($GENERATED_ALARM_FLIGHT['id'], icon)
    expect(status_icon).not_to(be_nil, "No status icon matching #{icon} found on Alarm card")
    expect(status_label.text).to include label.upcase
    expect(status_color).to eql color
  end
end

def time_span_to_int(time)
  timespan_parts = time.split(':').map(&:to_i)
  timespan_parts[0] * 60 + timespan_parts[1]
end

Then(/^AC: Flight alert "Escalation in" value counting down from "(.*)" seconds$/) do |time|
  timespan_int = time_span_to_int(time)
  escalate_in1 = @ad_flight_card.get_timer_value($GENERATED_ALARM_FLIGHT['id'], false).text
  sleep 1
  escalate_in2 = @ad_flight_card.get_timer_value($GENERATED_ALARM_FLIGHT['id'], false).text
  elapsed = @ad_flight_card.get_timer_value($GENERATED_ALARM_FLIGHT['id'], true).text
  total_time = [elapsed, escalate_in2].sum do |s|
    h, m = s.split(':').map(&:to_i)
    60 * h + m
  end
  expect([ timespan_int + 1, timespan_int, timespan_int - 1, timespan_int - 2]).to include(total_time)
  expect(time_span_to_int(escalate_in2)).to be <= time_span_to_int(escalate_in1)
end

Then(/^AC: Flight alert "Escalation in" value is "(.*)"$/) do |value|
  expect( @ad_flight_card.get_timer_value($GENERATED_ALARM_FLIGHT['id'], false).text).to include(value)
end

Then(/^AC: Flight alert "Elapsed time" value counting up$/) do
  elapsed1 = @ad_flight_card.get_timer_value($GENERATED_ALARM_FLIGHT['id'], true).text
  elapsed2 = @ad_flight_card.get_timer_value($GENERATED_ALARM_FLIGHT['id'], true).text
  expect(time_span_to_int(elapsed1)).to be <= time_span_to_int(elapsed2)
end

Then(/^AC: Flight alert "Time Elapsed" value counting up from "(.*)" seconds$/) do |_time|
  elapsed1 = @ad_flight_card.get_timer_value($GENERATED_ALARM_FLIGHT['id'], true).text
  sleep 1
  elapsed2 = @ad_flight_card.get_timer_value($GENERATED_ALARM_FLIGHT['id'], true).text
  expect(time_span_to_int(elapsed1)).to be <= time_span_to_int(elapsed2)
end

Then(/^AC: Wait until the flight "(Time elapsed|Escalation in)" value is "(.*)" for (\d+) seconds$/) do |time_label, value, timeout|
  time = 0
  while time < timeout
    if time_label == 'Time elapsed'
      elapsed = @ad_flight_card.get_timer_value($GENERATED_ALARM_FLIGHT['id'], true).text
      break if time_span_to_int(elapsed) >= time_span_to_int(value)
    else
      time_to_escalate = @ad_flight_card.get_timer_value($GENERATED_ALARM_FLIGHT['id'], false).text
      break if time_span_to_int(time_to_escalate) <= time_span_to_int(value)
    end
    sleep 1
    time += 1
  end
  if time == timeout
    raise "Unable to wait until #{time_label} value is #{value} for #{timeout} seconds"
  end
end

When(/AC: User click at clock icon on the flight in the top right hand corner$/) do
  @ad_flight_card.get_flight_card_delay_icon($GENERATED_ALARM_FLIGHT['id']).click
  sleep 1
end

Then(/^AC: Flight alert status (section|font) color is (blue|yellow|gray|white)$/) do |attribute, color|
  case color
  when 'blue'
    color = 'rgba(27, 172, 222, 1)'
  when 'yellow'
    color = 'rgba(255, 242, 179, 1)'
  when 'gray'
    color = 'rgba(115, 115, 115, 1)'
  when 'white'
    color = 'rgba(249, 250, 251, 1)'
  end
  flight_attribute_color = if attribute == 'section'
                             @ad_flight_card.flight_status_color($GENERATED_ALARM_FLIGHT['id']).style('background-color')
                           else
                             @ad_flight_card.flight_status_content($GENERATED_ALARM_FLIGHT['id']).style('color')
                           end
  expect(flight_attribute_color).to eql color
end

When(/^AC: User opens the generated alert details in (Alarm Queue|Alerts) panel$/) do |panel|
  begin
    @ad_common.get_matching_flight_plan_items(panel, $GENERATED_ALARM_FLIGHT['id'], 5)[0].click
  rescue Exception
    sleep 2
    @ad_common.get_matching_flight_plan_items(panel, $GENERATED_ALARM_FLIGHT['id'], 5)[0].click
  end
end

When(/^AC: User (opens|clicks) the "(.*)" alert details in (Alarm Queue|Alerts) panel$/) do |action, alert_text,panel|
  begin
    @ad_common.get_matching_flight_plan_items_by_text(panel, alert_text, 5)[0].click
  rescue Exception
    sleep 2
    @ad_common.get_matching_flight_plan_items_by_text(panel, alert_text, 5)[0].click
  end
  sleep 1
end

When(/^AC: User verifies that the generated alert card (is|isn't) highlighted in (Alarm Queue|Alerts) panel$/) do|action,panel|
  flight_card=@ad_common.get_flight_plan_item(panel, $GENERATED_ALARM_FLIGHT['id'], 5);
  if action =="is"
     expect(flight_card.find_element(:css,"div[data-testid='flight-sections-container']").css_value("background-color").to_s).to include('oklab')
  else
     expect(flight_card.find_element(:css,"div[data-testid='flight-sections-container']").css_value("background-color").to_s).not_to include('oklab')
  end
end


When(/^AC: User verifies that "(.*)" alert card (is|isn't) highlighted in (Alarm Queue|Alerts) panel$/) do|alert_text,action,panel|
  flight_card=@ad_common.get_matching_flight_plan_items_by_text(panel, alert_text, 5)[0];
  if action =="is"
    expect(flight_card.find_element(:css,"div[data-testid='flight-sections-container']").css_value("background-color").to_s).to include('oklab')
  else
    expect(flight_card.find_element(:css,"div[data-testid='flight-sections-container']").css_value("background-color").to_s).not_to include('oklab')
  end
end


When(/^AC: User verifies that "(.*)" alert card (has|doesn't have) button Start in (Alarm Queue|Alerts) panel$/) do|alert_text,action,panel|
  flight_card=@ad_common.get_matching_flight_plan_items_by_text(panel, alert_text, 5)[0];
  res=Common.find_element_no_wait(@selenium, flight_card,:css,"button[data-testid='start']")
  if action == "has"
    expect(res).not_to be(nil)
  else
    expect(res).to be(nil)
  end
end

When(/^AC: User clicks start button on alarm$/) do
  start_button = @ad_flight_card.alarm_start_button($GENERATED_ALARM_FLIGHT['id'])
  expect(start_button.displayed?).to eql true
  start_button.click
end


When(/^AC: User clicks (start|cancel) button in pop up modal$/) do |button|
  target_button = @ad_common.dialog_button(button)
  expect(target_button.displayed?).to eql true
  target_button.click
end


When(/^AC: Verify that start button has disappeared on pop up modal$/) do
  target_button = @ad_common.dialog_button_no_wait("start")
  expect(target_button).to eql nil
end


When(/^AC: User should see Start Alert modal popup$/) do
  dialog_element=@ad_common.start_alert_dialog
  expect(dialog_element.find_element(:css, "textarea[data-testid='note']").displayed?).to be(true)
  expect(dialog_element.find_element(:css, "button[data-testid='cancel']").displayed?).to be(true)
  expect(dialog_element.find_element(:css, "button[data-testid='start']").displayed?).to be(true)
end

When(/^AC: User specified "(.*)" notes at Start Alert modal popup$/) do |note|
  dialog_element=@ad_common.start_alert_dialog
  dialog_element.find_element(:css,"textarea[data-testid='note']").send_keys(process_param(note))
end

When(/^AC: User should see text on Start Alert modal popup matching$/) do |regexp|
  dialog_element=@ad_common.start_alert_dialog
  expect(dialog_element.text).to match(regexp)
end

When(/^AC: User should see (Medium|High) severity icon on Alert modal popup matching$/) do |severity|
  dialog_element=@ad_common.start_alert_dialog
  severity_icon=dialog_element.find_element(:css,"img[data-testid='alarm-severity-icon']."+severity.downcase)
  expect(severity_icon.displayed?).to be(true)
end

When(/^AC: User manually escalates alarm through elipses menu$/) do
  @wait.until { @ad_flight_card.elipses_menu($GENERATED_ALARM_FLIGHT['id']).displayed? }
  @ad_flight_card.elipses_menu($GENERATED_ALARM_FLIGHT['id']).click
  @wait.until { @ad_common.manual_escalation_btn.displayed? }
  @ad_common.manual_escalation_btn.click
end
When(/^AC: User open the alarm ellipsis menu$/) do
  @wait.until { @ad_flight_card.elipses_menu($GENERATED_ALARM_FLIGHT['id']).displayed? }
  @ad_flight_card.elipses_menu($GENERATED_ALARM_FLIGHT['id']).click
  sleep 0.5
end
When(/^AC: User verifies that "(.*)" menu is (not present|present)$/) do |menu_text, action|
  button_element=@common.find_element_no_wait(@selenium,@selenium, :xpath, ".//div[@data-testid='ellipsis-menu-item' and .='"+menu_text+"']")
  expect(button_element.displayed?).to be  !action.include?("not")
end
def verify_flight_record(flight_plan_element, expected_attributes)
  expected_attributes.each do |k, v|
    actual_value_element = flight_plan_element.find_element(:css, "[data-testid='#{k}']")
    actual_value = actual_value_element.text
    v = process_param(v.to_s)
    case v
    when /.*matches:.*/
      expect(actual_value.to_s).to(match(v.gsub('matches:', '')),
                                   "Flight attribute [#{k}] value is not proper. Actual [#{actual_value}] expected matches: [#{v}]")
    when /.*(true|false).*/
      bool_value = actual_value_element.find_element(:css, 'img').attribute('alt')
      if v.include? 'true'
        expect(bool_value).to eq('checked'),
                              "Flight attribute [#{k}] is not proper. Actual [#{bool_value}] expected [#{v}]"
      else
        expect(bool_value).to eq('unchecked'),
                              "Flight attribute [#{k}] is not proper. Actual [#{bool_value}] expected [#{v}]"
      end
    when /(High|Medium|Low)/
      severity_title = actual_value_element.attribute('alt').to_s
      expect(severity_title).to include(v.to_s.downcase),
                                "Flight attribute [#{k}] value is not proper. Actual [#{severity_title}] expected [#{v}]"
    when /.*destination:.*/
      destination = actual_value_element.find_element(:css, "[data-testid='flight-destinations']").text
      expect(destination.to_s.downcase).to include(v.gsub!('destination:', '').to_s.downcase),
                                           "Flight attribute [#{k}] value is not proper. Actual [#{destination}] expected to include [#{v}]"
    else
      expect(actual_value.to_s.strip.downcase).to(eq(v.to_s.downcase),
                                                  "Flight attribute [#{k}] value is not proper. Actual [#{actual_value}] expected [#{v}]")
    end
  end
end
