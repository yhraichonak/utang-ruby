Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class Login_screen
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end

  def keyboard
	@selenium.find_element(:class, 'XCUIElementTypeKeyboard')
  end

  def navigation_bar
    @appium.tag("XCUIElementTypeNavigationBar")
  end

  def username_textfield
    #@appium.tag("XCUIElementTypeTextField")
    #Appium_lib.predicate(@appium, "XCUIElementTypeTextField", "Username")
    textfield = @selenium.find_element(:class, "XCUIElementTypeTextField")
    return textfield
  end

  def password_textfield
    #@appium.tag("XCUIElementTypeSecureTextField")
    #Appium_lib.predicate(@appium, "XCUIElementTypeSecureTextField", "Password")
    textfield = @selenium.find_element(:class, "XCUIElementTypeSecureTextField")
    return textfield
  end

  def login_button
    #@appium.button_exact("Login")
    btn = Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Login")

    #buttons = @selenium.find_elements(:class, "XCUIElementTypeButton")
    #puts buttons.count
    #for i in 0..buttons.count
    #  puts buttons[i].name
    #  if(buttons[i].name == "Login")
    #    return buttons[i]
    #  end
    #end
    return btn
  end

  def cancel_button
    @appium.button_exact("Cancel")
  end

  def touchIdInfo_button
    @appium.button_exact("More Info")
  end

  def touchId_staticText
    @appium.find_ele_by_predicate(:class_name => "XCUIElementTypeStaticText", :value => "Allow TouchID Login")
  end

  def touchIdToggle_button
    @appium.tag("XCUIElementTypeSwitch")
  end

  def alertOK_button
     @selenium.find_element(:xpath, '//XCUIElementTypeAlert//XCUIElementTypeButton[@name="OK"]')
  end

  def alert_header2
    @selenium.find_element(:class, 'XCUIElementTypeAlert')
  end

  def alert_header
    #Element.new(@selenium, :xpath, "//XCUIElementTypeAlert[1]/XCUIElementTypeOther[1]/XCUIElementTypeOther[1]/XCUIElementTypeOther[2]/XCUIElementTypeOther[1]/XCUIElementTypeOther[1]/XCUIElementTypeStaticText[1]")
    #Appium_lib.predicate(@appium, "XCUIElementTypeStaticText", "Login Failed")
    parent = @selenium.find_element(:class, 'XCUIElementTypeAlert')
    txts = parent.find_elements(:class, 'XCUIElementTypeStaticText')
    txt = nil
    found = false
    for i in 0..(txts.count - 1)
      if(txts[i].text == "Login Failed")
        txt = txts[i]
        found = true
      end
      if found == true
        break
      end
    end
    return txt
  end

  def alert_description
    Element.new(@selenium, :xpath, "//XCUIElementTypeAlert[1]/XCUIElementTypeOther[1]/XCUIElementTypeOther[1]/XCUIElementTypeOther[2]/XCUIElementTypeOther[1]/XCUIElementTypeOther[1]/XCUIElementTypeStaticText[2]")
  end

  def login_text
   #@appium.find_ele_by_attr("XCUIElementTypeStaticText", "name", "Please Enter Your Site Credentials")
   # @appium.find_ele_by_predicate(class_name: "XCUIElementTypeStaticText", value: "Please Enter Your Site Credentials")
   txts = @selenium.find_elements(:class, "XCUIElementTypeStaticText")
   needed = nil
   for i in 0..(txts.count - 1)
     if txts[i].text == "Please enter your credentials"
       needed = txts[i]
       break
     end
   end
   return needed
  end

end
