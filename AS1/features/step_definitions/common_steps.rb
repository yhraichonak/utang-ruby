# frozen_string_literal: true
require File.dirname(__FILE__) +'/../../../api/features/lib/apis/amp_api.rb'
require File.dirname(__FILE__) +'/../../../api/features/lib/apis/amp_api.rb'
Dir[File.dirname(__FILE__) + "/../../../common/**/*.rb"].each {|file| require file }
$DND_SCRIPT=File.read("#{File.dirname(__FILE__)}/dnd.js")
Before do
  @Sidebar = Sidebar.new @selenium
  @Header_Bar = Header_Bar.new @selenium
  @Login_Window = Login_Window.new @selenium
  @PatientChart_Nav = PatientChart_Nav.new @selenium
  @BodySensor_Trends = BodySensor_Trends.new @selenium
  @Common_Page_View = Common_Page_View.new @selenium
  @AMP_Portal = AMP_Portal.new @selenium
  @SupervisorNursingReport_Screen = SupervisorNursingReport_Screen.new @selenium
end

Then(/^validate "(.*?)" screen via image compare$/) do |window_name|
  # @eyes.check_window(window_name) if EYES == false
end

Given(/^I have AS1 running with selenium$/) do
  @selenium.navigate.to SERVER_URL
  @wait.until { @Login_Window.ce_mark_img.displayed? }
  expect(@selenium.title).to eq 'utang ONE'
end

Given(/^I login to a testSite with "(.*?)" and "(.*?)"$/) do |username, password|
  # username = 'username' if (ENVIRONMENT == 'nodeSim') || (ENVIRONMENT == 'simulator')
  #
  # if USERNAME != nil
  #   puts "detecting username override"
  #   username = USERNAME
  # end
  #
  # if PASSWORD != nil
  #   puts "detecting password override"
  #   password = PASSWORD
  # end

  steps %(
	Given I have AS1 running with selenium
	)

  @wait.until { @Login_Window.username_input.displayed? }
  @wait.until { @Login_Window.login_button.displayed? }
  @wait.until { @Login_Window.ce_mark_img.displayed? }
  # sleep 5

  begin
    steps %(
      When I enter username "#{username}"
      And I enter password "#{password}"
      And I click the Login button
      Then I should see the patient list screen
    )
  rescue StandardError
    if @Login_Window.alert_ok_button.displayed?

      @Login_Window.alert_ok_button.click
      @wait.until { @Login_Window.username_input.displayed? }

      steps %(
        When I refresh the browser
        When I enter username "#{username}"
        And I enter password "#{password}"
        And I click the Login button
        Then I should see the patient list screen
      )
    end
  end
end

Given(/^I am a super user with all permissions$/) do
  USERNAME = SUPER_ALL_USERNAME
end

Given(/^I am a super user with no permissions$/) do
  USERNAME = process_param("[props.NU_USERNAME]")
  PASSWORD = process_param("[props.NU_PASSWORD]")
end

Given(/^I open url "(.*?)"$/) do |url|
  url=process_param(url)
  @selenium.navigate.to url
end

Given(/^Implementation or refactoring required$/) do
  raise "Implementation or refactoring required"
end

Given(/^I open (pm-mon|pm-evt) (Ascom|Engage|Voalte|CCF|Epic|MH) C3PO url with payload (.*?)$/) do |target, vendor, payload|
  payload=process_param(payload)
  crPo_url="#{AUTOMATION_URL}#/api/sharelink/#{vendor.downcase}/#{target}?siteid=#{SITE_ID}&payload=#{payload}"
  @selenium.navigate.to crPo_url
end

Given(/^I open (pm-mon|pm-evt) (Ascom|Engage|Voalte|CCF|Epic|MH) C3PO url with query (.*?)$/) do |target, vendor, query|
  query=process_param(query)
  crPo_url="utangone://#{vendor.downcase}/#{target}?siteid=#{SITE_ID}&payload=#{payload}"
  @appiumDriver.background_app
  @appiumDriver.navigate.to crPo_url
end

Given(/^user config for the user is updated with$/) do |userconfig|
  steps %(
	Given API: user config for user "#{USERNAME}" with password "#{PASSWORD}" is updated with
"""
#{userconfig}
""")
end

