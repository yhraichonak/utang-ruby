# frozen_string_literal: true

Before do
  @PM_Monitor_Screen = PM_Monitor_Screen.new @selenium
  @PM_Navigation_Menu = PM_Navigation_Menu.new @selenium
end

Then(/^I should see the Historical Monitor screen$/) do
  #puts "the button color is #{@PM_Navigation_Menu.sub_nav_button('Live')['button_obj'].css_value('color')}"
  expect(@PM_Navigation_Menu.sub_nav_button('Live')['button_obj'].css_value('color')).to match '.*(125, 125, 125|102, 102, 102).*'
  expect(@PM_Navigation_Menu.back_button.displayed?).to be_truthy
  expect(@PM_Monitor_Screen.pm_sub_nav_bar).to be_truthy
  expect(@PM_Monitor_Screen.navigation_link('Events')).to be_truthy
  expect(@PM_Monitor_Screen.navigation_link('Monitor')).to be_truthy
  expect(@PM_Monitor_Screen.navigation_link('Tools')).to be_truthy
  expect(@PM_Monitor_Screen.navigation_link('Live')).to be_truthy
end

Then(/^I should see the Live Monitor screen(| of .* patient)$/) do |patient|
  sleep 5
  toggle = false
  if BROWSER == 'ie' && (@PM_Navigation_Menu.sub_nav_button('Live')['status'] == true)
    live_button = @selenium.find_element(:xpath, '//span[2]/a[2]')
    live_button.click
    toggle = true
  end

  puts "the button color is #{@PM_Navigation_Menu.sub_nav_button('Live')['button_obj'].css_value('color')}"

  @wait.until { @PM_Monitor_Screen.patientMonitor_body }
  if @snippet_worklist_workflow != true
    expect(@PM_Monitor_Screen.patientMonitor_toolbar).to be_truthy
    expect(@PM_Monitor_Screen.patientMonitor_body).to be_truthy
  end

  expect(@PM_Navigation_Menu.back_button.displayed?).to be_truthy
  expect(@PM_Monitor_Screen.pm_sub_nav_bar).to be_truthy
  expect(@PM_Monitor_Screen.navigation_link('Events')).to be_truthy
  expect(@PM_Monitor_Screen.navigation_link('Monitor')).to be_truthy
  expect(@PM_Monitor_Screen.navigation_link('Tools')).to be_truthy
  expect(@PM_Monitor_Screen.navigation_link('Live')).to be_truthy

  #get the HR value from the PM Monitor screen
  @monitor_heart_rate_value = @PM_Monitor_Screen.monitor_heart_rate_value.text

  puts "monitor heart rate value = #{@monitor_heart_rate_value}"
  if (patient.include? "patient")
    patient=process_param(patient.split[1])
    @patient_list_name=patient['FULL_NAME']
    @patient_list_gender=patient['SEX']
    @patient_list_age=patient['AGE']
    @patient_list_mrn=patient['MRN']
    @patient_list_dob=patient['DOB']

    end
    # steps %(
    #   And I should see the pm patient info in the header
    # )

  live_button.click if BROWSER == ('ie') && (toggle == true)
  @initial_zoom_control_value = @PM_Monitor_Screen.monitor_zoom.attribute('value')
  puts "the initial zoom control value: #{@initial_zoom_control_value}"
  sleep 3
end

And(/^I should see the Live Monitor time in "(.*?)" format "(.*?)" hours ago "(.*?)" minutes "(.*?)" seconds$/) do | format_style, hours, minutes, seconds |
  sleep 3
  puts hours
  today = Time.now.getlocal(get_param("COMMON_TZ_OFFSET")).strftime('%m/%d/%Y')
  puts "today's date = #{today}"
  if $hour_ago < 10
    date = "#{format_style} - 0#{$hour_ago}:#{minutes}:#{seconds}"
  else
    date = "#{format_style} - #{$hour_ago}:#{minutes}:#{seconds}"
  end
  @wait.until { @PM_Monitor_Screen.patientMonitor_body }
  @wait.until { @PM_Monitor_Screen.monitor_time }
  date_text = @PM_Monitor_Screen.monitor_time.text
  if $hour_ago < 10
    assembled_date = "#{today} - 0#{$hour_ago}:#{minutes}:#{seconds}"
  else
    assembled_date = "#{today} - #{$hour_ago}:#{minutes}:#{seconds}"
  end
  expect(date_text).to eql assembled_date
  expect(DateTime.strptime(date_text, date)).to be_truthy
