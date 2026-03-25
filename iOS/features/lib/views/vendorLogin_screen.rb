Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class VendorLogin_screen
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end
  
  def navigation_bar
    #Element.new(@selenium, :xpath, "//XCUIElementTypeNavigationBar")
    nav_bar = @selenium.find_element(:class, "XCUIElementTypeNavigationBar")
    return nav_bar
  end
  
  def username_textfield
    #Element.new(@selenium, :xpath, "//XCUIElementTypeTextField")
    username_field = @selenium.find_element(:class, "XCUIElementTypeTextField")
    return username_field
  end
  
  def password_textfield
    #Element.new(@selenium, :xpath, "//XCUIElementTypeSecureTextField[@value='Password']")
    password_field = @selenium.find_element(:class, "XCUIElementTypeSecureTextField")
    return password_field
  end
  
  def login_button  
    #Element.new(@selenium, :xpath, "//XCUIElementTypeButton[@name='Login']")
    buttons = @selenium.find_elements(:class, "XCUIElementTypeButton")
    button = nil
    found = false
    
    for i in 0..(buttons.count - 1)
      if(buttons[i].name == "Login") #&& buttons[i].enabled == true)
        button = buttons[i]
        found = true
      end
      if found == true
        break
      end
    end
    return button
  end
  
  def cancel_button
    parent = @selenium.find_element(:class, "XCUIElementTypeNavigationBar")
    buttons = parent.find_elements(:class, "XCUIElementTypeButton")
    button = nil
    found = false
    
    for i in 0..(buttons.count - 1)
      if(buttons[i].name == "Cancel")
        button = buttons[i]
        found = true
      end
      if found == true
        break
      end
    end
  end
  
  def switch_user_button
    parent = @selenium.find_element(:class, "XCUIElementTypeNavigationBar")
    buttons = parent.find_elements(:class, "XCUIElementTypeButton")
    button = nil
    found = false
    
    for i in 0..(buttons.count - 1)
      if(buttons[i].name == "	Switch User")
        button = buttons[i]
        found = true
      end
      if found == true
        break
      end
    end
  end
  
  def vendor_text(text)
    #Element.new(@selenium, :xpath, "//XCUIElementTypeStaticText[@name='#{text}']")
    Appium_lib.predicate(@appium, "XCUIElementTypeStaticText", "#{text}")
  end 
  
end