Before do
  @ACWA_Tools_Screen = ACWA_Tools_Screen.new @selenium
end

Then(/^I should see the acwa tools screen$/) do
  @wait.until { @ACWA_Tools_Screen.acwa_tools_chart_container.displayed? == true }
end

When(/^I hover over "(.*?)" button on the acwa tools screen$/) do |button_name|
  case button_name
  when 'measure'
    button_obj = @ACWA_Tools_Screen.measure_button
    @selenium.action.move_to(button_obj['button']).perform
    sleep 2
    expect(button_obj['tooltip'].text).to eql 'Measure'
  when 'calipers'
    button_obj = @ACWA_Tools_Screen.calipers_button
    @selenium.action.move_to(button_obj['button']).perform
    sleep 2
    expect(button_obj['tooltip'].text).to eql 'Calipers'
  when 'pvc'
    button_obj = @ACWA_Tools_Screen.pvc_button
    @selenium.action.move_to(button_obj['button']).perform
    sleep 2
    expect(button_obj['tooltip'].text).to eql 'PVC'
  when 'march out'
    button_obj = @ACWA_Tools_Screen.march_out_button
    @selenium.action.move_to(button_obj['button']).perform
    sleep 2
    expect(button_obj['tooltip'].text).to eql 'March out'
  when 'paper mode'
    button_obj = @ACWA_Tools_Screen.papermode_button
    @selenium.action.move_to(button_obj['button']).perform
    sleep 2
    expect(button_obj['tooltip'].text).to eql 'Paper mode'
  end
end

When(/^I click the "(.*?)" button on the acwa tools screen$/) do |button_name|
  @wait.until { @ACWA_Tools_Screen.acwa_tools_chart_container.displayed? == true }
  case button_name
  when 'measure'
    button_obj = @ACWA_Tools_Screen.measure_button
    button_obj['button'].click 
    sleep 3
  when 'calipers'
    button_obj = @ACWA_Tools_Screen.calipers_button
    button_obj['button'].click
  when 'pvc'
    button_obj = @ACWA_Tools_Screen.pvc_button
    button_obj['button'].click
  when 'march out'
    button_obj = @ACWA_Tools_Screen.march_out_button
    button_obj['button'].click
  when 'paper mode'
    button_obj = @ACWA_Tools_Screen.papermode_button
    button_obj['button'].click
  end 
end

Then(/^I should see P QR QR Complex S and T calipers display on the acwa tools screen$/) do
  @wait.until { @ACWA_Tools_Screen.chart_body_info_lead_one['p_caliper'].displayed? == true }
  @wait.until { @ACWA_Tools_Screen.chart_body_info_lead_two['p_caliper'].displayed? == true }

  @wait.until { @ACWA_Tools_Screen.chart_body_info_lead_one['qr_caliper'].displayed? == true }
  @wait.until { @ACWA_Tools_Screen.chart_body_info_lead_two['qr_caliper'].displayed? == true }

  @wait.until { @ACWA_Tools_Screen.chart_body_info_lead_one['qrs_complex'].displayed? == true }
  @wait.until { @ACWA_Tools_Screen.chart_body_info_lead_two['qrs_complex'].displayed? == true }

  @wait.until { @ACWA_Tools_Screen.chart_body_info_lead_one['s_caliper'].displayed? == true }
  @wait.until { @ACWA_Tools_Screen.chart_body_info_lead_two['s_caliper'].displayed? == true }

  @wait.until { @ACWA_Tools_Screen.chart_body_info_lead_one['t_caliper'].displayed? == true }
  @wait.until { @ACWA_Tools_Screen.chart_body_info_lead_two['t_caliper'].displayed? == true }
end

When(/^I click the Create Frat Record button on the acwa tools screen$/) do 
  @wait.until { @ACWA_Tools_Screen.frat_controls_object['create_frat_record_button'].displayed? == true }
  obj = @ACWA_Tools_Screen.frat_controls_object['create_frat_record_button']
  obj.click
  sleep 2
end

Then(/^I should see the "(.*?)" screen$/) do | message |
  @wait.until { @ACWA_Tools_Screen.record_created_window_object['header'].displayed? == true }
  sleep 3
  window_obj = @ACWA_Tools_Screen.record_created_window_object
  expect(window_obj['message'].text).to eql message
end

When(/^I click the close button on the New Frat Record created screen$/) do 
  @wait.until { @ACWA_Tools_Screen.record_created_window_object['header'].displayed? == true }
  window_obj = @ACWA_Tools_Screen.record_created_window_object
  expect(window_obj['close_button'].text).to eql 'Close'
  window_obj['close_button'].click
  sleep 5
end

And(/^I wait for the "(.*?)" seconds on the screen$/) do |seconds|
  sleep seconds.to_i
end

When(/^I select the "(.*?)" dropdown on the acwa tools screen$/) do |which_drop_down|
  case which_drop_down
  when 'First Lead'
    dropdown_name =  'first_lead_indicator'
  when 'Second Lead'
    dropdown_name =  'second_lead_indicator'
  when 'Event Description'
    dropdown_name =  'event_description_indicator'
  end

  @ACWA_Tools_Screen.controls_dropdown_object[dropdown_name].click
end

When(/^I select the Event Description dropdown on the acwa tools screen$/) do 
  @ACWA_Tools_Screen.controls_dropdown_object['event_description_indicator'].click
end

Then(/^I should see "(.*?)" in the event description list$/) do |event|
  expect(@ACWA_Tools_Screen.event_description_list_box(event).displayed?).to be_truthy
end

And(/^I select "(.*?)" in list of event descriptions$/) do |event|
  @ACWA_Tools_Screen.event_description_list_box(event).click
end

And(/^I select "(.*?)" in list of ecg lead one$/) do |event|
  @ACWA_Tools_Screen.lead_one_list_box(event).click
end

And(/^I select "(.*?)" in list of ecg lead two$/) do |event|
  @ACWA_Tools_Screen.lead_two_list_box(event).click
end

