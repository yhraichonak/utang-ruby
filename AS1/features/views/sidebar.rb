# frozen_string_literal: true

# This is for a shared header bar amongst the site screens

Dir["#{File.dirname(__FILE__)}/../*.rb"].sort.each { |file| require file }

class Sidebar
  def initialize(selenium)
    @selenium = selenium
  end

  # should display "utang ONE"
  def sidebar_button
    sidebar = @selenium.find_element(:class, 'sidebar')
    divs = sidebar.find_elements(:css, 'div')
    secure_messages = nil
    notifications = nil
    emr_my_patients = nil
    critical_patients = nil
    emr_search = nil
    pm_all_patients = nil
    snippet_workflist = nil
    ventilator = nil
    ob_my_patients = nil
    most_recent = nil
    ems = nil
    my_inbox = nil
    cardio_search = nil

    (0..(divs.count - 1)).each do |i|
      case divs[i].text
      when 'Communication'
        secure_messages = divs[i + 1]
        notifications = divs[i + 2]
      when 'EMR'
        emr_my_patients = divs[i + 1]
        critical_patients = divs[i + 2]
        emr_search = divs[i + 3]
      when 'Patient Monitoring'
        pm_all_patients = divs[i + 1]
        snippet_workflist = divs[i + 2]
        ventilator = divs[i + 3]
      when 'OB'
        ob_my_patients = divs[i + 1]
      when 'Cardiology'
        most_recent = divs[i + 1]
        ems = divs[i + 2]
        my_inbox = divs[i + 3]
        cardio_search = divs[i + 4]
      end
    end

    {
      'secure_messages' => secure_messages,
      'notifications' => notifications,
      'emr_my_patients' => emr_my_patients,
      'critical_patients' => critical_patients,
      'emr_search' => emr_search,
      'pm_all_patients' => pm_all_patients,
      'snippet_workflist' => snippet_workflist,
      'ventilator' => ventilator,
      'ob_my_patients' => ob_my_patients,
      'most_recent' => most_recent,
      'ems' => ems,
      'my_inbox' => my_inbox,
      'cardio_search' => cardio_search
    }
  end

  def sidebarOption_button(menu_name)
    parent = @selenium.find_element(:class, 'patients-body')
    sidebar = parent.find_element(:class, 'sidebar')
    menu_options = sidebar.find_elements(:class, 'menu-option')

    (0..(menu_options.count - 1)).each do |i|
     return menu_options[i] if menu_options[i].text.include? menu_name
    end
  end

  def menu_options
    sleep 2
    sidebar = @selenium.find_element(:class, 'sidebar')
    menu_options = sidebar.find_elements(:class, 'menu-option')

    list_array = Array.new
    found = false

    for i in 0..(menu_options.count - 1)
      puts "#{i} #{menu_options[i].text}"
      if menu_options[i].text.include? "Census"
        list_array[0] = menu_options[i]
        list_array[1] = menu_options[i + 1]
        list_array[2] = menu_options[i + 2]
        list_array[3] = menu_options[i + 3]
        list_array[4] = menu_options[i + 4]
        #list_array[5] = menu_options[i + 5]
        found = true
        break
      end

      if found == true
        break
      end
    end

    return list_array
  end

  def sidebarOption_count(text)
    sidebar = @selenium.find_element(:class, 'sidebar')
    menu_options = sidebar.find_elements(:class, 'menu-option')
    (0..(menu_options.count - 1)).each do |i|
      begin
        return menu_options[i].find_element(:class, 'count').text if menu_options[i].text.include? text
      rescue Selenium::WebDriver::Error::NoSuchElementError
        return "0"
      end
    end
  end

  def sidebarButton_status(text)
    sidebar = @selenium.find_element(:class, 'sidebar')
    menu_options = sidebar.find_elements(:class, 'menu-option')
    (0..(menu_options.count - 1)).each do |i|
      if menu_options[i].text == text
        status = menu_options[i].attribute('className').include?('selected')
        return status
      end
    end
  end

  def sidebar_loader
    sidebar = @selenium.find_element(:class, 'sidebar')
    sidebar.find_element(:class, 'loader')
  end

  def sidebar
    @selenium.find_element(:class, 'sidebar')
  end

  def active_menu_option
    sidebar = @selenium.find_element(:class, 'sidebar')
    sidebar.find_element(:class, 'selected')
  end
end