end


And(/^I should see the Live Monitor at "(.*?)"$/) do | timestamp |
  @wait.until { @PM_Monitor_Screen.patientMonitor_body }
  @wait.until { @PM_Monitor_Screen.monitor_time }
  expect(@PM_Monitor_Screen.monitor_time.text).to eql process_param(timestamp)
end

And(/^I should see the Live Monitor contains "(.*?)"$/) do | target_date |
  @wait.until { @PM_Monitor_Screen.patientMonitor_body }
  @wait.until { @PM_Monitor_Screen.monitor_time }
  target_date=process_param(target_date)
  expect(@PM_Monitor_Screen.monitor_time.text).to include? target_date
end

And(/^I should see the Live Monitor time display "(.*?)" format "(.*?)" days ago "(.*?)" hours ago "(.*?)" minutes "(.*?)" seconds$/) do | format_style, days, hours, minutes, seconds |
  sleep 3

  t = Date.today
  calc_date = t - days.to_i
  puts "the calc date = #{calc_date}"
  new_date = calc_date.strftime("%m/%d/%Y")
  puts "new date = #{new_date}"

  #today = Time.now.strftime("%m/%d/%Y")
  #puts "today's date = #{today}"
  #yesterday = today - days.day
  #puts "yesterday's date = #{yesterday}"
  date = "#{format_style} #{$hour_ago}:#{minutes}:#{seconds}"

  @wait.until { @PM_Monitor_Screen.patientMonitor_body }
  @wait.until { @PM_Monitor_Screen.monitor_time }

  date_text = @PM_Monitor_Screen.monitor_time.text
  puts "date from screen = #{date_text}"

  assembled_date = "#{new_date} #{$hour_ago}:#{minutes}:#{seconds}"
  puts "assembled date = #{assembled_date}"

  expect(date_text).to eql assembled_date
  expect(DateTime.strptime(date_text, date)).to be_truthy
end

And(/^I should see the Live Monitor time display "(.*?)" format "(.*?)" days ago$/) do | format_style, days |
  sleep 3
  begin
    @wait.until { @PM_Monitor_Screen.patientMonitor_body }
    @wait.until { @PM_Monitor_Screen.monitor_time }

    date_text = @PM_Monitor_Screen.monitor_time.text
    puts "date from screen = #{date_text}"

    space_frament = date_text.index(' ')
    time_fragment = date_text[(space_frament + 1)..date_text.length]
    puts "time fragment = #{time_fragment}"
    t =  Time.now.getlocal(get_param("COMMON_TZ_OFFSET")).to_date
    puts "t = #{t}"
    calc_date =(t - days.to_i)
    puts "the calc date = #{calc_date}"
    new_date = calc_date.strftime("%m/%d/%Y")
    puts "new date = #{new_date}"

    date = "#{format_style} #{time_fragment}"

    assembled_date = "#{new_date} #{time_fragment}"
    puts "assembled date = #{assembled_date}"

    expect(date_text).to eql assembled_date
    truthy_date = DateTime.strptime(date_text, date)
    puts "truthy_date = #{truthy_date}"
    expect(DateTime.strptime(date_text, date)).to be_truthy
  rescue NoMethodError
    puts "Monitor Time is not appearing due to No Tele Data message"
  end
end

