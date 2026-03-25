Dir[File.dirname(__FILE__) + '/../*.rb'].each {|file| require file }

class Patient_List_screen
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end

  def action_bar
    return Element.new(@selenium, :id, "#{APP_PACKAGE}:id/action_bar")
  end

  def action_bar_site
    return Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_site")
  end

  def action_bar_tv_site
    return @selenium.find_element(:id, "#{APP_PACKAGE}:id/tv_site")
  end

  def action_bar_tv_site_element
    return Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_site")
  end

  def navigation_bar(arg1)
    return Element.new(@selenium, :id, 'android:id/action_bar_title')
  end

  def patient_list_obj
    return @selenium.find_element(:id, "#{APP_PACKAGE}:id/patient_listitem_content")
  end

  def patient_list_form
    return @selenium.find_element(:id, 'android:id/list')
  end

  def patient_group_header
    @selenium.find_element
  end

  def getNumOfPatientsInList
    return @selenium.find_elements(:xpath, 'android.widget.GridView[1]/android.widget.FrameLayout').count
  end

  def return_patient_ob_object(which_patient_cell)
	parent = @selenium.find_element(:id, 'android:id/list')

    e = parent.find_elements(:id, "#{APP_PACKAGE}:id/patient_listitem_content")

    full_name = e[which_patient_cell].find_element(:id, "#{APP_PACKAGE}:id/tv_name").text

    age_sex = ''

		begin
			age_sex = e[which_patient_cell].find_element(:id, "#{APP_PACKAGE}:id/tv_name_sub").text
			if(age_sex.nil?)
				age_sex = 'no value provided'
			end
		rescue

		end

    membrane_status = e[which_patient_cell].find_element(:id, "#{APP_PACKAGE}:id/tv_date").text

    gradiva_para_time = e[which_patient_cell].find_element(:id, "#{APP_PACKAGE}:id/tv_message").text

    doctor = e[which_patient_cell].find_element(:id, "#{APP_PACKAGE}:id/tv_content_right_1").text

    location = e[which_patient_cell].find_element(:id, "#{APP_PACKAGE}:id/tv_content_right_3").text

    return {
      'full_name' => full_name,
      'age_sex' => age_sex,
      'membrane_status' => membrane_status,
      'gradiva_para_time' => gradiva_para_time,
      'doctor' => doctor,
      'location' => location
    }
  end

  def return_patient_emr_object(which_patient_cell)
    sleep(4)

    e = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/patient_listitem_content")

    txtviews = e[which_patient_cell].find_elements(:class, 'android.widget.TextView')

    full_name = txtviews[0].text

    age_sex = txtviews[1].text

    dob = txtviews[2].text

    location = txtviews[3].text

    return {
      'full_name' => full_name,
      'age_sex' => age_sex,
      'dob' => dob,
      'location' => location
    }
  end

  def get_search_results_obj(name)
	grid = @selenium.find_element(:id, 'android:id/list')
	list_item_contents = grid.find_elements(:id, "#{APP_PACKAGE}:id/patient_listitem_content")
	full_name = ''
	current_status = ''
	misc_info = ''
	doctor_name = ''
	location = ''

	for i in (0..(list_item_contents.count - 1))
		content_main = list_item_contents[i].find_element(:id, "#{APP_PACKAGE}:id/content_main")
		full_name = content_main.find_element(:id, "#{APP_PACKAGE}:id/tv_name")

		if(full_name.text == name)
			current_status = content_main.find_element(:id, "#{APP_PACKAGE}:id/tv_date")
			misc_info = content_main.find_element(:id, "#{APP_PACKAGE}:id/tv_message")
			content_right = list_item_contents[i].find_element(:id, "#{APP_PACKAGE}:id/content_right")
			doctor_name = content_right.find_element(:id, "#{APP_PACKAGE}:id/tv_content_right_1")
			location = content_right.find_element(:id, "#{APP_PACKAGE}:id/tv_content_right_3")
			break
		else
			'no patients found'
		end
	end

	return {
      'full_name' => full_name.text,
      'current_status' => current_status.text,
      'misc_info' => misc_info.text,
      'doctor_name' => doctor_name.text,
      'location' => location.text
	}
  end

  def patient_exists(full_name)
    elements = @selenium.find_elements(:class, 'android.widget.TextView')

    found = false

    elements.each { |b|

      if b.text == full_name
        found = true
        break
      end
    }
    return found
  end

  def get_patient_obj(which)
    elements = @selenium.find_elements(:class, 'android.widget.TextView')

    counter = 0
    ##puts  elements.length

    start = 0

    elements.each { |b|
      if b.text == which
        start = counter
        break
      end
      counter = counter + 1
    }

    ##puts start

    full_name = elements.at(start).text
    start = start + 1
    age_sex = elements.at(start).text
    start = start + 1
    time_info = elements.at(start).text
    start = start + 1
    ecg_info = elements.at(start).text
    start = start + 1
    ecg_count = elements.at(start).text

    return {
      'full_name' => full_name,
      'age_sex' => age_sex,
      'time_info' => time_info,
      'ecg_info' => ecg_info,
      'ecg_count' => ecg_count
    }
  end

  def new(patient_name)
	list = @selenium.find_element(:id, 'android:id/list')
	cardids = list.find_elements(:id, "#{APP_PACKAGE}:id/list_cardId")

	for i in 0..(cardids.count - 1)
		patient_list_item = cardids[i].find_element(:id, "#{APP_PACKAGE}:id/patient_listitem_content")
		txts = patient_list_item.find_elements(:class, 'android.widget.TextView')
		imgs = patient_list_item.find_elements(:class, 'android.widget.ImageView')
		for b in 0..(txts.count - 1)
			if(txts[b].text == patient_name)
				return imgs[0]
			end
		end
	end
  end

  def patient_overflow_menu(which)
	patient_list_items = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/patient_listitem_content")

	for i in 0..(patient_list_items.count - 1)
		tv_name = patient_list_items[i].find_element(:id, "#{APP_PACKAGE}:id/tv_name")
    name1 = tv_name.text.downcase
    name2 = which.downcase
		if(tv_name.text.downcase == which.downcase)
			return patient_list_items[i].find_element(:id,"#{APP_PACKAGE}:id/context_menu")
		end
	end
  end

  def patient_list_cardio_button
	txts = @selenium.find_elements(:class, 'android.widget.TextView')

	for i in 0..(txts.count - 1)
		if(txts[i].text == 'Cardio')
			return txts[i]
		end
	end
	return
  end

  def patient_list_events_button
	txts = @selenium.find_elements(:class, 'android.widget.TextView')

	for i in 0..(txts.count - 1)
		if(txts[i].text == 'Events')
			return txts[i]
		end
	end
	return
  end

  def patient_list_live_monitor_button
	txts = @selenium.find_elements(:class, 'android.widget.TextView')

	for i in 0..(txts.count - 1)
		if(txts[i].text == 'Live Monitor')
			return txts[i]
		end
	end
	return
  end

  def patient_list_button(button)
    case button
    when 'Home'
      button = @selenium.find_element(:id, "#{APP_PACKAGE}:id/menu_home")
    when 'Monitor'
      button = @selenium.find_element(:id, "#{APP_PACKAGE}:id/menu_1")
    when 'Events'
      button = @selenium.find_element(:id, "#{APP_PACKAGE}:id/menu_2")
    when 'Tools'
      button = @selenium.find_element(:id, "#{APP_PACKAGE}:id/menu_3")
    when 'Share'
      button = @selenium.find_element(:id, "#{APP_PACKAGE}:id/menu_share")
    end
    return button
  end

  def patient_cell(patient_name)
    trycount = 0
    found = false
    row = 0
    while !found && trycount < 20
      patientList = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/tv_name")
      patientList.each { |patientCell|
        if patientCell.text == patient_name
          found = true
          break
        else
          row += 1
        end
      }
      if !found
        action_builder = @selenium.action
        touch = action_builder.add_pointer_input(:touch, 'finger')
        touch.create_pointer_move(duration: 0, x: patientList[patientList.length-2].location[:x], y: patientList[patientList.length-2].location[:y])
        touch.create_pointer_down(:left)
        touch.create_pointer_move(duration: 1, x: patientList[1].location[:x], y: patientList[1].location[:y])
        touch.create_pause(0.1)
        touch.create_pointer_up(:left)
        action_builder.perform

        row = 0
        trycount += 1
      end
    end
    return patientList.at(row) # False return: if found=false, returns row=0
  end

  def get_cell_from_patient_list(by_index=0)
    patient_cells = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/content_main")
    return patient_cells[by_index]
  end

  def find_patient_cell(patient_name)
    trycount = 0
    found = false
    row = 0
    while !found and trycount < 10
      patientList = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/tv_name")
      patientList.each { |patientCell|
        if patientCell.attribute('text') == patient_name
          found = true
          break
        else
          row += 1
        end
      }
      if !found
        #Appium::TouchAction.new.swipe(start_x: 700, start_y: 1800, end_x: 700, end_y: 300, duration: 2000).perform
        Appium::TouchAction.new.swipe(:start_x => 600, :start_y => 1000, :end_x => 600, :end_y => 200, :duration => 1000).perform
        sleep(1)
        row = 0
        trycount += 1
      end
    end
    return found
  end

  def searchEditor_textView
		  #e = @selenium.find_element(:class, 'android.widget.MultiAutoCompleteTextView')
    e = @selenium.find_element(:id, "#{APP_PACKAGE}:id/filter")
    return e
  end

  def search_field
	e = @selenium.find_element(:id, "#{APP_PACKAGE}:id/filter")
	return e
	end

  def pmcensus_search
	txts = @selenium.find_elements(:class, 'android.widget.TextView')

	for i in 0..(txts.count - 1)
		if(txts[i].text == 'Search')
			return txts[i]
		end
	end
	return
  end

  def pm_patient_by_index(index)
    elements = @selenium.find_elements(:class, 'android.widget.TextView')
    combined_elements = []
    elements.each { |texts|
      puts texts
    }
    patient = patients[index]
    name = patient.find_element(:class, 'name')
    split_name = (name.text).split(',', 2)
    infos = patient.find_elements(:class, 'info')
    dt_info = infos[1].text
    dt_info_split = dt_info.split(/ /, 2)
    mrn = dt_info_split[0]
    first_name = split_name[1].delete(infos[0].text) + ' ' + split_name[0]
    last_name = split_name[0] + ' ' + split_name[1].delete(infos[0].text)
    demographics = name.find_element(:css, 'span.info').text
    bed = patient.find_element(:css, 'div.meta.location').text
    statusColor = patient.find_element(:css, 'div.meta.location').css_value('background-color')
    eyeIcon = patient.find_element(:class, 'multi-patient-toggle')
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
      'patient_obj' => patient,
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
    header_index = 1
    if option == 'status'
      header_index = 0
    end
    group_headers = @selenium.find_elements(:class, 'label')
    group_header = group_headers[header_index]
    patient = pm_patient_by_index(1)[option].downcase
    header = group_header.text.downcase
    if pm_patient_by_index(1)[option].downcase == group_header.text.downcase
      return true
    else
      return false
    end
  end
end
