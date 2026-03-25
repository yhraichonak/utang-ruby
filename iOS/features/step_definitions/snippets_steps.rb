Before do
  @Snippets_screen = Snippets_screen.new selenium, appium
  @Snippets_details_screen = Snippets_details_screen.new selenium, appium
  @Snippets_preview_screen = Snippets_preview_screen.new selenium, appium
  @Keyboard = Keyboard.new selenium, appium
end

Then(/^I should see the ECG labels on the Monitor Tool Screen$/) do

end

Then(/^the waves should fully load$/) do
  puts "The waves fully loaded."
end

Then(/^I should see the Monitor Tool Screen$/) do
  @wait.until { @Snippets_screen.nav_bar.displayed? == true }
  expect(@Snippets_screen.nav_bar.visible).to be_truthy
	data = @Snippets_screen.patient_info

    @SNIPPET_NAME = data["name"]
    @SNIPPET_PID = data["pid"]
    @SNIPPET_LOC = data["loc"]
    @SNIPPET_HM = data["hm"]
    @SNIPPET_SITE = data["site"]
    @SNIPPET_GENDER = data["gender"]
    @SNIPPET_YEARS = data["years"]
end

Then(/^I should see the Snippet Document Preview Screen$/) do
  @wait.until { !@Snippets_preview_screen.title_bar.nil?  &&  @Snippets_preview_screen.title_bar.displayed? }
  puts "::::::"
  title_bar = @Snippets_preview_screen.title_bar.name
  puts title_bar
  puts "::::::"
  expect(title_bar).to be_truthy
end

When(/^I click the save button on the Snippet Document Preview Screen$/) do
  element = @Snippets_preview_screen.save_button
  Common.click_center_of_object(element)
end

When(/^I click the back button on the Snippet Document Edit Screen$/) do
  element = @Snippets_preview_screen.back_button
  Common.click_center_of_object(element)
end

When(/^I click the back button on the Snippet Document Preview Screen$/) do
  element = @Snippets_preview_screen.back_button
  #Common.click_center_of_object(element)
  element.click
end

When(/^I click the Measure button on the Monitor Tool Screen$/) do
  element = @Snippets_screen.measure_button
  #Common.click_center_of_object(element)
  element.click
end

Then(/^I should see the P QR S and T target objects(| without value read)$/) do |do_parse_value|
  found = false
  for i in 0..5
    begin
      @wait.until { @Snippets_screen.p_wave_target.displayed? == true }
      found = true
    rescue
      #@wait.until { @Snippets_screen.p_wave_target.displayed? == true }
    end

    sleep 1

    if found == true
      break
    end
  end

  targets = @Snippets_screen.get_target_objects
  expect(targets["target_p"].name).to include "Target-P"
  expect(targets["target_qr"].name).to include "Target-QR"
  expect(targets["target_s"].name).to include "Target-S"
  expect(targets["target_t"].name).to include "Target-T"

  if !do_parse_value.include? "without"
    if(ENV['DEVICE'].include? "iPad")
      snippet_text_values = @Snippets_screen.get_txts_ipad133
    else
      snippet_text_values = @Snippets_screen.get_txts_iphone133
    end

    @SNIPPET_HR = snippet_text_values["hr_value"]
    @SNIPPET_PR = snippet_text_values["pr_value"]
    @SNIPPET_QRS = snippet_text_values["qrs_value"]
    @SNIPPET_QT = snippet_text_values["qt_value"]
    @SNIPPET_QTC = snippet_text_values["qtc_value"]
    @SNIPPET_ECG_DROPDOWN = snippet_text_values["ecg_dropdown"]

    if $debug_flag == "debug"
      puts "+++++++++++++++"
      puts @SNIPPET_HR
      puts @SNIPPET_PR
      puts @SNIPPET_QRS
      puts @SNIPPET_QT
      puts @SNIPPET_QTC
      puts @SNIPPET_ECG_DROPDOWN
      puts "+++++++++++++++"
    end
  end
end

When(/^I click the Create Snippet button on the Monitor Tool Screen$/) do
  element = @Snippets_screen.create_snippet_button
  Common.click_center_of_object(element)
end

Then(/^I should see the Snippet Document Edit Screen from Snippet Document Preview Screen$/) do
  sleep 4
  @wait.until { @Snippets_details_screen.nav_bar.displayed? == true }
  expect(@Snippets_details_screen.nav_bar.visible).to be_truthy
end