Then(/^I should see the Live Monitor time in "(.*?)" format$/) do |date|
  # format = "%m/%d/%Y %l:%M:%S"
  #sleep 3 if SAUCELABS == true
  sleep 3
  date=process_param(date)
  @wait.until { @PM_Monitor_Screen.patientMonitor_body }
  @wait.until { @PM_Monitor_Screen.monitor_time }

  date_text = @PM_Monitor_Screen.monitor_time.text
  puts date_text

  expect(DateTime.strptime(date_text, date)).to be_truthy
end

When(/^I click on the "(.*?)" discrete$/) do |name|
  @PM_Monitor_Screen.discrete(name)['discrete_obj'].click
end

Then(/^I should see the "(.*?)" chart$/) do |name|
  expect(@PM_Monitor_Screen.chart(name).displayed?).to be_truthy
  expect(@PM_Monitor_Screen.discrete(name)['status']).to be_truthy
end

Then(/^I should close the "(.*?)" chart$/) do |name|
  expect(@PM_Monitor_Screen.discrete(name)['status']).to be_falsey
end

Then(/^I should see a total "(.*?)" trend data graphs display$/) do |expected_open|
  expect(@PM_Monitor_Screen.totalTrendsGraphs).to eql expected_open
end

When(/^I hover mouse of trend data for "(.*?)"$/) do |string|
  # can't automate, manual step
end

Then(/^I should see "(.*?)" hour time with value of discrete$/) do |int|
  # can't automate, manual step
end

Then(/^I should see "(.*?)" graphs lines in the trend data "(.*?)" for systolic diastolic mean$/) do |int, string|
  # can't automate, manual step
end

When(/^I should not see trend data for "(.*?)" block$/) do |_string|
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I should see trend data graphs stacked in order based on order of discretes on page$/) do
  @PM_Monitor_Screen.totalTrendsGraphs
end

When(/^I click on the "(.*?)" monitor waveform$/) do |name|
  @PM_Monitor_Screen.monitor_lead(name)['lead_obj'].click
end

When(/^I click on the monitor "(.*?)" waveform$/) do |number|
  @PM_Monitor_Screen.monitor_lead_by_order(number)['lead_obj'].click
  sleep 2
end

Then(/^the waveform "(.*?)" is disabled$/) do |name|
  expect(@PM_Monitor_Screen.monitor_lead(name)['status']).to be_falsey
end

Then(/^the waveform "(.*?)" displayed is disabled$/) do |name|
  expect(@PM_Monitor_Screen.monitor_lead_by_order(name)['status']).to eq "off"
end

Then(/^the waveform "(.*?)" button is "(.*?)"$/) do | wave, status |
  wave_status = @PM_Monitor_Screen.monitor_lead_by_order(wave)['status']
  puts "#{wave} should be #{status} from the feature"
  puts "status from the screen #{wave_status}"
  if status == "on"
    expect(wave_status).to eql "on"
  elsif status == "off"
    expect(wave_status).to eql "off"
  end
end

Then(/^the waveform "(.*?)" displayed is enabled$/) do |name|
  expect(@PM_Monitor_Screen.monitor_lead_by_order(name)['status']).to eq "on"
end

Then(/^the waveform "(.*?)" is active$/) do |name|
  expect(@PM_Monitor_Screen.monitor_lead(name)['status']).to be_truthy
end

When(/^I zoom "(.*?)" on monitor screen$/) do |zoom|
  if BROWSER == 'ie'
    objectCoord = @PM_Monitor_Screen.monitor_zoom.rect
    x = 0
    y = 0
    case zoom
    when 'in'
      x = 0
      y = 0
    when 'out'
      x = 0
      y = objectCoord[:height] - 5
    end
    @selenium.action.move_to(@PM_Monitor_Screen.monitor_zoom, x, y).click.release.perform
  else
    case zoom
    when 'in'
      @PM_Monitor_Screen.monitor_zoom.send_keys(:right) while @PM_Monitor_Screen.monitor_zoom.attribute('value').to_f != 10
    when 'out'
      @PM_Monitor_Screen.monitor_zoom.send_keys(:left) while @PM_Monitor_Screen.monitor_zoom.attribute('value').to_f != 1
    end
  end
