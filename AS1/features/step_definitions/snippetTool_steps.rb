# frozen_string_literal: true

Before do
  @SnippetTool_Screen = SnippetTool_Screen.new @selenium
  @PM_Navigation_Menu = PM_Navigation_Menu.new @selenium
end

When(/^I fling the snippet waveform to the "(.*?)"$/) do |direction|
  @org_snippet_time = @SnippetTool_Screen.snippet_time.text
  sleep 2

  case direction
  when 'left'
    @selenium.action.drag_and_drop_by(@SnippetTool_Screen.chart_window, -400, 0).perform
  when 'right'
    @selenium.action.drag_and_drop_by(@SnippetTool_Screen.chart_window, 400, 0).perform
  when 'down'
    @selenium.action.drag_and_drop_by(@SnippetTool_Screen.chart_window, 0, 100).perform
  when 'up'
    @selenium.action.drag_and_drop_by(@SnippetTool_Screen.chart_window, 0, -300).perform
  end

    sleep(2)
  @snippet_time = @SnippetTool_Screen.snippet_time.text
end

Then(/^I should see the Snippet Tool screen$/) do
   sleep 1
  #puts "in the see the snippet tool screen"
  @wait.until { @SnippetTool_Screen.chart_window.displayed? == true }
  @wait.until { @SnippetTool_Screen.snippet_widget.displayed? == true }

  expect(@SnippetTool_Screen.snippet_widget.displayed?).to be_truthy

  if @snippet_worklist_workflow != true
    steps %(
      And I should see the pm patient info in the header
    )
    #puts "in the not true"
    #sleep 10
    puts "the monitor disabled value = #{@PM_Navigation_Menu.sub_nav_button('Monitor')['disabled']}"

    expect(@PM_Navigation_Menu.sub_nav_button('Monitor')['disabled']).to be_falsey
    #puts "1"
    expect(@PM_Navigation_Menu.sub_nav_button('Events')['disabled']).to be_falsey
    #puts "2"
    expect(@PM_Navigation_Menu.sub_nav_button('Tools')['disabled']).to be_falsey
    #puts "3"
    expect(@PM_Navigation_Menu.sub_nav_button('Select Time')['disabled']).to be_falsey
    #puts "4"
    expect(@PM_Navigation_Menu.sub_nav_button('Live')['disabled']).to be_falsey
    #puts "5"
  else
    puts "in the true"
    expect(@PM_Navigation_Menu.sub_nav_button('Monitor')['disabled']).to be_truthy
    expect(@PM_Navigation_Menu.sub_nav_button('Events')['disabled']).to be_truthy
    expect(@PM_Navigation_Menu.sub_nav_button('Tools')['disabled']).to be_truthy
    sleep 1
    expect(@PM_Navigation_Menu.sub_nav_button('Select Time')['disabled']).to be_falsey
    expect(@PM_Navigation_Menu.sub_nav_button('Live')['disabled']).to be_truthy
  end

  if (@selenium.manage.window.size['width'] == 900) && (@selenium.manage.window.size['height'] == 600)
    expect(@SnippetTool_Screen.overflow_control.displayed?).to be_truthy
  else
    begin
      expect(@SnippetTool_Screen.selectOption1_control['label'].displayed?).to be_truthy
      expect(@SnippetTool_Screen.selectOption2_control['label'].displayed?).to be_truthy
      #expect(@SnippetTool_Screen.selectOption3_control['label'].displayed?).to be_truthy
    rescue StandardError
      sleep 5
      expect(@SnippetTool_Screen.selectOption1_control['label'].displayed?).to be_truthy
      expect(@SnippetTool_Screen.selectOption2_control['label'].displayed?).to be_truthy
      #expect(@SnippetTool_Screen.selectOption3_control['label'].displayed?).to be_truthy
    end
  end

  expect(@PM_Navigation_Menu.back_button.displayed?).to be_truthy
  expect(@SnippetTool_Screen.measure_button.displayed?).to be_truthy
  expect(@SnippetTool_Screen.calipers_button.displayed?).to be_truthy
  expect(@SnippetTool_Screen.marchout_toggle['disabled']).to be_truthy
  expect(@SnippetTool_Screen.paperMode_toggle['toggle_obj']).to be_truthy
  expect(@SnippetTool_Screen.createSnippet_button.displayed?).to be_truthy
  expect(@SnippetTool_Screen.chart_window.displayed?).to be_truthy
  expect(@SnippetTool_Screen.rhythm_strip.displayed?).to be_truthy
  expect(@SnippetTool_Screen.snippet_heartrate.displayed?).to be_truthy

  @snippet_tool_screen_heart_rate_value = @SnippetTool_Screen.snippet_heartrate.text
  puts "snippet tool screen heart rate value = #{@snippet_tool_screen_heart_rate_value}"
  puts "monitor heart rate value = #{@monitor_heart_rate_value}"

  if @monitor_heart_rate_value.nil? || @monitor_heart_rate_value.empty?
    puts "no incoming hr value from pm monitor"
  elsif $sim_enabled == true
    puts "sim site did not verify heart rate values"
  else
    if @monitor_heart_rate_value.include? "--"
      expect(@snippet_tool_screen_heart_rate_value).to eql "HR:"
    else
      expect(@snippet_tool_screen_heart_rate_value).to match "HR: \\d\\d"
    end

  end
end

And(/^the Heart Rate from Monitor screen matches the Snippet Tools screen$/) do
  puts "snippet tool screen heart rate value = #{@snippet_tool_screen_heart_rate_value}"
  expect(@snippet_tool_screen_heart_rate_value).to eql "HR: #{@monitor_heart_rate_value}"
end

Then(/^I should see the Snippet Tool screen with Create Snippet button hidden$/) do
  @wait.until { @SnippetTool_Screen.chart_window }
  @wait.until { @SnippetTool_Screen.selectOption1_control }

  expect(@SnippetTool_Screen.snippet_widget.displayed?).to be_truthy

  if @snippet_worklist_workflow != true
    steps %(
      And I should see the pm patient info in the header
    )
  end

  expect(@SnippetTool_Screen.selectOption1_control['label'].displayed?).to be_truthy
  expect(@SnippetTool_Screen.selectOption2_control['label'].displayed?).to be_truthy

  expect(@SnippetTool_Screen.measure_button.displayed?).to be_truthy
  expect(@SnippetTool_Screen.calipers_button.displayed?).to be_truthy
  expect(@SnippetTool_Screen.marchout_toggle['disabled']).to be_truthy
  expect(@SnippetTool_Screen.paperMode_toggle['toggle_obj']).to be_truthy
  expect(@SnippetTool_Screen.chart_window.displayed?).to be_truthy
  expect(@SnippetTool_Screen.rhythm_strip.displayed?).to be_truthy

  expect(@SnippetTool_Screen.snippet_heartrate.displayed?).to be_truthy

  begin
    expect(@SnippetTool_Screen.createSnippet_button.displayed?).to be_falsey
  rescue StandardError
    # if button not found continue - disabled
  end
end

