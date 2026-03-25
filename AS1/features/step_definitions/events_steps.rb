# frozen_string_literal: true

Before do
  @PatientHeader_Bar = PatientHeader_Bar.new @selenium
  @PatientEvents_Screen = PatientEvents_Screen.new @selenium
  @PM_Navigation_Menu = PM_Navigation_Menu.new @selenium
end

Then(/^I should see the Events screen$/) do
  # sleep(2)
  @selenium.manage.timeouts.implicit_wait = DEFAULT_EXPLICIT_WAIT
  @wait.until { @PatientEvents_Screen.patientEvents_view }
  @PatientEvents_Screen.patientEvents_view.displayed?.should eql true
  @wait.until { @PatientEvents_Screen.event_section('Last Hour') }
  expect(@PM_Navigation_Menu.back_button.displayed?).to be_truthy
  expect(@PatientEvents_Screen.event_section('Last Hour').displayed?).to be_truthy
  expect(@PatientEvents_Screen.event_section('1–6 Hours Ago').displayed?).to be_truthy
  expect(@PatientEvents_Screen.event_section('More than 6 Hours Ago').displayed?).to be_truthy

  steps %(
    And I should see the pm patient info in the header
	)
  sleep 3
  $events_header_obj = @PatientEvents_Screen.events_header_objects
end

And(/^I should see the date display in the more than six hours ago section$/) do
  more_than_six_event_count = @PatientEvents_Screen.more_than_six_event_count
  if more_than_six_event_count > 0
    expect(@PatientEvents_Screen.more_than_six_date).to be_truthy
  end
end

And(/^I should see the "(.*?)" header on the event screen$/) do | section |
  case section
  when 'last hour' 
    expect($events_header_obj['last_hour_title']).to be_truthy
    expect($events_header_obj['last_hour_title'].text).to include 'Last Hour'
  when 'one to six'
    expect($events_header_obj['one_to_six_title']).to be_truthy
    expect($events_header_obj['one_to_six_title'].text).to include '1–6 Hours Ago'
  when 'more than six'
    expect($events_header_obj['more_than_six_title']).to be_truthy
    expect($events_header_obj['more_than_six_title'].text).to include 'More than 6 Hours Ago'
  end
end

And(/^I should see the "(.*?)" expand link on the event screen$/) do | section |
  case section
  when 'last hour' 
    expect($events_header_obj['last_hour_expand_link']).to be_truthy
    expect($events_header_obj['last_hour_expand_link'].text).to eql 'Expand'
  when 'one to six'
    expect($events_header_obj['one_to_six_link']).to be_truthy
    expect($events_header_obj['one_to_six_link'].text).to eql 'Expand'
  when 'more than six'
    expect($events_header_obj['more_than_six_link']).to be_truthy
    expect($events_header_obj['more_than_six_link'].text).to eql 'Expand'
  end
end

When(/^I click on the Monitor button$/) do
  # sleep(3)
  @PM_Navigation_Menu.sub_nav_button('Monitor')['button_obj'].click
end

Then(/^I should see the Events, Monitor, Tools, Select Time, Live links$/) do
  expect(@PM_Navigation_Menu.sub_nav_button('Events')['button_obj'].displayed?).to be_truthy
  expect(@PM_Navigation_Menu.sub_nav_button('Monitor')['button_obj'].displayed?).to be_truthy
  expect(@PM_Navigation_Menu.sub_nav_button('Tools')['button_obj'].displayed?).to be_truthy
  expect(@PM_Navigation_Menu.sub_nav_button('Select Time')['button_obj'].displayed?).to be_truthy
  expect(@PM_Navigation_Menu.sub_nav_button('Live')['button_obj'].displayed?).to be_truthy
end

When(/^I click on the Event in section "(.*?)" and name "(.*?)"$/) do |section, name|
  @PatientEvents_Screen.patientEvent(section, name)['event_obj'].click
end

When(/^I click Expand link under "(.*?)" section$/) do |section|
  @PatientEvents_Screen.expand_collapse_link(section)['link_obj'].click