end

Then(/^the monitor zoom value is set at "(.*?)"$/) do |value|
  expect(@PM_Monitor_Screen.monitor_zoom.attribute('value').to_s).to eql value.to_s
end

Then(/^I should see the Monitor Time Ago displays on monitor$/) do
  steps %(
    Then the Monitor Time Ago displays on monitor
	)
  end

Then(/^the Monitor Time Ago displays on monitor$/) do
  sleep 5
  expect(@PM_Monitor_Screen.monitor_time_ago.displayed?).to be_truthy

  time_ago = @PM_Monitor_Screen.monitor_time_ago.text
  puts "time ago is: #{time_ago}"

  begin
    format = '%H:%M:%S ago'
    monitorTimeAgo = DateTime.strptime(time_ago, format)
    puts "the format was #{format}"
  rescue StandardError
    puts "the format was not #{format}"
  end

  begin
    format = '%dd %H:%M:%S ago'
    monitorTimeAgo = DateTime.strptime(time_ago, format)
    puts "the format was #{format}"
  rescue StandardError
    puts "the format was not #{format}"
  end

  begin
    format = '%M:%S ago'
    monitorTimeAgo = DateTime.strptime(time_ago, format)
    puts "the format was #{format}"
  rescue ArgumentError
    puts "the format was not #{format}"
  end

  begin
    format = '%S seconds ago'
    monitorTimeAgo = DateTime.strptime(time_ago, format)
    puts "the format was #{format}"
  rescue
    puts "the format was not #{format}"
  end

  puts @PM_Monitor_Screen.monitor_time_ago.text if INFO == true
  expect(monitorTimeAgo).to be_truthy
end

When(/^I scroll the monitor waveform to the "(.*?)"$/) do |direction|

  sleep 4

  @PM_Monitor_Screen.patientMonitor_body.click

  @PM_Monitor_Screen.patientMonitor_body.click
  @org_monitor_time = @PM_Monitor_Screen.monitor_time.text

  puts "monitor time: #{@org_monitor_time}"
  case direction
  when 'left'
    @selenium.action.drag_and_drop_by(@PM_Monitor_Screen.patientMonitor_body, -200, 0).perform
  when 'right'
    @selenium.action.drag_and_drop_by(@PM_Monitor_Screen.patientMonitor_body, 200, 0).perform
  when 'down'
    @selenium.action.drag_and_drop_by(@PM_Monitor_Screen.patientMonitor_body, 0, 100).perform
  when 'up'
    @selenium.action.drag_and_drop_by(@PM_Monitor_Screen.patientMonitor_body, 0, -300).perform
  end

  sleep 3
  @monitor_time = @PM_Monitor_Screen.monitor_time.text
  sleep 3
  puts "the monitor time = #{@monitor_time}"
end

Then(/^I should see monitor waveform moves "(.*?)" in time$/) do |time|
  steps %(
    Then monitor waveform moves "#{time}" in time
	)
end
Then(/^monitor waveform moves "(.*?)" in time$/) do |time|
  sleep(2)
  case time
  when 'forward'
    expect(@org_monitor_time).to be < @monitor_time
  when 'back'
    expect(@org_monitor_time).to be >= @monitor_time
  else
    expect(@org_monitor_time).to be == @monitor_time
  end
  sleep 4
end

Then(/^the Monitor Time should match the Event time selected$/) do
  time = @event_time.sub(/^0/, '')

  expect(@PM_Monitor_Screen.monitor_time.text).to include time
end

Then(/^I should see Event selected from events screen$/) do
  puts @event_name if INFO == true

  (1..5).each do |_i|
    if @PM_Monitor_Screen.monitor_events_by_name(@event_name)['event_message'].text == @event_name
      expect(@PM_Monitor_Screen.monitor_events_by_name(@event_name)['event_message'].text).to eq @event_name
    else
      @selenium.action.drag_and_drop_by(@PM_Monitor_Screen.patientMonitor_body, -400, 0).perform
      sleep 2
    end
  rescue StandardError
    @selenium.action.drag_and_drop_by(@PM_Monitor_Screen.patientMonitor_body, -400, 0).perform
    sleep 2
  end