Given(/^user config for the user is set to$/) do |userconfig|
  steps %(
	Given API: user config for user "#{USERNAME}" with password "#{PASSWORD}" is set to
"""
#{userconfig}
""")
end
Given(/^I login to a testSite with a valid credential$/) do

  username = USERNAME
  password = PASSWORD

  steps %(
	Given I have AS1 running with selenium
	)

  @wait.until { @Login_Window.username_input.displayed? == true }
  @wait.until { @Login_Window.login_button.displayed? == true  }
  @wait.until { @Login_Window.ce_mark_img.displayed? }
  sleep 5

  begin
    steps %(
      When I enter username "#{username}"
      And I enter password "#{password}"
      And I click the Login button
      Then I should see the patient list screen
    )
  rescue StandardError => e
    alert_ok= @Login_Window.alert_ok_button
    puts "Error occurred on login step #{e.message}"
    if !alert_ok.nil?
      alert_ok.click
    end
    steps %(When I refresh the browser)
    @wait.until { @Login_Window.username_input.displayed? }
    steps %(
        When I enter username "#{username}"
        And I enter password "#{password}"
        And I click the Login button
        Then I should see the patient list screen
      )
  end
  #$xAuthToken=@selenium.session_storage['authToken']
end


Given(/^I login to a testSite with username "(.*)" and password "(.*)"$/) do |username, password|
  USERNAME = process_param(username)
  PASSWORD = process_param(password)
  steps %(
  Given I login to a testSite with a valid credential
)
end

Given(/^I login to a testSite35 with "(.*?)" and "(.*?)"$/) do |username, password|
  # SERVER_URL = SITE35_URL
  # PATIENT = 'BLU1, BLU1'

  @selenium.navigate.to SITE35_URL
  expect(@selenium.title).to eq 'utang ONE'

  @wait.until { @Login_Window.username_input.displayed? }

  steps %(
  When I enter username "#{username}"
  And I enter password "#{password}"
  And I click the Login button
  Then I should see the patient list screen
  )
end

Given(/^I login to a testSite34 with "(.*?)" and "(.*?)"$/) do |username, password|
  # SERVER_URL = SITE35_URL
  # PATIENT = 'BLU1, BLU1'

  @selenium.navigate.to SITE34_URL
  expect(@selenium.title).to eq 'utang ONE'

  @wait.until { @Login_Window.username_input.displayed? }

  steps %(
  When I enter username "#{username}"
  And I enter password "#{password}"
  And I click the Login button
  Then I should see the patient list screen
  )
end

Given(/^I login to a test site "(.*?)" with user "(.*?)" and pass "(.*?)"$/) do |site_name, username, password|
  # SERVER_URL = SITE35_URL
  # PATIENT = 'BLU1, BLU1'

  case site_name
  when 'mindray'
    @selenium.navigate.to SITE_MINDRAY_URL
  when 'nihon khoden'
    @selenium.navigate.to SITE_NIHON_KHODEN_URL
  when 'muse9'
    @selenium.navigate.to SITE_MUSE9_URL
  when 'museNX'
    @selenium.navigate.to SITE_MUSENX_URL
  when 'acwa initial'
    @selenium.navigate.to SITE_ACWA_INITIAL_URL
  when 'acwa reviewer'
    @selenium.navigate.to SITE_ACWA_REVIEWER_URL
  when 'biointellisense'
    @selenium.navigate.to SITE_BIOINTELLISENSE_URL
  when 'server_hardening'
    @selenium.navigate.to SERVER_HARDENING_URL
  end

  puts "#{username} #{password}"
  expect(@selenium.title).to eq 'utang ONE'

  @wait.until { @Login_Window.username_input.displayed? }

  steps %(
  When I enter username "#{username}"
  And I enter password "#{password}"
  And I click the Login button
  Then I should see the patient list screen
  )
end

Given(/^I login to "(.*?)" with "(.*?)" and "(.*?)"$/) do |_sitename, username, password|
  steps %(
	Given I have AS1 running with selenium
	)

  @wait.until { @Login_Window.username_input.displayed? }

  steps %(
	When I enter username "#{username}"
	And I enter password "#{password}"
	And I click the Login button
	Then I should see the patient list screen
  )
end

Given(/^invalid login to "(.*?)" with "(.*?)" and "(.*?)"$/) do |_sitename, username, password|
  steps %(
	Given I have AS1 running with selenium
	)

  @wait.until { @Login_Window.username_input.displayed? }

  steps %(
	When I enter username "#{username}"
	And I enter password "#{password}"
	And I click the Login button
  )
