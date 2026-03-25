# frozen_string_literal: true

# This is for a shared patient header bar amongst the site screens

# THIS IS SUBJECT TO CHANGE

Dir["#{File.dirname(__FILE__)}/../*.rb"].sort.each { |file| require file }

class PatientHeader_Bar
  def initialize(selenium)
    @selenium = selenium
  end

  def patient_info_object
    p_header = @selenium.find_element(:class, 'patient-header')
    p_info = p_header.find_element(:class, 'patient-info')
    name = p_info.find_element(:class, 'name').text
    age_sex = p_info.find_element(:class, 'age').text
    mrn_location = p_info.find_element(:class, 'info').attribute("innerText")

    {
      'name' => name,
      'age_sex' => age_sex,
      'mrn_location' => mrn_location
    }
  end

  def expandNavigation_button
    @selenium.find_element(:class, 'icon-menu')
  end

  def userNavigation_menu
    @selenium.find_element(:class, 'user-menu')
  end

  def main_header
    header = @selenium.find_element(:class, 'main-header')
    is_open = false

    is_open = true if header.attribute('className').include? 'open'

    {
      'header_obj' => header,
      'is_open' => is_open
    }
  end
end
