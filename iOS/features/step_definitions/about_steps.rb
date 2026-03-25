Before do
  @About_screen = About_screen.new selenium, appium
end

And(/^I verify the Application Info on the About screen$/) do
  application_info_values = @About_screen.application_info_data_object
  expect(application_info_values["app_name_label"].text).to eq "App Name"
  expect(application_info_values["app_name_button"].text).to eq "utang ONE®"
  expect(application_info_values["app_version_label"].text).to eq "App Version"
  expect(application_info_values["app_version_button"].text).to eq "#{$as_version} "
  expect(application_info_values["build_number_label"].text).to eq "Build Number"
  expect(application_info_values["build_number_button"].text).to eq "#{$as_build_number}"
  expect(application_info_values["udi_label"].text).to eq "UDI"
  expect(application_info_values["udi_button"].text).to include get_param("COMMON_ABOUT_APP_UDI")
  expect(application_info_values["copyright_label"].text).to eq "Copyright"
  expect(application_info_values["copyright_button"].text).to eq "© #{get_param("COMMON_ABOUT_REGISTERED_YEAR")} utang"
  expect(application_info_values["patent_number_label"].text).to eq "Patent Number"
  expect(application_info_values["patent_number_button"].text).to eq "USPTO 8,255,238"
end

And(/^I verify the Device Info on the About screen$/) do
  device_info_values = @About_screen.device_info_data_object
  expect(device_info_values["registration_code_label"].text).to eq "Registration Code"
  expect(device_info_values["registration_code_button"].text).to eq @RegistrationCode
  expect(device_info_values["registration_email_label"].text).to eq "Registration Email"
  expect(device_info_values["registration_email_button"].text).to eq "test@test.com"
  expect(device_info_values["unique_id_label"].text).to eq "Unique ID"
  expect(device_info_values["device_model_label"].text).to eq "Device Model"

  if $device_name.include? "iPad"
   expect(device_info_values["device_model_button"].text).to eq "iPad"
   expect(device_info_values["system_name_button"].text).to eq "iPadOS"
  else
   expect(device_info_values["device_model_button"].text).to eq "iPhone"
   expect(device_info_values["system_name_button"].text).to eq "iOS"
  end
  expect(device_info_values["system_name_label"].text).to eq "System Name"
  expect(device_info_values["system_version_label"].text).to eq "System Version"
  expect(device_info_values["system_version_button"].text).to eq $device_version
end

And(/^I verify the Technical Support Info on the About screen$/) do
  tech_support_info_values = @About_screen.tech_support_data_object
  expect(tech_support_info_values["phone_us_label"].text).to eq "Phone US Toll-free (24/7)"
  expect(tech_support_info_values["phone_us_button"].text).to eq get_param("COMMON_ABOUT_SUPPORT_US")
  expect(tech_support_info_values["phone_uk_label"].text).to eq "Phone UK (24/7)"
  expect(tech_support_info_values["phone_uk_button"].text).to eq get_param("COMMON_ABOUT_SUPPORT_UK")
  expect(tech_support_info_values["phone_ca_label"].text).to eq "Phone CA (24/7)"
  expect(tech_support_info_values["phone_ca_button"].text).to eq get_param("COMMON_ABOUT_SUPPORT_CA")
  expect(tech_support_info_values["phone_au_label"].text).to eq "Phone AU (24/7)"
  expect(tech_support_info_values["phone_au_button"].text).to eq get_param("COMMON_ABOUT_SUPPORT_AU")
  expect(tech_support_info_values["email_label"].text).to eq "Email"
  expect(tech_support_info_values["email_button"].text).to eq get_param("COMMON_ABOUT_SUPPORT_EMAIL")
end

And(/^I verify the Manufactured By Info on the About screen$/) do
  man_info_values = @About_screen.manu_by_data_object
  expect(man_info_values["man_address_txt"].text).to eq get_param("COMMON_ABOUT_MANUF")
  expect(man_info_values["man_date_txt"].text).to eq $as_man_date
end

And(/^I verify the EU Authorized Representative Info on the About screen$/) do
  eu_rep_values = @About_screen.eu_auth_data_object
  expect(eu_rep_values["eu_address_txt"].text).to eq get_param("COMMON_ABOUT_REPR_EU")
end

Then(/^I verify the AU Authorized Representative Info on the About screen$/) do
  au_rep_values = @About_screen.au_auth_data_object
  puts "au_address_txt #{au_rep_values["au_address_txt"].text}"
  expect(au_rep_values["au_address_txt"].text).to eq get_param("COMMON_ABOUT_REPR_AU")
end

