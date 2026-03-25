# frozen_string_literal: true

Before do
  @About_Window = About_Window.new @selenium
  @Header_Bar = Header_Bar.new @selenium
  @PatientList_Screen = PatientList_Screen.new @selenium
end

When(/^I click on the About button$/) do
  @Header_Bar.about_link.click
end

When(/^I click the username dropdown indicator$/) do
  @About_Window.user_menu_button.click
  sleep 2
end

Then(/^I should see About and Logout links$/) do
  @wait.until { @About_Window.about_button.displayed? == true }
  expect(@About_Window.about_button.displayed?).to be_truthy
  expect(@About_Window.logout_button.displayed?).to be_truthy
end

When(/^I click on About link$/) do
  @About_Window.about_button.click
end

When(/^Flaky step$/) do
  if ENV["TRIGER"].nil?
    ENV["TRIGER"]="true"
    raise "Artificial exception"
  end
end

When(/^I click on Logout link$/) do
  @About_Window.logout_button.click
  sleep 2
end

When(/^I click on Done button on the About screen$/) do
  @About_Window.done_button.click
end

Then(/^I should see About screen window$/) do
  @wait.until { @About_Window.window_title.displayed? == true }
  expect(@About_Window.window_title.displayed?).to be_truthy
end

Then(/^I should see Application Info section$/) do
  expect(@About_Window.applicationInfo_title.text).to eql 'Application Info'
  about_information = @About_Window.about_Info
  expect(about_information['App Name'].text).to eql 'utang ONE®'
  expect(about_information['App Version'].text).to be_truthy
  expect(about_information['App Version'].text).to eql $app_version
  expect(about_information['Build Number'].displayed?).to be_truthy
  expect(about_information['Build Number'].text).to end_with "#{$app_build_number}"
  expect(about_information['UDI'].displayed?).to be_truthy
  expect(about_information['Copyright'].text).to include(Date.today.year.to_s+' utang')
  expect(about_information['Patent Number'].text).to eql 'USPTO 8,255,238'
end

Then(/^I should see UDI as "(.*?)"$/) do |string|
  expect(@About_Window.about_Info['UDI'].text).to eql process_param(string)
end
Then(/^I should see UDI as matching "(.*?)"$/) do |string|
  expect(@About_Window.about_Info['UDI'].text).to match string
end
Then(/^I should see App Version as "([^"]*)"$/) do |string|
  expect(@About_Window.about_Info['App Version'].text).to eql process_param(string)
end

Then(/^I should see Manufacture Date as "([^"]*)"$/) do |build_date|
  build_date = process_param(build_date)
  expect(@About_Window.about_Info['Build Date'].text).to eql build_date
end

Then(/^I should see Manufacture Date as matching "([^"]*)"$/) do |string|
  expect(@About_Window.about_Info['Build Date'].text).to match process_param(string)
end

Then(/^I should see "(.*?)" in "(.*?)" section$/) do |row_name, section_name|
  # steps tested in section steps
end

Then(/^I should see Technical Support section$/) do
  expect(@About_Window.technicalSupport_title.text).to eql 'Technical Support'
  about_information = @About_Window.about_Info
  expect(about_information['Phone US'].text).to eql '1-877-258-5869'
  expect(about_information['Phone UK'].text).to eql '800: 0-800-088-5520'
  expect(about_information['Phone CA'].text).to eql '1-210-805-0444, Option 2'
  expect(about_information['Phone AU'].text).to eql '039832 2222'
  expect(about_information['Email Support'].text).to eql 'support@xxxx.com'
end

Then(/^I should see Device Info section$/) do
  expect(@About_Window.deviceInfo_title.text).to eql 'Device Info'
end

Then(/^I should see Manufactured By section$/) do
  expect(@About_Window.manufacturedBy_title.text).to eql 'Manufactured By'
  expect(@About_Window.about_Info['utang Address'].text).to eql "utang Technologies Inc.
2915 W. Bitters Rd. Suite 215
San Antonio, TX 78248 USA"
  expect(@About_Window.about_Info['Build Date'].text).to be_truthy
  expect(@About_Window.manufacturedByLogo1_image.displayed?).to be_truthy
  expect(@About_Window.manufacturedByLogo2_image.displayed?).to be_truthy
end

Then(/^I should see EU Authorized Representative section$/) do
  expect(@About_Window.euAuthorizedRepresentative_title.text).to eql 'EU Authorized Representative & Importer'
  expect(@About_Window.about_Info['EU Authorized Rep'].text).to eql "MedEnvoy Global B.V.
Prinses Margrietplantsoen 33 - Suite 123
2595 AM The Hague
The Netherlands"
  expect(@About_Window.ecRep_image.displayed?).to be_truthy