Then(/^I should see the Snippet Document Edit Screen$/) do
  sleep 4
  # @wait.until { @Keyboard.full_keyboard.displayed? == true }

  @appiumDriver.hide_keyboard

  if(ENV['DEVICE'].include? "iPad")
    snippet_details_text_values = @Snippets_details_screen.get_txts_ipad133
  else
    snippet_details_text_values = @Snippets_details_screen.get_txts_iphone133
  end

  @SNIPPET_DETAIL_ECG_DROPDOWN = snippet_details_text_values["ecg_dropdown"]

  @SNIPPET_DETAIL_NAME = snippet_details_text_values["name"]
  @SNIPPET_DETAIL_PID = snippet_details_text_values["pid"]
  @SNIPPET_DETAIL_LOC = snippet_details_text_values["loc"]
  @SNIPPET_DETAIL_HM = snippet_details_text_values["hm"]
  @SNIPPET_DETAIL_SITE = snippet_details_text_values["site"]
  @SNIPPET_DETAIL_GENDER = snippet_details_text_values["gender"]
  @SNIPPET_DETAIL_YEARS = snippet_details_text_values["years"]

  if $debug_flag == "debug"
      puts "--------------------"
      puts @SNIPPET_DETAIL_ECG_DROPDOWN
      puts @SNIPPET_DETAIL_NAME
      puts @SNIPPET_DETAIL_PID
      puts @SNIPPET_DETAIL_LOC
      puts @SNIPPET_DETAIL_HM
      puts @SNIPPET_DETAIL_SITE
      puts @SNIPPET_DETAIL_GENDER
      puts @SNIPPET_DETAIL_YEARS
      puts "--------------------"
  end

  snippet_details_text_fields = @Snippets_details_screen.get_txtfields

  @SNIPPET_DETAIL_HR = snippet_details_text_fields["hr_value"]
  @SNIPPET_DETAIL_PR = snippet_details_text_fields["pr_value"]
  @SNIPPET_DETAIL_QRS = snippet_details_text_fields["qrs_value"]
  @SNIPPET_DETAIL_QT = snippet_details_text_fields["qt_value"]
  @SNIPPET_DETAIL_QTC = snippet_details_text_fields["qtc_value"]

  if $debug_flag == "debug"
    puts "((((((((((((("
    puts @SNIPPET_DETAIL_HR
    puts @SNIPPET_DETAIL_PR
    puts @SNIPPET_DETAIL_QRS
    puts @SNIPPET_DETAIL_QT
    puts @SNIPPET_DETAIL_QTC
    puts "((((((((((((("
  end

  expect(@SNIPPET_HR).to eq @SNIPPET_DETAIL_HR
  expect(@SNIPPET_PR).to eq @SNIPPET_DETAIL_PR
  expect(@SNIPPET_QRS).to eq @SNIPPET_DETAIL_QRS
  expect(@SNIPPET_QT).to eq @SNIPPET_DETAIL_QT
  expect(@SNIPPET_QTC).to eq @SNIPPET_DETAIL_QTC

  expect(@SNIPPET_ECG_DROPDOWN).to eq @SNIPPET_DETAIL_ECG_DROPDOWN

  expect(@SNIPPET_NAME).to eq @SNIPPET_DETAIL_NAME
  expect(@SNIPPET_PID).to eq @SNIPPET_DETAIL_PID
  expect(@SNIPPET_LOC).to eq @SNIPPET_DETAIL_LOC
  expect(@SNIPPET_HM).to eq @SNIPPET_DETAIL_HM
  expect(@SNIPPET_SITE).to eq @SNIPPET_DETAIL_SITE
  expect(@SNIPPET_GENDER).to eq @SNIPPET_DETAIL_GENDER
  expect(@SNIPPET_YEARS).to eq @SNIPPET_DETAIL_YEARS
end

And(/^I select the done button on the Snippet Document Edit Screen$/) do
  rescue
    element = @Snippets_details_screen.done_keyboard_button
    if(element.displayed)
      Common.click_center_of_object(element)
    end
  begin
    @appiumDriver.hide_keyboard
  end
  @wait.until { element.displayed? == false }
end

When(/^I click the save button on the Snippet Document Edit Screen$/) do
  element = @Snippets_details_screen.save_button
  Common.click_center_of_object(element)
end

When(/^I click the cancel button on the Snippet Document Edit Screen$/) do
  element = @Snippets_details_screen.cancel_button
  #Common.click_center_of_object(element)
  element.click
end

When(/^I click the preview button on the Snippet Document Edit Screen$/) do
  sleep(2)
  @wait.until { @Snippets_details_screen.preview_button.displayed? == true }
  element = @Snippets_details_screen.preview_button
  Common.click_center_of_object(element)
end