end
Given(/^invalid login to testSite with "(.*?)" and "(.*?)"$/) do | username, password|
  steps %(
	Given invalid login to "testSite" with "#{username}" and "#{password}"
	)
end
Given(/^I login to simulator with "(.*?)" and "(.*?)"$/) do |username, password|
  # SERVER_URL = SIMULATOR_URL
  $sim_enabled = true
  @selenium.navigate.to SIMULATOR_URL
  sleep 1
  @selenium.navigate.to SIMULATOR_URL
  expect(@selenium.title).to eq 'utang ONE'

  @wait.until { @Login_Window.username_input.displayed? }

  steps %(
	When I enter username "#{username}"
	And I enter password "#{password}"
	And I click the Login button
	Then I should see the patient list screen
  )
end

When(/^I click "(.*?)" on the List$/) do |button_name|

  sleep 2
  if ENVIRONMENT == '39' || ENVIRONMENT == 'simulator'
    if button_name == 'Census' || button_name == 'OB Patients'
      @patient_type_flag = 'OB'
    end
  else
    if button_name == 'Census' || button_name == 'My Patients' || button_name == 'Snippet Baseline Worklist'
      @patient_type_flag = 'PM'
    elsif button_name == 'Census' || button_name == 'MOST RECENT' || button_name == 'EMS' || button_name == 'SCOTT GILLENWATER' || button_name == 'SEARCH'
      @patient_type_flag = 'CARDIO'
    end
  end

  begin
    retries ||= 0
    @wait.until { @Sidebar.sidebarOption_button(button_name).displayed? == true }
    @wait.until { @Sidebar.sidebarOption_button('My Patients').displayed? == true }
  rescue StandardError
    retry if (retries += 1) < 3
  end

  begin
    my_patients_element = @Sidebar.sidebarOption_button('My Patients')
    @my_patient_count = my_patients_element.find_element(:tag_name, 'div').text.to_i
  rescue Selenium::WebDriver::Error::NoSuchElementError
    @my_patient_count = 0
  end

  puts "--------"
  puts "the my patient count = #{@my_patient_count}"
  puts "--------"

  if button_name == 'My Patients'
    if @my_patient_count == 0
      steps %(
        When I add patients to My Patients list
      )
    end
  end

  @Sidebar.sidebarOption_button(button_name).click
  if button_name == 'Snippets Report'
    expect(@SupervisorNursingReport_Screen.from_datepicker.displayed?).to be_truthy
  else
    selected_list = @Sidebar.active_menu_option
    @patient_list_selected = button_name
    expect(selected_list.text).to include(@patient_list_selected)
  end

  sleep 1
end

Then(/^I should see in List of List Patient Monitoring no SEARCH listed$/) do
  puts "determining if search is available for PM"
  menu_array = @Sidebar.menu_options

  search_value = nil

  for i in 0..(menu_array.count - 1)
    if menu_array[i].text.include?("Search") || menu_array[i].text.include?("SEARCH")
      search_value = true
      break
    else
      search_value = false
    end

    if search_value == true
      break
    end
  end

  expect(search_value).to eql false
end

Then(/^I should see the List of Lists on the left-hand sidebar of the PM Census List screen$/) do
  expect(@Sidebar.sidebar.displayed?).to be_truthy
end

Then(/^I should see My Patients counter saved from previous session$/) do
  begin
    retries ||= 0
    @wait.until { @Sidebar.sidebarOption_button(button_name).displayed? == true }
    @wait.until { @Sidebar.sidebarOption_button('My Patients').displayed? == true }
  rescue StandardError
    retry if (retries += 1) < 3
  end
  sleep 3
  begin
    newest_value = @Sidebar.sidebarOption_button('My Patients').find_element(:class, 'count').text.to_i
  rescue Selenium::WebDriver::Error::NoSuchElementError
    newest_value = 0
  end
  puts "++++++++++++++"
  puts "the current value = #{newest_value}"
  puts "++++++++++++++"
  expect(newest_value).to eql @my_patient_count
end

When(/^I click PM main list on the sidebar$/) do
  begin
    retries ||= 0
    @wait.until { @Sidebar.sidebarOption_button(SITE_LIST).displayed? == true }
    @Sidebar.sidebarOption_button(SITE_LIST).click
  rescue StandardError
    retry if (retries += 1) < 3
  end

  @patient_list_selected = 'Census'
end

