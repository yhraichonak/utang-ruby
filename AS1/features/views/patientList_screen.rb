# frozen_string_literal: true

Dir["#{File.dirname(__FILE__)}/../*.rb"].sort.each { |file| require file }

class PatientList_Screen
  def initialize(selenium)
    @selenium = selenium
  end

  def patient_card
    @selenium.find_elements(:class, 'patient')
  end

  def patientList_form
    @selenium.find_element(:css, '.patient-groups')
  end

  def patientGroup_header
    @selenium.find_element(:class, 'label')
  end

  def single_column_patients
    @selenium.find_elements(:css, 'div.patients.single-column')
  end

  def single_column_patients_array
    single_column_patients_array = []
    # patients_array = @selenium.find_elements(:xpath, "(//span[@class='label']/parent::header//following-sibling::div[@class='patients single-column'])[1]//div[@class='patient']")
    patients_array = @selenium.find_elements(:xpath, "(//span[@class='label' and contains(text(), 'ATQA')]/parent::header//following-sibling::div[@class='patients single-column'])[1]//div[@class='patient']")
    (0..patients_array.count - 1).each do |i|
      name = patients_array[i].find_element(:class, 'name')
      hash = {
        'name' => name.text
      }
      single_column_patients_array.push(hash)
    end
    return single_column_patients_array
  end

  def single_column_patients_label_array
    single_column_patients_array = []
    full_xpath = "//*[@id='patient-groups']/header/span[1]"
    patients_array = @selenium.find_elements(:xpath, full_xpath)
    patients_array.each do |element|
      single_column_patients_array.push(element.text)
    end
    return single_column_patients_array.uniq
  end

  def patients
    @selenium.find_elements(:class, 'patients')
  end


  def pm_patient_text(patient_name)
    sleep(5)
    patient = @selenium.find_elements(:class, 'patient')
    (0..patient.count - 1).each do |i|
      name = patient[i].find_element(:class, 'name')

      puts "Searching for #{patient_name}"
      puts "The name on the screen is #{name.text}"
      puts "Found = #{name.text.include? patient_name}"
      if patient_name.include?("matches:")
        next unless name.text.match? patient_name.gsub("matches:","")
      else
        next unless name.text.include? patient_name
      end

      demographics = name.find_element(:css, 'span.info').text
      infos = patient[i].find_elements(:class, 'info')
      dt_info = infos[1].text
      bed = patient[i].find_element(:css, 'div.meta.location').text
      statusColor = patient[i].find_element(:css, 'div.meta.location').css_value('background-color')

      myPatientToggle = patient[i].find_element(:class, 'multi-patient-toggle')
      eyeIcon = myPatientToggle.find_element(:id, 'Star')
      eyeIconSelected = false

      if myPatientToggle.attribute('className').include?('selected')
        eyeIconSelected = true
      end
      puts "the value of eyeIconSelected = #{eyeIconSelected}"

      case statusColor
      when 'rgba(28, 172, 221, 1)'
        statusColor = 'blue'
        status = 'active'
      when 'rgba(204, 204, 204, 1)'
        statusColor = 'gray'
        status = 'inactive'
      end

      return {
        'patient_obj' => patient[i],
        'name' => name.text,
        'demographics' => demographics,
        'dt_info' => dt_info,
        'bed' => bed,
        'statusColor' => statusColor,
        'status' => status,
        'eyeIcon' => eyeIcon,
        'eyeIconSelected' => eyeIconSelected
      }
    end
    raise "Patient not found [#{patient_name}]"
  end

  def star_icon
    myPatientToggle = patient[i].find_element(:class, 'multi-patient-toggle')
    starIcon = myPatientToggle.find_element(:id, 'Star')
    return starIcon
  end

  # def get_all_patient_info
  #   collected_patients = []
  #   patient = @selenium.find_elements(:class, 'patient')
  #   (0..patient.count - 1).each do |i|
  #     name = patient[i].find_element(:class, 'name')

  #     puts "The name on the screen is #{name.text}"
  #     puts "Found = #{name.text}"
  #     next unless name.text.include? patient_name

  #     demographics = name.find_element(:css, 'span.info').text
  #     infos = patient[i].find_elements(:class, 'info')
  #     dt_info = infos[1].text
  #     bed = patient[i].find_element(:css, 'div.meta.location').text
  #     statusColor = patient[i].find_element(:css, 'div.meta.location').css_value('background-color')

  #     myPatientToggle = patient[i].find_element(:class, 'multi-patient-toggle')
  #     eyeIcon = myPatientToggle.find_element(:id, 'Star')
  #     eyeIconSelected = false

  #     if myPatientToggle.attribute('className').include?('selected')
  #       eyeIconSelected = true
  #     end
  #     puts "the value of eyeIconSelected = #{eyeIconSelected}"


  #     patient[i] = {
  #       'patient_obj' => patient[i],
  #       'name' => name.text,
  #       'demographics' => demographics,
  #       'dt_info' => dt_info,
  #       'bed' => bed,
  #       'statusColor' => statusColor,
  #       'status' => status,
  #       'eyeIcon' => eyeIcon,
  #       'eyeIconSelected' => eyeIconSelected
  #     }
  #     puts "this is the patient object #{patient[i]}"
  #     collected_patients.push(patient[i])
  #   end

  # end

  def pm_patient_text_groupings(patient_name)
    puts "looking for patient #{patient_name}"
    locations = nil
    location = nil

    patient_group = @selenium.find_element(:class, 'patient-groups')
    patients = patient_group.find_elements(:class, 'patients')
    puts "total patient groups = #{patients.count}"
    locations = patient_group.find_elements(:css, '.location')
    found = false

    for x in 0..(patients.count - 1)
      puts "patient group #{x}"
      patient = patients[x].find_elements(:class, 'patient')
      puts "patient count = #{patient.count}"
      for i in 0..(patient.count - 1)
        name = patient[i].find_element(:class, 'name')
        #puts "#{i} = name = #{name.text}"
        if name.text.include? patient_name
          found = true
          # begin
          #   locations = patient[i].find_elements(:css, 'span.label')
          #   location = locations[i].text
          #   puts location
          # rescue StandardError
          #   # if group label is not grouped/sorted skip
          #   location = nil
          # end
          location=patient[i].find_elements(:xpath,'.//../preceding-sibling::header').last
          demographics = name.find_element(:css, 'span.info').text
          infos = patient[i].find_elements(:class, 'info')
          dt_info = infos[1].text
          bed = patient[i].find_element(:css, 'div.meta.location').text
          statusColor = patient[i].find_element(:css, 'div.meta.location').css_value('background-color')

          puts "#{name.text} #{demographics} #{dt_info} #{bed} #{statusColor}"

          case statusColor
          when 'rgba(28, 172, 221, 1)'
            statusColor = 'blue'
            status = 'active'
          when 'rgba(204, 204, 204, 1)'
            statusColor = 'gray'
            status = 'inactive'
          end
          break
        end

        if found == true
          break
        end
      end
      if found == true
        break
      end
    end

    return {
      'patient_obj' => patient[i],
      'name' => name.text,
      'demographics' => demographics,
      'dt_info' => dt_info,
      'location' => location.text,
      'bed' => bed,
      'statusColor' => statusColor,
      'status' => status
    }
  end

  def pm_patient_approvalStatus(patient_name)
    # patient_group = @selenium.find_element(:class, 'patient-groups')
    # patients = patient_group.find_elements(:class, 'patients')
    # (0..patients.count - 1).each do |x|
    patient = @selenium.find_elements(:class, 'patient')
    approved = nil

    (0..patient.count - 1).each do |i|
      name = patient[i].find_element(:class, 'name')

      @selenium.manage.timeouts.implicit_wait = 2
      begin
        snippet_indicator = patient[i].find_element(:class, 'snippet-update')
        todo = snippet_indicator.find_element(:class, 'todo')
        approved = if todo.attribute('className').include? 'done'
                     true
                   else
                     false
                   end
        approval_status = true if snippet_indicator.displayed?
      rescue StandardError
        approval_status = false
      end
      @selenium.manage.timeouts.implicit_wait = DEFAULT_IMPLICIT_WAIT

      if name.text.include? patient_name
        return {
          'patient_obj' => patient[i],
          'name' => name.text,
          'approvalStatus' => approval_status,
          'approved' => approved
        }
      end
    end
  end

  def pm_patient_dropdown(patient_name)
    # patient_group = @selenium.find_element(:class, 'patient-groups')
    # patients = patient_group.find_elements(:class, 'patients')
    # (0..patients.count - 1).each do |x|
    patient = @selenium.find_elements(:class, 'patient')

    (0..patient.count - 1).each do |i|
      name = patient[i].find_element(:class, 'name')
      options = patient[i].find_elements(:class, 'option')
      if name.text.include? patient_name
        return {
          'dropdown_obj' => patient[i].find_element(:class, 'drop-down'),
          'events_link' => options[0],
          'overview_link' => options[1]
          # ventilator_link' => options[2]
        }
      end
    end
  end

  def cardio_patient_objects(patient_name)
    patient_group = @selenium.find_element(:class, 'patient-groups')
    patient_groups = patient_group.find_elements(:class, 'patients')

    patient_found = false
    patient_obj = nil
    p_name = nil
    dt_info = nil
    ecg_info = nil
    ecg_count = nil

    for i in 0..(patient_groups.count - 1)
      patients = patient_groups[i].find_elements(:class, 'patient')

      for z in 0..(patients.count - 1)
        p_name = patients[z].find_element(:class, 'name')
        puts "in cardio text method patient name - #{p_name.text}"

        if p_name.text.include? patient_name
          patient_obj = patients[z]

          infos = patients[z].find_elements(:class, 'info')
          sex_age_info = infos[0].text
          dt_info = infos[1].text

          begin
            ecg_info = infos[2].text
            ecg_count = patient[z].find_element(:class, 'meta').text
          rescue

          end

          patient_found = true
        end

        if patient_found == true
          break
        end
      end

      if patient_found == true
        break
      end
    end

    return {
      'patient_obj' => patient_obj,
      'name' => p_name.text,
      'sex_age_info' => sex_age_info,
      'dt_info' => dt_info,
      'ecg_info' => ecg_info,
      'ecg_count' => ecg_count
    }
  end


  def pm_patient_objects(patient_name)
    patient_group = @selenium.find_element(:class, 'patient-groups')
    patient_groups = patient_group.find_elements(:class, 'patients').filter{|t| t.displayed?}

    patient_found = false
    patient_obj = nil
    p_name = nil
    dt_info = nil

    for i in 0..(patient_groups.count - 1)
      patients = patient_groups[i].find_elements(:class, 'patient')

      for z in 0..(patients.count - 1)
        p_name = patients[z].find_element(:class, 'name')
        is_regexp=false
        expected_name=patient_name
        if patient_name.include?("matches:")
          is_regexp=true
          expected_name = patient_name.gsub("matches:","")
        end


        if (!is_regexp && p_name.text.downcase.include?(expected_name.downcase)) ||(is_regexp && p_name.text.match?(expected_name))

          patient_obj = patients[z]
          demographics = p_name.find_element(:css, 'span.info').text
          drop_down = patients[z].find_elements(:class, 'drop-down')
          location = patients[z].find_elements(:class, 'drop-down')
          multi_patient_toggle = patients[z].find_elements(:class, 'multi-patient-toggle')
          infos = patients[z].find_elements(:class, 'info')
          sex_age_info = infos[0].text
          puts sex_age_info
          dt = infos[1]
          puts "++"
          dt_info = dt.find_element(:css, 'span')
          puts dt_info.text
          puts "++"
          patient_found = true
          break
        end

        if patient_found == true
          break
        end
      end

      if patient_found == true
        break
      end
    end

    return {
      'patient_obj' => patient_obj,
      'name' => p_name.text,
      'sex_age_info' => sex_age_info,
      'dt_info' => dt_info,
      'drop_down' => drop_down,
      'location' => location,
      'demographics' => demographics,
      'multi_patient_toggle' => multi_patient_toggle
    }
  end

  def patient_text(patient_name)
    patient_group_parent = @selenium.find_element(:class, 'patient-groups')
    patient_groups = patient_group_parent.find_elements(:class, 'patients').filter{|t| t.displayed?}

    patient_needed = nil
    found = false

    for i in 0..(patient_groups.count - 1)
      patients = patient_groups[i].find_elements(:class, 'patient')

      for x in 0..(patients.count - 1)
        patient_n = patients[x].find_element(:class, 'name').text
        puts "#{x} = #{patient_n}"
        if patient_n.include? patient_name
          patient_needed = patients[x]
          infos = patients[x].find_elements(:class, 'info')
          dt_info = infos[1].text

          begin
            ecg_info = infos[2].text
            ecg_count = patients[x].find_element(:class, 'meta').text
          rescue
            ecg_info =  nil
            ecg_count = nil
          end
          found = true
          break
        end

        if found == true
          break
        end
      end
      if found == true
        break
      end
    end
    return {
      'patient_obj' => patient_needed,
      'name' => patient_n,
      'dt_info' => dt_info,
      'ecg_info' => ecg_info,
      'ecg_count' => ecg_count
    }
  end

  def patient_text_og(patient_name)
    patient_group = @selenium.find_element(:class, 'patient-groups')
    patients = patient_group.find_element(:class, 'patients')
    patient = patients.find_elements(:class, 'patient')

    puts patient.count

    (0..patient.count).each do |i|
      name = patient[i].find_element(:class, 'name').text

      puts i
      puts name

      infos = patient[i].find_elements(:class, 'info')
      dt_info = infos[1].text

      begin
        ecg_info = infos[2].text
        ecg_count = patient[i].find_element(:class, 'meta').text
      rescue
        ecg_info =  nil
        ecg_count = nil
      end

      if name.include? patient_name
        return {
          'patient_obj' => patient[i],
          'name' => name,
          'dt_info' => dt_info,
          'ecg_info' => ecg_info,
          'ecg_count' => ecg_count
        }
      end
    end
  end

  def patient_group_header_text
    groups = @selenium.find_elements(:css, 'header.single-column')
    @group_array = []
    groups.each do |group|
      label = group.find_element(:class, 'label').text
      puts label
      @group_array.push(label)
    end

    return @group_array
  end

  def patientList_count
    # patient_group = @selenium.find_element(:class, 'patient-group')
    # patients = patient_group.find_element(:class, 'patients')
    patient = @selenium.find_elements(:class, 'patient')
    patient.count
  end

  def patient_groups_view
    @selenium.find_element(:id, 'patient-groups')
  end

  def patient_groups
    patient_groups = @selenium.find_element(:class, 'patient-groups')
    patients = patient_groups.find_elements(:class, 'patients')
    single_column = nil
    (0..patients.count - 1).each do |i|
      #puts "the class name for #{i} = #{patients[i].attribute('className')}"
      if patients[i].attribute('className').include? 'single-column'
        single_column = true
        puts 'On' if INFO == true
      else
        single_column = false
        puts 'Off' if INFO == true
      end
    end
    puts "the single column value = #{single_column}"
    {
      'single_column' => single_column,
      'obj' => patients
    }
  end

  def patientRow_text(info, index)
    patient = @selenium.find_elements(:xpath, "//div[@class='patient']")
    info_text = ''
    case info
    when 'name'
      info_text = patient[index].find_element(:class, 'name').text
    when 'last_name'
      info_text = patient[index].find_element(:class, 'name').text.split(', ').first
    when 'first_name'
      info_text = patient[index].find_element(:class, 'name').text.split(', ').last
    when 'unit'
      patients= patient[index].find_element(:xpath, './..')
      puts "#{patients.text}"
      patient_group = patients.find_element(:xpath, 'preceding-sibling::header')
      puts "#{patient_group.text}"
      locations = patient_group.find_elements(:css, 'span.label')
      info_text = locations.text
    when 'bed'
      info_text = patient[index].find_element(:css, 'div.meta.location').text
    when 'dob'
      infos = patient[index].find_elements(:class, 'info')
      info_text = infos[1].text.split(': ').last
    end
    return info_text
  end

  def pm_patientRow_text(row)
    tot_patient_counter = 0
    current_patient = row
    locations = nil
    location = nil

    patient_group = @selenium.find_element(:class, 'patient-groups')
    patients = @selenium.find_elements(:class, 'patients')

    (0..patients.count - 1).each do |x|
      patient = patients[x].find_elements(:class, 'patient')
      tot_patient_counter += patient.count

      if tot_patient_counter >= current_patient
        begin
          (locations = patient_group.find_elements(:css, 'span.label'))
          (location = locations[x].text)
        rescue StandardError
          # if group label is not grouped/sorted skip
          (location = nil)
        end

        (name = patient[row - 1].find_element(:class, 'name'))
        (demographics = name.find_element(:css, 'span.info').text)
        (infos = patient[row - 1].find_elements(:class, 'info'))
        (dt_info = infos[1].text)
        (bed = patient[row - 1].find_element(:css, 'div.meta.location').text)
        (statusColor = patient[row - 1].find_element(:css, 'div.meta.location').css_value('background-color'))

        # eyeIcon = patient[i].find_element(:css, 'icon-eye')
        # eyeIconSelected = false
        # if eyeIcon.attribute("className").include?("selected")
        #  eyeIconSelected = true
        # end

        case statusColor
        when 'rgba(28, 172, 221, 1)'
          statusColor = 'blue'
          status = 'active'
        when 'rgba(204, 204, 204, 1)'
          statusColor = 'gray'
          status = 'inactive'
        end

        return {
          'patient_obj' => patient[row - 1],
          'name' => name.text,
          'demographics' => demographics,
          'dt_info' => dt_info,
          'location' => location,
          'bed' => bed,
          'statusColor' => statusColor,
          'status' => status
          # "eyeIcon" => eyeIcon,
          # "eyeIconSelected" => eyeIconSelected
        }
      else
        row -= patient.count
      end
    end
  end

  def pm_patientList_count
    # patients = @selenium.find_elements(:class, 'patients').select{|i| i.displayed? == true}
    # patien_group = @selenium.find_element(:class, 'patient-groups')
    totalPatients = @selenium.find_elements(:class, 'patient').select{|i| i.displayed? == true}
    puts "-------"
    puts totalPatients.count
    puts "-------"
    totalPatients.count
  end

  def pm_patientGroup_count
    totalGroups = @selenium.find_elements(:class, 'patients').select{|i| i.displayed? == true}
    totalGroups.count
  end

  def patientGroup(index)
    groups = @selenium.find_elements(:class, 'patients').select{|i| i.displayed? == true}
    return groups[index]
  end

  def pm_patientList_filtered_out_count
    #patients = @selenium.find_element(:class, 'patients')
    patien_group = @selenium.find_element(:class, 'patient-groups')

    patients = patien_group.find_elements(:class, 'patients')

    total_filtered = 0

    for i in 0..(patients.count - 1)
      filtered_patients = patients[i].find_elements(:class, 'filtered-out')
      total_filtered = total_filtered + filtered_patients.count
    end
    puts total_filtered
    return total_filtered
  end

  def pm_patient_list_count_by_group
    patient_group = @selenium.find_element(:class, 'patient-groups')
    patients = patient_group.find_elements(:class, 'patients')
    puts "the number of patient groups = #{patients.count}"

    record_count_array = Array.new(patients.count)

    for i in 0..(patients.count - 1)
      patient_l = patients[i].find_elements(:class, 'patient')
      puts "group #{i} has #{patient_l.count} patients"
      record_count_array[i] = patient_l.count
    end

    return record_count_array
  end

  def title_text
    @selenium.find_element(:xpath, '//*[@id="body"]/section/div/div[1]')
  end

  def siteName_textView
    @selenium.find_element(:xpath, '//*[@id="body"]/section/div/div[2]/h4')
  end

  def patient_list
    @selenium.find_element(:id, 'patientListForm')
  end

  def unit_listView
    @selenium.find_element(:id, 'listView')
  end

  def patient_view
    @selenium.find_element(:class, 'patName')
  end

  def patient_selection(patient)
    elements = @selenium.find_elements(:class, 'patName')
    (0..(elements.count - 1)).each do |i|
      return elements[i] if elements[i].text.include? patient
    end
  end

  # should display "© 2017 - utang Technologies"
  def copyright_textView
    @selenium.find_element(:xpath, '//*[@id="mainDiv"]/footer/div/div[1]/p')
  end

  def selectedNavigationList
    @selenium.find_element(:css, 'div.menu-option.selected')
  end

  def search_field(search_name)
    search = @selenium.find_element(:class, 'search')
    search_fields = search.find_elements(:class, 'input-group')
    (0..(search_fields.count - 1)).each do |i|
      label = search_fields[i].find_element(:css, 'label')
      return search_fields[i].find_element(:css, 'input') if label.text == search_name
    end
  end

  def search_button
    return @selenium.find_element(:xpath, ".//input[@aria-label='Search']")
  end

  def search_warning
    warning = @selenium.find_element(:class, 'warning')
    return warning
  end

  def group_sort_link
    links = @selenium.find_elements(:css, 'a')
    (0..(links.count - 1)).each do |i|
      next unless links[i].text == 'Group / Sort'

      status = if links[i].attribute('className').include?('active')
                 true
               else
                 false
               end

      disabled = if links[i].attribute('className').include?('disabled')
                   true
                 else
                   false
                 end

      return {
        'link_obj' => links[i],
        'status' => status,
        'disabled' => disabled
      }
    end
  end

  def filter_units_link
    links = @selenium.find_elements(:css, 'a')
    (0..(links.count - 1)).each do |i|
      next unless links[i].text == 'Filter Units'

      status = if links[i].attribute('className').include?('active')
                 true
               else
                 false
               end

      disabled = if links[i].attribute('className').include?('disabled')
                   true
                 else
                   false
                 end

      return {
        'link_obj' => links[i],
        'status' => status,
        'disabled' => disabled
      }
    end
  end

  def multiPatientView_link
    links = @selenium.find_elements(:css, 'a')
    (0..(links.count - 1)).each do |i|
      next unless links[i].text == 'Multi-Patient View'

      status = if links[i].attribute('className').include?('active')
                 true
               else
                 false
               end

      disabled = if links[i].attribute('className').include?('disabled')
                   true
                 else
                   false
                 end

      return {
        'link_obj' => links[i],
        'status' => status,
        'disabled' => disabled
      }
    end
  end

  def search_input
    @selenium.find_element(:css, 'input.simple-search')
  end

  def spacer_left
    parent = @selenium.find_element(:class, 'sub-nav')
    spacer = parent.find_elements(:class, 'spacer-flex')
    return spacer[0]
  end

  def spacer_right
    parent = @selenium.find_element(:class, 'sub-nav')
    spacer = parent.find_elements(:class, 'spacer-flex')
    return spacer[1]
  end

  def search_container
    @selenium.find_element(:class, 'simple-search-container')
  end

  def unit_header(unit_name)
    patient_groups = @selenium.find_element(:class, 'patient-groups')
    headers = patient_groups.find_elements(:css, 'header')
    (0..headers.count - 1).each do |i|
      status = if headers[i].attribute('style').include? 'display: none;'
                 false
               else
                 true
               end
      label = headers[i].find_element(:class, 'label')
      if label.text == unit_name
        return {
          'label' => label,
          'status' => status
        }
      end
    end
  end

  def first_unit_header_element
    patient_groups = @selenium.find_element(:class, 'patient-groups')
    headers = patient_groups.find_elements(:css, 'header')
    return headers[0]
  end

  def unit_group(which)
    patient_groups = @selenium.find_elements(:class, 'patient-groups')
    # if patient_groups[which-1].attribute("className").include?("active")
    #  status = true
    # else
    #  status = false
    # end
    begin
      header = patient_groups[which - 1].find_element(:class, 'single-column')
    rescue Selenium::WebDriver::Error::NoSuchElementError
      header = patient_groups[which - 1].find_element(:class, 'active')
    end

    label = header.find_element(:class, 'label')
    @selenium.manage.timeouts.implicit_wait = 1
    time = header.find_element(:class, 'sub-label')
    status = if header.attribute('className').include?('active')
               true
             else
               false
             end
    @selenium.manage.timeouts.implicit_wait = DEFAULT_IMPLICIT_WAIT

    {
      'label' => label,
      'time' => time,
      'status' => status
    }
  end

  def unit_header_label
    @selenium.find_elements(:class, 'label')
  end

  def patient_snippet_indicator(row, name)
    # totalPatients = @selenium.find_elements(:class, 'patient')
    # totalPatients = totalPatients.count - 1

    patient_group = @selenium.find_elements(:class, 'patient-groups')

    patients = patient_group[row - 1].find_element(:class, 'patients')
    patient = patients.find_elements(:class, 'patient')

    (0..patient.count - 1).each do |i|
      next unless patient[i].find_element(:class, 'name').text.include? name

      snippet_indicator = patient[i].find_element(:class, 'snippet-update')
      todo = snippet_indicator.find_element(:class, 'todo')

      if todo.attribute('className').include?('done')
        status = true
        user = snippet_indicator.find_element(:css, 'span')
      else
        status = false
        user = nil
      end

      return {
        'snippet_indicator_obj' => snippet_indicator,
        'status' => status,
        'user' => user
      }
    end
  end

  def documented_snippet_old
    patient_group = @selenium.find_element(:class, 'patient-groups')
    patients = patient_group.find_elements(:class, 'patients')
    (0..patients.count - 1).each do |x|
      patient = patients[x].find_elements(:class, 'patient')

      (0..patient.count - 1).each do |i|
        snippet_indicator = patient[i].find_element(:class, 'snippet-update')
        todo = snippet_indicator.find_element(:class, 'todo')

        return snippet_indicator if todo.attribute('className').include?('done')
      end
    end
  end

  def documented_snippet
    patient_group = @selenium.find_element(:class, 'patient-groups')
    patients = patient_group.find_elements(:class, 'patients')

    found = false
    documented_snip = nil

    for i in 0..(patients.count - 1)
      patient = patients[i].find_elements(:class, 'patient')
      for z in 0..(patient.count - 1)
        snippet_indicator = patient[z].find_element(:class, 'snippet-update')
        todo = snippet_indicator.find_element(:class, 'todo')
        check_done = todo.attribute('className').include?('done')

        if check_done == true
          documented_snip = snippet_indicator
          break
        end
        if found == true
          break
        end
      end
      if found == true
        break
      end
    end
    return documented_snip
  end
  def first_patient_name()
    return @selenium.find_element(:css, '.patient .name').text
  end

  def unDocumented_snippet(return_name = false)
    patient_group = @selenium.find_element(:class, 'patient-groups')
    patients = patient_group.find_elements(:class, 'patients')
    (0..patients.count - 1).each do |x|
      patient = patients[x].find_elements(:class, 'patient')

      (0..patient.count - 1).each do |i|
        snippet_indicator = patient[i].find_element(:class, 'snippet-update')
        todo = snippet_indicator.find_element(:class, 'todo')

        if todo.attribute('className').include?('done')
          # do nothing - skip patient
        else
          if return_name
            return patient[i].find_element(:class, 'name')
          else
            return snippet_indicator
          end
        end
      end
    end
  end

  def baseline_snippet
    patient_group = @selenium.find_element(:class, 'patient-groups')
    patients = patient_group.find_elements(:class, 'patients')
    (0..patients.count - 1).each do |x|
      patient = patients[x].find_elements(:class, 'patient')
      return patient[0]
    end
  end

  def snippet_item_completed_window
    title = @selenium.find_element(:id, 'swal2-title')
    contents = @selenium.find_element(:id, 'swal2-content')

    {
      'title' => title,
      'message' => contents
    }
  end

  def snippet_completed_ok_button
    @selenium.find_element(:class, 'swal2-confirm')
  end

  def patientList_message
    @selenium.find_element(:class, 'warning')
  end

  def increase_my_patients_count(total_patients_needed, patients_already_added)
    mpv_toggles = @selenium.find_elements(:class, 'multi-patient-toggle')
    amount_needed = total_patients_needed.to_i - patients_already_added.to_i
    puts "Amount of patients needed is #{amount_needed}"
    puts "Amount of mpv toggles is #{mpv_toggles.length}"
    (0..(total_patients_needed.to_i - 1)).each do |index|
      selected = mpv_toggles[index].attribute('className')
      puts selected
      unless selected.include? "selected"
        star = mpv_toggles[index].find_element(:id, 'Star')
        star.click
      end
    end
  end

  def get_patient_group_patient_list_count()
    active_group = @selenium.find_element(:class, 'menu-option selected')
    patients = @selenium.find_element(:class, 'patients')
    patient_count = patients.find_elements(:class, 'patient').count

    $patient_count = patient_count
    return $patient_count
  end

  def starting_pm_patient
    patient = @selenium.find_elements(:class, 'patient')
    name = patient[0].find_element(:class, 'name')
    split_name = (name.text).split('•')[0].split(',', 2)
    first_name = split_name[1].delete("• •") + " " + split_name[0]
    last_name = split_name[0] + " " + split_name[1].delete("• •")
    demographics = name.find_element(:css, 'span.info').text
    infos = patient[0].find_elements(:class, 'info')
    dt_info = infos[1].text
    dt_info_split = dt_info.split(/ /, 2)
    mrn = dt_info_split[0]
    bed = patient[0].find_element(:css, 'div.meta.location').text
    statusColor = patient[0].find_element(:css, 'div.meta.location').css_value('background-color')
    eyeIcon = patient[0].find_element(:class, 'multi-patient-toggle')
    eyeIconSelected = false

    if eyeIcon.attribute('className').include?('selected')
      eyeIconSelected = true
    end

    case statusColor
    when 'rgba(28, 172, 221, 1)'
      statusColor = 'blue'
      status = 'active'
    when 'rgba(204, 204, 204, 1)'
      statusColor = 'gray'
      status = 'inactive'
    end

    return {
      'patient_obj' => patient[0],
      'name' => name.text,
      'firstname' => first_name,
      'lastname' => last_name,
      'mrn' => mrn,
      'demographics' => demographics,
      'dt_info' => dt_info,
      'bed' => bed,
      'statusColor' => statusColor,
      'status' => status,
      'eyeIcon' => eyeIcon,
      'eyeIconSelected' => eyeIconSelected
    }
  end

  def group_header_patient_name_compare(option)
    group_header = @selenium.find_element(:class, 'label')
    if starting_pm_patient[option].downcase == group_header.text.downcase
      return true
    else
      return false
    end
  end

  def patients_array
    @patients_array = []
    patient = @selenium.find_elements(:class, 'patient')
    (0..patient.count - 1).each do |i|
      name = patient[i].find_element(:class, 'name')

      demographics = name.find_element(:css, 'span.info').text
      infos = patient[i].find_elements(:class, 'info')
      dt_info = infos[1].text
      bed = patient[i].find_element(:css, 'div.meta.location').text
      statusColor = patient[i].find_element(:css, 'div.meta.location').css_value('background-color')

      eyeIcon = patient[i].find_element(:class, 'multi-patient-toggle')
      eyeIconSelected = false

      if eyeIcon.attribute('className').include?('selected')
        eyeIconSelected = true
      end

      case statusColor
      when 'rgba(28, 172, 221, 1)'
        statusColor = 'blue'
        status = 'active'
      when 'rgba(204, 204, 204, 1)'
        statusColor = 'gray'
        status = 'inactive'
      end

      hash = {
        'patient_obj' => patient[i],
        'name' => name.text,
        'demographics' => demographics,
        'dt_info' => dt_info,
        'bed' => bed,
        'statusColor' => statusColor,
        'status' => status,
        'eyeIcon' => eyeIcon,
        'eyeIconSelected' => eyeIconSelected
      }
      @patients_array.push(hash)
    end
    return @patients_array
  end

  def patient_header_displayed()
    headerList = []
    @selenium.manage.timeouts.implicit_wait = DEFAULT_IMPLICIT_WAIT
    header = @selenium.find_elements(:class, 'label')
    (0..header.count - 1).each do |i|
      headerList.push(header[i].text)
    end
    return headerList
  end

  def patient_type_list()
    patientList = []
    @selenium.manage.timeouts.implicit_wait = DEFAULT_IMPLICIT_WAIT
    list = @selenium.find_elements(:css, '.meta.location.status-active')
    (0..list.count - 1).each do |i|
      patientList.push(list[i].text)
    end
    return patientList
  end

  def toggle_values()
    is_toggle = false
    @selenium.manage.timeouts.implicit_wait = DEFAULT_IMPLICIT_WAIT
    filter_un_checked_items = @selenium.find_elements(:css, '.toggle .onoffswitch')
    filter_checked_items = @selenium.find_elements(:css, '.onoffswitch-checkbox:checked+.onoffswitch-label')
    checked_count = filter_checked_items.count
    unchecked_count = filter_un_checked_items.count

    if checked_count.eql?(0)
      is_toggle = false
    elsif checked_count.eql?(unchecked_count)
      is_toggle = true
    end
    return is_toggle
  end

  def cardio_patientRow_text(row)
    patient_group = @selenium.find_element(:class, 'patient-groups')
    patients = patient_group.find_element(:class, 'patients')
    patient = patients.find_elements(:class, 'patient')
    i = row - 1
    name = patient[i].find_element(:class, 'name')
    infos = patient[i].find_elements(:class, 'info')
    dt_info = infos[1]
    ecg_info = infos[2]
    ecg_count = patient[i].find_element(:class, 'meta')
    {
      'patient_obj' => patient[i],
      'name' => name,
      'dt_info' => dt_info,
      'ecg_info' => ecg_info,
      'ecg_count' => ecg_count
    }
  end

  def my_patient_array
    @my_patient_array = []
    my_patient = @selenium.find_elements(:class, 'patient')
    (0..my_patient.count - 1).each do |i|
      name = my_patient[i].find_element(:class, 'name')
      hash = {
        'name' => name.text
      }
      @my_patient_array.push(hash)
    end
    return @my_patient_array
  end
end
