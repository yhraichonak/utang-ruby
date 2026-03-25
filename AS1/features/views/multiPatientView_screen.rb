# frozen_string_literal: true

Dir["#{File.dirname(__FILE__)}/../*.rb"].sort.each { |file| require file }

class MultiPatientView_Screen
  def initialize(selenium)
    @selenium = selenium
  end

  def multi_patient_window
    @selenium.find_element(:class, 'surveil')
  end

  def single_lead_patient_info(which_patient)
    parent = @selenium.find_element(:class, 'patients')
    surveil_patients = parent.find_elements(:class, 'surveil-patient')

    patient_info = surveil_patients[which_patient.to_i - 1].find_element(:class, 'patient-info')
    name = patient_info.find_element(:class, 'name')
    location = patient_info.find_element(:class, 'location')
    #header = patient_info.find_element(:class, '')

    {
      'name' => name,
      'location' => location
    }
  end

  def mpv_first_patient
    parent = @selenium.find_element(:class, 'patients')
    surveil_patients = parent.find_elements(:class, 'surveil-patient')
    patient_info = surveil_patients[0].find_element(:class, 'patient-info')
    patient_name = patient_info.find_element(:class, 'name').text

    return patient_name
  end

  def single_lead_discretes(which_patient)
    parent = @selenium.find_element(:class, 'patients')
    surveil_patients = parent.find_elements(:class, 'surveil-patient')

    discretes = surveil_patients[which_patient.to_i - 1].find_element(:class, 'discretes')

    begin
      hr = discretes.find_element(:class, 'hr-beat-min')
      hr_title = hr.find_element(:class, 'title')
      heart_rate = hr.find_element(:class, 'value')
    rescue Selenium::WebDriver::Error::NoSuchElementError  => e
      e.message
      hr = discretes.find_element(:class, 'hr-bpm')
      hr_title = hr.find_element(:class, 'title')
      heart_rate = hr.find_element(:class, 'value')
    end

    begin
      pvc_bpm = discretes.find_element(:css, '.pvc-beat-min,.pvc-bpm')
      pvc_bpm_title = pvc_bpm.find_element(:class, 'title')
    rescue Selenium::WebDriver::Error::NoSuchElementError => e
      e.message
    end

    begin
      spo = discretes.find_element(:class, 'spo₂')
      spo_title = spo.find_element(:class, 'title')
    rescue Selenium::WebDriver::Error::NoSuchElementError => e
      e.message
    end

    begin
      nbp_mm_hg = discretes.find_element(:class, 'nbp-mm-hg')
      nbp_mm_hg_title = nbp_mm_hg.find_element(:class, 'title')
    rescue Selenium::WebDriver::Error::NoSuchElementError  => e
      e.message
    end

    begin
      rr_bpm = discretes.find_element(:css, '.rr-bpm,.rr-ecg-bpm')
      rr_bpm_title = rr_bpm.find_element(:class, 'title')
    rescue Selenium::WebDriver::Error::NoSuchElementError  => e
      e.message
    end

    begin
      pulse_rate_beat_min = discretes.find_element(:class, 'pulse-rate-beat-min')
      pulse_rate_beat_min_title = pulse_rate_beat_min.find_element(:class, 'title')
    rescue Selenium::WebDriver::Error::NoSuchElementError  => e
      e.message
    end

    begin
      cuff_pres = discretes.find_element(:class, 'cuff-pres-mm-hg')
      cuff_pres_title = cuff_pres.find_element(:class, 'title')
    rescue Selenium::WebDriver::Error::NoSuchElementError  => e
      e.message
    end

    {
      'hr' => hr,
      'hr_title' => hr_title,
      'heart_rate' => heart_rate,
      'spo' => spo,
      'spo_title' => spo_title,
      'nbp_mm_hg' => nbp_mm_hg,
      'nbp_mm_hg_title' => nbp_mm_hg_title,
      'rr_bpm' => rr_bpm,
      'rr_bpm_title' => rr_bpm_title,
      'pulse_rate_beat_min' => pulse_rate_beat_min,
      'pulse_rate_beat_min_title' => pulse_rate_beat_min_title,
      'pvc_bpm' => pvc_bpm,
      'pvc_bpm_title' => pvc_bpm_title,
      'cuff_pres' => cuff_pres,
      'cuff_pres_title' => cuff_pres_title
    }
  end

  def condensedPatientMonitors
    window = @selenium.find_element(:class, 'surveil')
    window.find_elements(:class, 'surveil-patient')
  end

  def condensedPatientMonitor(patient_name)
    window = @selenium.find_element(:class, 'patients')
    patientMonitors = window.find_elements(:class, 'surveil-patient')
    (0..patientMonitors.count - 1).each do |x|
      name = patientMonitors[x].find_element(:class, 'name')

      puts name.text if INFO == true

      next unless name.text.include? patient_name

      location = patientMonitors[x].find_element(:class, 'location')
      chart = patientMonitors[x].find_element(:class, 'chart')
      discretes = patientMonitors[x].find_element(:class, 'discretes')
      alarmInfo = patientMonitors[x].find_element(:css, 'header')

      return {
        'monitor_obj' => patientMonitors[x],
        'name' => name.text,
        'chart' => chart,
        'discretes' => discretes,
        'location' => location,
        'alarmInfo' => alarmInfo
      }
    end
  end

  def multipatients_array
    @multipatients_array = []
    patient = @selenium.find_elements(:class, 'surveil-patient')
    (0..patient.count - 1).each do |i|
      name = patient[i].find_element(:class, 'name')
      location = patient[i].find_element(:class, 'location')



      hash = {
        'patient_obj' => patient[i],
        'name' => name.text,
        'location' => location
      }
      @multipatients_array.push(hash)
    end
    return @multipatients_array
  end

  def dragable_patient_card
    list = @selenium.find_element(:class, 'patient-list-items')
    patient_card = list.find_elements(:class, 'patientDrag')
    return patient_card
  end

  def dragable_patients_array
    @dragpatients_array = []
    patient = @selenium.find_elements(:class, 'patientDrag')
    (0..patient.count - 1).each do |i|
      name = patient[i].find_element(:class, 'name')
      location = patient[i].find_element(:class, 'location')



      hash = {
        'patient_obj' => patient[i],
        'name' => name.text,
        'location' => location
      }
      @dragpatients_array.push(hash)
    end
    return @dragpatients_array
  end

  def monitorClose_button
    @selenium.find_element(:class, 'close')
  end

  def monitorCharts
    @selenium.find_element(:class, 'monitor-charts')
  end

  def zoomControl_slider
    slider = @selenium.find_element(:class, 'font-size')
    slider.find_element(:css, 'input')
  end

  def zoomControl_status
    slider = @selenium.find_element(:class, 'font-size')
    if slider.attribute('className').include? 'disabled'
      false
    else
      true
    end
  end

  def time_live_button_object(patient_count)
    time_live_button_objects = Array.new(patient_count)

    split_container = @selenium.find_element(:class, 'split-screen-container')
    split_screens = split_container.find_elements(:class, 'split-screen-item')

    split_screens_count = split_screens.count

    puts "patient count = #{split_screens_count}"

    (0..(split_screens.count - 1)).each do |z|
      # monitor_widget = split_screens[z].find_element(:class, 'monitor widget')
      sub_nav = split_screens[z].find_element(:class, 'sub-nav')
      span = sub_nav.find_elements(:css, 'span')
      links = span[1].find_elements(:css, 'a')

      # for i in 0..(links.count - 1)
      # puts links[i].text
      # end

      time_live_button_objects[z] = [links[0], links[1]]
    end

    return time_live_button_objects
  end

  def found_time_live_button_object
    time_live_button_objects = Array.new(['', ''])

    split_container = @selenium.find_element(:class, 'split-screen-container')
    split_screens = split_container.find_elements(:class, 'split-screen-item')

    split_screens_count = split_screens.count

    puts "patient count = #{split_screens_count}"

    (0..(split_screens.count - 1)).each do |z|
      begin
        sub_nav = split_screens[z].find_element(:class, 'sub-nav')
        span = sub_nav.find_elements(:css, 'span')
        links = span[1].find_elements(:css, 'a')

        time_live_button_objects[z] = [links[0], links[1]]
        return true
      rescue
        return false
      end
    end

  end

  # def lef_nav_objects
  # side_nav = @selenium.find_element(:class, 'side-nav')
  #  hrefs = side_nav.find_elements(:)
  # end

  def sub_nav_buttons
    side_nav = @selenium.find_element(:class, 'side-nav')
    buttons = side_nav.find_elements(:css, 'a')

    patient_list = buttons[0]
    multi = buttons[1]
    single_lead = buttons[1]
    dual_lead = buttons[2]
    quad_lead = buttons[3]
    six_lead = buttons[4]
    nine_lead = buttons[5]
    twelve_lead = buttons[6]
    sixteen_lead = buttons[7]

    {
      'patient_list' => patient_list,
      'multi' => multi,
      'single_lead' => single_lead,
      'dual_lead' => dual_lead,
      'quad_lead' => quad_lead,
      'six_lead' => six_lead,
      'nine_lead' => nine_lead,
      'twelve_lead' => twelve_lead,
      'sixteen_lead' => sixteen_lead
    }
  end

  def condensedMonitorView_button
    side_nav = @selenium.find_element(:class, 'side-nav')
    buttons = side_nav.find_elements(:css, 'a')
    buttons[1]
  end

  def side_nav_button(view_number)
    side_nav = @selenium.find_element(:class, 'side-nav')
    buttons = side_nav.find_elements(:css, 'a')

    found = false
    button = nil
    if view_number === 'patient-list'
      button = buttons[0]
    else
      (0..(buttons.count - 1)).each do |i|
        puts "button #{i} = #{buttons[i].text}"
        if buttons[i].text == view_number.to_s
          puts "found the side nav view button #{buttons[i].text}"
          # puts "the class name = #{buttons[i].attribute('className')}"
          found = true
          button = buttons[i]
          break
        end
        if found == true
          break
        end
    end
  end

    return button
  end

  def dualMonitorView_button
    side_nav = @selenium.find_element(:class, 'side-nav')
    buttons = side_nav.find_elements(:css, 'a')

    found = false
    button = nil

    (0..(buttons.count - 1)).each do |i|
      puts "button #{i} = #{buttons[i].text}"
      if buttons[i].text == '2'
        puts "found the dual monitor button #{buttons[i].text}"
        puts "the class name = #{buttons[i].attribute('className')}"
        found = true
        button = buttons[i]
        break
      end
      if found == true
        break
      end
    end

    return button
  end

  def quadMonitorView_button
    side_nav = @selenium.find_element(:class, 'side-nav')
    buttons = side_nav.find_elements(:css, 'a')
    quad_button = nil
    found = false

    (0..(buttons.count - 1)).each do |i|
      puts "button #{i} = #{buttons[i].text}"
      if buttons[i].text == '4'
        puts "found the quad monitor button #{buttons[i].text}"
        puts "the class name = #{buttons[i].attribute('className')}"
        quad_button = buttons[i]
        found = true
        break
      end
      if found == true
        break
      end
    end

    return quad_button
  end

  def sixMonitorView_button
    # side_nav = @selenium.find_element(:class, 'side-nav')
    # button = side_nav.find_element(:xpath, "//a[@href='6']")
    # @selenium.find_element(:class, 'icon-six-view')

    side_nav = @selenium.find_element(:class, 'side-nav')
    buttons = side_nav.find_elements(:css, 'a')

    found = false

    (0..(buttons.count - 1)).each do |i|
      puts "button #{i} = #{buttons[i].text}"
      if buttons[i].text == '6'
        puts "found the dual monitor button #{buttons[i].text}"
        puts "the class name = #{buttons[i].attribute('className')}"
        found = true
        break
      end
      if found == true
        break
      end
    end

    return buttons[i]
  end

  def eightMonitorView_button
    @selenium.find_element(:class, 'icon-eight-view')
  end

  def nineMonitorView_button
    # side_nav = @selenium.find_element(:class, 'side-nav')
    # button = side_nav.find_element(:xpath, "//a[@href='9']")
    # @selenium.find_element(:class, 'icon-nine-view')

    side_nav = @selenium.find_element(:class, 'side-nav')
    buttons = side_nav.find_elements(:css, 'a')

    found = false

    (0..(buttons.count - 1)).each do |i|
      puts "button #{i} = #{buttons[i].text}"
      if buttons[i].text == '9'
        puts "found the dual monitor button #{buttons[i].text}"
        puts "the class name = #{buttons[i].attribute('className')}"
        found = true
        break
      end
      if found == true
        break
      end
    end

    return buttons[i]
  end

  def twelveMonitorView_button
    # side_nav = @selenium.find_element(:class, 'side-nav')
    # button = side_nav.find_element(:xpath, "//a[@href='12']")

    side_nav = @selenium.find_element(:class, 'side-nav')
    buttons = side_nav.find_elements(:css, 'a')

    found = false

    (0..(buttons.count - 1)).each do |i|
      puts "button #{i} = #{buttons[i].text}"
      if buttons[i].text == '12'
        puts "found the dual monitor button #{buttons[i].text}"
        puts "the class name = #{buttons[i].attribute('className')}"
        found = true
        break
      end
      if found == true
        break
      end
    end

    return buttons[i]
  end

  def sixteenMonitorView_button
    # side_nav = @selenium.find_element(:class, 'side-nav')
    # button = side_nav.find_element(:xpath, "//a[@href='16']")

    side_nav = @selenium.find_element(:class, 'side-nav')
    buttons = side_nav.find_elements(:css, 'a')

    found = false

    (0..(buttons.count - 1)).each do |i|
      puts "button #{i} = #{buttons[i].text}"
      if buttons[i].text == '16'
        puts "found the dual monitor button #{buttons[i].text}"
        puts "the class name = #{buttons[i].attribute('className')}"
        found = true
        break
      end
      if found == true
        break
      end
    end

    return buttons[i]
  end

  def fullPatientMonitors
    @selenium.find_elements(:css, 'div.monitor.widget')
  end

  def hidePHI_button
    mpv = @selenium.find_element(:class, 'surveil')
    sub_nav = mpv.find_element(:class, 'sub-nav')
    buttons = sub_nav.find_elements(:css, 'a')
    (0..buttons.count - 1).each do |x|
      return buttons[x] if buttons[x].text.include? 'Hide PHI'
    end
  end

  def bodySensorObservations_view
    @selenium.find_element(:class, 'ObservationsMPV__BodySensorPatients-sc-7r0r-5')
  end

  def bodySensorEvents_view
    @selenium.find_element(:class, 'EventsMPV__WidgetContent-sc-ex1v4-1')
  end

  def MPV_ObservationView_Patients
    patients = @selenium.find_elements(:class, 'PatientMPV__BodySensorSection-sc-exd6xl-0')
  end

  def MPV_EventTileView_Patients
    patients = @selenium.find_elements(:class, 'PatientTile__PatientWrapper-sc-48r23h-0')
  end

  def sideNav_50view
    @selenium.find_element(:class, 'icon-fifty-view')
  end

  def sideNav_observationView
    @selenium.find_element(:class, 'icon-multi')
  end

  def biointel_viewOptions
    @selenium.find_elements(:class, 'SideNav__IconWrapper-sc-crrnk0-2')
  end

  def mpv_link_button
    @selenium.find_element(:class, 'Multi-Patient View')
  end

  def eachC3poCondensedMonitorDetailsIsDisplayed()
    patientMonitors = @selenium.find_elements(:class, 'surveil-patient')
    (0..patientMonitors.count - 1).each do |x|
      name = patientMonitors[x].find_element(:class, 'name')
      puts name.text if INFO == true
      next unless (patientMonitors.count-1).eql? 40
      location = patientMonitors[x].find_element(:class, 'location')
      chart = patientMonitors[x].find_element(:class, 'chart')
      discretes = patientMonitors[x].find_element(:class, 'discretes')
      alarmInfo = patientMonitors[x].find_element(:css, 'header')
      return {
        'monitor_obj' => patientMonitors[x],
        'name' => name.text,
        'chart' => chart,
        'discretes' => discretes,
        'location' => location,
        'alarmInfo' => alarmInfo
      }
    end
  end

  def mpv_patientListTabs(tabName)
    @selenium.manage.timeouts.implicit_wait = 2
    patient_lists = @selenium.find_element(:css, '.patient-list .list-head')
    tabs = patient_lists.find_elements(:class, 'tab')
    (0..tabs.count - 1).each do |x|
      if tabs[x].text == tabName
        tabs[x].click
      end
    end
  end

  def mpv_patient_list_slideout_component
    @selenium.find_element(:class, 'patient-list')
  end

  def census_patient_list
    @selenium.manage.timeouts.implicit_wait = 3
    @census_patient_list = []
    patient = @selenium.find_elements(:css, 'div.patient-list-item.patientDrag')
    puts "census patient count: #{patient.count}"
    (0..patient.count - 1).each do |i|
      name = patient[i].find_element(:class, 'name')
      location = patient[i].find_element(:class, 'location')
       hash = {
        'patient_obj' => patient[i],
        'name' => name.text,
        'location' => location
      }
      @census_patient_list.push(hash)
    end
    return @census_patient_list
  end

  def verifyPatientName
    names = @selenium.find_elements(:class, 'name-age')
    (0..names.count - 1).each do |x|
      next if names[x].text.empty?

      if INFO == true
        puts names[x].text
        puts names[x].text.length
      end
      expect(names[x].text.length).to be <= 11
    end
  end

  def multi_patient_window_back_button
    backButtonText = @selenium.find_element(:css, 'a[class="back-btn"]')
    return backButtonText
  end

end