When(/^I click the Create Snippet button$/) do
  if @SnippetTool_Screen.measure_button.attribute('className') == 'selected'
    pr_value = @SnippetTool_Screen.calc_distance_values['PR']
    qrs_value = @SnippetTool_Screen.calc_distance_values['QRS']
    qt_value = @SnippetTool_Screen.calc_distance_values['QT']
    qtc_value = @SnippetTool_Screen.calc_distance_values['QTc']

    @snippet_pr_value =  pr_value[4..pr_value.length - 1]
    @snippet_qrs_value = qrs_value[5..qrs_value.length - 1]
    @snippet_qt_value = qt_value[4..qt_value.length - 1]
    @snippet_qtc_value = (qtc_value[5..qtc_value.length - 1] if QTC_CONFIG == true)
    @measure_button_on = true
  end

  hr_value = @SnippetTool_Screen.snippet_heartrate.text
  @snippet_hr_value = hr_value[4..hr_value.length]
  @snippet_duration = @SnippetTool_Screen.selectOption3_control['label'].text

  # if duration field blank more than likely screen is in small resolution need to grab indicator instead
  @snippet_duration = @SnippetTool_Screen.indicators[2].text if @snippet_duration == ''

  @SnippetTool_Screen.createSnippet_button.click
end

Then(/^I should see the Snippet Tool time in "(.*?)" format$/) do |date_format|
  date_format=process_param(date_format)
  snippet_date = @SnippetTool_Screen.snippet_time.text
  puts "snippet date:  #{snippet_date}"
  puts "time:  #{date_format}"  # "%m/%d/%Y 01:35:45"

  puts "+++++++++"
  puts "DateTime.strptime = #{DateTime.strptime(snippet_date, date_format)}"
  puts "+++++++++"

  expect(DateTime.strptime(snippet_date, date_format)).to be_truthy
end

Then(/^I see the Snippet Rhythm Strip timestamp "(.*?)" format$/) do |timestamp|
  snippet_date = @SnippetTool_Screen.rhythmScript_timestamp.text
  if INFO == true
    puts timestamp
    puts snippet_date
  end

  expect(DateTime.strptime(snippet_date, timestamp)).to be_truthy
end

When(/^I select "(.*?)" waveform in option (\d+) dropdown on Snippet screen$/) do |option, number|
  monitor_menu_choice = ''
  option=process_param(option)
  sleep 1
  case number.to_i
  when 1
    monitor_menu_choice = @SnippetTool_Screen.selectOption1_control['control_obj']
  when 2
    monitor_menu_choice = @SnippetTool_Screen.selectOption2_control['control_obj']
  end
  monitor_menu_choice.click()

  begin
    @SnippetTool_Screen.selectOption_menu(option).click
  rescue StandardError

    sleep 1
    @selenium.action.move_to(menu, 185, 285).click.release.perform
    sleep 1
    @SnippetTool_Screen.selectOption_menu(option).click
  end

  @wait.until { monitor_menu_choice.text() == option }
end

Then(/^User is able to select "(.*)" snippet duration on Snippet screen$/) do |duration|

  ecg1ctrl=@SnippetTool_Screen.selectOption1_control['control_obj'].text
  ecg2ctrl=@SnippetTool_Screen.selectOption2_control['control_obj'].text
  steps %( When I select "#{duration}" in option dropdown on Snippet screen)
  steps %(  Then I should see the "#{ecg1ctrl}" waveform and "#{ecg2ctrl}" waveform in chart and rhythm strip on Snippet screen )

end

