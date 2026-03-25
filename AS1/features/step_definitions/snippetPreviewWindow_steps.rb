# frozen_string_literal: true

Before do
  @SnippetDocPreview_Window = SnippetDocPreview_Window.new @selenium
end

Then(/^I should see the Snippet Document Preview window$/) do

  snippet_wait=Selenium::WebDriver::Wait.new(timeout: 120)
  snippet_wait.until {  @SnippetDocPreview_Window.preview_window.enabled?  }
  snippet_wait.until { @SnippetDocPreview_Window.save_button.enabled? }

  expect(@SnippetDocPreview_Window.preview_window.displayed?).to be_truthy
  expect(@SnippetDocPreview_Window.save_button.displayed?).to be_truthy
  expect(@SnippetDocPreview_Window.back_button.displayed?).to be_truthy
end

When(/^I click the Back button on Snippet Document Preview window$/) do
  @wait.until { @SnippetDocPreview_Window.back_button.enabled? == true }
  @SnippetDocPreview_Window.back_button.click
end

When(/^I click the Save button on Snippet Document Preview window$/) do
  @wait.until { @SnippetDocPreview_Window.save_button.enabled? == true }
  @SnippetDocPreview_Window.save_button.click
end

Then(/^I see Snippet Saved notification window$/) do
  retries ||= 0
  @wait.until { @SnippetDocPreview_Window.snippet_notification_window.text == 'Snippet Saved' }
  expect(@SnippetDocPreview_Window.snippet_notification_window.text).to eql 'Snippet Saved'
rescue StandardError
  sleep 2
  retry if (retries += 1) < 3
end

When(/^I click OK button Snippet Saved notification window$/) do
  @SnippetDocPreview_Window.ok_button.click
end

When(/^I scroll the Snippet Preview Document "(.*?)"$/) do |direction|

  scroll_x = 0
  scroll_y = 0
  case direction
  when 'right'
    scroll_x = 10
  when 'left'
    scroll_x = -10
  when 'down'
    scroll_y = 500
  end

  scroll_origin = Selenium::WebDriver::WheelActions::ScrollOrigin.element(@SnippetDocPreview_Window.preview_doc_window)
  @selenium.action.scroll_from(scroll_origin, scroll_x, scroll_y).perform
  sleep 2
end

When(/^I zoom "(.*?)" on snippet document preview window$/) do |zoom|
  sleep 3
  case zoom
  when 'in'
    @SnippetDocPreview_Window.zoom.send_keys(:left) while @SnippetDocPreview_Window.zoom.attribute('value').to_f != 10
  when 'out'
    @SnippetDocPreview_Window.zoom.send_keys(:right) while @SnippetDocPreview_Window.zoom.attribute('value').to_f != 1
  end
end

Then(/^the snippet document preview zoom value is set at "(.*?)"$/) do |value|
  sleep 2
  expect(@SnippetDocPreview_Window.zoom.attribute('value').to_s).to eql value.to_s
end

Then(/^I should see the Snippet Preview Document display Patient Details$/) do
  #TODO: Figure out how to parse data from pdf to verify patient information
  sleep 5
  if BROWSER == "edge"
     raise "Manual verification required. Integration with DevTools not yet implemented for Edge"
  else
    @snippetPreview_apiData = JSON.parse($API_LOGS.filter { |t| t.to_s.include?("previewsnippet") }.last["request"]["postData"])
    expect(@snippetPreview_apiData['snippetDetails']['lastName']).to eql get_param("DP_LNAME")
    expect(@snippetPreview_apiData['snippetDetails']['firstName']).to eql get_param("DP_FFNAME")
    expect(@snippetPreview_apiData['snippetDetails']['mrn']).to eql get_param("DP_MRN").to_s
    expect(@snippetPreview_apiData['snippetDetails']['siteName']).to include get_param("COMMON_SITE_NAME")
    expect(@snippetPreview_apiData['snippetDetails']['unit']).to eql get_param("DP_UNIT")
    expect(@snippetPreview_apiData['snippetDetails']['location']).to eql get_param("DP_BED")
    expect(@snippetPreview_apiData['snippetDetails']['dobFormatted']).to eql get_param("DP_DOB")
  end

