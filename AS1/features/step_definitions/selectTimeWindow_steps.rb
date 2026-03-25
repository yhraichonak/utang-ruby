# frozen_string_literal: true

Before do
  @SelectTime_Window = SelectTime_Window.new @selenium
end

Then(/^I should see the Select Time window$/) do
  retries ||= 0
  @wait.until { @SelectTime_Window.time_object.displayed? == true }
  expect(@SelectTime_Window.time_object.displayed?).to be_truthy
rescue StandardError
  steps %(
        When I click the "Select Time" button in sub navigation menu
    )
  retry if (retries += 1) < 3
end

When(/^I click the ok button on Select Time Window$/) do
  sleep 2
  @SelectTime_Window.window_header.click
  sleep 2
  @SelectTime_Window.ok_button.click
end

When(/^I click the ok button on Select Time Window - ok text removed from window, button ok still displays$/) do
  sleep 4
  @SelectTime_Window.ok_button.click
end

When(/^I enter the time of "([^"]*)" hours ago "([^"]*)" minutes "([^"]*)" seconds$/) do |hours, minutes, seconds|
  puts 'overriding the hour field, to one hour ago'
  t = Time.now.getlocal(get_param("COMMON_TZ_OFFSET"))
  current_hour = t.hour
  $hour_ago = current_hour - hours.to_i
  puts "current_hour = #{current_hour}"
  puts "an hour ago is #{$hour_ago}"

  if $hour_ago < 10
    time_ago = "0#{$hour_ago}:#{minutes}:#{seconds}"
  else
    time_ago = "#{$hour_ago}:#{minutes}:#{seconds}"
  end

  @SelectTime_Window.time_object.click
  puts "sending #{time_ago}"
  @SelectTime_Window.time_object.send_keys(time_ago)
end

When(/^I click day select box$/) do
  inlog = @SelectTime_Window.date_picker_select_date.count

  if inlog > 1
    @SelectTime_Window.date_picker_select_date[0].click
  else
    pending 'Site is not configured for multi day PM'
  end
  sleep 3
end

Then(/^I should see number of dates configured listed in datefield$/) do
  dayOptionCount = false
  daysConfigured = @SelectTime_Window.select_day_options.count
  dayOptionCount = true if daysConfigured > 1
  puts "Number of Days Configured: #{daysConfigured.to_i - 1}" if INFO == true
  expect(dayOptionCount).to be_truthy
end

When(/^I select day "(.*?)" in datefield$/) do |day|
  day_option_count = @SelectTime_Window.select_day_options.count
  puts "::::::::::::"
  puts day_option_count
  puts "::::::::::::"

  if day_option_count > 2
    @SelectTime_Window.select_day_options[day.to_i - 1].click
  else
    puts @SelectTime_Window.select_day_options[0].text if INFO == true
    @SelectTime_Window.select_day_options[0].click
  end
end

Then(/^I should not see an option to choose a future day$/) do
  d = Date.today
  date = d.strftime("%m/%d/%Y")
  puts date
  date_options = @SelectTime_Window.select_day_options

  date_options.each do |option|
    puts option.text
    expect(option.text).to be <= date
  end
end

When(/^I click the cancel button on Select Time Window$/) do
  cancel_button = @SelectTime_Window.cancel_button

  expect(cancel_button.displayed? == true)
  cancel_button.click
end
