Before { @PmSnippet = PM_Snippet.new selenium, appium }

When(/^I click the Cancel button on the Snippet Document Edit Screen$/) do
  @PmSnippet.navbar_cancel_button.click
end

When(/^I click the Create Snippet button on the Monitor Tool Screen$/) do
  @PmSnippet.navbar_create_button.click
end

When(/^I click the Measure button on the Monitor Tool Screen$/) do
  sleep 4
  begin
    @PmSnippet.measure_button.click
  rescue NoMethodError
    log_info("Not able to click Measure Button from the first attemp")
    Appium::TouchAction.new.tap(:x => 940, :y => 300, :duration => 100).perform
  end
  expect(@PmSnippet.legend.displayed? == true)
end

When(/^I select the navigation bar Monitor Tool button$/) do
  @PmSnippet.tool_button.click
end

When(/^I click the Save button on the Snippet Document Edit Screen$/) do
  @PmSnippet.save_button.click
end

When(/^I click the Preview button on the Snippet Document Edit Screen$/) do
  @PmSnippet.preview_button.click
end

When(/^I click the Back button on the Snippet Document Preview Screen$/) do
  @PmSnippet.preview_navbar_back_button.click
end

When(/^I click the Save button on the Snippet Document Preview Screen$/) do
  @PmSnippet.preview_navbar_save_button.click
end

Then(/^I should see the Monitor Tool Screen$/) do
  wait_for(10) { @PmSnippet.lead_title_container.displayed? == true }
end

Then(/^I should see the "P", "QR", "S", and "T" target buttons$/) do
  expect(@PmSnippet.wave_view_p_button.displayed?).to be true
  expect(@PmSnippet.wave_view_qr_button.displayed?).to be true
  expect(@PmSnippet.wave_view_s_button.displayed?).to be true
  expect(@PmSnippet.wave_view_t_button.displayed?).to be true
end

Then(/^I should see the Snippet Document Edit Screen$/) do
  expect(@PmSnippet.preview_button.displayed?).to be true
end

Then(/^I should see the Snippet Document Preview Screen$/) do
  expect(@PmSnippet.preview_pdf_layout.displayed?).to be true
end