end

Then(/^I should see UK Responsible Person & Importer$/) do
  expect(@About_Window.ukResponsiblePerson_title.text).to eql 'UK Responsible Person & Importer'
  expect(@About_Window.about_Info['UK Responsible Person'].text).to eql "MedEnvoy UK Limited
85, Great Portland Street, First Floor
London, W1W 7LT
United Kingdom"
  expect(@About_Window.ecRep_image.displayed?).to be_truthy
end

Then(/^I should see AU Authorized Representative section$/) do
  expect(@About_Window.auAuthorizedRepresentative_title.text).to eql 'AU Authorized Representative'
  expect(@About_Window.about_Info['AU Authorized Rep'].text).to eql "Cardioscan Services Pty Ltd.
293 Camberwell Rd. Suite 301
Victoria 3124 Australia
+61 3 9832 2222
0 3 9832-2222"
end

Then(/^I should see Online User Guide link in Technical Support section$/) do
  expect(@About_Window.about_Info['Instructions'].text).to eql 'User Guides and Training'
  puts @About_Window.about_Info['Instructions'].find_element(:css, 'a').attribute('href') if INFO == true
  expect(@About_Window.about_Info['Instructions'].find_element(:css, 'a').attribute('href')).to eql 'https://utang.lpages.co/webtraining/'
end

Then(/^I should see EULA link$/) do
  expect(@About_Window.eula_link.text).to eql 'End User License Agreement'
  puts @About_Window.eula_link.attribute('href') if INFO == true
  expect(@About_Window.eula_link.attribute('href')).to eql 'https://www.utang.com/utang-eula'
end

Then(/^I should see utang ONE logo$/) do
  expect(@About_Window.utangLogos_image.displayed?).to be_truthy
end

Then(/^I should see CE Mark image - 2797$/) do
  expect(@About_Window.utangLogos_image.displayed?).to be_truthy
end

Then(/^I should see Rx Symbol image$/) do
  expect(@About_Window.utangLogos_image.displayed?).to be_truthy
end

Then(/^I should see the logout prompt display$/) do
  expect(@About_Window.logout_prompt.displayed?).to be_truthy
end

When(/^I click the logout prompt ok button$/) do
  @About_Window.logout_prompt_ok.click
end

And(/^I should see - Nurse following the username$/) do
  expect(@About_Window.user_menu_button.text.eql?('super-all - Nurse')).to be_truthy
end

And(/^I should see - Monitor Tech following the username$/) do
  expect(@About_Window.user_menu_button.text.eql?('super-all - Monitor Tech')).to be_truthy
end

And(/^I should see only the username$/) do
  expect(@About_Window.user_menu_button.text.eql?('super-all-role2')).to be_truthy
end

Then(/^I should see the options About, Preferences and Logout$/) do
  @wait.until { @About_Window.about_button.displayed? == true }
  expect(@About_Window.about_button.displayed?).to be_truthy
  expect(@About_Window.logout_button.displayed?).to be_truthy
  expect(@About_Window.preferences_button.displayed?).to be_truthy
end

When(/^I click the Preferences button$/) do
  @About_Window.preferences_button.click
end

Then(/^I should see the Preferences window$/) do
  @wait.until { @About_Window.preferences_window.displayed? == true }
  expect(@About_Window.preferences_window.displayed?).to be_truthy
end

Then(/^I should "(.*?)" the Role: section$/) do |option|
  option = process_param(option)
  @wait.until { @About_Window.preferences_window.displayed? == true }
  case option
  when 'see'
    expect(@About_Window.preferences_window_role_section(option).text).eql? 'Role'
  when 'not see'
    puts 'Role section is not present '
  end
end

When(/^I see a dropdown menu and select role type as "(.*?)"$/) do |roletype|
  roletype = process_param(roletype)
  @wait.until { @About_Window.preferences_window.displayed? == true }
  @About_Window.preferences_window_select_role_type(roletype)
end

Then(/^I should see the Role listed as Nurse$/) do
  @wait.until { @About_Window.preferences_window.displayed? == true }
  expect(@About_Window.preferences_window_role_type.text).eql? 'Nurse'
end

Then(/^I should see the Role listed as Monitor Tech$/) do
  @wait.until { @About_Window.preferences_window.displayed? == true }
  expect(@About_Window.preferences_window_role_type.text).eql? 'Monitor Tech'
end

When(/^I click on Done button on the Preferences screen$/) do
  @About_Window.done_button.click
end

And(/^I should see my username with no role listed$/) do
  expect(@About_Window.user_menu_button.text.eql?('super-all')).to be_truthy
end