When(/^I logout of application$/) do
  sleep 2
  @Header_Bar.userMenu_button.click
  sleep 1
  @wait.until { @Header_Bar.logout_button.displayed? == true }
  @Header_Bar.logout_button.click
  USERNAME=nil
end

When(/^I should see login screen$/) do
  @wait.until { @Login_Window.username_input.displayed? == true }

  expect(@Login_Window.username_input.displayed?).to be_truthy
end

When(/^I see the browser resolution to "(.*?)" width by "(.*?)" height$/) do |width, height|
  @selenium.manage.window.resize_to(width, height)
  # sleep 3
end

When(/^I refresh the browser$/) do
  @selenium.navigate.refresh
  sleep 2
end

When(/^clear browser cache and reload$/) do
  if BROWSER != "edge"
    #TODO: implement calls to DevTools for Edge
    @selenium.devtools.network.clear_browser_cache
  end
  @selenium.navigate.refresh
end

When(/^I create "(.*?)" snippets$/) do |snippets_count|
  (0..snippets_count - 1).each do |_x|
    steps %(
      When I click the "Tools" button in sub navigation menu
      Then I should see the Snippet Tool screen
      When I click the Create Snippet button
      Then I should see the Snippet Document Edit View
      When I click the Save button on Snippet Document Edit screen
      Then I see Snippet Saved notification window
      When I click OK button Snippet Saved notification window
      Then I should see the Live Monitor screen
      When I click the "Live" button in sub navigation menu
    )
  end
end

When(/^I click the Home icon$/) do
  @Header_Bar.home_button.click
end

When(/^I click the Back button in browser$/) do
  @selenium.navigate.back
end

Given(/^I set webclient config "([^"]*)" to value "([^"]*)"$/) do |client_config, value|
  value = case value
          when 'true'
            true
          when 'false'
            false
          when 'null'
            nil
          else
            value.to_i
          end

  json_value = Web_Client.new.set_config(client_config, value)

  expect(json_value).to eql value
end

Given(/^I set server hostconfig "([^"]*)" to value "([^"]*)"$/) do |key, value|
  Fed_Host.new.update_host_config(key, value)
end

Then(/^I should see the site listed next to the AS logo$/) do
  as_one_logo = @Header_Bar.as_one_logo
  as_one_site_name = @Header_Bar.as_one_site_name

  logo_location_x = as_one_logo.location[:x]
  logo_location_y = as_one_logo.location[:y]
  site_location_x = as_one_site_name.location[:x]
  site_location_y = as_one_site_name.location[:y]

  expect(as_one_logo).to be_truthy
  expect(logo_location_x).to eql(47).or eql(46)
  expect(logo_location_y).to eql(8).or eql(7.5)

  expect(as_one_site_name.text).to include PATIENT_SITE_NAME
  expect(site_location_x).to eql(11).or eql(10)
  expect(site_location_y).to eql(8).or eql(7.5)


end

Then(/^I should see the "([^"]*)" tab$/) do |arg1|
  if arg1 == "Group / Sort"
    group_sort = @Header_Bar.group_sort_sub_nav
    group_sort_location_x = group_sort.location[:x]
    group_sort_location_y = group_sort.location[:y]

    expect(group_sort).to be_truthy
    expect(group_sort_location_x).to be >= 950
    expect(group_sort_location_y).to eql 50

  elsif arg1 == "Filter Units"
    filter_unit = @Header_Bar.filter_unit_sub_nav
    filter_unit_location_x = filter_unit.location[:x]
    filter_unit_location_y = filter_unit.location[:y]

    expect(filter_unit).to be_truthy
    expect(filter_unit_location_x).to be >= 1000
    expect(filter_unit_location_y).to eql 50
  elsif arg1 == "Multi-Patient View"
    multi_patient = @Header_Bar.multi_patient_sub_nav
    multi_patient_location_x = multi_patient.location[:x]
    multi_patient_location_y = multi_patient.location[:y]

    expect(multi_patient).to be_truthy
    expect(multi_patient_location_x).to eql 0
    expect(multi_patient_location_y).to eql 50
  end
end

