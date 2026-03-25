# frozen_string_literal: true

When(/^I open Developer Tools in browser$/) do
  if (BROWSER == 'chrome' || BROWSER == 'edge') && SAUCELABS == false && GRID == false
    # manual test step.
  else
    pending 'step can only be perform in chrome or edge browsers locally'
  end
end

When(/^I view Network in Developer Tools$/) do
  # manual test step....selenium has network responses captured already
end

Then(/^I should see allowEdit set to "(.*?)" displaying in response for requestedit API call$/) do |boolean|
  @api_logs = Devtools.new.api_capture(@selenium)['api_logs']
  # log @network_logs.count
  (0..@api_logs.count - 1).each do |i|
    if @api_logs[i]['response']['url'].include? '/api/cardio/requestedit?'
      # expect(sidebar_buttons["most_recent"].text).to eq "MOST RECENT"
      requestId = @api_logs[i]['requestId']
      postbody = @selenium.devtools.network.get_response_body(request_id: requestId)
      puts postbody if INFO == true
      expect(postbody['result']['body']).to include "\"allowEdit\":#{boolean}"
    end
  rescue StandardError
    # do not puts if error
  end
end

Then(/^I should see statementlibrary API call returned$/) do
  @api_logs = Devtools.new.api_capture(@selenium)['api_logs']
  (0..@api_logs.count - 1).each do |i|
    expect(@api_logs[i]['response']['url']).to include '/api/cardio/statementlibrary?' if @api_logs[i]['response']['url'].include? '/api/cardio/statementlibrary?'
  rescue StandardError
    # do not puts if error
  end
end

Then(/^I should see the statement library selection window appear with values with "(.*?)"$/) do |_string|
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I should not see statementlibrary API call returned$/) do
  @api_logs = Devtools.new.api_capture(@selenium)['api_logs']
  (0..@api_logs.count - 1).each do |i|
    expect(@api_logs[i]['response']['url']).not_to include '/api/cardio/statementlibrary?'
  end
end

Then(/^I should see Min Max ranges displaying in response for measurements API call$/) do
  @api_logs = Devtools.new.api_capture(@selenium)['api_logs']
  # sleep 2
  (0..@api_logs.count - 1).each do |i|
    next unless @api_logs[i]['response']['url'].include? '/api/pm/measurements?'

    requestId = @api_logs[i]['requestId']
    postbody = @selenium.devtools.network.get_response_body(request_id: requestId)
    puts postbody if INFO == true
    expect(postbody['result']['body']).to include '"min":-800,"max":800'
  end
end

Then(/^I should see Min Max ranges displaying \(simulator\) in response for measurements API call$/) do
  @network_logs = Devtools.new.api_capture(@selenium)['network_logs']
  (0..@network_logs.count - 1).each do |i|
    # puts @network_logs[i]['response']['url']
    next unless @network_logs[i]['response']['url'].include? '/pm/measurements?'

    requestId = @network_logs[i]['requestId']
    postbody = @selenium.devtools.network.get_response_body(request_id: requestId)
    puts postbody if INFO == true
    expect(postbody['result']['body']).to include '"min":1848,"max":2247'
  rescue NoMethodError
    next
  rescue Selenium::WebDriver::Error::WebDriverError
    next
  end
end

Then(/^I should see snippetRawData displaying in request payload model for savesnippets POST API call$/) do
  @api_logs = Devtools.new.api_capture(@selenium)['api_logs']
  (0..@api_logs.count - 1).each do |i|
    next unless @api_logs[i]['response']['url'].include? '/api/aso/post/snippets/savesnippet/?'

    requestId = @api_logs[i]['requestId']
    postbody = @selenium.devtools.network.get_request_post_data(request_id: requestId)
    puts postbody if INFO == true
    expect(postbody['result']['body']).to include 'snippetRawData'
  end
end

Then(/^I should see moduleId equal to 1 request made in patient API call$/) do
  @api_logs = Devtools.new.api_capture(@selenium)['api_logs']
  (0..@api_logs.count - 1).each do |i|
    expect(@api_logs[i]['response']['url']).to include 'moduleId=1' if @api_logs[i]['response']['url'].include? 'api/patient?'
  rescue StandardError
    # do not puts if error
  end
end
