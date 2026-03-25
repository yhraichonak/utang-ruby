Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class Search_screen
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end

  def nav_bar
    @selenium.find_element(:id, "#{APP_PACKAGE}:id/tv_title")
  end

  def age_criteria
    elements = @selenium.find_elements(:class, "android.widget.ImageView")
    (0..(elements.count)).each do |i|
      return elements[i] if elements[i].text == "37"
    end
  end

  def navigation_bar
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_title")
  end

  def no_patients_found
    Element.new(@selenium, :id, 'android:id/empty')
  end

  def print_text_views
    elements = @selenium.find_elements(:class, "android.widget.TextView")
    elements.each { |b| puts "text views = " + b.text }
  end

  def print_edit_text_views
    elements = @selenium.find_elements(:class, "android.widget.EditText")
    elements.each { |b| puts "edit text views = " + b.text }
  end

  def print_button_views
    elements = @selenium.find_elements(:class, 'android.widget.Button')
    elements.each { |b| puts "buttons = " + b.text }
  end

  def print_image_button_views
     elements = @selenium.find_elements(:class, 'android.widget.ImageButton')
    elements.each { |b| puts "buttons = " + b.text }
  end

  def patient_exists(full_name)
    elements = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/tv_name")
    elements.each do |b|
      return true if b.text.downcase == full_name.downcase
    end
    return false
  end

  def get_patient_cell_data(expected_name)
    patient_list = @selenium.find_element(:id, 'android:id/list')
    patient_list_items = patient_list.find_elements(:id, "#{APP_PACKAGE}:id/patient_listitem_content")
    patient_cell = nil

    if patient_list_items.count == 1
      patient_cell = patient_list_items[0]
    else
      (0..(patient_list_items.count - 1)).each do |i|
        patient_cell_name = patient_list_items[i].find_element(:id, "#{APP_PACKAGE}:id/tv_name").text

        patient_cell = patient_list_items[i] if expected_name == patient_cell_name
      end
    end

    unless patient_cell.nil?
      return {
        "full_name" => patient_cell.find_element(:id, "#{APP_PACKAGE}:id/tv_name").text,
        "age_sex" => patient_cell.find_element(:id, "#{APP_PACKAGE}:id/tv_name_sub").text,
        "time_info" => patient_cell.find_element(:id, "#{APP_PACKAGE}:id/tv_date").text,
        "ecg_info" => patient_cell.find_element(:id, "#{APP_PACKAGE}:id/tv_message").text,
        "ecg_count" => patient_cell.find_element(:id, "#{APP_PACKAGE}:id/tv_bubbleinfo").text
      }
    end
  end

  def search_result_header
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/search_criteria_reminder")
  end

  def get_pm_patient_obj(expected_name)
    patient_list_cells = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/patient_listitem_content")

    patient_list_cells.each do |cell|
      name = cell.find_element(:id, "#{APP_PACKAGE}:id/tv_name").text
      if name.downcase == expected_name.downcase
        full_name = name
        age_sex = cell.find_element(:id, "#{APP_PACKAGE}:id/tv_name_sub").text
        mrn_dob = cell.find_element(:id, "#{APP_PACKAGE}:id/tv_date").text
        bed = cell.find_element(:id, "#{APP_PACKAGE}:id/tv_bubbleinfo").text
        return {
          'full_name' => full_name,
          'age_sex' => age_sex,
          'mrn_dob' => mrn_dob,
          'bed' => bed
        }
      end
    end
  end

  def get_emr_patient_obj
    elements = @selenium.find_elements(:class, "android.widget.TextView")

    counter = 0
    start = 0

    elements.each do |b|

      if b.text == which
        start = counter
        break
      end
      counter = counter + 1
    end

    full_name = elements.at(start).text
    start = start + 1

    age_sex = elements.at(start).text
    start = start + 1

    dob = elements.at(start).text
    start = start + 1

    mrn_location = elements.at(start).text

    return {
      "full_name" => full_name,
      "age_sex" => age_sex,
      "mrn_dob" => dob,
      "location" => mrn_location
    }
  end

  def search_btn
	  @selenium.find_element(:id, "#{APP_PACKAGE}:id/psearch_search_button")
  end

  def reset_btn
	  @selenium.find_element(:id, "#{APP_PACKAGE}:id/psearch_reset_button")
  end

  def ob_search_field(which, criteria)
	  elements = @selenium.find_elements(:class, "android.widget.EditText")
    case which
    when "Last"
      elements.at(0).send_keys(criteria)
    when "First"
      elements.at(1).send_keys(criteria)
    end
  end

  def search_button
    @selenium.find_element(:id, "#{APP_PACKAGE}:id/psearch_search_button")
  end

  def cardio_search_button
    elements = @selenium.find_elements(:class, "android.widget.Button")
    elements.at(1)
  end

  def medication_search
    @selenium.find_element(:id, "#{APP_PACKAGE}:id/filter")
  end

  def search_field(which, criteria)
    elements = @selenium.find_elements(:class, "android.widget.EditText")
    case which
    when "First"
      elements.at(0).send_keys(criteria)
    when "Last"
      elements.at(1).send_keys(criteria)
    when "DOB"
      elements.at(2).send_keys(criteria)
    when "Age"
      elements.at(3).send_keys(criteria)
    when "MRN"
      elements.at(4).send_keys(criteria)
    end
  end

  def cardio_search_field(which, criteria)
    sleep(2)
    elements = @selenium.find_elements(:class, "android.widget.EditText")
    case which
    when "First"
      elements.at(1).send_keys(criteria)
    when "Last"
      elements.at(0).send_keys(criteria)
    when "DOB"
      elements.at(2).send_keys(criteria)
    when "Age"
      elements.at(3).send_keys(criteria)
    when "MRN"
      elements.at(4).send_keys(criteria)
    end
  end

  def emr_search_field(which, criteria)
    sleep(2)
    elements = @selenium.find_elements(:class, "android.widget.EditText")
    case which
    when "Last"
      elements.at(0).send_keys(criteria)
    when "Age"
      elements.at(1).send_keys(criteria)
    when "MRN"
      elements.at(2).send_keys(criteria)
    end
  end

  def pm_search_field(which, criteria)
    elements = @selenium.find_elements(:class, "android.widget.EditText")
    case which
    when "First"
      elements.at(0).send_keys(criteria)
    when "Last"
      elements.at(1).send_keys(criteria)
    when "Unit"
      elements.at(2).send_keys(criteria)
      #@selenium.find_elements(:xpath, '//view[1]/window[1]/view[1]/window[1]/window[1]/window[1]/window[1]/gridlayout[1]/textfield[3]').send_keys(criteria)
    when "Bed"
      elements.at(2).send_keys(criteria)
      #@selenium.find_elements(:xpath, '//view[1]/window[1]/view[1]/window[1]/window[1]/window[1]/window[1]/gridlayout[1]/textfield[3]').send_keys(criteria)
    when "MRN"
      elements.at(3).send_keys(criteria)
    end
  end

  def pmsearchresults
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_name")
	end
end