When(/^I scroll to the bottom of the view$/) do

  do_swipe
  do_swipe
  # $GLOBAL_APPIUM.action.move_to_location(600, 550).pointer_down(:left).move_to_location(600, 200).release.perform
  # $GLOBAL_APPIUM.action.move_to_location(600, 550).pointer_down(:left).move_to_location(600, 200).release.perform


  # action_builder = @selenium.action
  # touch = action_builder.add_pointer_input(:touch, 'finger')
  # touch.create_pointer_move(duration: 0, x: center_x, y: center_y)
  # touch.create_pointer_down(:left)
  # touch.create_pointer_move(duration: 1, x: center_x, y: center_y - offset)
  # touch.create_pause(1)
  # touch.create_pointer_up(:left)
  # action_builder.perform
  # Appium::TouchAction.new.swipe(:start_x => 600, :start_y => 550, :end_x => 600, :end_y => 200, :duration => 1000).perform
  #
  # Appium::TouchAction.new.swipe(:start_x => 600, :start_y => 550, :end_x => 600, :end_y => 200, :duration => 1000).perform
  sleep 1

  if (ENV['DEVICE'].include? "iPad" or ENV['DEVICE'].include? "SE" )
    do_swipe
    # $GLOBAL_APPIUM.action.move_to_location(600, 550).pointer_down(:left).move_to_location(600, 200).release.perform
    sleep 1
  end
end

Then(/^I should see the About screen$/) do
  if $debug_flag == "debug"
   puts "on the about screen"
  end
  puts "trying the implicit wait ???"
  puts Time.now
  @wait.until { @About_screen.navigation_bar.displayed? == true }
  puts Time.now

  expect(@About_screen.navigation_bar.name).to eq "About"
  expect(@About_screen.cancel_button.text).to eq "Cancel"

  expect(@About_screen.table_section("Application Info").nil?).to be_falsey

  expect(@About_screen.table_section("Device Info").nil?).to be_falsey

 if($device_plat == "12.4")
   puts "in the 12.4"
    about_info = @About_screen.about_info_txts
 else
    about_info = @About_screen.about_info_buttons
 end

  @RegistrationCode = about_info["registration_code"].text
  @InitialRegCode = @RegistrationCode
  @appVersion = about_info["app_version"].text
  @buildNumber = about_info["build_number"].text
  # expect(@buildNumber).to eq "#{$as_build_number}"
  @udi = about_info["udi"].text

  if $debug_flag == "info" || $debug_flag == "debug"
   puts "registration code: #{@RegistrationCode}"
   puts "application version: #{@appVersion}"
   puts "build number: #{@buildNumber}"
  end

  File.write('buildInfo.txt', "App Version: #{@appVersion} \nBuild Number: #{@buildNumber} \nUDI: #{@udi}")
  #
end

When(/^I click the Sign Out button$/) do
  if(ENV['DEVICE'].include? "iPad")
    el = @About_screen.about_table
    pos =  el.location
    size =  el.size

    center_x = pos[:x] + size[:width] / 2
    center_y = pos[:y] + size[:height] / 2
    offset = 300

    Appium::TouchAction.new.press(:x => center_x, :y => center_y).wait(1000).move_to(:x => center_x, :y => center_y - offset).release.perform
    Appium::TouchAction.new.press(:x => center_x, :y => center_y).wait(1000).move_to(:x => center_x, :y => center_y - offset).release.perform
    Appium::TouchAction.new.press(:x => center_x, :y => center_y).wait(1000).move_to(:x => center_x, :y => center_y - offset).release.perform
  else
    selenium.execute_script 'mobile: scroll', :direction => 'down'
    selenium.execute_script 'mobile: scroll', :direction => 'down'
  end

  element = @About_screen.signOut_button
  Common.click_center_of_object(element)
end

Then(/^I should see the Sign Out prompt$/) do
  expect(@About_screen.signout_signout_button.visible).to be_truthy
end


And(/^I click the Sign Out button on the Sign Out prompt$/) do
  element = @About_screen.signout_signout_button
  Common.click_center_of_object(element)
end

When(/^I click the Ok button on Success window prompt$/) do
  puts Time.now
  @wait.until { @About_screen.success_ok_button.displayed? == true }
  puts Time.now

  element = @About_screen.success_ok_button
  Common.click_center_of_object(element)
end

When(/^I click the Cancel button on the About screen$/) do
  element = @About_screen.cancel_button
  expect(element.visible).to be_truthy
  #element.click
  Common.click_center_of_object(element)
end

When(/^I click the Done button on the About screen$/) do
  element = @About_screen.cancel_button
  Common.click_center_of_object(element)
end
