Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class Events_screen
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end

  def navigationBar
    nav_bar = @selenium.find_element(:class, 'XCUIElementTypeNavigationBar')
    return nav_bar
  end

  def liveMonitor_button
    Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Live Monitor")
  end

  def event_cell(row_number)
    row = row_number.to_i - 1

    if $is_7x_version
      parent = @selenium.find_elements(:class, 'XCUIElementTypeScrollView')
      cells = parent[1].find_elements(:class, 'XCUIElementTypeImage')
      cells.each_with_index { |cell, i|
        if cells[i].displayed? == true
          return cell
        end
      }
    else
      parent = @selenium.find_elements(:class, 'XCUIElementTypeCollectionView')
      cells = parent[0].find_elements(:class, 'XCUIElementTypeCell')
      return cells[row]
    end
  end

  def noEvent_staticText
    Appium_lib.predicate(@appium, "XCUIElementTypeStaticText", "No Events")
  end

  def chooseTime_button
    parent = @selenium.find_element(:class, 'XCUIElementTypeNavigationBar')
    buttons = parent.find_elements(:class, 'XCUIElementTypeButton')
    return buttons[0]
  end

  def chooseTime_button_ipad
    parent = @selenium.find_element(:class, 'XCUIElementTypeNavigationBar')
    buttons = parent.find_elements(:class, 'XCUIElementTypeButton')
    return buttons[0]
  end

  def choose_time_btn
    parent = @selenium.find_element(:class, 'XCUIElementTypeNavigationBar')
    buttons = parent.find_elements(:class, 'XCUIElementTypeButton')
    return buttons[1]
  end

  def choose_time_btn_one_six
    parent = @selenium.find_element(:class, 'XCUIElementTypeNavigationBar')
    buttons = parent.find_elements(:class, 'XCUIElementTypeButton')
    if $is_7x_version
      if buttons[2].name == "clock"
        return buttons[2]
      end
    else
       buttons[1]
    end
  end

  def new_nav_live_monitor_button
  @selenium.find_element(:xpath, "//XCUIElementTypeStaticText[@name='Monitor']")
  end
end
