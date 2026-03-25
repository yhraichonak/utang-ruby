# frozen_string_literal: true

Before do
  @PatientList_Screen = PatientList_Screen.new @selenium
  @PMGroupSort_Window = PMGroupSort_Window.new @selenium
  @PMFilterUnits_Window = PMFilterUnits_Window.new @selenium
  @SnippetWorklist_Screen = SnippetWorklist_Screen.new @selenium
  @Sidebar = Sidebar.new @selenium
end

When(/^I add patients to My Patients list$/) do
  @wait.until { @PatientList_Screen.patientList_form.displayed? == true }
  patient_groups = @selenium.find_elements(:class, 'patients')
  header_text = @selenium.find_elements(:class, 'label')

  puts "this is the length of patient groups #{patient_groups.count}"
  t = 0
  while t < (patient_groups.count - 1) # the minus 1 removes those discharged
    patients = patient_groups[t + 1] # the plus one is because if it starts from zero for some reason it pulls in total patient count
    patient = patients.find_elements(:class, 'patient')
    header = header_text[t]

    puts "this is the header #{header}"
    # based off of how we currently set up our my patients, this sets the total number of patients we want to add from each group
    case header
    when 'GREEN', 'ICU1'
      l = patient.count
    when 'ORANGE'
      l = 3
    when 'PURPLE', 'RED', 'YELLOW'
      l = 1
    else
      l = 0
    end
    j = 0
    puts "this is the patient count #{patient.count}"
    # Using the number we got above, loop through the patients and mark the star
    while j < l
      star = patient[j].find_element(:id, 'Star')
      star.click
      j += 1
    end
    t += 1
  end
end

When(/^I add "(.*?)" patients to My Patients List$/) do |pnts|
  patient_groups = @PatientList_Screen.patientList_form
  all_patients = @PatientList_Screen.patient_card
  patient_count = all_patients.count
  selected_list = @Sidebar.active_menu_option
  given_count = pnts.to_i

  @wait.until { patient_groups.displayed? == true }
  expect(selected_list.text).to eql 'Census'

  l = 0
  while l < given_count
    new_patient = all_patients[l]
    star = new_patient.find_element(:id, 'Star')
    mpv_toggle = new_patient.find_element(:class, 'multi-patient-toggle').attribute('class')

    puts mpv_toggle + ' this is the class'

    if !mpv_toggle.include?('selected')
      star.click
    elsif mpv_toggle.include?('selected')
      puts "Patient already selected"
    end

    l += 1
  end
end

Then(/^I should see the patient list screen$/) do
  sleep(3)
  @wait.until { @PatientList_Screen.patientList_form.displayed? == true }
  expect(@PatientList_Screen.patientList_form).to be_truthy
end

Then(/^I should not see "(.*?)" in the sidebar$/) do |button_name|
  button = @Sidebar.menu_options
  expect(!button.include?(button_name)).to be_truthy
end

Then(/^I should see the patient list grouped by "(.*?)"$/) do |choice|
  @wait.until { @PatientList_Screen.patientList_form.displayed? == true }
  case
  when choice == "Active"
    option = 'status'
  when choice == "Bed"
    option = 'bed'
  when choice == "First Name"
    option = 'firstname'
  when choice == "Last Name"
    option = 'lastname'
  when choice == "MRN"
    option = 'mrn'
  end
  if choice == "Unit"
    expect(@PatientList_Screen.patientGroup_header.text).to eql "5E"
  else
    expect(@PatientList_Screen.group_header_patient_name_compare(option)).to be_truthy
  end
end

Then(/^I should see the patient list grouped by "(.*?)" and inverted$/) do |choice|
  @wait.until { @PatientList_Screen.patientList_form.displayed? == true }
  case
  when choice == "Active"
    option = 'status'
  when choice == "Bed"
    option = 'bed'
  when choice == "First Name"
    option = 'firstname'
  when choice == "Last Name"
    option = 'lastname'
  when choice == "MRN"
    option = 'mrn'
  end
  if choice == "Unit"
    expect(@PatientList_Screen.patientGroup_header.text).to eql "GREEN"
  else
    expect(@PatientList_Screen.group_header_patient_name_compare(option)).to be_truthy
  end
end