end
Then(%r{^I should see the Snippet Preview Document display Snippet Start/End Times HH:MM:SS format$}) do
  beginDate = JSON.pretty_generate(@snippetPreview_apiData['snippetLead'][0]['beginDate'])
  beginTime = JSON.pretty_generate(@snippetPreview_apiData['snippetLead'][0]['beginTime'])
  endDate = JSON.pretty_generate(@snippetPreview_apiData['snippetLead'][0]['endDate'])
  endTime = JSON.pretty_generate(@snippetPreview_apiData['snippetLead'][0]['endTime'])

  if INFO == true
    puts JSON.pretty_generate(@snippetPreview_apiData['snippetLead'])
    puts beginDate
    puts beginTime
    puts endDate
    puts endTime
  end

  format = '"%H:%M:%S"'
  expect(DateTime.strptime(beginTime, format)).to be_truthy
  expect(DateTime.strptime(endTime, format)).to be_truthy
end

Then(/^I should see the Snippet Preview Document display Measurements from snippet tool$/) do
  expect(@snippetPreview_apiData['snippetDetails']['hr']).not_to be_nil
  expect(@snippetPreview_apiData['snippetDetails']['pr']).not_to be_nil
  expect(@snippetPreview_apiData['snippetDetails']['qrs']).not_to be_nil
  expect(@snippetPreview_apiData['snippetDetails']['qt']).not_to be_nil
  expect(@snippetPreview_apiData['snippetDetails']['qtc']).not_to be_nil
end

Then(/^I should see the Snippet Preview Document display Measurements from snippet tool read blank with Measure Off$/) do
  expect(@snippetPreview_apiData['snippetDetails']['hr']).not_to be_nil
  expect(@snippetPreview_apiData['snippetDetails']['pr']).to eql "--"
  expect(@snippetPreview_apiData['snippetDetails']['qrs']).to eql "--"
  expect(@snippetPreview_apiData['snippetDetails']['qt']).to eql "--"
end

Then(/^I should see the Snippet Preview Document display HR value$/) do
  expect(@snippetPreview_apiData['snippetDetails']['hr']).not_to be_nil
end

Then(%r{^I should see the Snippet Preview Document display Snippet/Rhythm Strip Image$}) do
  puts JSON.pretty_generate(@snippetPreview_apiData['snippetLead'][0]['leadImage']) if INFO == true

  expect(@snippetPreview_apiData['snippetLead'][0]['leadImage']).not_to be_nil
end

Then(/^I should see the Snippet Preview Document display Zoom snapshot \(measurements on\)$/) do
  if INFO == true
    # puts JSON.pretty_generate(@snippetPreview_apiData['snippetRawData'])
    puts JSON.pretty_generate(@snippetPreview_apiData['snippetSnapshot'])
  end
  expect(@snippetPreview_apiData['snippetSnapshot']).not_to be_nil
end

Then(/^I should see the Snippet Preview Document display DOB$/) do
  if BROWSER == "edge"
    raise "Manual verification required. Integration with DevTools not yet implemented for Edge"
  else
    @snippetPreview_apiData = JSON.parse($API_LOGS.filter { |t| t.to_s.include?("previewsnippet") }.last["request"]["postData"])
    expect(@snippetPreview_apiData['snippetDetails']['dobFormatted']).to eql get_param("DP_DOB")
  end
end

When(/^User enable API traffic recording$/) do
  if BROWSER != "edge"
    # TODO: Implement DevTools API for Edge browser
    $API_LOGS = Devtools.new.api_capture(@selenium)['api_logs']
  end
end

When(/^User enable Network traffic recording$/) do
  $NETWORK_LOGS = Devtools.new.api_capture(@selenium)['network_logs']
end
