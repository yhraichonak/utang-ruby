Before do
  @PM_Monitor_screen = PM_Monitor_screen.new selenium, appium
  @PM_Events_screen = PM_Events_screen.new selenium, appium
  @ECG_View_screen = ECG_View_screen.new selenium, appium
  @Patient_Summary_screen = Patient_Summary_screen.new selenium, appium
  @PM_Snippet = PM_Snippet.new selenium, appium
  @Menu = Menu.new selenium, appium
  @Time_Chooser = Time_Chooser.new selenium, appium
  @PM_Trend_screen = PM_Trend_screen.new selenium, appium
  @selenium = selenium
end

Then(/^I should see the Patient Monitoring screen$/) do
  for i in 0..5
    sleep 1
  begin
    @PM_Events_screen.live_monitor_button.exists.should be true
  rescue
    i
  end
  end
end

Then(/^I should see the HOME screen's demographics grid$/) do
  sleep(1)
  wait_for(10) { @Patient_Summary_screen.demographics_grid.exists == true }
end

Then(/^I should see the HOME button selected$/) do
  expect(@PM_Monitor_screen.navbar_home_element.attribute('selected') == true)
end

Then(/^I should see the EVENTS screen's events list$/) do
  sleep(1)
  wait_for(10) { @PM_Events_screen.events_list.exists == true }
end

Then(/^I should see the EVENTS button selected$/) do
  expect(@PM_Monitor_screen.navbar_events_element.attribute('selected') == true)
end

Then(/^I should see the MONITOR screen's Live button$/) do
  sleep(1)
  wait_for(10) { @PM_Monitor_screen.control_live_element.exists == true }
end

Then(/^I should see the MONITOR button selected$/) do
  expect(@PM_Monitor_screen.navbar_monitor_element.attribute('selected') == true)
end

Then(/^I should see the TOOLS screen's "Jump To" button$/) do
  sleep(1)
  wait_for(10) { @PM_Snippet.tool_jump_to_element.exists }
end

Then(/^I should see the TOOLS button selected$/) do
  expect(@PM_Monitor_screen.navbar_tools_element.attribute('selected') == true)
end

Then(/^I should see the ECGs screen's cardio patient banner$/) do
  begin
    wait_for(2) { @ECG_View_screen.close_menu_button.click }
  rescue
    nil
  end
  expect(@ECG_View_screen.ecg_patient_banner.exists == true)
end

Then(/^I should see the ECGs button selected$/) do
  expect(@PM_Monitor_screen.navbar_ecgs_element.attribute('selected') == true)
end

Then(/^I should see the PM screen with events from the patient list screen$/) do
  expect(@PM_Events_screen.live_monitor_button.exists).to be true
end

Then(/^I should see the PM screen with No Events displayed$/) do
  expect(@PM_Events_screen.live_monitor_button.exists).to be true
  count = @PM_Events_screen.events_count
  expect(count).to be >= 2
end

Then(/^I should see the PM screen with events$/) do
  puts @PM_Events_screen.live_monitor_button.exists
  expect(@PM_Events_screen.live_monitor_button.exists).to be true
  expect(@PM_Monitor_screen.events_discrete.exists).to be true
end

When(/^I click on the Live Monitor button$/) do
  @PM_Events_screen.live_monitor_button.click
end

When(/^I click Cancel from the choose time screen$/) do
  @PM_Monitor_screen.choose_time_cancel.click
end

Then(/^I should see the Live Monitor screen(| of .* patient)$/) do |patient|
  # sleep(0.5)
  wait_for(4) { @PM_Monitor_screen.time_ago }
  expect(@PM_Monitor_screen.time_index.exists == true)
  expect(@PM_Monitor_screen.time_ago.text == '')
  if (patient.include? 'patient')
    patient=process_param(patient.split[1])
    @patient_list_name=patient['FULL_NAME']
    @patient_list_gender=patient['SEX']
    @patient_list_age=patient['AGE']
    @patient_list_mrn=patient['MRN']
    @patient_list_dob=patient['DOB']
  end
  @PM_Monitor_screen
end

Then(/^I should see the Events screen(| of .* patient)$/) do |patient|
  wait_for(20) { @PM_Events_screen.events_list.exists == true }
  expect(@PM_Events_screen.navigation_bar.displayed?).to be_truthy
end

Then(/^I should see the PM Events screen$/) do
  expect(@PM_Monitor_screen.events_list.exists == true)
end

Then(/^I should see the PM Events screen with no events$/) do
  expect(@PM_Monitor_screen.events_discretes.exists == false)
end

When(/^I click on the LIVE MONITOR button$/) do
  @wait.until { @PM_Monitor_screen.live_monitor_button.displayed == true }
  @PM_Monitor_screen.live_monitor_button.click
end

When(/^I click on the Events button$/) do
  @PM_Monitor_screen.navbar_events_button.click
end

When(/^I click the ECGs button$/) do
  @wait.until { @PM_Monitor_screen.navbar_ecgs_button }
  @PM_Monitor_screen.navbar_ecgs_button.click
end

When(/^I click the Home button$/) do
  # Note: Remove workaround when navigation button display issue is fixed.
  # DeviceExtensions.display_power_cycle # Workaround fix
  @Menu.summary_home_button.click
end

Then(/^I should see the LIVE MONITOR screen$/) do
  #sleep(10)
  #puts @appiumDriver.get_android_inspect
  #puts @appiumDriver.get_source
  #puts @appiumDriver.page

  $PM_WRAPPER = @PM_Monitor_screen.pm_wave_wrapper
  expect($PM_WRAPPER.exists).to be true
  $PM_WRAPPER.click
end

Then(/^I should see the MONITOR screen not LIVE$/) do
  @wait.until { @PM_Monitor_screen.pm_wave_wrapper.exists == true }
  expect(@PM_Monitor_screen.pm_wave_wrapper.exists).to be true
end

Then(/^I should see the MONITOR screen not LIVE at "(.*)" timestamp$/) do |timestamp|
  @wait.until { @PM_Monitor_screen.pm_wave_wrapper.exists == true }
  expect(@PM_Monitor_screen.pm_wave_wrapper.exists).to be true
  timestamp = process_param timestamp
  if timestamp.start_with?('contains:')
    timestamp = timestamp.gsub('contains:', '')
    expect(@PM_Monitor_screen.time_index.text).to include timestamp
  else
    expect(@PM_Monitor_screen.time_index.text.gsub("\n", ' ')).to eql timestamp
  end
end
When(/^I click on the time chooser button$/) do
  @wait.until { @PM_Monitor_screen.time_chooser_button.exists == true }
  @Menu.time_chooser_button.click
end

When(/^I click on the jump to button on the Live Monitor Screen$/) do
  @Menu.jump_to_button.click
end

Then(/^I should see the time chooser window$/) do
  expect(@Time_Chooser.ok_button.exists).to be true
  $PICKER_OBJECT = @Time_Chooser.picker_object
  $DAYS_VALUE = $PICKER_OBJECT['day_middle'].text
  $MINUTES_VALUE = $PICKER_OBJECT['minute_middle'].text
  $HOURS_VALUE = $PICKER_OBJECT['hour_middle'].text
end

And(/^I click the OK button on the time chooser window$/) do
  @Time_Chooser.ok_button.click
end

When(/^I long press on the HR discrete$/) do
  $HR_DISCRETE = @PM_Monitor_screen.hr_discrete

  $HR_TITLE = $HR_DISCRETE['title']
  $HR_VALUE = $HR_DISCRETE['value']

  puts $HR_TITLE
  puts $HR_VALUE

  obj = $HR_DISCRETE['object']

  x = obj.location[:x]
  y = obj.location[:y]

  # @selenium.action
  #          .click_and_hold(obj)
  #          .perform

  action_builder = @selenium.action
  touch = action_builder.add_pointer_input(:touch, 'finger')
  touch.create_pointer_move(duration: 0, x: x, y: y)
  touch.create_pointer_down(:left)
  touch.create_pause(2)
  touch.create_pointer_up(:left)
  action_builder.perform

  # Appium::TouchAction.new.swipe(:start_x => x, :start_y => y, :end_x => x, :end_y => y, :duration => 6000).perform
end

When(/^I long press on the training HR discrete$/) do
   #sleep(5)
  $HR_DISCRETE = @PM_Monitor_screen.training_hr_discrete

  $HR_TITLE = $HR_DISCRETE['hr_title'].attribute('text')
  $HR_VALUE = $HR_DISCRETE['hr_value'].attribute('text')

  obj = $HR_DISCRETE['hr_object']

  x = obj.location[:x]
  y = obj.location[:y]

   # @selenium.action
   #          .click_and_hold(obj)
   #          .perform

   action_builder = @selenium.action
   touch = action_builder.add_pointer_input(:touch, 'finger')
   touch.create_pointer_move(duration: 0, x: x, y: y)
   touch.create_pointer_down(:left)
   touch.create_pause(2)
   touch.create_pointer_up(:left)
   action_builder.perform

  # Appium::TouchAction.new.swipe(:start_x => x, :start_y => y, :end_x => x, :end_y => y, :duration => 3000).perform
end

When(/^I long press on the PVC discrete$/) do
  $PVC_DISCRETE = @PM_Monitor_screen.pvc_discrete
  $PVC_TITLE = $PVC_DISCRETE['title']
  $PVC_VALUE = $PVC_DISCRETE['value']
  x = $PVC_DISCRETE['object'].location.x
  y = $PVC_DISCRETE['object'].location.y

  # @selenium.action
  #          .click_and_hold($PVC_DISCRETE['object'])
  #          .perform

  action_builder = @selenium.action
  touch = action_builder.add_pointer_input(:touch, 'finger')
  touch.create_pointer_move(duration: 0, x: x, y: y)
  touch.create_pointer_down(:left)
  touch.create_pause(2)
  touch.create_pointer_up(:left)
  action_builder.perform
end

When(/^I long press on the NBP discrete$/) do
  #sleep(3)
  $NBP_DISCRETE = @PM_Monitor_screen.nbp_discrete
  $NBP_TITLE = $NBP_DISCRETE['nbp_title'].text
  $NBP_LEFT = $NBP_DISCRETE['nbp_left'].text
  $NBP_SEPARATOR = $NBP_DISCRETE['nbp_separator'].text
  $NBP_RIGHT = $NBP_DISCRETE['nbp_right'].text

  $NBP_COMBO = "#{$NBP_LEFT}#{$NBP_SEPARATOR}#{$NBP_RIGHT}"

  obj = $NBP_DISCRETE['nbp_object']

  x = obj.location[:x]
  y = obj.location[:y]

  @selenium.action
           .click_and_hold(obj)
           .perform

  # Appium::TouchAction.new.swipe(:start_x => x, :start_y => y, :end_x => x, :end_y => y, :duration => 3000).perform
end

When(/^I select a medication$/) do
  Appium::TouchAction.new.tap(:x => 200, :y => 1600, :duration => 100).perform
end

When(/^I long press on the AR1 discrete$/) do
  $AR1_DISCRETE = @PM_Monitor_screen.ar1_discrete
  $AR1_TITLE = $AR1_DISCRETE['ar1_title'].text
  $AR1_LEFT = $AR1_DISCRETE['ar1_left'].text
  $AR1_SEPARATOR = $AR1_DISCRETE['ar1_separator'].text
  $AR1_RIGHT = $AR1_DISCRETE['ar1_right'].text

  $AR1_COMBO = "#{$AR1_LEFT}#{$AR1_SEPARATOR}#{$AR1_RIGHT}"

  obj = $AR1_DISCRETE['nbp_object']

  x = obj.location[:x]
  y = obj.location[:y]

  @selenium.action
           .click_and_hold(obj)
           .perform

  # Appium::TouchAction.new.swipe(:start_x => x, :start_y => y, :end_x => x, :end_y => y, :duration => 3000).perform
end

Then(/^I should see the PM HR Trend screen$/) do
  @selenium.manage.timeouts.implicit_wait = 1
  @wait.until { @selenium.find_elements(:id, "#{APP_PACKAGE}:id/spinner").empty? }
  @selenium.manage.timeouts.implicit_wait = 1
  expect(@PM_Trend_screen.trend_graph.exists).to be true
  # hr_discrete_data = @PM_Trend_screen.hr_discrete_info
  # expect($HR_TITLE).to eq hr_discrete_data['title']
  # # Trend Graph was changed so that there is no title or value available in the element
end

Then(/^I should see the PM PVC Trend screen$/) do
  @selenium.manage.timeouts.implicit_wait = 1
  @wait.until { @selenium.find_elements(:id, "#{APP_PACKAGE}:id/spinner").empty? }
  @selenium.manage.timeouts.implicit_wait = 1
  expect(@PM_Trend_screen.trend_graph.exists).to be true
  # pvc_discrete_data = @PM_Trend_screen.pvc_discrete_info
  # expect($PVC_TITLE).to eq pvc_discrete_data['title'].text
  # Trend Graph was changed so that there is no title or value available in the element
end

Then(/^I should see the PM NBP Trend screen$/) do
  @selenium.manage.timeouts.implicit_wait = 1
  @wait.until { @selenium.find_elements(:id, "#{APP_PACKAGE}:id/spinner").empty? }
  @selenium.manage.timeouts.implicit_wait = 1
  expect(@PM_Trend_screen.trend_graph.exists).to be true
  nbp_discrete_data = @PM_Trend_screen.nbp_discrete_info
  expect($NBP_TITLE).to eq nbp_discrete_data['title'].text
  expect($NBP_LEFT).to eq nbp_discrete_data['nbp_left'].text
  expect($NBP_SEPARATOR).to eq nbp_discrete_data['nbp_separator'].text
  expect($NBP_RIGHT).to eq nbp_discrete_data['nbp_right'].text
  expect($NBP_COMBO).to eq "#{nbp_discrete_data['nbp_left'].text}#{nbp_discrete_data['nbp_separator'].text}#{nbp_discrete_data['nbp_right'].text}"
end

Then(/^I should see the PM AR1 Trend screen$/) do
  expect(@PM_Trend_screen.trend_graph.exists).to be true
  ar1_discrete_data = @PM_Trend_screen.ar1_discrete_info
  expect($AR1_TITLE).to eq ar1_discrete_data['title'].text
  expect($AR1_LEFT).to eq ar1_discrete_data['ar1_left'].text
  expect($AR1_SEPARATOR).to eq ar1_discrete_data['ar1_separator'].text
  expect($AR1_RIGHT).to eq ar1_discrete_data['ar1_right'].text
  expect($AR1_COMBO).to eq "#{ar1_discrete_data['ar1_left'].text}#{ar1_discrete_data['ar1_separator'].text}#{ar1_discrete_data['ar1_right'].text}"
end

When(/^I "(.*?)" the days by "(.*?)" days/) do |direction, days|
  $PICKER_OBJECT = @Time_Chooser.picker_object
  origin = $PICKER_OBJECT['day_middle']

  # if(direction == 'increase')
  #   (1..days.to_i).each {
  #     target = $PICKER_OBJECT['day_bottom']
  #     @selenium.action
  #              .drag_and_drop_by(target, origin.location[:x], origin.location[:y])
  #              .perform
  #     sleep 0.5
  #   }
  #
  # elsif(direction == 'decrease')
  #   (1..days.to_i).each {
  #     target = $PICKER_OBJECT['day_top']
  #     @selenium.action
  #              .drag_and_drop_by(target, origin.location[:x], origin.location[:y])
  #              .perform
  #     sleep 0.5
  #   }
  # end
  (1..days.to_i).each do |_|
    if direction == 'increase'
      target = $PICKER_OBJECT['day_top']
    else
      target = $PICKER_OBJECT['day_bottom']
    end

    action_builder = @selenium.action
    touch = action_builder.add_pointer_input(:touch, 'finger')
    touch.create_pointer_move(duration: 0, x: origin.location[:x], y: origin.location[:y])
    touch.create_pointer_down(:left)
    touch.create_pointer_move(duration: 1, x: target.location[:x], y: target.location[:y])
    touch.create_pause(0.1)
    touch.create_pointer_up(:left)
    action_builder.perform
  end

  current_val = @Time_Chooser.days_number_picker['middle'].text
  d1 = Date.strptime($DAYS_VALUE, '%m/%d/%Y')
  d2 = Date.strptime(current_val, '%m/%d/%Y')
  if d1.day.to_i == 1
    calc = d1.month.to_i - d2.month.to_i
    expect(calc.to_i).to eq days.to_i
  else
    calc = d1.day.to_i - d2.day.to_i
    expect(calc.to_i).to eq days.to_i
  end
end

When(/^I "(.*?)" the hours by "(.*?)" hours$/) do |direction, hours|
  $PICKER_OBJECT = @Time_Chooser.picker_object

  if(direction == 'increase')
    puts 'unable to increase hours into the future.......'
  elsif(direction == 'decrease')
    for i in 1..hours.to_i
      e1 = $PICKER_OBJECT['hour_bottom']
      e1_x = e1.location[:x]
      e1_y = e1.location[:y]

      e2 = $PICKER_OBJECT['hour_top']
      e2_x = e2.location[:x]
      e2_y = e2.location[:y]

      @selenium.action
               .drag_and_drop_by(e2, e1_x, e1_y)
               .perform
      # Appium::TouchAction.new.swipe(:start_x => e2_x, :start_y => e2_y, :end_x => e1_x, :end_y => e1_y, :duration => 250).perform
      sleep 2
    end
  end

  current_val = @Time_Chooser.hours_number_picker['middle'].text
  calc_hours = $HOURS_VALUE.to_i - current_val.to_i
   #expect(calc_hours).to eq hours.to_i
end

When(/^I "(.*?)" the minutes by "(.*?)" minutes/) do |direction, minutes|
  if(direction == 'increase')
    for i in 1..minutes.to_i
      e1 = $PICKER_OBJECT['minute_bottom']
      e1_x = e1.location[:x]
      e1_y = e1.location[:y]

      e2 = $PICKER_OBJECT['minute_top']
      e2_x = e2.location[:x]
      e2_y = e2.location[:y]

      @selenium.action
               .drag_and_drop_by(e1, e2_x, e2_y)
               .perform
      # Appium::TouchAction.new.swipe(:start_x => e1_x, :start_y => e1_y, :end_x => e2_x, :end_y => e2_y, :duration => 300).perform
      sleep 2
    end
  elsif(direction == 'decrease')
    for i in 1..minutes.to_i
      e1 = $PICKER_OBJECT['minute_bottom']
      e1_x = e1.location[:x]
      e1_y = e1.location[:y]

      e2 = $PICKER_OBJECT['minute_top']
      e2_x = e2.location[:x]
      e2_y = e2.location[:y]

      @selenium.action
               .drag_and_drop_by(e2, e1_x, e1_y)
               .perform
      # Appium::TouchAction.new.swipe(:start_x => e2_x, :start_y => e2_y, :end_x => e1_x, :end_y => e1_y, :duration => 300).perform
      sleep 2
    end
  end
  current_val = @Time_Chooser.minutes_number_picker['middle'].text

  if(direction == 'increase')
    calc_mins = current_val.to_i - $MINUTES_VALUE.to_i
  #expect(calc_mins).to eq minutes.to_i
  elsif(direction == 'decrease')
    calc_mins = $MINUTES_VALUE.to_i - current_val.to_i
     #expect(calc_mins).to eq minutes.to_i
  end
end

When(/^I "(.*?)" the OLD hours by "(.*?)" hours$/) do |direction, hours|
  sleep(2)
  $HOURS = @Time_Chooser.hours_number_picker

  middle_location = $HOURS['middle']
  current_value = middle_location.text

  if(direction == 'increase')
    calc_value = current_value.to_i + hours.to_i
    if value > 23
      value = calc_value - 24
    elsif calc_value < 0
      value = calc_value + 24
    end
  elsif(direction == 'decrease')
    calc_value = current_value.to_i - hours.to_i
    if calc_value < 0
      value = calc_value + 24
    elsif calc_value > 23
      value = calc_value - 24
    end
  end
    #puts "the current value is #{current_value}"
    #puts "the calculated value = #{calc_value}"
    #puts "the value after = #{value}"

    middle_location.send_keys([:control, 'a'], :backspace)
    middle_location.send_keys(value)

    #puts "post entry #{@Time_Chooser.hours_number_picker["middle"].text}"
end

When(/^I "(.*?)" the minutes OLD by "(.*?)" minutes/) do |direction, minutes|
  sleep(2)
  $MINUTES = @Time_Chooser.minutes_number_picker

  middle_location = $MINUTES['middle']
  current_value = middle_location.text

  if(direction == 'increase')
    calc_value = current_value.to_i + minutes.to_i
    if calc_value > 59
      value = calc_value - 60
    elsif calc_value < 0
      value = calc_value + 60
    end
  elsif(direction == 'decrease')
    calc_value = current_value.to_i - minutes.to_i
    if calc_value < 0
      value = calc_value + 60
    elsif calc_value > 59
      value = calc_value - 60
    end
  end
    #puts "the current value is #{current_value}"
    #puts "the calculated value = #{calc_value}"
    #puts "the value after = #{value}"

    middle_location.send_keys([:control, 'a'], :backspace)
    middle_location.send_keys(value)

    #puts "post entry = #{@Time_Chooser.minutes_number_picker["middle"].text}"
end