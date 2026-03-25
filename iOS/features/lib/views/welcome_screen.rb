Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class Welcome_screen
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end
  
  def title_text
    e = Appium_lib.predicate(@appium, "XCUIElementTypeStaticText", "WELCOME")
    #    application = @selenium.find_element(:class, 'XCUIElementTypeApplication')
    #    window = application.find_element(:class, 'XCUIElementTypeWindow')
    #   
    #    e = window.find_elements(:class, 'XCUIElementTypeStaticText')
    #   
    #	  value_found = false
    #    for i in 0..(e.count - 1)
    #      value_needed = e[i]
    #      puts "#{i} - #{value_needed.name}"
    #      if(value_needed.name == "WELCOME")
    #        value_found = true
    #        break
    #      elsif (value_needed.name == "Welcome")
    #        value_found = true
    #        break
    #      end
    #      if value_found == true
    #        break
    #      end
    #    end
    #  
    return e
  end
  
  def welcome_textView
    Element.new(@selenium, :xpath, "//UIAApplication[1]/UIAWindow[2]/UIATextView[1]")
  end
  
  def viewTraining_button
    Element.new(@selenium, :xpath, "//UIAButton[1]")
  end
   
  def signIn_button
    #Element.new(@selenium, :xpath, "//XCUIElementTypeButton[@name='Sign In']")
    #Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Sign In")
    buttons = @selenium.find_elements(:class, 'XCUIElementTypeButton')
    found = false
    value = nil
    for i in 0..(buttons.count - 1)
      
      if (buttons[i].name == "Sign In")
        value = buttons[i]
        found = true
        break
      end
      
      if (found == true)
        break
      end
    end
    
    return value
  end
  
  def reset_password_button
    #Element.new(@selenium, :xpath, "//XCUIElementTypeButton[@name='Sign In']")
    #Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Sign In")
    buttons = @selenium.find_elements(:class, 'XCUIElementTypeButton')
    found = false
    value = nil
    for i in 0..(buttons.count - 1)
      
      if (buttons[i].name == "Reset Password")
        value = buttons[i]
        found = true
        break
      end
      
      if (found == true)
        break
      end
    end
    
    return value
  end
  
  def resetPassword_button
    e = Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Reset Password")
    return e    
  end
  
  def alert_window
    a_window = @selenium.find_element(:class, "XCUIElementTypeAlert")
    return a_window
  end
  
  def keyboard
    @selenium.find_element(:class, 'XCUIElementTypeKeyboard')
  end
  
  def username_textfield    
    u_field = @selenium.find_element(:class, "TextField")
    return u_field
  end
  
  def password_textfield
    p_field = @selenium.find_element(:class, "SecureTextField")
    return p_field
  end
  
  def signIn_cell
    parent = @selenium.find_element(:class, 'XCUIElementTypeAlert')
    buttons = parent.find_elements(:class, 'XCUIElementTypeButton')
    
    return buttons[1]   
  end
  
  def cancel_cell
    e = Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Cancel")
    return e
  end
  
  def as1_logo
    #e = Appium_lib.predicate(@appium, "XCUIElementTypeImage", "WELCOME_logo.png")
    #return e
    images = @selenium.find_elements(:class, "XCUIElementTypeImage")
    image = nil 
    found = false

    for i in 0..(images.count - 1)
      puts images[i].name
      if images[i].name == "WELCOME_logo.png"
        puts "++"
        image = images[i]
        puts "++"
        found = true
        break
      end
      if found == true
        break
      end
    end
    return image
  end
  
  def as1_disclaimer
    parent = @selenium.find_element(:class, "XCUIElementTypeTextView")
    txts = parent.find_elements(:class, "XCUIElementTypeStaticText")
        
    #for i in 0..(txts.count - 1)
    #  puts txts[i].text
    #end
    
    message_one = txts[0]
    message_two = txts[1]
    
    return {
      "message_one" => message_one,
      "message_two" => message_two
    }
  end
  
  def as1_disclaimer14   
    txts = @selenium.find_elements(:class, "XCUIElementTypeTextView")
        
    for i in 0..(txts.count - 1)
      puts txts[i].text
    end
    
    message_one = txts[1]
    message_two = txts[2]
    
    return {
      "message_one" => message_one,
      "message_two" => message_two
    }
  end
  
  def ce_marks
    Element.new(@selenium, :xpath, "#{APP_PACKAGE}:id/about_cemark")
  end
  
  def ce_numbers
    Element.new(@selenium, :xpath, "#{APP_PACKAGE}:id/about_cemark_number")
  end
  
end