end

When(/^I click the expand link for the "(.*?)" section$/) do |section|
  events_count = 0
  case section
  when 'last hour'
    events_count = @PatientEvents_Screen.last_hour_event_count
    if events_count > 0
      expect($events_header_obj['last_hour_expand_link']).to be_truthy
      $events_header_obj['last_hour_expand_link'].click
      sleep 4
      $last_hour_events_obj = @PatientEvents_Screen.last_hour_event_object
    end
  when 'one to six'
    events_count = @PatientEvents_Screen.one_to_six_event_count
    if events_count > 0
      expect($events_header_obj['one_to_six_link']).to be_truthy
      $events_header_obj['one_to_six_link'].click
      sleep 4
      $one_to_six_hours_events_obj = @PatientEvents_Screen.one_to_six_hours_event_object
    end
  when 'more than six' 
    events_count = @PatientEvents_Screen.more_than_six_event_count
    if events_count > 0
      expect($events_header_obj['more_than_six_link']).to be_truthy
      $events_header_obj['more_than_six_link'].click
      sleep 4
      $more_than_six_hours_events_obj = @PatientEvents_Screen.more_than_six_hours_events_object
    end
  end
end

And(/^I should see the event title and time stamp with format "(.*?)" in the "(.*?)" section$/) do | date_format, section |
  events_count = 0

  case section
  when 'last hour'
    events_count = @PatientEvents_Screen.last_hour_event_count
    if events_count > 0
      event_info = $last_hour_events_obj['events_info']
    end
  when 'one to six'
    events_count = @PatientEvents_Screen.one_to_six_event_count
    if events_count > 0
      event_info = $one_to_six_hours_events_obj['events_info']
    end
  when 'more than six'
    events_count = @PatientEvents_Screen.more_than_six_event_count
    if events_count > 0
      event_info = $more_than_six_hours_events_obj['events_info']
    end
  end

  if events_count > 0
    for i in 0..(event_info.count - 1)
      expect(event_info[i][0].text).to be_truthy

      if event_info[i][1].text == ""
        puts "the value is empty"
      else
        expect(DateTime.strptime(event_info[i][1].text, date_format)).to be_truthy
      end
    end
  else
    puts "no events displayed"
  end
end

And(/^the time stamp with format "(.*?)" be sorted descending in the "(.*?)" section$/) do | date_format, section |
  events_count = 0

  case section
  when 'last hour'
    events_count = @PatientEvents_Screen.last_hour_event_count
    if events_count > 0
      event_info = $last_hour_events_obj['events_info']
    end
  when 'one to six'
    events_count = @PatientEvents_Screen.one_to_six_event_count
    if events_count > 0
      event_info = $one_to_six_hours_events_obj['events_info']
    end
  when 'more than six'
    events_count = @PatientEvents_Screen.more_than_six_event_count
    if events_count > 0
      event_info = $more_than_six_hours_events_obj['events_info']
    end
  end

  #for i in 0..(event_info.count - 1)
  #  puts "#{i} = #{DateTime.strptime(event_info[i][1].text, date_format)}"
  #end

  if events_count > 0
    for i in 0..(event_info.count - 1)

      expect(event_info[i][0].text).to be_truthy
      if i < ( event_info.count - 2 )
        if event_info[i][1].text == ""
          puts "the value is empty"
        else
          if event_info[i + 1][1].text == "" 
            puts "value + 1 is empty"
          else     
            puts "#{DateTime.strptime(event_info[i][1].text, date_format)} #{DateTime.strptime(event_info[i + 1][1].text, date_format)}"
            expect(DateTime.strptime(event_info[i][1].text, date_format)).to be > DateTime.strptime(event_info[i + 1][1].text, date_format)
          end
        end
      end
    end
  else
    puts "no events displayed"
  end
end

