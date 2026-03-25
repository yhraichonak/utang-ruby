Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class Menu
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end

  def back_button
    Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Back")
  end

  def cancel_button
    buttons = @selenium.find_elements(:class, "XCUIElementTypeButton")
    puts "button count = #{buttons.count}"
    found = false
    b = nil
    for i in 0..(buttons.count - 1)
      puts buttons[i].name
      if(buttons[i].name == 'Cancel')
        found = true
        b = buttons[i]
      end
      if found == true
        break
      end
    end

    return b
  end

  def back_button_sites
    buttons = @selenium.find_elements(:class, "XCUIElementTypeButton")
    puts "button count = #{buttons.count}"
    found = false
    b = nil
    for i in 0..(buttons.count - 1)
      puts buttons[i].name
      if(buttons[i].name == 'Sites')
        found = true
        b = buttons[i]
      end
      if found == true
        break
      end
    end

    return b
  end

  def back_button_cardio_most_recent
    buttons = @selenium.find_elements(:class, "XCUIElementTypeButton")
    puts "button count = #{buttons.count}"
    found = false
    b = nil
    for i in 0..(buttons.count - 1)
      puts buttons[i].name
      if(buttons[i].name == 'Cardio > MOST RECENT')
        found = true
        b = buttons[i]
      end
      if found == true
        break
      end
    end

    return b
  end

  def back_button_pm_census
    buttons = @selenium.find_elements(:class, "XCUIElementTypeButton")
    puts "button count = #{buttons.count}"
    found = false
    b = nil
    for i in 0..(buttons.count - 1)
      puts i
      puts buttons[i].name
      if(buttons[i].name == 'PM > Census')
        found = true
        b = buttons[i]
      end
      if found == true
        break
      end
    end

    return b
  end

  def alert_element
    alert = @selenium.find_element(:class, "XCUIElementTypeAlert")
    return alert
  end

  def allow_button
    Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Allow")
  end

  def dont_allow_button
    Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Don’t Allow")
  end

  def nav_bar
    @selenium.find_element(:class, 'XCUIElementTypeNavigationBar')
  end

  def x_button
    Appium_lib.predicate(@appium, "XCUIElementTypeButton", "common close")
  end

  def apply_button
    Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Apply")
  end

  def pm_census_filter
    parent = @selenium.find_element(:class, 'XCUIElementTypeNavigationBar')
    buttons = parent.find_elements(:class, 'XCUIElementTypeButton')
    return buttons[3]
  end

  def pm_group_sort_by
    parent = @selenium.find_element(:class, 'XCUIElementTypeNavigationBar')
    buttons = parent.find_elements(:class, 'XCUIElementTypeButton')
    return buttons[2]
  end

  def refine_nav_bar
    Appium_lib.predicate(@appium, "XCUIElementTypeNavigationBar", "Refine")
  end

  def unit_filter_bar
    Appium_lib.predicate(@appium, "XCUIElementTypeNavigationBar", "Unit Filter")
  end

  def group_sort_bar
    Appium_lib.predicate(@appium, "XCUIElementTypeNavigationBar", "Group/Sort")
  end

  def pm_share
    Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Share")
  end

  def pm_choose_time
    Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Choose Time")
  end

  def pm_tool
    Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Tool")
  end

  def pm_cancel
    Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Cancel")
  end

  def new_nav_summary
    buttons = @selenium.find_elements(:class, 'XCUIElementTypeButton')
    return buttons[3]
    #Appium_lib.predicate(@appium, "XCUIElementTypeImage", "toolbar_home")
  end

  def new_nav_summary_ipad
    parent =  @selenium.find_element(:class, 'XCUIElementTypeScrollView')
    txts = parent.find_elements(:class, 'XCUIElementTypeStaticText')
    txt = nil
    found = false

    for i in 0..(txts.count - 1)
      puts txts[i].text
      if(txts[i].text == "Home")
        txt = txts[i]
        found = true
        break
      end

      if found == true
        break
      end
    end

    #e = Appium_lib.predicate(@appium, "XCUIElementTypeStaticText", "Home")
    return txt
    #Appium_lib.predicate(@appium, "XCUIElementTypeImage", "toolbar_home")
  end

  def new_nav_hamburger
    buttons = @selenium.find_elements(:class, 'XCUIElementTypeButton')
    return buttons[4]
    #Appium_lib.predicate(@appium, "XCUIElementTypeImage", "hamburger")
  end

  def new_nav_home
    return @selenium.find_element(:accessibility_id, "Home")
  end

  def new_nav_home_training_not_working
    Appium_lib.predicate(@appium, "XCUIElementTypeImage", "toolbar_home")
  end

  def new_nav_home_training_pm

    buttons = @selenium.find_elements(:class, 'XCUIElementTypeButton')
    #puts "+++"
    #puts buttons.count
    #puts "++++++++"
    #for i in 0..(buttons.count - 1 )
    #  puts "#{i} = #{buttons[i].text}"
    #end

    return buttons[2]
  end

  def new_nav_home_training_docs

    buttons = @selenium.find_elements(:class, 'XCUIElementTypeButton')
    #puts "+++"
    #puts buttons.count
    #puts "++++++++"
    #for i in 0..(buttons.count - 1 )
    #  puts "#{i} = #{buttons[i].text}"
    #end

    return buttons[3]
  end

  def docs_button
    Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Docs")
  end

  def new_nav_home_training
    buttons = @selenium.find_elements(:class, 'XCUIElementTypeButton')
    #puts "+++"
    #puts buttons.count
    #puts "++++++++"
    #for i in 0..(buttons.count - 1 )
    #  puts "#{i} = #{buttons[i].name}"
    #end

    return buttons[1]
  end

  def new_nav_monitor
    buttons = @selenium.find_elements(:class, 'XCUIElementTypeButton')
    return buttons[4]
  end

  def new_nav_events
    buttons = @selenium.find_elements(:class, 'XCUIElementTypeButton')
    return buttons[5]
  end

  def new_nav_button(button_text)
    return @selenium.find_element(:accessibility_id, button_text)
  end

  def new_nav_tool
    return @selenium.find_elements(:class, 'XCUIElementTypeButton')[6]
  end

  def new_nav_share
    return  @selenium.find_element(:accessibility_id, "Share")
  end

  def menu_sheet
    if(Gem::Version.new(ENV['VERSION'] ) >= Gem::Version.new('16.0'))
      sheet = @selenium.find_element(:xpath, '//XCUIElementTypeOther[2]/XCUIElementTypeOther[3]')
    else
      sheet = @selenium.find_element(:class, 'XCUIElementTypeSheet')
    end
    return sheet
  end

  def menu_logout
    #scroll = @selenium.find_elements(:class, 'XCUIElementTypeScrollView')
    buttons = @selenium.find_elements(:class, 'XCUIElementTypeButton')

    button = nil
    found = false
    for i in 0..(buttons.count - 1)
      puts buttons[i].name

      if(buttons[i].text == "Logout")
        button = buttons[i]
        found = true
      else
        puts 'no logout button found'
      end

      if found == true
        break
      end
    end
    return button
  end
end