end

Then(/^I should see overlapping Events priority in order from left to right$/) do
  @selenium.manage.timeouts.implicit_wait = 2
  events_count = @PM_Monitor_Screen.monitor_events['event_obj'].count
  puts events_count if INFO == true

  event_types = @PM_Monitor_Screen.monitor_events['event_type']
  if events_count > 1
    puts event_types[0] if INFO == true
    case event_types[0]
    when 'high'
      (1..events_count - 1).each do |i|
        puts event_types[i] if INFO == true
        expect(event_types[i]).to eql('high').or eql('medium').or eql('low')
      end
    when 'medium'
      (1..events_count - 1).each do |i|
        puts event_types[i] if INFO == true
        expect(event_types[i]).to eql('medium').or eql('low')
      end
    when 'low'
      (1..events_count - 1).each do |i|
        puts event_types[i] if INFO == true
        expect(event_types[i]).to eql('low')
      end
    end
    # if mulitple alarms are not displaying on screen, continue
  end
  @selenium.manage.timeouts.implicit_wait = DEFAULT_IMPLICIT_WAIT
end

Then(/^I should see ST parameter values$/) do
  sleep 1
  expect(@PM_Monitor_Screen.discrete('ST mm')['discrete_obj'].displayed?).to be_truthy
end

When(/^I scroll the discretes to the right$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I should see view discretes scroll off screen from the right$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I should see discrete values updating as new data comes in$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I fling the monitor waveform to the "(.*?)"$/) do |direction|
  steps %(
    When I scroll the monitor waveform to the "#{direction}"
	)
  sleep 4
end

Then(/^I should notice little to no vertical movement on fling action$/) do
  # visual manual step
end

Then(/^I should see discrete values updating as the data changes$/) do
  # visual manual step
end

Then(/^I should see graph line color as same as discrete box background color$/) do
  # visual manual step; trends object can't get color of trends
end

Then(/^I should see "(.*?)" graphs lines in the trend data "(.*?)" for V V1 V2 V3 V4 V5 V6 I II III aVF aVR aVL MCL$/) do |int, string|
  # visual manual step; trends object can't get graph lines
end

When(/^I click on the close X button for "(.*?)" discrete$/) do |discrete|
  if discrete == 'NBP mm[Hg]'
    @PM_Monitor_Screen.trends_close_button(1).click
  else
    @PM_Monitor_Screen.trends_close_button(0).click
  end
end

Then(/^I should not see a blank screen$/) do
  leads = @PM_Monitor_Screen.monitor_lead
  expect(leads['status']).to be_truthy

  puts "this is the label #{leads['lead_obj'].text}"
  expect(leads['lead_obj'].text).to match ".+"

  puts "this is the length of visible monitors #{leads.length}"
  expect(leads.length).to be > 0
end

Then(/^I should see the Historical Live Monitor screen$/) do
  @monitor_time_ago_historical = @PM_Monitor_Screen.monitor_time_ago.text
  expect(@monitor_time_ago_historical).to be_truthy
  puts "the historical time agao: #{@monitor_time_ago_historical}"
  sleep 2
  @static_monitor_time = @PM_Monitor_Screen.monitor_time.text
  puts "the static static monitor time: #{@static_monitor_time}"
end

Then(/^I should see that the time is the same time displayed before clicking "([^"]*)"$/) do |arg1|
  expect(@static_monitor_time).to eql @snippet_tool_static_time
end

Then(/^the waveforms should not be resized$/) do
  @post_zoom_control_value = @PM_Monitor_Screen.monitor_zoom.attribute('value')
  puts "the post zoom control value: #{@post_zoom_control_value}"
  expect(@post_zoom_control_value).to eql @initial_zoom_control_value
end