Then(/^the "([^"]*)" tab should be "([^"]*)" aligned on the screen$/) do |name, direction|
  multi_patient = @Header_Bar.multi_patient_sub_nav
  multi_patient_location_x = multi_patient.location[:x]
  multi_patient_location_y = multi_patient.location[:y]

  search_field = @Header_Bar.search_field_sub_nav
  search_field_location_x = search_field.location[:x]
  search_field_location_y = search_field.location[:y]

  group_sort = @Header_Bar.group_sort_sub_nav
  group_sort_location_x = group_sort.location[:x]
  group_sort_location_y = group_sort.location[:y]

  filter_unit = @Header_Bar.filter_unit_sub_nav
  filter_unit_location_x = filter_unit.location[:x]
  filter_unit_location_y = filter_unit.location[:y]

  if direction == "right"
    case
    when "Group / Sort"
      expect(group_sort_location_x).to be > search_field_location_x
    when "Filter Units"
      expect(filter_unit_location_x).to be > search_field_location_x
    end
  elsif direction == "left"
    case
    when "Multi-Patient View"
      expect(multi_patient_location_x).to be < search_field_location_x
    end
  end
end

Then(/^I see "(.*)" tab active and the chart is loaded$/) do |chart_nav|
  selectedNav = ''
  activeChart = ''
  case chart_nav
  when "Body Sensor"
    selectedNav = @PatientChart_Nav.bodySensor_tab
    activeChart = @BodySensor_Trends.trendsScreen
  when "Vents"
    selectedNav = @PatientChart_Nav.vents_tab
  when "Imaging"
    selectedNav = @PatientChart_Nav.imaging_tab
  when "ECGs"
    selectedNav = @PatientChart_Nav.ecgs_tab
  when "Documents"
    selectedNav = @PatientChart_Nav.documents_tab
  when "Monitor"
    selectedNav = @PatientChart_Nav.monitor_tab
  when "Vitals"
    selectedNav = @PatientChart_Nav.vitals_tab
  when "Active Meds"
    selectedNav = @PatientChart_Nav.activeMeds_tab
  when "Labs"
    selectedNav = @PatientChart_Nav.labs_tab
  when "Overview"
    selectedNav = @PatientChart_Nav.overview_tab
  end
  @wait.until { activeChart.displayed? == true }
  @wait.until { selectedNav.displayed? == true }

  selectedNav.attribute(:class).should include 'active'
end

Then(/^I should not see an error popup$/) do
  error = nil

  begin
    if(@Common_Page_View.error_popup.exists)
      error = true
    end
  rescue => e
    error = false
  end
  expect(error).to be_falsey
  expect(e.class.name).to eql "Selenium::WebDriver::Error::NoSuchElementError"
end


Given(/^I have "(.*?)" AMP running with selenium$/) do |site|
  @selenium.navigate.to Common.get_amp_url_by(site)
  @wait.until { @AMP_Portal.title.displayed? }
  expect(@AMP_Portal.title.text).to eq 'utang Management Portal'
end

Given(/^I have AMP running with selenium$/) do
  @selenium.navigate.to Common.get_amp_url_by(ENVIRONMENT)
  @wait.until { @AMP_Portal.title.displayed? }
  expect(@AMP_Portal.title.text).to eq 'utang Management Portal'
end

When(/^I click "(.*?)" on the AMP Home Screen$/) do |option|
  @wait.until { @AMP_Portal.title.displayed? }
  @AMP_Portal.home_screen_selection(option).click
end

Then(/^I should see the AMP User List$/) do
  @wait.until { @AMP_Portal.title.displayed? }
  expect(@AMP_Portal.title.text).to eq 'Enterprise Users'
end

When(/^I click on "(.*?)" in the AMP User List$/) do |user|
  @AMP_Portal.select_user(user).click
end

Then(/^I should see the user's settings$/) do
  @wait.until { @AMP_Portal.title.displayed? }
  name = @AMP_Portal.full_name
  title = "Details for User: %s" % name
  expect(@AMP_Portal.title.text).to eq title
end

When(/^I turn "(.*?)" "(.*?)" checkbox "(.*?)"$/) do |site, column, switch|
  checkbox = @AMP_Portal.site_configuration_checkbox(site, column)
  checked = checkbox.attribute('checked')
  puts checked
  if checkbox.attribute('checked') == "true" && switch == 'Off'
    checkbox.click
  elsif switch == 'On'
    checkbox.click
  end
end

When(/^I click the Back to List button$/) do
  @AMP_Portal.back_list_button.click
end

When(/^I wait "(.*?)" seconds$/) do |seconds|
  sleep seconds.to_i
end

When(/^I click the browser refresh button$/) do
  @selenium.navigate.refresh
end