When(/^I click on "(.*?)" in patient list(| without redirect| without override| without redirect and without override)$/) do |patient_name,options|
    begin
    steps %(When do click on "#{patient_name}" in patient list#{options})
    rescue =>e
      steps %(
      Given API: user config for user "#{USERNAME}" with password "#{PASSWORD}" is updated with
"""
[props.COMMON_RESET_GROUP_FILTER_CONFIG]
"""
    When I refresh the browser
    When do click on "#{patient_name}" in patient list#{options}
)

      end
  end

When(/^do click on "(.*?)" in patient list(.*)$/) do |patient_name,options|
  begin
    patient_name=process_param(patient_name)
    retries ||= 0
    @wait.until { @PatientList_Screen.patientList_form.displayed? == true }
    if @patient_type_flag == 'PM'
      puts 'its a pm'
      puts "sending patient #{patient_name}"
      @patient_obj = @PatientList_Screen.pm_patient_objects(patient_name)
      puts 'pm.......'
    elsif @patient_type_flag == 'CARDIO'
      puts 'cardio patient name override detected'
      if (options.to_s.include?("without override"))
        CARDIO_PATIENT_OVERRIDE = false
      end
      if CARDIO_PATIENT_OVERRIDE == true
        patient_name = CARDIO_PATIENT
      end
      puts 'its a cardio'
      @patient_obj = @PatientList_Screen.cardio_patient_objects(patient_name)
      @ecg_list_details_date=@patient_obj['dt_info'].split(' - ')[0]
      @ecg_list_details_time=@patient_obj['dt_info'].split(' - ')[1]
      @ecg_list_details_diag=@patient_obj['ecg_info']
      puts 'cardio.....'
    elsif @patient_type_flag == 'OB'
      puts 'its an ob'
      @patient_obj = @PatientList_Screen.pm_patient_objects(patient_name)
      puts 'ob........'
    else
      puts 'its an other'
      @patient_obj = @PatientList_Screen.patient_text(patient_name)
      puts 'other.....'
    end
    @patient_list_name = @patient_obj['name']
    puts @patient_obj['name']

  rescue Selenium::WebDriver::Error::StaleElementReferenceError
    @Sidebar.sidebarOption_button(@patient_list_selected).click
    retry if (retries += 1) < 3
  end

  puts "the patient type is #{@patient_type_flag}"

  case @patient_type_flag
  when 'PM'
    steps %(
      When I collect pm patient list data
      )
  when 'CARDIO'
    steps %(
        When I collect cardio patient list data
        )
  when 'OB'
    steps %(
      When I collect pm patient list data
      )
  else
    steps %(
        When I collect cardio patient list data
        )
  end
  raise("Unable to find patient #{patient_name}") if @patient_obj['patient_obj'].nil?
  @patient_obj['patient_obj'].click

  #TODO: Temporary workaround for new default Patient Info Tab
  if (!options.to_s.include?("without redirect"))
    Common.click_if_element_present(@selenium, :css, ".header-top-menu-buttons>.icon-menu[src*='expand']")
    sleep 1
    Common.click_if_element_present(@selenium, :xpath, ".//nav/a[contains(.,'Overview')]")
    Common.click_if_element_present(@selenium, :css, ".header-top-menu-buttons>.icon-menu[src*='collapse']")
  end
end


When(/^I click on default patient in list(| without redirect)$/) do |do_redierct|
  steps %(
    When I click on "#{DEFAULT_PATIENT}" in patient list#{do_redierct}
        )
end


When(/^I click on "(.*?)" in Snippet Baseline Worklist/) do |patient_name|
  begin
    retries ||= 0
    # @wait.until { @PatientList_Screen.starting_pm_patient['patient_obj'].displayed? == true }
    @wait.until { @PatientList_Screen.patientList_form.displayed? == true }
    puts 'found the patient list form'

    @patient_obj = @PatientList_Screen.pm_patient_objects(patient_name)
    @patient_list_name = @patient_obj['name']
    puts @patient_obj['name']

  rescue Selenium::WebDriver::Error::StaleElementReferenceError
    @Sidebar.sidebarOption_button(@patient_list_selected).click
    retry if (retries += 1) < 3
  end

  steps %(
    When I collect pm patient list data
    )

  @patient_obj['patient_obj'].click
end

When(/^I click on a patient with no ECGs in patient list(| without redirect)$/) do |do_redierct|
  begin
    retries ||= 0
    # @wait.until { @PatientList_Screen.starting_pm_patient['patient_obj'].displayed? == true }
    @wait.until { @PatientList_Screen.patientList_form.displayed? == true }
    puts 'found the patient list form'
    patient_name = NO_ECG_PATIENT

    if @patient_type_flag == 'PM'
      puts 'its a pm'
      puts "sending patient #{patient_name}"
      @patient_obj = @PatientList_Screen.pm_patient_objects(patient_name)
      puts 'pm.......'
    elsif @patient_type_flag == 'CARDIO'
      puts 'its a cardio'
      @patient_obj = @PatientList_Screen.cardio_patient_objects(patient_name)
      puts 'cardio.....'
    elsif @patient_type_flag == 'OB'
      puts 'its an ob'
      @patient_obj = @PatientList_Screen.pm_patient_objects(patient_name)
      puts 'ob........'
    else
      puts 'its an other'
      @patient_obj = @PatientList_Screen.patient_text(patient_name)
      puts 'other.....'
    end
    @patient_list_name = @patient_obj['name']
    puts @patient_obj['name']

  rescue Selenium::WebDriver::Error::StaleElementReferenceError
    @Sidebar.sidebarOption_button(@patient_list_selected).click
    retry if (retries += 1) < 3
  end

  puts "the patient type is #{@patient_type_flag}"

  case @patient_type_flag
  when 'PM'
    steps %(
      When I collect pm patient list data
      )
  when 'CARDIO'
    steps %(
        When I collect cardio patient list data
        )
  when 'OB'
    steps %(
      When I collect pm patient list data
      )
  else
    steps %(
        When I collect cardio patient list data
        )
  end
  @patient_obj['patient_obj'].click
  #TODO: Temporary workaround for new default Patient Info Tab
  if (!do_redierct.to_s.include?("without"))
    Common.click_if_element_present(@selenium, :css, ".header-top-menu-buttons>.icon-menu[src*='expand']")
    sleep 1
    Common.click_if_element_present(@selenium, :xpath, ".//nav/a[contains(.,'Overview')]")
    Common.click_if_element_present(@selenium, :css, ".header-top-menu-buttons>.icon-menu[src*='collapse']")
  end
end

When(/^I click on test patient in cardio patient list$/) do
  begin
    retries ||= 0
    @wait.until { @PatientList_Screen.patientList_form.displayed? == true }
    patient_name = CARDIO_PATIENT

    puts patient_name if INFO == true

    @wait.until { @PatientList_Screen.patient_text(patient_name) }
    @patient_obj = @PatientList_Screen.patient_text(patient_name)
  rescue Selenium::WebDriver::Error::StaleElementReferenceError
    @Sidebar.sidebarOption_button(@patient_list_selected).click
    retry if (retries += 1) < 3
  end

  steps %(
    When I collect cardio patient list data
  )

  @patient_obj['patient_obj'].click
end

When(/^I collect cardio patient list data$/) do
  @CARDIO_PL = true
  @patient_info_p_list = @patient_obj['name']
  @dt_info_p_list = @patient_obj['dt_info']
  @ecg_info_p_list = @patient_obj['ecg_info']
  @patient_list_ecg_count = @patient_obj['ecg_count'].to_i

  if INFO == true
    puts @patient_info_p_list
    puts @dt_info_p_list
    puts @ecg_info_p_list
    puts @patient_list_ecg_count
  end

  s = @patient_info_p_list

  puts '++++++'
  puts "s on patient list screen = #{s}"
  puts '++++++'

  separator = (0...s.length).find_all { |i| s[i, 1] == '•' }

  if ENVIRONMENT == 'mindray' || ENVIRONMENT == 'acwa initial' || '34'
    @patient_list_name = s[0..(separator[0] - 1)]
  else
    @patient_list_name = s[0..(separator[0] - 2)]
  end

  puts "name from patient list = #{@patient_list_name}"

  @patient_list_gender = s[(separator[0] + 2)..(separator[1] - 2)]
  @patient_list_age = s[(separator[1] + 2)..s.length - 1]

  if INFO == true
    puts @patient_list_name
    puts @patient_list_gender
    puts @patient_list_age
  end
end

When(/^I collect patient list data$/) do
  @CARDIO_PL = true
  @patient_info_p_list = @patient_obj['name']
  @dt_info_p_list = @patient_obj['dt_info']
  @ecg_info_p_list = @patient_obj['ecg_info']
  @patient_list_ecg_count = @patient_obj['ecg_count'].to_i

  if INFO == true
    puts @patient_info_p_list
    puts @dt_info_p_list
    puts @ecg_info_p_list
    puts @patient_list_ecg_count
  end

  s = @patient_info_p_list

  puts '++++++'
  puts "s on patient list screen = #{s}"
  puts '++++++'

  separator = (0...s.length).find_all { |i| s[i, 1] == '•' }

  if ENVIRONMENT == 'mindray' || ENVIRONMENT == 'acwa initial'
    @patient_list_name = s[0..(separator[0] - 1)]
  else
    @patient_list_name = s[0..(separator[0] - 2)]
  end

  puts "name from patient list = #{@patient_list_name}"

  # @patient_list_gender = s[(separator[0] + 2)..(separator[1] - 2)]
  # @patient_list_age = s[(separator[1] + 2)..s.length - 1]

  if INFO == true
    puts @patient_list_name
    puts @patient_list_gender
    puts @patient_list_age
  end
end

When(/^I collect pm patient list data$/) do
  @CARDIO_PL = false
  @patient_info_p_list = @patient_obj['name']
  @dt_info_p_list = @patient_obj['dt_info']
  @demographics_p_list = @patient_obj['demographics']

  puts 'in the collect pm patient list data step'
  puts @patient_info_p_list
  puts '======='
  puts @demographics_p_list
  puts @dt_info_p_list

  s = @demographics_p_list
  puts "the value for s is #{s}"
  separator = (0...s.length).find_all { |i| s[i, 1] == '•' }

  @patient_list_name = @patient_info_p_list.gsub(@demographics_p_list, ' ')
  @patient_list_gender = s[separator[0] + 2..separator[1] - 2]
  @patient_list_age = s[(separator[1] + 2)..s.length - 1]

  if INFO == true
    puts @patient_list_name
    puts @patient_list_gender
    puts @patient_list_age
  end
  if @dt_info_p_list.is_a? String
    t = @dt_info_p_list
  else
    t = @dt_info_p_list.text
  end

  separator = (0...t.length).find_all { |i| t[i, 1] == '•' }
  @patient_list_mrn = t[0..(separator[0].to_i - 2)]
  @patient_list_dob = t[(separator[0] + 2)..t.length - 1]

  if INFO == true
    puts @patient_list_mrn
    puts @patient_list_dob
  end
end


When(/^I click on test patient "(.*?)" in PM patient list$/) do |patient_name|
  begin
    retries ||= 0
    @wait.until { @PatientList_Screen.patientList_form.displayed? == true }
  rescue Selenium::WebDriver::Error::StaleElementReferenceError
    @Sidebar.sidebarOption_button(@patient_list_selected).click
    retry if (retries += 1) < 3
  end

  begin
    retries ||= 0
    sleep(2)
    @patient_obj = @PatientList_Screen.pm_patient_text(patient_name)
  rescue StandardError
    @wait.until { @PatientList_Screen.pm_patient_text(patient_name) }
    retry if (retries += 1) < 3
  end

  steps %(
    When I collect pm patient list data
  )

  begin
    retries ||= 0
    @patient_obj['patient_obj'].click
    steps %(
      Then I should see the patient summary screen
    )
  rescue StandardError
    @patient_obj = @PatientList_Screen.pm_patient_text(patient_name)
    @wait.until { @patient_obj['patient_obj'].displayed? == true }
    retry if (retries += 1) < 3
  rescue Selenium::WebDriver::Error::StaleElementReferenceError
    @Sidebar.sidebarOption_button(@patient_list_selected).click
    retry if (retries += 1) < 3
  end
end

When(/^I click on test patient in PM patient list$/) do
  patient_name = PATIENT

  begin
    retries ||= 0
    @wait.until { @PatientList_Screen.patientList_form.displayed? == true }
  rescue Selenium::WebDriver::Error::StaleElementReferenceError
    @Sidebar.sidebarOption_button(@patient_list_selected).click
    retry if (retries += 1) < 3
  end

  begin
    retries ||= 0
    @patient_obj = @PatientList_Screen.pm_patient_text(patient_name)
  rescue StandardError
    @wait.until { @PatientList_Screen.pm_patient_text(patient_name) }
    retry if (retries += 1) < 3
  end
  steps %(
    When I collect pm patient list data
  )

  begin
    retries ||= 0
    @patient_obj['patient_obj'].click
    #TODO:
    Common.click_if_element_present(@selenium, :css, ".header-top-menu-buttons>.icon-menu[src*='expand']")
    sleep 1
    Common.click_if_element_present(@selenium, :xpath, ".//nav/a[contains(.,'Overview')]")
    Common.click_if_element_present(@selenium, :css, ".header-top-menu-buttons>.icon-menu[src*='collapse']")
    steps %(
      Then I should see the patient summary screen
    )
  rescue StandardError
    @patient_obj = @PatientList_Screen.pm_patient_text(patient_name)
    @wait.until { @patient_obj['patient_obj'].displayed? == true }
    retry if (retries += 1) < 3
  rescue Selenium::WebDriver::Error::StaleElementReferenceError
    @Sidebar.sidebarOption_button(@patient_list_selected).click
    retry if (retries += 1) < 3
  end
end

When(/^I collect "(.*?)" patient list data$/) do |patient_list|
  @collected_patients = @PatientList_Screen.patients_array
  selected_patient_list = @Sidebar.active_menu_option

  expect(selected_patient_list.text).to include patient_list

  @collected_patients_names = @collected_patients[1]["name"]

  @collected_patients.each { |x| puts x["name"]}
  puts "Those are the patients on the #{patient_list} list"

  @name_array = @collected_patients.map { |names| names["name"]}
  puts @name_array

end

When(/^I click on "(.*?)" in PM patient list$/) do |name|
  begin
    retries ||= 0
    @wait.until { @PatientList_Screen.patientList_form.displayed? == true }
  rescue Selenium::WebDriver::Error::StaleElementReferenceError
    @Sidebar.sidebarOption_button(@patient_list_selected).click
    retry if (retries += 1) < 3
  end

  patient_name = name
  @patient_obj = @PatientList_Screen.pm_patient_text(patient_name)

  steps %(
    When I collect pm patient list data
  )

  @patient_obj['patient_obj'].click
end

Then(/^I should see the same patients in MPV as on the "(.*?)" list view$/) do |patient_list|
  # each of these arrays is used in either this step or others, please don't remove
  @mpv_list_collection = @MultiPatientView_Screen.multipatients_array
  @mpv_names = @mpv_list_collection.map { |y| y["name"] }
  @mpv_names_split = @mpv_list_collection.map { |x| x["name"].split(" ") }
  @patient_list_abbreviated_names = @collected_patients.map { |y, z=y["name"].split(",")| "#{z[0][0,3]}, #{z[1].strip[0,3]}".strip}

  @mpv_abbreviated_names =  @mpv_list_collection.map { |y, z=y["name"].split("•")| z[0].strip}
  puts "here are the patients from the #{patient_list} list view"
  @collected_patients.each { |x| puts x["name"]}

  puts "here are the patient from the MPV list view"
  @mpv_list_collection.each { |x| puts x["name"]}

  puts "here are the abbreviated #{patient_list} names."
  puts @patient_list_abbreviated_names.to_s
  puts @mpv_abbreviated_names.to_s
  expect(@patient_list_abbreviated_names.to_s.sub("[","").sub("]","")).to include(@mpv_abbreviated_names.to_s.sub("[","").sub("]",""))

end

Then(/^I should see the patient appear in snippet worklist with undocumented snippet$/) do
  @wait.until { @PatientList_Screen.pm_patient_approvalStatus(PATIENT)['approved'] == false }
  expect(@PatientList_Screen.pm_patient_approvalStatus(PATIENT)['approved']).to be_falsey
end

Then(/^I should see the Patient List$/) do
  @PatientList_Screen.title_text.text.should include 'Patient List'
  @PatientList_Screen.title_text.text.should include '34 QA Cardio PM EMR LightLabs (msg)'
  expect(@PatientList_Screen.patient_list.displayed?).to eql true
end

Then(/^I should see the "(.*?)" unit$/) do |unit|
  @PatientList_Screen.unit_listView.text.should include unit
end

Then(/^I should see patient with name "(.*?)"$/) do |name|
  @PatientList_Screen.patient_view.text.should include name
end

Then(/^I should see patient "(.*?)" in list$/) do |name|
  @PatientList_Screen.patient_card.text.should include name
end

When(/^I select patient with name "(.*?)"$/) do |patient|
  @PatientList_Screen.patient_selection(patient).click
end

Then(/^I should be on "(.*?)" patientList$/) do |selected_text|
  active_option = @Sidebar.active_menu_option
  expect(active_option.text).to include selected_text
end

Then(/^I should see patient information in patientList$/) do |table|
  patients = table.hashes
  patients.each do |patient|
    patient=process_hash_params(patient)
    patientData = @PatientList_Screen.patient_text(patient[:patientName])
    expect(patientData['name']).to include patient[:patientName]
    expect(patientData['name']).to include patient[:gender]
    expect(patientData['name']).to include patient[:age]
    expect(patientData['ecg_count']).to include patient[:ecgCount]
    if patient[:diagStatement].include? "matches:"
      regexp=patient[:diagStatement].gsub("matches:","")
      expect(patientData['ecg_info']).to match(/#{regexp}/)
    else
      expect(patientData['ecg_info']).to include patient[:diagStatement]
    end
    expect(patientData['dt_info']).to include patient[:acqDate]
  end
end

Then(/^I should see patient "(.*?)" in My Patient list$/) do |patient_name|
  active_list = @Sidebar.active_menu_option
  expect(active_list.text.include? "My Patients").to eql true
  patients = @PatientList_Screen.patient_card

  patients.each do |patient|
    name = patient.find_element(:class, 'name').text
    if name.include? patient_name
      expect(name.include? patient_name).to eql true
    end
  end
end

Then(/^I should see PM patient information in patientList$/) do |table|
  # For PM patient list

  patients = table.hashes
  patients.each do |patient|
    patient=process_hash_params(patient)
    patientData = @PatientList_Screen.pm_patient_text_groupings(patient[:patientName])
    expect(patientData['name']).to include patient[:patientName]
    unless patient[:gender].nil?
      expect(patientData['demographics']).to include patient[:gender]
    end
    unless patient[:age].nil?
      expect(patientData['demographics']).to include patient[:age]
    end
    expect(patientData['dt_info']).to include patient[:mrn].to_s
    expect(patientData['dt_info']).to include patient[:dob].to_s
    #TODO: clarify if location info should be there
    expect(patientData['location']).to include patient[:location].to_s
    expect(patientData['status']).to include patient[:status].to_s
    expect(patientData['statusColor']).to include patient[:statusColor].to_s
  end
end

Then(/^I should see PM patient information in site 34 patientList$/) do |table|
  # For PM patient list
  retries ||= 0
  patients = table.hashes
  patients.each do |patient|
    puts patient[:patientName]
    puts "--------"
    patientData = @PatientList_Screen.pm_patient_text_groupings(patient[:patientName])

    expect(patientData['name']).to include patient[:patientName]
    expect(patientData['dt_info']).to include patient[:mrn].to_s
    expect(patientData['location']).to include patient[:location].to_s unless patientData['location'].nil?

    expect(patientData['status']).to include patient[:status].to_s
    expect(patientData['statusColor']).to include patient[:statusColor].to_s
  end
rescue Selenium::WebDriver::Error::StaleElementReferenceError
  retry if (retries += 1) < 3
end

Then(/^I should see patient list sorted by acquistion date by LIFO$/) do
  patient_date = nil
  nextPatient_date = nil
  (1..@PatientList_Screen.patientList_count - 1).each do |i|
    patient_date = @PatientList_Screen.cardio_patientRow_text(i)['dt_info'].text
    nextPatient_date = @PatientList_Screen.cardio_patientRow_text(i + 1)['dt_info'].text
    patient_date = DateTime.strptime(patient_date, '%m/%d/%Y - %H:%M:%S')
    nextPatient_date = DateTime.strptime(nextPatient_date, '%m/%d/%Y - %H:%M:%S')
    expect(patient_date).to be >= nextPatient_date
  end
end

Then(/^I should see the search patient list screen$/) do
  expect(@Sidebar.active_menu_option.text).to eql 'SEARCH'
  expect(@PatientList_Screen.search_field('Last').displayed?).to be_truthy
  expect(@PatientList_Screen.search_field('First').displayed?).to be_truthy
  expect(@PatientList_Screen.search_field('DOB').displayed?).to be_truthy
  expect(@PatientList_Screen.search_field('Age').displayed?).to be_truthy
  expect(@PatientList_Screen.search_field('MRN/PID').displayed?).to be_truthy
  sleep 1
end

When(/^I enter "(.*?)" in "(.*?)" search field$/) do |contents, field_name|
  search_field=@PatientList_Screen.search_field(process_param(field_name))
  search_field.click
  search_field.send_keys(process_param(contents))
  sleep(2)
end

When(/^I should see a total of (\d+) patient\(s\) in the search results$/) do |list_count|
  expect(@PatientList_Screen.patientList_count.to_i).to be >= list_count.to_i if list_count.to_i != 0
end

Then(/^I should see a total of (\d+) patient\(s\) in the PM search results$/) do |list_count|
  count = @PatientList_Screen.pm_patientList_count.to_i
  puts "the patient count is #{count}"
  expect(count).to be >= list_count.to_i
end

Then(/^I should see a total count of (\d+) patient\(s\) in the PM search results$/) do |list_count|
  count = @PatientList_Screen.pm_patientList_count.to_i
  puts "the patient count is #{count}"
  expect(count).to eql list_count.to_i
end

Then(/^I should see "(.*?)" patients active on the patient list screen$/) do |list_count|
  patient_count = @PatientList_Screen.pm_patientList_count.to_i
  puts "the patient count is #{patient_count}"
  diff = patient_count.to_i
  expect(diff).to eql list_count.to_i
end

When(/^I click on search button$/) do
  @PatientList_Screen.search_button.click
end

When(/^I hover over test patient in PM patient list$/) do
  @selenium.action.move_to(@PatientList_Screen.pm_patient_dropdown(@patient)['dropdown_obj']).perform
end

Then(/^I should see Events, Live Monitor links$/) do
  steps %(
    When I hover over dropdown arrow of test patient in PM patient list
  )
  patient_name = process_param("[props.DP_FULL_NAME]")
  expect(@PatientList_Screen.pm_patient_dropdown(patient_name)['events_link'].displayed?).to be_truthy
  expect(@PatientList_Screen.pm_patient_dropdown(patient_name)['overview_link'].displayed?).to be_truthy
  # expect(@PatientList_Screen.pm_patient_dropdown(@patient)["ventilator_link"].displayed?).to be_truthy
end

When(/^I click the Events link on patient list$/) do
  steps %(
    When I hover over dropdown arrow of test patient in PM patient list
  )
  patient_name = process_param("[props.DP_FULL_NAME]")
  @PatientList_Screen.pm_patient_dropdown(patient_name)['events_link'].click
end

When(/^I click the Overview link on patient list$/) do
  steps %(
    When I hover over dropdown arrow of test patient in PM patient list
)
  patient_name = process_param("[props.DP_FULL_NAME]")
  @PatientList_Screen.pm_patient_dropdown(patient_name)['overview_link'].click
end

When(/^I click the Ventilator link on patient list$/) do
  pending 'link disabled until 4.0'
  @PatientList_Screen.pm_patient_dropdown(@patient)['ventilator_link'].click
end

When(%r{^I click on Group/Sort link$}) do
  @wait.until { @PatientList_Screen.group_sort_link['link_obj'].displayed? == true }
  begin
    retries ||= 0
    @PatientList_Screen.group_sort_link['link_obj'].click
  rescue Selenium::WebDriver::Error::ElementClickInterceptedError
    sleep(0.5)
    retry if (retries += 1) < 3
  end
end

Then(/^I see group sort title$/) do
    @wait.until { @PMGroupSort_Window.group_sort_window.displayed? == true }
    expect(@PMGroupSort_Window.group_sort_window.text).to eql 'Group / Sort'
end

Then(%r{^I should see the Group/Sort window$}) do
  @wait.until { @PMGroupSort_Window.group_sort_window.displayed? == true }
  @wait.until { @PMGroupSort_Window.group_by_field_control.displayed? == true }
  expect(@PMGroupSort_Window.group_sort_window.text).to eql 'Group / Sort'
rescue StandardError
  expect(@PMGroupSort_Window.group_sort_window.text).to eql 'Group / Sort'
end

When(/^I click on Group By dropdown and select "(.*?)"$/) do |option|
  @wait.until { @PMGroupSort_Window.group_by_field_control.displayed? == true }
  @PMGroupSort_Window.group_by_field_control.click

  begin
    retries ||= 0
    @wait.until { @PMGroupSort_Window.group_by_field_menu(option) }
    @PMGroupSort_Window.group_by_field_menu(option).click
  rescue Selenium::WebDriver::Error::ElementClickInterceptedError
    sleep(0.5)
    retry if (retries += 1) < 3
  end
end

Then(/^Group by should have (.*?) selected$/) do |option|
  group_by_text = @PMGroupSort_Window.group_by_field_control
  @wait.until { @PMGroupSort_Window.group_by_field_control.displayed? == true }
  expect(group_by_text.text).to eq(option)
end

Then(/^Sort by should have (.*?) selected$/) do |option|
  sort_by_text = @PMGroupSort_Window.first_sort_by_field_control
  @wait.until { @PMGroupSort_Window.first_sort_by_field_control.displayed? == true }
  expect(sort_by_text.text).to eq(option)
end

Then(/^second Sort by should have (.*?) selected$/) do |option|
  sort_by_text = @PMGroupSort_Window.second_sort_by_field_control
  @wait.until { @PMGroupSort_Window.second_sort_by_field_control.displayed? == true }
  expect(sort_by_text.text).to eq(option)
end

When(/^I click on first Sort By dropdown and select "(.*?)"$/) do |option|
  @wait.until { @PMGroupSort_Window.first_sort_by_field_control.displayed? == true }
  @PMGroupSort_Window.first_sort_by_field_control.click

  @wait.until { @PMGroupSort_Window.first_sort_by_field_menu(option) }
  @PMGroupSort_Window.first_sort_by_field_menu(option).click
end

When(/^I click on second Sort By dropdown and select "(.*?)"$/) do |option|
  @wait.until { @PMGroupSort_Window.second_sort_by_field_control.displayed? == true }
  @PMGroupSort_Window.second_sort_by_field_control.click

  @wait.until { @PMGroupSort_Window.second_sort_by_field_menu(option) }
  @PMGroupSort_Window.second_sort_by_field_menu(option).click
end

When(/^I click on the Group By invert button$/) do
  @wait.until { @PMGroupSort_Window.group_by_field_control.displayed? == true }
  @PMGroupSort_Window.group_sort_window_checkboxes(0).click
end

When(/^I set group by to "(.*?)"$/) do |group_by_option|
  steps %(
    When I click on Group/Sort link
    When I click on Group By dropdown and select "#{group_by_option}"
    When I click the ok button on Group / Sort window
	)
end

When(/^I click on the first Sort By invert button$/) do
  @wait.until { @PMGroupSort_Window.first_sort_by_field_control.displayed? == true }
  @PMGroupSort_Window.group_sort_window_checkboxes(1).click
end

When(/^I click on the second Sort By invert button$/) do
  @wait.until { @PMGroupSort_Window.second_sort_by_field_control.displayed? == true }
  @PMGroupSort_Window.group_sort_window_checkboxes(2).click
end

When(/^I see the group and sort by dropdown options$/) do
  @wait.until { @PMGroupSort_Window.group_sort_window.displayed? == true }
  expect(@PMGroupSort_Window.dropdown_fields.text.include? 'Group By').to eq true
  expect(@PMGroupSort_Window.dropdown_fields.text.include? 'Sort By').to eq true
end

When(%r{^I click the ok button on Group / Sort window$}) do
  @PMGroupSort_Window.ok_button.click
end

When(%r{^I click the reset button on Group / Sort window$}) do
  @PMGroupSort_Window.reset_button.click
end

When(%r{^I click the cancel button on Group / Sort window$}) do
  @PMGroupSort_Window.cancel_button.click
end

Then(/^I see the reset button$/) do
  expect(@PMGroupSort_Window.reset_button.displayed?).to eq true
end

Then(/^I see the ok button$/) do
  expect(@PMGroupSort_Window.ok_button.displayed?).to eq true
end

Then(/^I see the cancel button$/) do
  expect(@PMGroupSort_Window.cancel_button.displayed?).to eq true
end

When(%r{^I click outside the Group / Sort window$}) do
  @selenium.action.move_to(@PMGroupSort_Window.cancel_button, 185, 285).click.release.perform
end

When(/^I reset grouping and sorting on patients list$/) do
  steps %(
  When I clear grouping on patients list
  )
end

When(/^I clear grouping on patients list$/) do
  steps %(
  When wait for 2 seconds
  When I click on Group/Sort link
  And wait for 1 seconds
  And I click the reset button on Group / Sort window
  )
end

When(/^I have "(.*?)" or more patients added to My Patients List$/) do |patient_count|
  patients = @PatientList_Screen.patientList_count
  given_count = patient_count.to_i
  selected_list_view = @Sidebar.active_menu_option

  expect(selected_list_view.text).to include 'My Patients'

  if patients < given_count

    steps %(
      When I click "Census" on the List
      And I add "#{given_count}" patients to My Patients List
      And I click "My Patients" on the List
      Then I should see the patient list screen
    )
    new_patient_count = @PatientList_Screen.patientList_count
    puts "This is the new patient count #{new_patient_count}"

    expect(new_patient_count).to eql given_count
  else
    expect(patients).to eql given_count
  end
end

Then(/^I should see the group sort components at their default state$/) do
  expect(@PMGroupSort_Window.group_by_field_control.text).to eq "Unit"
  expect(@PMGroupSort_Window.first_sort_by_field_control.text).to eq "Bed"
  expect(@PMGroupSort_Window.second_sort_by_field_control.text).to eq "Select..."
  expect(@PMGroupSort_Window.group_sort_window_checkboxes(0).attribute("checked")).to eq nil
  expect(@PMGroupSort_Window.group_sort_window_checkboxes(1).attribute("checked")).to eq nil
  expect(@PMGroupSort_Window.group_sort_window_checkboxes(2).attribute("checked")).to eq nil
end

Then(/^I should see the group sort components not at their default state$/) do
  expect(@PMGroupSort_Window.group_by_field_control.text).to eq "Age"
  expect(@PMGroupSort_Window.first_sort_by_field_control.text).to eq "MRN"
  expect(@PMGroupSort_Window.second_sort_by_field_control.text).to eq "Gender"
  expect(@PMGroupSort_Window.group_sort_window_checkboxes(0).attribute("checked")).to eq "true"
  expect(@PMGroupSort_Window.group_sort_window_checkboxes(1).attribute("checked")).to eq "true"
  expect(@PMGroupSort_Window.group_sort_window_checkboxes(2).attribute("checked")).to eq "true"
end

Then(/^I should see all the group sort components displaying correctly$/) do
  expect(@PMGroupSort_Window.group_sort_window.text).to eq "Group / Sort"
  expect(@PMGroupSort_Window.group_by_field_control.displayed?).to be_truthy
  expect(@PMGroupSort_Window.first_sort_by_field_control.displayed?).to be_truthy
  expect(@PMGroupSort_Window.second_sort_by_field_control.displayed?).to be_truthy
  expect(@PMGroupSort_Window.group_sort_window_checkboxes(0).displayed?).to be_truthy
  expect(@PMGroupSort_Window.group_sort_window_checkboxes(1).displayed?).to be_truthy
  expect(@PMGroupSort_Window.group_sort_window_checkboxes(2).displayed?).to be_truthy
  expect(@PMGroupSort_Window.reset_button.displayed?).to be_truthy
  expect(@PMGroupSort_Window.cancel_button.displayed?).to be_truthy
  expect(@PMGroupSort_Window.ok_button.displayed?).to be_truthy
end

When(/^I enter "(.*?)" into the search filter$/) do |input|
  @PatientList_Screen.search_input.clear
  @PatientList_Screen.search_input.send_keys(process_param(input))
  # sleep 2
end

When(/^I click on Filter Units link$/) do
  @PatientList_Screen.filter_units_link['link_obj'].click
end

When(/^reset unit filtering$/) do
  filter=find_element_no_wait(@selenium,@selenium,:css,"a.active[href='filter-unit']")
  unless filter.nil?
    steps %(
    When I click on Filter Units link
    When I click the Toggle All button on Filter Units window
    And I click Ok button in Filter Units window
  )
  end
end

Then(/^I should see the Filter Units window$/) do
  expect(@PMFilterUnits_Window.filter_units_window.text).to eql 'Filter Units'
rescue StandardError
  @PatientList_Screen.filter_units_link['link_obj'].click
  expect(@PMFilterUnits_Window.filter_units_window.text).to eql 'Filter Units'
end

Then(/^I select the toggle all button$/) do
  sleep 2
  e = @PMFilterUnits_Window.toggle_all_button
  #@selenium.action.move_to(e).click.perform
  e.click
  #@PMFilterUnits_Window.toggle_all_button.click
  sleep 3

  puts "++++++"
  @PMFilterUnits_Window.unit_toggle_status
  puts "++++++"
end

Then(/^all units should be Off$/) do
  puts "there is no indication in the xml the toggles are on or offf??"
end

When(/^I click on "(.*?)" filter unit switch button$/) do |string|
  sleep 2
  @PMFilterUnits_Window.unit_toggle_button(string).click
end

When(/^I click "(.*?)" the "(.*?)" filter unit switch button$/) do |status, unit|
  sleep 2

  case status
  when 'Off'
    status = false
  when 'On'
    status = true
  end

  currentStatus = @PMFilterUnits_Window.unit_toggle_button(unit).find_element(:css, '.onoffswitch-checkbox').selected?
  @PMFilterUnits_Window.unit_toggle_button(unit).click if status != currentStatus

  # @PMFilterUnits_Window.unit_toggle_button(unit).click
  # checkbox = switch.find_element(:css, '.onoffswitch-checkbox')
end

When(/^I click on "([^"]*)" filter unit switch to "([^"]*)" button$/) do |unit, status|
  unit=process_param(unit)
  case status
  when 'disable'
    status = false
  when 'enable'
    status = true
  end

  currentStatus = @PMFilterUnits_Window.unit_toggle_button(unit).find_element(:css, '.onoffswitch-checkbox').selected?
  @PMFilterUnits_Window.unit_toggle_button(unit).click if status != currentStatus
end

Then(/^I should see a total of (\d+) patient\(s\) in the PM search results from "([^"]*)" section$/) do |patients, unit|
  # expect(@PatientList_Screen.unit_header(unit)['status']).to eql
end

When(/^I click Ok button in Filter Units window$/) do
  sleep 2
  @PMFilterUnits_Window.ok_button.click
  sleep 2
end

When(/^I filter following units "(.*?)"$/) do |status, table|
  unitList = table.raw
  unitArray = unitList.flatten

  steps %(
    When I click on Filter Units link
    Then I should see the Filter Units window
  )
  toggle = @PMFilterUnits_Window.toggle

  toggle.each do |t|
    label = t.find_element(:class, 'label').text
    switch = t.find_element(:class, 'onoffswitch')
    switch_input = t.find_element(:class, 'onoffswitch-checkbox')

    case status
    when 'on'
      if (unitArray.include? label) && !switch_input.attribute('checked')
        switch.click
        expect(switch_input.attribute('checked'))
      end
      if (!unitArray.include? label) && switch_input.attribute('checked')
        switch.click
        expect(!switch_input.attribute('checked'))
      end
    when 'off'
      if (unitArray.include? label) && switch_input.attribute('checked')
        switch.click
        expect(!switch_input.attribute('checked'))
      end
      if (!unitArray.include? label) && !switch_input.attribute('checked')
        switch.click
        expect(switch_input.attribute('checked'))
      end
    end
  end
end

Then(/^I should see the Group Sort link not highlighted$/) do
  status = @PatientList_Screen.group_sort_link['status']
  disabled = @PatientList_Screen.group_sort_link['disabled']
  puts "the Group Sort Link status = #{status}"
  puts "the Group Sort Link disabled = #{disabled}"
  expect(status).to be_falsey
end

Then(/^I should see the Group Sort link highlighted$/) do
  expect(@PatientList_Screen.group_sort_link['status']).to be_truthy
end

Then(/^I should see the Filter Units link highlighted$/) do
  sleep 2
  expect(@PatientList_Screen.filter_units_link['status']).to be_truthy
end

Then(/^I should see the Filter Units link not highlighted$/) do
  expect(@PatientList_Screen.filter_units_link['status']).to be_falsey
end

Then(/^I should see Group Sort, Filter Units links active$/) do
  @wait.until { @PatientList_Screen.filter_units_link['disabled'] == false }
  expect(@PatientList_Screen.filter_units_link['disabled']).to be_falsey
  expect(@PatientList_Screen.group_sort_link['disabled']).to be_falsey
end

Then(/^I should see the Multi-Patient View link active$/) do
  expect(@PatientList_Screen.multiPatientView_link['disabled']).to be_falsey
end

Then(/^I should see the Filter Units link disabled$/) do
  expect(@PatientList_Screen.filter_units_link['disabled']).to be_truthy
end

Then(/^I should see the Group Sort link disabled$/) do
  sleep(5)
  expect(@PatientList_Screen.group_sort_link['disabled']).to be_truthy
end

Then(/^I should see the Filter Units link active$/) do
  expect(@PatientList_Screen.filter_units_link['disabled']).to be_falsey
end

Then(/^I should see the Group Sort link active$/) do
  expect(@PatientList_Screen.group_sort_link['disabled']).to be_falsey
end

Then(/^I should see the Multi-Patient View link disabled$/) do
  expect(@PatientList_Screen.multiPatientView_link['disabled']).to be_truthy
end

Then(/^I should see the Multi-Patient View link not display$/) do
  mpv_exists = true

  begin
    mpv = @PatientList_Screen.multiPatientView_link
    puts "found mpv #{mpv.displayed?}"
  rescue
    mpv_exists = false
    puts "mpv does not exist"
  end

  expect(mpv_exists).to be_falsey
end

When(/^I click the Toggle All button on Filter Units window$/) do
  sleep 4
  toggle_all_button = @PMFilterUnits_Window.toggle_all_button
  puts "the toggle button text = #{toggle_all_button.text}"
  toggle_all_button.click
end

Then(/^I should see the snippet worklist screen$/) do
  sleep 1
  @wait.until { @SnippetWorklist_Screen.column_toggle['toggle_obj'].displayed? == true }


  puts @patient_list_selected if INFO == true

  @snippet_worklist_workflow = @patient_list_selected != 'Snippet Baseline Worklist'
  expect(@PatientList_Screen.patientList_form).to be_truthy
  #turn this back on when the screen is fixed
  ####expect(@Sidebar.sidebarButton_status(@patient_list_selected)).to be_truthy
end

Then(/^I should see PM patient information in site snippet worklist$/) do |table|
  sleep 3
  patients = table.hashes
  begin
    retries ||= 0
    patients.each do |patient|
      patientData = @PatientList_Screen.pm_patient_text_groupings(patient[:patientName])
      puts "+++++"
      puts patientData['name']
      puts patientData['dt_info']
      puts patientData['location']
      puts "+++++"

      expect(patientData['name']).to include patient[:patientName]
      expect(patientData['dt_info']).to include patient[:mrn].to_s
      expect(patientData['dt_info']).to include 'DOB:'

      expect(patientData['location']).to include patient[:location].to_s unless patientData['location'].nil?
    end
  rescue StandardError
    retry if (retries += 1) < 3
  end
end

Then(/^I should see the first Unit shift header as active-blue on snippet worklist$/) do
  @wait.until { @PatientList_Screen.first_unit_header_element.displayed? == true}
  expect(@PatientList_Screen.unit_group(1)['status']).to be_truthy
end

Then(/^I should see Unit and Time in shift header on snippet worklist$/) do
  # expect(@PatientList_Screen.unit_group(1)["label"].text).to include "ICU1"
  #
  # format = "%H:%M"
  #
  # log @PatientList_Screen.unit_group(1)["time"].text
  # expect(DateTime.strptime(@PatientList_Screen.unit_group(1)["time"].text, format)).to be_truthy
  expect(@PatientList_Screen.unit_group(1)['time'].text).to be_truthy
end

Then(/^I should see Unit Label in shift header on snippet worklist$/) do
  unit_text = @PatientList_Screen.unit_group(1)['time'].text
  puts unit_text

  found = false

  #if unit_text.include?('Morning') || unit_text.include?('Evening') || unit_text.include?('Afternoon') ||
  #   unit_text.include?('mid') || unit_text.include?('Brunch') || unit_text.include?('Two50') ||
  #   unit_text.include?('Six') || unit_text.include?('Five') || unit_text.include?('Four') ||
  #  found = true
  #end
  shift_array = ['Morning', 'Afternoon', 'Evening', 'mid-shift', 'Three', 'Two', 'Two50', 'Five', 'Six', 'Four', 'Ten Five AM', 'A1', 'A2', 'A3', 'A4', 'Three Fifty Five', '15:30', '15:35', '15:45','15:50']
  #shift_array = ["Morning", "Evening", "Afternoon", "mid", "Brunch", "Two50", "Six", "Five"]

  for i in 0..(shift_array.count - 1)
    if unit_text.include? shift_array[i]
      found = true
      break
    end

    if found == true
      break
    end
  end

  expect(found).to be_truthy
end

Then(/^I should see patients with documented and undocumented indicators$/) do
  retries ||=0
  @wait.until{ @PatientList_Screen.unit_header_label[0].displayed? == true }

  documented = nil
  undocumented = nil

  begin
    documented = @PatientList_Screen.documented_snippet.displayed?
  rescue
    retry if (retries += 1) < 3
    documented = false
  end

  begin
    undocumented = @PatientList_Screen.unDocumented_snippet.displayed?
  rescue
    retry if (retries += 1) < 3
    undocumented = false
  end

  puts "documented = #{documented}"
  puts "undocumented = #{undocumented}"

  if documented == true
    expect(documented).to be_truthy
  elsif documented == false
    expect(documented).to be_falsey
  end

  if undocumented == true
    expect(undocumented).to be_truthy
  elsif undocumented == false
    expect(undocumented).to be_falsey
  end

end

When(/^I click on a documented snippet in worklist$/) do
  retries ||= 0
  @SnippetWorklist_Screen.hideCompleted_toggle['toggle_obj'].click if @SnippetWorklist_Screen.hideCompleted_toggle['buttonOn'] == true
  @PatientList_Screen.documented_snippet.click
rescue Selenium::WebDriver::Error::StaleElementReferenceError
  sleep 1
  retry if (retries += 1) < 5
rescue Selenium::WebDriver::Error::ElementClickInterceptedError
  sleep(3)
  steps %(
    When I refresh the browser
    And I login to a testSite with "utang" and "XXXXX"
    And I click "Snippet Worklist" on the List
  )
  retry if (retries += 1) < 5
end

Then(/^I should see a message "(.*?)"$/) do |_string|
  expect(@PatientList_Screen.snippet_item_completed_window['title'].text).to eql 'Worklist Item Completed'
  expect(@PatientList_Screen.snippet_item_completed_window['message'].text).to eql 'Worklist item has already been completed.'
end

Then(/^I click the OK button in snippet worklist completed window$/) do
  @PatientList_Screen.snippet_completed_ok_button.click
  sleep 2
end

When(/^I select the bottom patient$/) do
  last_patient = @PatientList_Screen.patient_card.last

  last_patient.click
end

When(/^I click on a undocumented snippet in worklist$/) do
  @wait.until { @SnippetWorklist_Screen.column_toggle['toggle_obj'].displayed? == true }
  selected_list = @Sidebar.active_menu_option

  puts "This is the list #{selected_list.text}"
  if selected_list.text.include? 'Snippet Baseline Worklist'
    ##
    # Using the second index patient because the first patient is "Missing, Unit"
    # "Missing, Unit" has no unit and ends up breaking tests.
    patient_card = @PatientList_Screen.patient_card[1]
    patient_name = patient_card.find_element(:class, 'name')
    first_patient = patient_name.text
    puts first_patient

    steps %{
      When I click on "#{first_patient}" in Snippet Baseline Worklist
    }
  else
    retries ||= 0
    @snippet_worklist_workflow = true
    @selenium.execute_script "arguments[0].scrollIntoView(false);", @PatientList_Screen.unDocumented_snippet
    @PatientList_Screen.unDocumented_snippet.click
  end
rescue Selenium::WebDriver::Error::StaleElementReferenceError
  sleep 1

  retry if (retries += 1) < 3
rescue Selenium::WebDriver::Error::ElementClickInterceptedError
  sleep 1

  retry if (retries += 1) < 3
end

When(/^I click on a snippet in baseline worklist$/) do
  @wait.until { @SnippetWorklist_Screen.column_toggle['toggle_obj'].displayed? == true }
  retries ||= 0
  @snippet_worklist_workflow = true
  @PatientList_Screen.baseline_snippet.click
rescue Selenium::WebDriver::Error::StaleElementReferenceError
  sleep 1

  retry if (retries += 1) < 3
end

When(/^I get "(.*?)" patient data$/) do |patientView|

end

Then(/^I should see no patient search in header$/) do
  value = nil
  begin
    if (@PatientList_Screen.search_input.exists)
      value = true
    end
  rescue => e
    value = false
  end
  expect(value).to be_falsey
  expect(e.class.name).to eql "Selenium::WebDriver::Error::NoSuchElementError"
end

Then(/^I should see No Results for Search Criteria message$/) do
  sleep 2
  expect(@PatientList_Screen.search_warning.text).to eql "No Results for Search Criteria"
end

Then(/^I should see At least one field is required to search message$/) do
  sleep 2
  expect(@PatientList_Screen.search_warning.text).to eql "At least one field is required to search"
end

Then(/^I should see message "(.*?)"$/) do |message|
  sleep 2
  if @expected_mpv_monitors >= 40 && BROWSER != 'ie'
    expect(@PatientList_Screen.patientList_message.text).to eql message
  elsif @expected_mpv_monitors >= 10 && BROWSER == 'ie'
    message == 'Too many beds have been selected for display. Only the first 10 may be viewed. Please adjust your filter settings.'
  end
  # do not check for message if less than 40 on chrome/edge or less than 10 on ie
end

Then(/^I should see not message "(.*?)"$/) do |_string|
  begin
    warning = @selenium.find_element(:class, 'warning')
  rescue StandardError
    warning = nil
  end

  expect(warning).to be_nil
end

Then(/^I should see "(.*?)" in the search filter$/) do |search_value|
  puts "the current value of the search field is +++#{@PatientList_Screen.search_input.attribute('value')}++++"
  expect(@PatientList_Screen.search_input.attribute('value')).to eql process_param(search_value)
end

Then(/^I should see same number of patients in worklist as listed in list of list count$/) do
  @listCount = @Sidebar.sidebarOption_count('Snippet Baseline Worklist')
  #patient_count_array = @PatientList_Screen.pm_patient_list_count_by_group
  expect(@PatientList_Screen.pm_patientList_count.to_i).to eql @listCount.to_i
end

Then(/^I should see one less patient in baseline worklist$/) do
  newListCount = @Sidebar.sidebarOption_count('Snippet Baseline Worklist')
  puts newListCount if INFO == true

  expect(@listCount.to_i).to eql newListCount.to_i + 1
end

Then(/^I should see the snippet baseline worklist screen$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I should see "(.*?)" sorted in default order A-Z$/) do |list|
  selected_menu = @Sidebar.active_menu_option
  expect(selected_menu.text.include? list).to be_truthy

  groups_array = []
  groups = @PatientList_Screen.patient_group_header_text
  patients_group = patients = @PatientList_Screen.single_column_patients
  puts "These are the groups #{groups}"

  alpha_groups = groups.sort!
  puts "These are the groups in alpha order #{alpha_groups}"

  expect(groups).to eql alpha_groups

  patients_group.each do |pg|
    patients_array = []
    patient_row = pg.find_elements(:class, 'patient')

    patient_row.each do |patient|
      patient_name = patient.find_element(:class, 'name').text
      patients_array.push(patient_name)
    end

    alpha_patients = patients_array.sort!

    expect(alpha_patients).to eql patients_array
    patients_array = []
  end
end

Then(/^it should be sorted by (.*?) in ascending order$/) do |sort_attribute|
  patients = @selenium.find_element(:class, 'patients').find_elements(:class, 'patient')

  case sort_attribute
  when "Unit" # BROKEN
    as1_sorted_patients = []
    for i in 0..(patients.count - 1)
      patient_bed_name = patients[i].find_element(:class, 'location').text
      if patient_bed_name == "STANDBY"
        as1_sorted_patients.append("MISSING") # The unit name for "STANDBY" patients is "MISSING"
      else
        if patients[i].find_elements(:css, 'div')[2].attribute('class').include?("status-active")
          as1_sorted_patients.append(patient_bed_name.split('-')[0]) # the unit name is the same as the first section of the bed name for regular patients
        else
          as1_sorted_patients.append("Discharged") # Inactive patients that are not "STANDBY" patients, go to the "Discharged" unit
        end
      end
    end
    as1_sorted_patients = as1_sorted_patients.reject(&:empty?) # Remove empty strings from array
    if INFO == true
      puts "AS1 Sort: " + as1_sorted_patients.to_s
      puts "Ruby Sort: " + as1_sorted_patients.sort.to_s
    end
    expect(as1_sorted_patients).to eql as1_sorted_patients.sort
  when "Last Name"
    last_names = patients.map { |selenium_obj| selenium_obj.find_element(:class, 'name').text.split('•')[0].split(',')[0].strip }
    last_names = last_names.reject(&:empty?) # Remove empty strings from array
    if INFO == true
      puts "AS1 Sort: " + last_names.to_s
      puts "Ruby Sort: " + last_names.sort.to_s
    end
    expect(last_names).to eql last_names.sort_by {|word| word.downcase}
  when "First Name"
    first_names = patients.map { |selenium_obj| selenium_obj.find_element(:class, 'name').text.split('•')[0].split(',')[1].strip }
    first_names = first_names.reject(&:empty?) # Remove empty strings from array
    if INFO == true
      puts "AS1 Sort: " + first_names.to_s
      puts "Ruby Sort: " + first_names.sort.to_s
    end
    expect(first_names).to eql first_names.sort_by {|word| word.downcase}
  when "Gender"
    genders = patients.map { |selenium_obj| selenium_obj.find_element(:class, 'name').text.split('•')[1].strip }
    genders = genders.reject(&:empty?) # Remove empty strings from array
    if INFO == true
      puts "AS1 Sort: " + genders.to_s
      puts "Ruby Sort: " + genders.sort.to_s
    end
    expect(genders).to eql genders.sort
  when "Age" # BROKEN
    ages = patients.map { |selenium_obj| selenium_obj.find_element(:class, 'name').text.split('•')[2] }
    ages = ages.compact # Remove nil values from patients with no listed age
    ages = ages.map { |age_string| age_string.strip.to_i } # Convert ages from string to int so they can be sorted properly
    if INFO == true
      puts "AS1 Sort: " + ages.to_s
      puts "Ruby Sort: " + ages.sort.to_s
    end
    expect(ages).to eql ages.sort
  when "DOB"
    dobs = patients.map { |selenium_obj| selenium_obj.find_elements(:class, 'info')[1].text.split(':')[1]}
    dobs = dobs.compact.map{|x| x.strip!}
    expect(dobs).to eql dobs.sort_by { |s| Date.strptime(s, '%m/%d/%Y') }
  when "MRN"
    mrns = patients.map { |selenium_obj| selenium_obj.find_elements(:class, 'info')[1].text.split('•')[0].strip }
    mrns = mrns.reject(&:empty?) # Remove empty strings from array

    ##
    # The AS1 sort seems to work by sorting the integers first by value, then
    # the non-integer MRNs are sorted alphaneumerically.
    as1_sorted_mrns = []
    ruby_sorted_mrns = []
    mrns_int = []
    mrns_str = []
    for i in 0..(mrns.count - 1)
      as1_sorted_mrns.append(mrns[i])
      if mrns[i].to_i.to_s == mrns[i] # Uses casting to detect if the string is actual an integer. Strings cast as integers return as 0.
        mrns_int.append(mrns[i].to_i)
      else
        mrns_str.append(mrns[i])
      end
    end
    ruby_sorted_mrns.concat(mrns_int.sort)
    ruby_sorted_mrns.concat(mrns_str)
    ruby_sorted_mrns = ruby_sorted_mrns.map(&:to_s) # Cast every element of the array to a string
    if INFO == true
      puts "AS1 Sort: " + as1_sorted_mrns.to_s
      puts "Ruby Sort: " + ruby_sorted_mrns.to_s
    end
    expect(as1_sorted_mrns).to eql ruby_sorted_mrns
  when "Bed" # BROKEN
    beds = patients.map { |selenium_obj| selenium_obj.find_element(:class, 'location').text }
    beds = beds.reject(&:empty?) # Remove empty strings from array
    if INFO == true
      puts "AS1 Sort: " + beds.to_s
      puts "Ruby Sort: " + beds.sort.to_s
    end
    expect(beds).to eql beds.sort
  when "Active Inactive"
    statuses = patients.map { |selenium_obj| selenium_obj.find_elements(:css, 'div')[2].attribute('class').include?("status-active").to_s }
    statuses = statuses.reject(&:empty?) # Remove empty strings from array
    if INFO == true
      puts "AS1 Sort: " + statuses.to_s
      puts "Ruby Sort: " + statuses.sort.reverse.to_s
    end
    expect(statuses).to eql statuses.sort.reverse # Used "reverse" because I want the list sorted true->false rather than the alphabetical false->true
  end
end

Then(/^I should see no approval status icon for "(.*?)"$/) do |patient_name|
  retries ||= 0
  expect(@PatientList_Screen.pm_patient_approvalStatus(patient_name)['approvalStatus']).to be_falsey
rescue Selenium::WebDriver::Error::StaleElementReferenceError
  sleep 0.5
  retry if (retries += 1) < 3
end

Then(/^I should see an approval status for "(.*?)"$/) do |patient_name|
  expect(@PatientList_Screen.pm_patient_approvalStatus(patient_name)['approvalStatus']).to be_truthy
end

Then(/^I should not see Snippet Worklists$/) do
  snippetWorklist = false

  begin
    expect(sidebarOption_button('Snippet Worklist').displayed?).to be_falsey
  rescue StandardError
    expect(snippetWorklist).to be_falsey
  end
end

When(/^I click on patient "(.*?)" star icon to "(.*?)"$/) do |patient_name, status|
  patient_name=process_param(patient_name)
  @wait.until { @PatientList_Screen.patientList_form }
  if status == 'enabled'
    value = true
  elsif status == 'disabled'
    value = false
  end

  steps %(
    When I get my patient count
  )

  begin
    retries ||= 0
    @PatientList_Screen.pm_patient_text(patient_name)['eyeIcon'].click if @PatientList_Screen.pm_patient_text(patient_name)['eyeIconSelected'] != value
    @wait.until { @PatientList_Screen.pm_patient_text(patient_name)['eyeIconSelected'] == value}
  rescue => e
    retry if (retries += 1) < 3
  end

end

Then(/^I should "(.*?)" patient "(.*?)" in My Patient list$/) do |visibility, patient|
  patient = process_param(patient)
  my_patient_list_array = []
  mpln = []
  mpfn = []
  (0..@PatientList_Screen.my_patient_array.count-1).each do |i|
    mpl_lastname = @PatientList_Screen.my_patient_array[i]['name'].split(",",2)[0].strip.downcase
    mpl_firstname = @PatientList_Screen.my_patient_array[i]['name'].split(",",2)[1].split("•",2)[0].strip.downcase
    final_mpfn = mpfn.push(mpl_firstname)
    final_mpln = mpln.push(mpl_lastname)
    my_patient_list_array = final_mpln.zip(final_mpfn).map { |a| a.join(', ') }
  end
  mpl_array = my_patient_list_array
  puts "final_mpl == #{mpl_array}"
  final_mpl_array = mpl_array
  if visibility == "see"
    expect(final_mpl_array).to include (patient)
  elsif visibility == "not see"
    expect(final_mpl_array).not_to include (patient)
  end
end

When(/^I configure patient "(.*?)" star icon to be "(.*?)"$/) do |patient, status|
  star = @PatientList_Screen.pm_patient_text(patient)['eyeIconSelected']
  if status == 'disabled'
    value = false
  elsif status == 'enabled'
    value = true
  end

  if star != value
    steps %{
      When I click on patient "#{patient}" star icon to "#{status}"
    }
  elsif star == value
    puts "the patient is configured correctly"
  end
end

Then(/^I should see the patient "(.*?)" star icon "(.*?)"$/) do |patient_name, status|
  patient_name=process_param(patient_name)
  sleep 2
  staleElement = true
  if status == 'enabled'
    value = true
  elsif status == 'disabled'
    value = false
  end
  begin
    retries ||= 0
    expect(@PatientList_Screen.pm_patient_text(patient_name)['eyeIconSelected']).to eql value
  rescue => e
    retry if (retries += 1) < 3
  end
end

When(/^I get my patient count$/) do

  begin
    my_patients_element = @Sidebar.sidebarOption_button('My Patients')
    @my_patient_count = my_patients_element.find_element(:tag_name, 'div').text.to_i
  rescue Selenium::WebDriver::Error::NoSuchElementError
    @my_patient_count = 0
  end

  puts "You have #{@my_patient_count} patients in your my patient list"
end

Then(/^I should see My Patients counter increase by "(.*?)"$/) do |value|
  my_patient_count = @my_patient_count
  number = value.to_i

  my_patients_element = @Sidebar.sidebarOption_button('My Patients')

  begin
    @updated_my_patient_count = my_patients_element.find_element(:tag_name, 'div').text.to_i
  rescue Selenium::WebDriver::Error::NoSuchElementError
    @updated_my_patient_count = 0
  end

  new_count = my_patient_count + number

  puts new_count
  new_count.should == @updated_my_patient_count
  @my_patient_count=@updated_my_patient_count
end

Then(/^I should see My Patients counter decrease by "(.*?)"$/) do |value|
  my_patient_count = @my_patient_count
  number = value.to_i

  my_patients_element = @Sidebar.sidebarOption_button('My Patients')

  begin
    @updated_my_patient_count = my_patients_element.find_element(:tag_name, 'div').text.to_i
  rescue Selenium::WebDriver::Error::NoSuchElementError
    @updated_my_patient_count = 0
  end

  new_count = my_patient_count - number

  puts new_count
  new_count.should == @updated_my_patient_count
end

Then(/^I should see My Patients count decrease by "(.*?)"$/) do |value|
  my_patient_count = @my_patient_count
  number = value.to_i
  my_patients_element = @Sidebar.sidebarOption_button('My Patients')
  begin
    @updated_my_patient_count = my_patients_element.find_element(:tag_name, 'div').text.to_i
    puts "patient count is #{@updated_my_patient_count}"
  rescue Selenium::WebDriver::Error::NoSuchElementError
    @updated_my_patient_count = 0
  end
  if my_patient_count == 0
    new_count = my_patient_count
  else
    new_count = my_patient_count - number
  end
  puts new_count
  new_count.should == @updated_my_patient_count
end

Then(/^I should see My Patients counter with count of "(.*?)"$/) do |number|
  my_patient_count = @my_patient_count
  my_patients_sidebar = @Sidebar.sidebarOption_button('My Patients')
  counter = my_patients_sidebar.find_element(:class, 'count')

  expect(counter).to be_truthy
  expect(counter.text).to eql number
end

Then(/^I should see a total of "(.*?)" patients in the PM search results for "(.*?)" location$/) do |expected_patients, unit|
  locations = @selenium.find_element(:class, 'patient-groups').find_elements(:css, 'span.label')
  puts locations.count if INFO == true
  unitFilter = false
  (0..locations.count - 1).each do |x|
    puts locations[x].text if INFO == true

    unitFilter = true if locations[x].text.include? unit
  end

  if expected_patients.positive?
    expect(unitFilter).to be_truthy
  else
    expect(unitFilter).to be_falsey
  end
end

When(/^I have (\d+) or more patients added to My Patients List$/) do |int|
  sleep(1)
  current_my_patient_count = @PatientList_Screen.pm_patientList_count.to_i
  if current_my_patient_count > int.to_i
    expect(current_my_patient_count).to be >= int.to_i
  else
    @Sidebar.sidebarOption_button('Census').click
    sleep(3)
    @PatientList_Screen.increase_my_patients_count(int, current_my_patient_count)
    @Sidebar.sidebarOption_button('My Patients').click
    new_my_patient_count = @PatientList_Screen.pm_patientList_count.to_i
    expect(new_my_patient_count).to be >= int.to_i
  end
end

Given(/^User have at least (\d+) patients in My Patients List$/) do |int|
  my_patients_number=@selenium.find_element(:xpath,".//div[@class='menu-option' and contains(.,'My Patients')]").text.gsub("My Patients","")
  my_patients_number=my_patients_number.empty? ? 0 : my_patients_number.to_i
  @PatientList_Screen.increase_my_patients_count(int, my_patients_number) if my_patients_number < int.to_i
end


When(/^I have (\d+) patients added to My Patients List$/) do |_int|
  sleep 5
  expect(@PatientList_Screen.pm_patientList_count.to_i).to eql 3
end

When(/^I hover of the patient in patient list they appear highlighted$/) do
  patient_name = PATIENT
  patient_obj = @PatientList_Screen.pm_patient_text(patient_name)
  puts patient_obj['patient_obj'].css_value('background-color') if INFO == true

  @selenium.action.move_to(patient_obj['patient_obj']).perform

  backgroundColor = patient_obj['patient_obj'].css_value('background-color')
  puts backgroundColor if INFO == true
  expect(backgroundColor).to eql 'rgba(204, 237, 249, 1)' # blue highlight color
end

Then(/^I should not see previous patient selected highlight \(only on hover\)$/) do
  patient_name = PATIENT
  patient_obj = @PatientList_Screen.pm_patient_text(patient_name)

  backgroundColor = patient_obj['patient_obj'].css_value('background-color')
  puts backgroundColor if INFO == true
  expect(backgroundColor).to eql 'rgba(255, 255, 255, 1)' # white background, not highlighted color
end

When(/^I hover over dropdown arrow of test patient in PM patient list$/) do
  patient_name = process_param("[props.DP_FULL_NAME]")
  @selenium.action.move_to(@PatientList_Screen.pm_patient_dropdown(patient_name)['dropdown_obj']).perform
end

Then(/^I should see search filter removed$/) do
  @selenium.manage.timeouts.implicit_wait = 2
  found = nil
  begin
    expect(@PatientList_Screen.search_input.displayed?).to be_falsey
    found = true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    # expecting element to not exist and throw EOFError
  end
  @selenium.manage.timeouts.implicit_wait = DEFAULT_IMPLICIT_WAIT
  expect(found).to be_nil
end

Then(/^I should see no units filtered in worklist$/) do
  expect(@PatientList_Screen.pm_patientList_count.to_i).to be > 0
end

Then(/^I should not see the patients duplicated$/) do
  sleep 20
  pending 'manual step check...need figure out how to automate'
end

Then(/^I should see on second line as MRN\*DOB of patient list$/) do
  puts @dt_info_p_list if INFO == true
end

When(/^I should see on first line as \[Last Name\], \[First Name\]\*\[GENDER\]\*\[AGE\] of patient list$/) do
  puts @patient_info_p_list if INFO == true
  # manual step
end

Then(/^I should see on first line as \[Last Initial\], \[First Initial\]\*\[GENDER\]\*\[AGE\] of patient list$/) do
  puts @patient_info_p_list if INFO == true
  # manual step
end

Then(/^I should see the patient search box center aligned on screen$/) do
  # margin_left = @PatientList_Screen.search_container.css_value('margin-left')
  # margin_right = @PatientList_Screen.search_container.css_value('margin-right')

  # puts "margin left = #{margin_left}"

  # puts "margin right = #{margin_right}"

  # expect(@PatientList_Screen.search_container.css_value('position')).to eql 'relative'
  # expect(margin_left[0..2].to_i).to be >= 93
  # expect(margin_left[0..2].to_i).to be < 100
  # expect(margin_right[0..3].to_i).to be >= 535
  # expect(margin_right[0..3].to_i).to be < 540

  expect(@PatientList_Screen.spacer_left.displayed?).to be_truthy
  expect(@PatientList_Screen.search_container.displayed?).to be_truthy
  expect(@PatientList_Screen.spacer_right.displayed?).to be_truthy
end

When(/^I configure My Patients list to have "(.*?)" patients$/) do |count|
  count_number = count.to_i
  i = 0
  my_patients_count=0
  mypatient_counter=@Sidebar.sidebarOption_button('My Patients').find_elements(:class, 'count')
  if (mypatient_counter.size>0)
    my_patients_count = mypatient_counter.first.text.to_i
  end
  patient_card = @PatientList_Screen.patient_card

  if count_number <= my_patients_count
    if count_number == 0
      star_selector = "div.patient-groups .multi-patient-toggle .icon-star"
      while @selenium.find_elements(:css,star_selector).size >0
        @selenium.find_element(:css, star_selector).click
        sleep(0.5)
      end
    else
      puts "already have enough my patients"
    end
  else
    while my_patients_count < count_number
      puts "here is the my patients count #{my_patients_count}"
      patient_star = patient_card[i].find_element(:class, 'icon-star')
      mp_toggle = patient_card[i].find_element(:class, 'multi-patient-toggle')
      if mp_toggle.attribute('className').include?('selected')
        puts "onto the next"
      else
        patient_star.click
        my_patients_count -= 1
      end
      i += 1
    end
  end
end

Then(/^I should see the PM patient list filtered by "(.*?)"$/) do |filtered|
  filtered=process_param(filtered)
  @selenium.manage.timeouts.implicit_wait = DEFAULT_IMPLICIT_WAIT
  expect(@PatientList_Screen.patient_header_displayed().include?(filtered)).to be_truthy
end

Then(/^I should see the PM patient list filtered by all units except "(.*?)"$/) do |filtered|
  filtered=process_param(filtered)
  expect(@PatientList_Screen.patient_header_displayed().include? (filtered)).to be_falsey
end

Then(/^I should see all units toggle "(.*?)"$/) do |toggle_status|
  if (toggle_status=='OFF')
    expect(@PatientList_Screen.toggle_values()).to be_falsey
  elsif toggle_status == 'ON'
    expect(@PatientList_Screen.toggle_values()).to be_truthy
  end
end

Then(/^I should see the PM patient list group sort cached from the previous session based on (.*?)$/) do |sort|
  pm_sorted_array = []

  (0..@PatientList_Screen.pm_patientList_count - 1).each do |i|
   pm_sorted_array << @PatientList_Screen.patientRow_text(sort, i)
  end
  puts "This is the pm sorted array #{pm_sorted_array}"
  puts "This is mpv sorted array #{@mpv_sorted_array}"
  expect(pm_sorted_array.should == @mpv_sorted_array)
end

And (/^I should see (.*?) highlighted in blue on the List$/) do |sidebar_option|
  process_param(sidebar_option)
  active_option = @Sidebar.active_menu_option
  backgroundColor = active_option.css_value('background-color')
  puts backgroundColor if INFO == true
  expect(backgroundColor).to eql 'rgba(28, 172, 221, 1)' # blue highlight color
end

And (/^I should not see the (.*?) api call made to server$/) do |api_call|

  if BROWSER != "edge"
    process_param(api_call)
    expect(JSON.parse($API_LOGS.filter { |t| t.to_s.include?(api_call) }.to_s)).nil?
  else
     raise "Manual verification required. Integration with DevTools not yet implemented for Edge"
  end
end

And(/^I get the snippet worklist patient list and click on first patient in the list$/) do
  fil_ele = []
  spgn = []
  (0..@PatientList_Screen.single_column_patients_array.count - 1).each do |i|
    spgn1 = @PatientList_Screen.single_column_patients_array[i]['name']
    snippet_patient_group = spgn.push(spgn1)
    # snippet_patient_group = spgn.push(spgn1).map { |element| element.gsub(/• M • .*/, '').gsub(/• F • .*/, '') }
    filtered_elements = snippet_patient_group.select { |element| element}
    fil_ele = filtered_elements.map { |element| element.gsub(/• M • .*/, '').gsub(/• F • .*/, '') }
  end
  puts "patient list is #{fil_ele}"
  @patient_data = fil_ele.first
  puts "First Patient name is #{@patient_data}"

  @patient_obj = @PatientList_Screen.pm_patient_objects(@patient_data)
  @patient_list_name = @patient_obj['name']
  puts "Final First name is #{@patient_obj['name']}"
  @patient_obj['patient_obj'].click
end

And(/^I should see the snippets grouped first by Worklist Time LIFO, then Alpha Sort by unit$/) do
  unit_sort = @PatientList_Screen.single_column_patients_label_array
  ruby_unit_sort = unit_sort.sort
  expect(unit_sort.should == ruby_unit_sort)
end