And(/^I should see the event discretes HR PVC RR in the "(.*?)" section$/) do | section |
  events_count = 0

  case section
  when 'last hour'
    events_count = @PatientEvents_Screen.last_hour_event_count
    if events_count > 0
      event_info = $last_hour_events_obj['events_info']
    end
  when 'one to six'
    events_count = @PatientEvents_Screen.one_to_six_event_count
    if events_count > 0
      event_info = $one_to_six_hours_events_obj['events_info']
    end
  when 'more than six'
    events_count = @PatientEvents_Screen.more_than_six_event_count
    if events_count > 0
      event_info = $more_than_six_hours_events_obj['events_info']
    end
  end

  if events_count > 0
    for i in 0..(event_info.count - 1)
      expect(event_info[i][2].text).to eql 'HR'
      expect(event_info[i][3].text).to be_truthy
      expect(event_info[i][4].text).to eql 'PVC'
      expect(event_info[i][5].text).to be_truthy
    end
  else
    puts "no events displayed"
  end
end

When(/^I should see the discrete data for events for "(.*?)" section$/) do |section|
  expect(@PatientEvents_Screen.expand_collapse_link(section)['expanded']).to be_truthy
end

When(/^I click on the "(.*?)" event in "(.*?)" section$/) do | which, section |
  events_count = 0

  case which
  when 'first'
    which_event = 0
  when 'second'
    which_event = 1
  when 'third'
    which_event = 2
  end

  case section
  when 'last hour'
    events_count = @PatientEvents_Screen.last_hour_event_count
    if events_count > 0
      events = $last_hour_events_obj['events']
      event_info = $last_hour_events_obj['events_info']
    end
  when 'one to six'
    events_count = @PatientEvents_Screen.one_to_six_event_count
    if events_count > 0
      events = $one_to_six_hours_events_obj['events']
      event_info = $one_to_six_hours_events_obj['events_info']
    end
  when 'more than six'
    events_count = @PatientEvents_Screen.more_than_six_event_count
    if events_count > 0
      events = $more_than_six_hours_events_obj['events']
      event_info = $more_than_six_hours_events_obj['events_info']
    end
  end

  events[which_event].click
  
  event_message = event_info[which_event][0]
  event_time = event_info[which_event][1]
  hr_discrete_value = event_info[which_event][3]
  pvc_discrete_value = event_info[which_event][5]
  rr_discrete_value = event_info[which_event][7]



end

When(/^I click on the first Event in event section$/) do
  @event_name =  @PatientEvents_Screen.firstEvent['event_name'].text
  @event_time =  @PatientEvents_Screen.firstEvent['time'].text

  if INFO == true
    puts @event_name
    puts @event_time
  end

  @PatientEvents_Screen.firstEvent['event_obj'].click
rescue StandardError
  pending 'No events to select for patient'
end

Then(/^I should see date grouping, with leading zeroes, one header per day for events "(.*?)"h in the past$/) do |_int|
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^the Date Headers should remain at top until replaced by next Date Headers being sticky when scrolling$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I scroll the events More than "(.*?)" Hours Ago "(.*?)"$/) do |_int, _string|
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I should see that Event column scroll down$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I should see that Event column scroll up$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I scroll the events More than (\d+) Hours Ago "([^"]*)"$/) do |arg1, arg2|
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I should see the Events screen displayed$/) do
  @selenium.manage.timeouts.implicit_wait = DEFAULT_EXPLICIT_WAIT
  @wait.until { @PatientEvents_Screen.patientEvents_view }
  @PatientEvents_Screen.patientEvents_view.displayed?.should eql true
  @wait.until { @PatientEvents_Screen.event_section('Last Hour') }
  expect(@PM_Navigation_Menu.back_button.displayed?).to be_truthy
  expect(@PatientEvents_Screen.event_section('Last Hour').displayed?).to be_truthy
  expect(@PatientEvents_Screen.event_section('1–6 Hours Ago').displayed?).to be_truthy
  expect(@PatientEvents_Screen.event_section('More than 6 Hours Ago').displayed?).to be_truthy

  $events_header_obj = @PatientEvents_Screen.events_header_objects
end