Then(/^User is able to select every waveform in option (\d+) dropdown on Snippet screen$/) do |number|

  ecg1ctrl=@SnippetTool_Screen.selectOption1_control
  ecg2ctrl=@SnippetTool_Screen.selectOption2_control

  case number.to_i
  when 1
    monitor_menu_choice = ecg1ctrl['control_obj']
    static_ecg=ecg2ctrl['label'].text
  when 2
    monitor_menu_choice = ecg2ctrl['control_obj']
    static_ecg=ecg1ctrl['label'].text
  end
  monitor_menu_choice.click()
  sleep 1
  ecgs=@SnippetTool_Screen.selectOptions_menu.collect{|x| x.text}
  monitor_menu_choice.click()
  ecgs.each{ |x|
    steps %( When I select "#{x}" waveform in option #{number} dropdown on Snippet screen)
    case number.to_i
    when 1
      steps %(  Then I should see the "#{x}" waveform and "#{static_ecg}" waveform in chart and rhythm strip on Snippet screen )
    when 2
      steps %(  Then I should see the "#{static_ecg}" waveform and "#{x}" waveform in chart and rhythm strip on Snippet screen )
    end
  }
end

Then(/^User is able to see the both of the waveform dropdowns on Snippet screen$/) do
  @SnippetTool_Screen.selectOption1_control['control_obj'].click
  expect(@SnippetTool_Screen.selectOptions_menu[1].displayed?).to be_truthy
  @SnippetTool_Screen.selectOption2_control['control_obj'].click
  expect(@SnippetTool_Screen.selectOptions_menu[1].displayed?).to be_truthy
end

Then(/^User is able to see the snippet duration dropdown on Snippet screen$/) do
  @SnippetTool_Screen.selectOption3_control['control_obj'].click
  expect(@SnippetTool_Screen.selectOptions_menu[1].displayed?).to be_truthy
end

Then(/^I should see the "(.*?)" waveform and "(.*?)" waveform in chart and rhythm strip on Snippet screen$/) do |label1, label2|
  puts @SnippetTool_Screen.chart_wave_label(1).text if INFO == true
  label1=process_param(label1)
  label2=process_param(label2)
  if label1.include? "matches:"
    expect(@SnippetTool_Screen.chart_wave_label(1).text).to match label1.gsub("matches:","")
  else
    expect(@SnippetTool_Screen.chart_wave_label(1).text).to include label1
  end


  if label2 != 'none'
    puts @SnippetTool_Screen.chart_wave_label(2).text if INFO == true
    begin
      if label2.include? "matches:"
        expect(@SnippetTool_Screen.chart_wave_label(2).text).to match label2.gsub("matches:","")
      else
        expect(@SnippetTool_Screen.chart_wave_label(2).text.gsub("ECG-","")).to eql label2.gsub("ECG-","")
      end
    rescue RSpec::Expectations::ExpectationNotMetError
      steps %( When I zoom "out" on snippet tool screen )
      expect(@SnippetTool_Screen.chart_wave_label(2).text).to eql label2
    end
  end

  labelText = @SnippetTool_Screen.selectOption3_control['label'].text

  if BROWSER == 'ie'
    case labelText
    when '5 seconds'
      expect(@SnippetTool_Screen.rhythm_strip_handle_start.css_value('transform')).to eql 'matrix(1, 0, 0, 1, 491, 0)'
    when '10 seconds'
      expect(@SnippetTool_Screen.rhythm_strip_handle_start.css_value('transform')).to eql 'matrix(1, 0, 0, 1, 366, 0)'
    when '30 seconds'
      expect(@SnippetTool_Screen.rhythm_strip_handle_start.css_value('transform')).to eql 'matrix(1, 0, 0, 1, -134, 0)'
    when '60 seconds'
      expect(@SnippetTool_Screen.rhythm_strip_handle_start.css_value('transform')).to eql 'matrix(1, 0, 0, 1, -884, 0)'
    when '150 seconds'
      expect(@SnippetTool_Screen.rhythm_strip_handle_start.css_value('transform')).to eql 'matrix(1, 0, 0, 1, -3134, 0)'
    end
  elsif labelText == '5 seconds'
    expect(@SnippetTool_Screen.rhythm_strip_handle_start.css_value('transform')).to eql 'matrix(1, 0, 0, 1, 499, 0)'
  elsif labelText == '10 seconds'
    handle = @SnippetTool_Screen.rhythm_strip_handle_start

    case handle.css_value('transform')
    when 'matrix(1, 0, 0, 1, 373.5, 0)'
      expect(handle.css_value('transform')).to eql 'matrix(1, 0, 0, 1, 373.5, 0)'
    when  'matrix(1, 0, 0, 1, 365.5, 0)'
      expect(handle.css_value('transform')).to eql 'matrix(1, 0, 0, 1, 365.5, 0)'
    when 'matrix(1, 0, 0, 1, 374, 0)'
      expect(handle.css_value('transform')).to eql 'matrix(1, 0, 0, 1, 374, 0)'
    end
    # expect(@SnippetTool_Screen.rhythm_strip_handle_start.css_value('transform')).to include('matrix(1, 0, 0, 1, 373.5, 0)', 'matrix(1, 0, 0, 1, 365.5, 0)', 'matrix(1, 0, 0, 1, 374, 0)')
  elsif labelText == '30 seconds'
    value = @SnippetTool_Screen.rhythm_strip_handle_start.css_value('transform')
    case value
    when 'matrix(1, 0, 0, 1, -126.5, 0)'
      expect(value).to eql 'matrix(1, 0, 0, 1, -126.5, 0)'
    when 'matrix(1, 0, 0, 1, -134.5, 0)'
      expect(value).to eql 'matrix(1, 0, 0, 1, -134.5, 0)'
    when 'matrix(1, 0, 0, 1, -126, 0)'
      expect(value).to eql 'matrix(1, 0, 0, 1, -126, 0)'
    end

  elsif labelText == '60 seconds'
  value = @SnippetTool_Screen.rhythm_strip_handle_start.css_value('transform')
  case value
  when 'matrix(1, 0, 0, 1, -876.5, 0)'
    expect(value).to eql 'matrix(1, 0, 0, 1, -876.5, 0)'
  when 'matrix(1, 0, 0, 1, -884.5, 0)'
    expect(value).to eql 'matrix(1, 0, 0, 1, -884.5, 0)'
  end
  elsif labelText == '150 seconds'
    expect(@SnippetTool_Screen.rhythm_strip_handle_start.css_value('transform')).to eql 'matrix(1, 0, 0, 1, -3127, 0)'
  end
end

When(/^I select "(.*?)" in option dropdown on Snippet screen$/) do |option|
  sleep 2
  @SnippetTool_Screen.selectOption3_control['control_obj'].click
  sleep 1
  @SnippetTool_Screen.selectOption_menu(option).click
  sleep 2
end

When(/^I "(.*?)" the snippet length duration to "(.*?)" seconds$/)do |option, duration|
  default_duration = @SnippetTool_Screen.selectOption3_control['label'].text.to_i
  right_indicator = @SnippetTool_Screen.boundary_marker('right')
  count = (duration.to_i - default_duration).abs

  case option
  when 'increase'
    x = 50 * count
  when 'decrease'
    x = (-50 * count)
  end

  @selenium.action.drag_and_drop_by(right_indicator,  x.to_i, 0).perform
end

Then(/^I should see the snippet length duration display "(.*?)"$/)do |duration|
  expect(@SnippetTool_Screen.selectOption3_control['label'].text).to eql duration
end

Then(/^I should see the Measure button "(.*?)"$/) do |status|
  retries ||= 0
  if status == 'active'
    @wait.until { @SnippetTool_Screen.measure_button.attribute('className') == 'selected' }
    expect(@SnippetTool_Screen.measure_button.attribute('className')).to eql 'selected'
  else
    @wait.until { @SnippetTool_Screen.measure_button.attribute('className') == '' }
    expect(@SnippetTool_Screen.measure_button.attribute('className')).to eql ''
  end
rescue StandardError
  retry if (retries += 1) < 3
end

Then(/^I should see the HR legend in waveform chart$/) do
  expect(@SnippetTool_Screen.snippet_heartrate.displayed?).to be_truthy
end

When(/^I click on Measure button$/) do
  @SnippetTool_Screen.measure_button.click
end

Then(/^I should see calculating distances of PR, QRS, and QT values$/) do
  expect(@SnippetTool_Screen.calc_distance_values['calc_obj'].displayed?).to be_truthy
  expect(@SnippetTool_Screen.calc_distance_values['QT']).to include 'QT'
  expect(@SnippetTool_Screen.calc_distance_values['PR']).to include 'PR'
  expect(@SnippetTool_Screen.calc_distance_values['QRS']).to include 'QRS'
end

Then(/^I should see calculating distance of QTc value$/) do
  expect(@SnippetTool_Screen.calc_distance_values['calc_obj'].displayed?).to be_truthy
  expect(@SnippetTool_Screen.calc_distance_values['QTc']).to include 'QTc'
end

Then(/^I should not see calculating distances of PR, QRS, and QT values$/) do
  expect(@SnippetTool_Screen.calc_distance_values['calc_obj'].displayed?).to be_falsey
rescue StandardError
  # rescue if cant find object - pass
end

Then(%r{^I should see the Measure controls for P, Q/R, S, T$}) do
  expect(@SnippetTool_Screen.measureCaliper('P').displayed?).to be_truthy
  expect(@SnippetTool_Screen.measureCaliper('Q/R').displayed?).to be_truthy
  expect(@SnippetTool_Screen.measureCaliper('S').displayed?).to be_truthy
  expect(@SnippetTool_Screen.measureCaliper('T').displayed?).to be_truthy

  @org_pr_value = @SnippetTool_Screen.calc_distance_values['PR']
  @org_qrs_value = @SnippetTool_Screen.calc_distance_values['QRS']
  @org_qt_value = @SnippetTool_Screen.calc_distance_values['QT']
  @org_qtc_value = @SnippetTool_Screen.calc_distance_values['QTc']

  puts "the pr value = #{@org_pr_value}"
  puts "the qrs value = #{@org_qrs_value}"
  puts "the qt value = #{@org_qt_value}"
  puts "the qtc value = #{@org_qtc_value}"

  @org_pr_value =  @org_pr_value[4..@org_pr_value.length - 1]
  @org_qrs_value = @org_qrs_value[5..@org_qrs_value.length - 1]
  @org_qt_value = @org_qt_value[4..@org_qt_value.length - 1]
  @org_qtc_value = @org_qtc_value[5..@org_qtc_value.length - 1] if QTC_CONFIG == true

  puts "pr value = #{@org_pr_value}"
  puts "qrs value = #{@org_qrs_value}"
  puts "qt value = #{@org_qt_value}"
  puts "qtc value = #{@org_qtc_value}"

  # assertions below ensure order of measurements
  expect(@org_pr_value.to_f).to be > 0
  expect(@org_qrs_value.to_f).to be > 0
  expect(@org_qt_value.to_f).to be > 0
  expect(@org_qt_value.to_f).to be > @org_qrs_value.to_f
end

Then(%r{^I should see P, Q/R, S, T Measure Controls center aligned$}) do
  canvas_thirds = @SnippetTool_Screen.tools_chart_canvas.size.width / 3
  expect(@SnippetTool_Screen.measureCaliper('P').location.x).to be >= canvas_thirds
  expect(@SnippetTool_Screen.measureCaliper('T').location.x).to be <= (canvas_thirds * 2)
end

And(/^I should validate the calculation of QTc value$/) do
  value = (@org_qt_value.to_f / Math.sqrt(60 / @monitor_heart_rate_value.to_f)).round(2)
  calculated_qtc_value = @org_qt_value.to_f + 0.00175 * (@monitor_heart_rate_value.to_f - 60)
  puts "the Hodges calculated value of QTc = #{calculated_qtc_value}"
  puts "the calculated value of QTc = #{value}"
end

Then(/^I should see calculating distances of QTc value$/) do
  if QTC_CONFIG == true
    @org_qt_value = @SnippetTool_Screen.calc_distance_values['QT']
    @org_qt_value = @org_qt_value[4..@org_qt_value.length - 1]
    hr = @SnippetTool_Screen.snippet_heartrate.text
    hr = hr[4..hr.length - 1]

    if INFO == true
      puts hr
      puts @org_qt_value
    end

    sqrt = Math.sqrt(60 / hr.to_f)

    puts sqrt if INFO == true

    value = (@org_qt_value.to_f / Math.sqrt(60 / hr.to_f)).round(3)
    value = value.round(2)

    puts value if INFO == true

    value = "#{value}0" if value.to_s.length == 3

    puts value if INFO == true
    @org_qtc_value = "QTc: #{value}"
    expect(@SnippetTool_Screen.calc_distance_values['QTc']).to eql @org_qtc_value
  end
end

When(/^I move the "(.*?)" Measure control to the right of "(.*?)" measure control$/) do |control1, control2|
  @org_pr_value = @SnippetTool_Screen.calc_distance_values['PR']
  @org_qrs_value = @SnippetTool_Screen.calc_distance_values['QRS']
  @org_qt_value =  @SnippetTool_Screen.calc_distance_values['QT']

  @org_pr_value =  @org_pr_value[4..@org_pr_value.length - 1]
  @org_qrs_value = @org_qrs_value[5..@org_qrs_value.length - 1]
  @org_qt_value = @org_qt_value[4..@org_qt_value.length - 1]

  p_measure_control1 = @SnippetTool_Screen.measureCaliper('P').rect
  qr_measure_control1 = @SnippetTool_Screen.measureCaliper('Q/R').rect
  s_measure_control1 = @SnippetTool_Screen.measureCaliper('S').rect
  t_measure_control1 = @SnippetTool_Screen.measureCaliper('T').rect

  sleep 2

  if (control1 == 'Q/R') && (control2 == 'S')
    @selenium.action.drag_and_drop_by(@SnippetTool_Screen.measureCaliper('Q/R'),
                                      (s_measure_control1[:x] - qr_measure_control1[:x]) + 50, 0).perform
  elsif (control1 == 'P') && (control2 == 'Q/R')
    @selenium.action.drag_and_drop_by(@SnippetTool_Screen.measureCaliper('P'),
                                      (qr_measure_control1[:x] - p_measure_control1[:x]) + 50, 0).perform
    @SnippetTool_Screen.measureCaliper('P').click
    @SnippetTool_Screen.measureCaliper('P').click
  elsif (control1 == 'Q/R') && (control2 == 'T')
    @selenium.action.drag_and_drop_by(@SnippetTool_Screen.measureCaliper('Q/R'),
                                      (t_measure_control1[:x] - qr_measure_control1[:x]) + 50, 0).perform
  end

  sleep 2

  # added retry drag if grabbed wrong caliper
  p_measure_control2 = @SnippetTool_Screen.measureCaliper('P').rect
  qr_measure_control2 = @SnippetTool_Screen.measureCaliper('Q/R').rect
  s_measure_control2 = @SnippetTool_Screen.measureCaliper('S').rect
  t_measure_control2 = @SnippetTool_Screen.measureCaliper('T').rect

  if (control1 == 'Q/R') && (control2 == 'S')
    if qr_measure_control1[:x] == qr_measure_control2[:x]
      @selenium.action.drag_and_drop_by(@SnippetTool_Screen.measureCaliper('Q/R'),
                                        (s_measure_control2[:x] - qr_measure_control2[:x]) + 50, 0).perform
    end
  elsif (control1 == 'P') && (control2 == 'Q/R')
    if p_measure_control1[:x] == p_measure_control2[:x]
      @selenium.action.drag_and_drop_by(@SnippetTool_Screen.measureCaliper('P'),
                                        (qr_measure_control2[:x] - p_measure_control2[:x]) + 50, 0).perform
    end
  elsif (control1 == 'Q/R') && (control2 == 'T')
    if qr_measure_control1[:x] == qr_measure_control2[:x]
      @selenium.action.drag_and_drop_by(@SnippetTool_Screen.measureCaliper('Q/R'),
                                        (t_measure_control2[:x] - qr_measure_control2[:x]) + 50, 0).perform
    end
  end
end

When(/^I move the "(.*?)" Measure control to the left of "(.*?)" measure control$/) do |control1, _control2|
  done = false

  until done
    @org_pr_value = @SnippetTool_Screen.calc_distance_values['PR']
    @org_qrs_value = @SnippetTool_Screen.calc_distance_values['QRS']
    @org_qt_value =  @SnippetTool_Screen.calc_distance_values['QT']

    @org_pr_value =  @org_pr_value[4..@org_pr_value.length - 1]
    @org_qrs_value = @org_qrs_value[5..@org_qrs_value.length - 1]
    @org_qt_value = @org_qt_value[4..@org_qt_value.length - 1]

    p_measure_control1 = @SnippetTool_Screen.measureCaliper('P').rect
    qr_measure_control1 = @SnippetTool_Screen.measureCaliper('Q/R').rect
    s_measure_control1 = @SnippetTool_Screen.measureCaliper('S').rect
    t_measure_control1 = @SnippetTool_Screen.measureCaliper('T').rect

    translate = @SnippetTool_Screen.measureCaliper(control1).location.x - @SnippetTool_Screen.measureCaliper(_control2).location.x - 5

    sleep 2
    @selenium.action.drag_and_drop_by(@SnippetTool_Screen.measureCaliper(control1), translate, 0).perform
    sleep 2

    # added retry drag if grabbed wrong caliper
    p_measure_control2 = @SnippetTool_Screen.measureCaliper('P').rect
    qr_measure_control2 = @SnippetTool_Screen.measureCaliper('Q/R').rect
    s_measure_control2 = @SnippetTool_Screen.measureCaliper('S').rect
    t_measure_control2 = @SnippetTool_Screen.measureCaliper('T').rect

    case control1
    when 'P'
      done = true if p_measure_control1 != p_measure_control2
    when 'Q/R'
      done = true if qr_measure_control1 != qr_measure_control2
    when 'S'
      done = true if s_measure_control1 != s_measure_control2
    when 'T'
      done = true if t_measure_control1 != t_measure_control2
    end
  end
end

When(/^I drag the "(.*?)" Measure control to the "(.*?)"$/) do |control, direction|
  sleep 2
  case direction
  when 'left'
    @selenium.action.drag_and_drop_by(@SnippetTool_Screen.measureCaliper(control), -25, 0).perform
  when 'right'
    @selenium.action.drag_and_drop_by(@SnippetTool_Screen.measureCaliper(control), 25, 0).perform
  end
  sleep 2
end

Then(/^I should see measurement distances retaining their previous values$/) do
  @new_org_pr_value = @SnippetTool_Screen.calc_distance_values['PR']
  @new_org_qrs_value = @SnippetTool_Screen.calc_distance_values['QRS']
  @new_org_qt_value = @SnippetTool_Screen.calc_distance_values['QT']
  @new_org_qtc_value = @SnippetTool_Screen.calc_distance_values['QTc']

  #if INFO == true
    puts @new_org_pr_value
    puts @new_org_qrs_value
    puts @new_org_qt_value
    puts @new_org_qtc_value
  #end

  expect(@new_org_pr_value).to eql  "PR: #{@org_pr_value}"
  expect(@new_org_qrs_value).to eql "QRS: #{@org_qrs_value}"
  expect(@new_org_qt_value).to eql  "QT: #{@org_qt_value}"
  expect(@new_org_qtc_value).to eql "QTc: #{@org_qtc_value}" if QTC_CONFIG == true
end

Then(/^I should see the "(.*?)" distance value "(.*?)"$/) do |control, value|
  # if control == "PR"
  #  sleep 1
  #  @SnippetTool_Screen.measureCaliper("P").click
  #  sleep 1
  #  @SnippetTool_Screen.measureCaliper("P").click
  #  sleep 1
  # end

  if @SnippetTool_Screen.measureCaliper('P').css_value('opacity') == '0.5'
    @SnippetTool_Screen.measureCaliper('P').click
    sleep 1
  end

  if @SnippetTool_Screen.measureCaliper('Q/R').css_value('opacity') == '0.5'
    @SnippetTool_Screen.measureCaliper('Q/R').click
    sleep 1
  end

  if @SnippetTool_Screen.measureCaliper('S').css_value('opacity') == '0.5'
    @SnippetTool_Screen.measureCaliper('S').click
    sleep 1
  end

  if @SnippetTool_Screen.measureCaliper('T').css_value('opacity') == '0.5'
    @SnippetTool_Screen.measureCaliper('T').click
    sleep 1
  end

  pr_value = @SnippetTool_Screen.calc_distance_values['PR']
  qrs_value = @SnippetTool_Screen.calc_distance_values['QRS']
  qt_value =  @SnippetTool_Screen.calc_distance_values['QT']
  qtc_value = @SnippetTool_Screen.calc_distance_values['QTc']

  pr_value =  pr_value[4..pr_value.length - 1]
  qrs_value = qrs_value[5..qrs_value.length - 1]
  qt_value = qt_value[4..qt_value.length - 1]
  qtc_value = qtc_value[5..qtc_value.length - 1] if QTC_CONFIG == true

  if (control == 'QRS') && (value == 'negative')
    if @SnippetTool_Screen.measureCaliper('Q/R').css_value('opacity') == '0.5'
      @SnippetTool_Screen.measureCaliper('Q/R').click
      sleep 1
    end
    expect(qrs_value.to_f).to be < 0
  elsif (control == 'PR') && (value == 'negative')
    expect(pr_value.to_f).to be < 0
  elsif (control == 'QT') && (value == 'negative')
    expect(qt_value.to_f).to be < 0
  elsif (control == 'QRS') && (value == 'increase')
    expect(qrs_value.to_f).to be > @org_qrs_value.to_f
  elsif (control == 'PR') && (value == 'increase')
    expect(pr_value.to_f).to be > @org_pr_value.to_f
  elsif (control == 'QT') && (value == 'increase')
    expect(qt_value.to_f).to be > @org_qt_value.to_f
  elsif (control == 'QRS') && (value == 'decrease')
    expect(qrs_value.to_f).to be < @org_qrs_value.to_f
  elsif (control == 'PR') && (value == 'decrease')
    expect(pr_value.to_f).to be < @org_pr_value.to_f
  elsif (control == 'QT') && (value == 'decrease')
    expect(qt_value.to_f).to be < @org_qt_value.to_f
  end
end

When(/^I click on "(.*?)" Measure control$/) do |control|
  @SnippetTool_Screen.measureCaliper(control).click
end

Then(/^I should see the "(.*?)" Measure control "(.*?)"$/) do |control, status|
  if status == 'disabled'
    expect(@SnippetTool_Screen.measureCaliper(control).css_value('opacity')).to eql '0.5'
  else
    expect(@SnippetTool_Screen.measureCaliper(control).css_value('opacity')).to eql '1'
  end
end

Then(/^I should see the "(.*?)" distance value as (.*?)$/) do |value, number|
  expect(@SnippetTool_Screen.calc_distance_values[value]).to eql("#{value}: #{number}")
end

# Then(/^I should see the "(.*?)" distance value as --$/) do |string|
#   if string == 'QTc'
#     expect(@SnippetTool_Screen.calc_distance_values[string]).to eql "#{string}: --" if QTC_CONFIG == true
#   else
#     expect(@SnippetTool_Screen.calc_distance_values[string]).to eql "#{string}: --"
#   end
# end

When(/^I click the Paper Mode toggle$/) do
  obj = @SnippetTool_Screen.paperMode_toggle
  puts obj['disabled']
  puts obj['buttonOn']
  sleep 1
  obj['toggle_obj'].click

  sleep 2
end

Then(/^I should see the Snippet Tool screen with Paper Mode "(.*?)"$/) do |status|
  sleep 3
  if status == 'On'

    @wait.until { @SnippetTool_Screen.chart_window }
    @wait.until { @SnippetTool_Screen.selectOption1_control }

    expect(@SnippetTool_Screen.snippet_widget.displayed?).to be_truthy

    steps %(
      And I should see the pm patient info in the header
    )

    expect(@SnippetTool_Screen.selectOption1_control['label'].text).to include get_param("COMMON_ECG1")
    expect(@SnippetTool_Screen.selectOption2_control['label'].text).to include get_param("COMMON_ECG2")
    expect(@SnippetTool_Screen.selectOption3_control['label'].text).to eql '6 seconds'

    expect(@SnippetTool_Screen.measure_button.displayed?).to be_truthy
    expect(@SnippetTool_Screen.calipers_button.displayed?).to be_truthy

    if @SnippetTool_Screen.calipers_button.attribute('className').include? 'selected'
      expect(@SnippetTool_Screen.marchout_toggle['disabled']).to be_falsey
    else
      expect(@SnippetTool_Screen.marchout_toggle['disabled']).to be_truthy
    end

    expect(@SnippetTool_Screen.paperMode_toggle['buttonOn']).to be_truthy
  else
    @wait.until { @SnippetTool_Screen.selectOption1_control }

    expect(@SnippetTool_Screen.snippet_widget.displayed?).to be_truthy

    steps %(
      And I should see the pm patient info in the header
    )

    expect(@SnippetTool_Screen.selectOption1_control['label'].text).to include 'II'
    expect(@SnippetTool_Screen.selectOption2_control['label'].text).to include 'ECG-V1'
    expect(@SnippetTool_Screen.selectOption3_control['label'].text).to eql '6 seconds'

    expect(@SnippetTool_Screen.measure_button.displayed?).to be_truthy
    expect(@SnippetTool_Screen.calipers_button.displayed?).to be_truthy

    if @SnippetTool_Screen.calipers_button.attribute('className').include? 'selected'
      expect(@SnippetTool_Screen.marchout_toggle['disabled']).to be_falsey
    else
      expect(@SnippetTool_Screen.marchout_toggle['disabled']).to be_truthy
    end

    expect(@SnippetTool_Screen.paperMode_toggle['buttonOn']).to be_falsey
  end
  expect(@SnippetTool_Screen.createSnippet_button.displayed?).to be_truthy
  expect(@SnippetTool_Screen.chart_window.displayed?).to be_truthy
  expect(@SnippetTool_Screen.rhythm_strip.displayed?).to be_truthy
  expect(@SnippetTool_Screen.snippet_heartrate.displayed?).to be_truthy
end

When(/^I click on Caliper button$/) do
  @SnippetTool_Screen.calipers_button.click
end

Then(/^I should see the Caliper button "(.*?)"$/) do |status|
  retries ||= 0
  if status == 'active'
    @wait.until { @SnippetTool_Screen.calipers_button.attribute('className') == 'selected' }
    expect(@SnippetTool_Screen.calipers_button.attribute('className')).to eql 'selected'
  else
    @wait.until { @SnippetTool_Screen.calipers_button.attribute('className') == '' }
    expect(@SnippetTool_Screen.calipers_button.attribute('className')).to eql ''
  end
rescue StandardError
  retry if (retries += 1) < 3
end

Then(/^I should see calculating distances for the calipers$/) do
  expect(@SnippetTool_Screen.caliper_distance.displayed?).to be_truthy
  expect(@SnippetTool_Screen.caliper('left').displayed?).to be_truthy
  expect(@SnippetTool_Screen.caliper('right').displayed?).to be_truthy
  @first_caliper_distance = @SnippetTool_Screen.caliper_distance.text
end

When(/^I drag the "(.*?)" caliper to the "(.*?)"$/) do |caliper, direction|
  @org_caliperDistance = @SnippetTool_Screen.caliper_distance.text

  sleep 2
  case direction
  when 'left'
    @selenium.action.drag_and_drop_by(@SnippetTool_Screen.caliper(caliper), -25, 0).perform
  when 'right'
    @selenium.action.drag_and_drop_by(@SnippetTool_Screen.caliper(caliper), 25, 0).perform
  end
  sleep 2
end

Then(/^I should see the caliper distance "(.*?)"$/) do |status|
  @caliperDistance = @SnippetTool_Screen.caliper_distance.text

  if INFO == true
    puts @org_caliperDistance
    puts @caliperDistance
  end

  case status
  when 'increase'
    puts "in here"
    puts "original value = #{@org_caliperDistance.to_f}"
    puts "post value = #{@caliperDistance.to_f}"

    if @org_caliperDistance.to_f < @caliperDistance.to_f
      puts "true"
    else
      puts "false"
    end

    expect(@org_caliperDistance.to_f).to be < @caliperDistance.to_f
  when 'decrease'
    expect(@org_caliperDistance.to_f).to be > @caliperDistance.to_f
  end
  sleep 5
end

When(/^I drag the whole caliper to the center$/) do
  @selenium.action.drag_and_drop_by(@SnippetTool_Screen.caliper_distance, -50, 0).perform
end

Then(/^the caliper displays in the center of waveform$/) do
  # step is used due to bug AS1-585
end

Then(/^I should see calipers reset original distance$/) do
  caliperDistance = @SnippetTool_Screen.caliper_distance.text
  expect(@first_caliper_distance).to be == caliperDistance
end

When(/^I click the Marchout switch to "(.*?)"$/) do |_status|
  @SnippetTool_Screen.marchout_toggle['toggle_obj'].click
end

Then(/^the Caliper Marchout lines appear in zoom view and rhythm strip$/) do
  @wait.until { @SnippetTool_Screen.marchout_toggle['buttonOn'] == true }
  expect(@SnippetTool_Screen.marchout_toggle['buttonOn']).to be_truthy
  # expect(@SnippetTool_Screen.marchout_toggle["disabled"]).to be_falsey
end

Then(/^the Caliper Marchout lines should not appear in zoom view and rhythm strip$/) do
  if @SnippetTool_Screen.calipers_button.attribute('className') == 'selected'
    @wait.until { @SnippetTool_Screen.marchout_toggle['buttonOn'] == false }
    expect(@SnippetTool_Screen.marchout_toggle['buttonOn']).to be_falsey
  else
    @wait.until { @SnippetTool_Screen.marchout_toggle['disabled'] == true }
    expect(@SnippetTool_Screen.marchout_toggle['disabled']).to be_truthy
  end
end

Then(/^the Marchout switch should be "(.*?)"$/) do |status|
  case status
  when 'enabled'
    expect(@SnippetTool_Screen.marchout_toggle['disabled']).to be_falsey
  when 'disabled'
    expect(@SnippetTool_Screen.marchout_toggle['disabled']).to be_truthy
  end
end

Then(/^the snippet tool zoom value is set at "(.*?)"$/) do |value|
  expect(@SnippetTool_Screen.snippet_zoom.attribute('value').to_s).to eql value.to_s
end

When(/^I zoom "(.*?)" on snippet tool screen$/) do |zoom|
  current_val= @SnippetTool_Screen.snippet_zoom.attribute('value').to_i
  case zoom
  when 'in'
    ((10-current_val)*10).times do
      @SnippetTool_Screen.snippet_zoom.send_keys(:right)
      sleep(0.1)
    end
  when 'out'
    ((current_val-1)*10).times do
      @SnippetTool_Screen.snippet_zoom.send_keys(:left)
      sleep(0.1)
    end
  end
end

When(/^I zoom "(.*?)" on snippet tool screen to zoom "(.*?)"$/) do |zoom, zoom_level|
  current_val= @SnippetTool_Screen.snippet_zoom.attribute('value').to_i
  target_val= zoom_level.to_f
  case zoom
  when 'in'
    ((target_val-current_val)*10).times do
      @SnippetTool_Screen.snippet_zoom.send_keys(:right)
      sleep(0.1)
    end
  when 'out'
    ((current_val-target_val)*10).times do
      @SnippetTool_Screen.snippet_zoom.send_keys(:left)
      sleep(0.1)
    end
  end
end

When(/^I zoom to "(.*?)" on snippet tool screen$/) do |zoom|
  if zoom.to_f > @SnippetTool_Screen.snippet_zoom.attribute('value').to_f
    @SnippetTool_Screen.snippet_zoom.send_keys(:right) while @SnippetTool_Screen.snippet_zoom.attribute('value').to_f != zoom.to_f
  else
    @SnippetTool_Screen.snippet_zoom.send_keys(:left) while @SnippetTool_Screen.snippet_zoom.attribute('value').to_f != zoom.to_f
  end
end

When(/^I scroll the snippet waveform to the "(.*?)"$/) do |direction|
  @org_snippet_time = @SnippetTool_Screen.snippet_time.text
  # log @org_snippet_time

  sleep 2

  case direction
  when 'left'
    @selenium.action.drag_and_drop_by(@SnippetTool_Screen.chart_window, -300, 0).perform
    sleep 2
    @selenium.action.drag_and_drop_by(@SnippetTool_Screen.chart_window, -300, 0).perform
  when 'right'
    @selenium.action.drag_and_drop_by(@SnippetTool_Screen.chart_window, 300, 0).perform
  when 'up'
    @selenium.action.drag_and_drop_by(@SnippetTool_Screen.chart_window, 0, -400).perform
  when 'down'
    @selenium.action.drag_and_drop_by(@SnippetTool_Screen.chart_window, 0, 400).perform
  end

  sleep 2

  @snippet_time = @SnippetTool_Screen.snippet_time.text
  # log @snippet_time
end

Then(/^snippet waveform moves "(.*?)" in time$/) do |time|
  case time
  when 'forward'
    expect(@org_snippet_time).to be < @snippet_time
  when 'back'
    expect(@org_snippet_time).to be > @snippet_time
  end
end

Then(/^I should see caliper distances retaining their previous value$/) do
  @compare_caliperDistance = @SnippetTool_Screen.caliper_distance.text
  puts @compare_caliperDistance if INFO == true

  expect(@caliperDistance).to eql @compare_caliperDistance
end

Then(/^I record original measurement values$/) do
  @first_pr_value = @SnippetTool_Screen.calc_distance_values['PR']
  @first_qrs_value = @SnippetTool_Screen.calc_distance_values['QRS']
  @first_qt_value = @SnippetTool_Screen.calc_distance_values['QT']
  @first_qtc_value = @SnippetTool_Screen.calc_distance_values['QTc']
end

Then(/^I should see measurement distances back to their original values$/) do
  @org_pr_value = @SnippetTool_Screen.calc_distance_values['PR']
  @org_qrs_value = @SnippetTool_Screen.calc_distance_values['QRS']
  @org_qt_value = @SnippetTool_Screen.calc_distance_values['QT']
  @org_qtc_value = @SnippetTool_Screen.calc_distance_values['QTc']

  expect(@first_pr_value).to eql @org_pr_value
  expect(@first_qrs_value).to eql @org_qrs_value
  expect(@first_qt_value).to eql @org_qt_value
  expect(@first_qtc_value).to eql @org_qtc_value
end

Then(/^Measurements and boundary indicators remain sticky to previous location$/) do
  steps %(
    Then I should see measurement distances retaining their previous values
  )
end

Then(/^I record the original caliper distance$/) do
  @org_caliperDistance = @SnippetTool_Screen.caliper_distance.text
  puts @org_caliperDistance if INFO == true
end

Then(/^I should see caliper distances back to their original value$/) do
  caliperDistance = @SnippetTool_Screen.caliper_distance.text
  puts caliperDistance if INFO == true

  expect(caliperDistance).to eql @org_caliperDistance
end

Then(/^I should see overflow control$/) do
  expect(@SnippetTool_Screen.overflow_control.displayed?).to be_truthy
end

When(/^I click the overflow control$/) do
  @SnippetTool_Screen.overflow_control.click
end

Then(/^I should see the lead selectors$/) do
  expect(@SnippetTool_Screen.selectOption1_control['label'].displayed?).to be_truthy
  expect(@SnippetTool_Screen.selectOption2_control['label'].displayed?).to be_truthy
end

Then(/^I should see the paper mode toggle$/) do
  expect(@SnippetTool_Screen.paperMode_toggle['toggle_obj']).to be_truthy
end

Then(/^I should see the marchout toggle$/) do
  expect(@SnippetTool_Screen.marchout_toggle['disabled']).to be_truthy
end

Then(/^I should see the length selector$/) do
  expect(@SnippetTool_Screen.selectOption3_control['label'].displayed?).to be_truthy
end

Then(/^I should see waveform "(.*?)" not muted$/) do |string|
  # do nothing visual check
end

Then(/^I should see the measuring labels on top one-third of viewable area$/) do
  # measure_p = @SnippetTool_Screen.measureCaliper('P').rect
  # measure_qr = @SnippetTool_Screen.measureCaliper('Q/R').rect
  # measure_s = @SnippetTool_Screen.measureCaliper('S').rect
  # measure_t = @SnippetTool_Screen.measureCaliper('T').rect
  # chart_window = @SnippetTool_Screen.chart_window.rect

  measure_p = @SnippetTool_Screen.measureCaliper('P').location.y
  measure_qr = @SnippetTool_Screen.measureCaliper('Q/R').location.y
  measure_t = @SnippetTool_Screen.measureCaliper('S').location.y
  measure_s = @SnippetTool_Screen.measureCaliper('T').location.y
  chart_window = @SnippetTool_Screen.chart_window.size
  chart_window_location = @SnippetTool_Screen.chart_window.location


  # log measure_p
  # log chart_window
  #
  # log chart_window[:y]
  # log chart_window[:width]
  # log measure_p[:y]

  max_y = (chart_window.height / 2) + chart_window_location.y
  min_y = (2 * max_y) / 3

  expect(measure_p).to be < max_y
  expect(measure_p).to be > min_y

  expect(measure_qr).to be < max_y
  expect(measure_qr).to be > min_y

  expect(measure_s).to be < max_y
  expect(measure_s).to be > min_y

  expect(measure_t).to be < max_y
  expect(measure_t).to be > min_y
end

Then(/^I should not see measurement distances retaining their previous values$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^the time displayed should be the time the Live Monitor stopped$/) do
  @snippet_tool_static_time = @SnippetTool_Screen.snippet_time.text
  @snippet_tool_static_time = @snippet_tool_static_time.gsub('- ', '')
  expect(@snippet_tool_static_time).to be_truthy
  puts "the static time on the snippet tool screen: #{@snippet_tool_static_time}"
end

And(/^I should see the Snippet Tool refresh$/) do
  canvas_chart = @SnippetTool_Screen.tools_chart_canvas
  expect(canvas_chart).to be_truthy
end

When(/^I scroll the "(.*?)" boundary indicator to the "(.*?)"$/) do |option, direction|
  left_object = @SnippetTool_Screen.boundary_marker('left')
  @left_start_x = left_object.location.x
  right_object = @SnippetTool_Screen.boundary_marker('right')
  @right_start_x = right_object.location.x
  @waveform_length = @SnippetTool_Screen.waveform_length_number

  if option == 'left'
    object = left_object
  elsif option == 'right'
    object = right_object
  end

  case direction
  when 'left'
    x = -50
  when 'right'
    x = 50
  end

  @selenium.action.drag_and_drop_by(object,  x.to_i, 0).perform
end

When(/^I scroll the "(.*?)" boundary indicator to the far "(.*?)"$/) do |option, direction|
  screen_offset = 30
  left_object = @SnippetTool_Screen.boundary_marker('left')
  left_location = left_object.location
  @left_start_x = left_location.x
  right_object = @SnippetTool_Screen.boundary_marker('right')
  right_location = right_object.location
  @right_start_x = right_location.x

  case direction
  when 'left'
    if option == 'left'
      object = left_object
      x = -(left_object.location.x-screen_offset)
      little_x = -1
    elsif option == 'right'
      object = right_object
      x = - right_object.location.x
      little_x = -1
    end
  when 'right'
    screen_offset=screen_offset+55 if @selenium.browser.to_s.include?('edge')
    if option == 'left'
      object = left_object
      x = (@selenium.manage.window.size.width - left_object.location.x-screen_offset)
      little_x = 1
    elsif option == 'right'
      object = right_object
      x = (@selenium.manage.window.size.width - right_object.location.x)- screen_offset
      little_x = 1
    end
  end

  @selenium.action.drag_and_drop_by(object,  x.to_i, 0).perform
   # @selenium.action.click_and_hold(object).move_by(little_x, 0).move_by(little_x, 0).move_by(little_x, 0).move_by(little_x, 0).perform
  # sleep(5)
end

Then(/^the rhythm strip should be back to center$/) do
  @selenium.action.release.perform
  sleep(1)
end

Then(/^the "(.*?)" boundary indicator moves to the "(.*?)"$/) do |option, direction|
  sleep(1)
  case direction
  when 'left'
    expect(@SnippetTool_Screen.boundary_marker(option).location.x).to be < @left_start_x
  when 'right'
    expect(@SnippetTool_Screen.boundary_marker(option).location.x).to be > @right_start_x
  end
end

Then(/^the "(.*?)" boundary indicator can only be dragged to the edge of the screen$/) do |option|
  case option
  when 'left'
    expect(@SnippetTool_Screen.boundary_marker(option).location.x).to be >= 0
  when 'right'
    expect(@SnippetTool_Screen.boundary_marker(option).location.x).to be <= 1200
  end
end

Then(/^the "(.*?)" boundary indicator does not move$/) do |option|
  sleep(1)
  case option
  when 'left'
    expect(@SnippetTool_Screen.boundary_marker(option).location.x).to be <= @left_start_x
  when 'right'
    expect(@SnippetTool_Screen.boundary_marker(option).location.x).to be >= @right_start_x
  end
end

Then(/^the "(.*?)" boundary window should continue to scroll with the waveform expanding as well$/) do |option|
  waveform_length = []
  left_object = @SnippetTool_Screen.boundary_marker('left')
  right_object = @SnippetTool_Screen.boundary_marker('right')
  if option == 'left'
    object = left_object
    x = -10
  elsif option == 'right'
    object = right_object
    x = 10
  end

  (0..1).each do
    waveform_length.push(@SnippetTool_Screen.waveform_length_number)
    @selenium.action.drag_and_drop_by(object,x, 0).perform
    sleep 1
  end
  expect(waveform_length[1]).to be > waveform_length[0]
  # @selenium.action.release.perform
end

Then(/^the Rhythm strip boundary indicator "(.*?)" in size$/) do |option|
  case option
  when 'increases'
    expect(@SnippetTool_Screen.waveform_length_number).to be > @waveform_length
  when 'decreases'
    expect(@SnippetTool_Screen.waveform_length_number).to be < @waveform_length
  end
end

When(/^I scroll the rhythm strip to the "(.*?)"$/)do |direction|
  @left_start_x = @SnippetTool_Screen.boundary_marker('left').location.x
  @right_start_x = @SnippetTool_Screen.boundary_marker('right').location.x
  @start_time = @SnippetTool_Screen.rhythm_strip_timestamp
  rhythm_strip_object = @SnippetTool_Screen.rhythm_strip
  left_boundary_x = @SnippetTool_Screen.boundary_marker('left').location.x

  if @SnippetTool_Screen.measure_button.attribute('className').include? 'selected'
    @start_boundary_indicator_to_p = @SnippetTool_Screen.measureCaliper('P').location.x - left_boundary_x
    @start_boundary_indicator_to_qr = @SnippetTool_Screen.measureCaliper('Q/R').location.x - left_boundary_x
    @start_boundary_indicator_to_s = @SnippetTool_Screen.measureCaliper('S').location.x - left_boundary_x
    @start_boundary_indicator_to_t = @SnippetTool_Screen.measureCaliper('T').location.x - left_boundary_x
  end

  case direction
  when 'left'
    x = -100
  when 'right'
    x = 100
  end
  @selenium.action.drag_and_drop_by(rhythm_strip_object,  x.to_i, 0).perform
end

Then(/^the rhythm strip should scroll to the "(.*?)"$/)do |direction|
  case direction
  when 'left'
    expect(@SnippetTool_Screen.rhythm_strip_timestamp).to be > @start_time
  when 'right'
    expect(@SnippetTool_Screen.rhythm_strip_timestamp).to be < @start_time
  end
end

Then(/^the boundary indicators should remain in place$/) do
  expect(@SnippetTool_Screen.boundary_marker('left').location.x).to eql @left_start_x
  expect(@SnippetTool_Screen.boundary_marker('right').location.x).to eql @right_start_x
end

Then(/^the boundary indicators should move with measure controls$/) do
  sleep(5)
  left_boundary_x = @SnippetTool_Screen.boundary_marker('left').location.x
  boundary_indicator_to_p = @SnippetTool_Screen.measureCaliper('P').location.x - left_boundary_x
  boundary_indicator_to_qr = @SnippetTool_Screen.measureCaliper('Q/R').location.x - left_boundary_x
  boundary_indicator_to_s = @SnippetTool_Screen.measureCaliper('S').location.x - left_boundary_x
  boundary_indicator_to_t = @SnippetTool_Screen.measureCaliper('T').location.x - left_boundary_x
  expect(boundary_indicator_to_p - @start_boundary_indicator_to_p).to be <= 150
  expect(boundary_indicator_to_qr - @start_boundary_indicator_to_qr).to be <= 150
  expect(boundary_indicator_to_s - @start_boundary_indicator_to_s).to be <= 150
  expect(boundary_indicator_to_t - @start_boundary_indicator_to_t).to be <= 150
end

When(/^I click ok on the error window$/) do
  # begin
    sleep(5)
    # wait.until{ @SnippetTool_Screen.error_window['title'].displayed? == true }
    @SnippetTool_Screen.error_window['button'].click
  # rescue
  #   @SnippetTool_Screen.error_window['button'].click
  # end
end
