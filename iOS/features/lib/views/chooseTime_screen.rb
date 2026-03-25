Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class ChooseTime_screen
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end
    
  def day_pickerWheel
    #Element.new(@selenium, :xpath, "//XCUIElementTypePickerWheel[1]")
    pickerwheel = @appium.tags("XCUIElementTypePickerWheel")
    return pickerwheel[0]
  end 
  
  def hour_pickerWheel
    #Element.new(@selenium, :xpath, "//XCUIElementTypePickerWheel[2]")
    pickerwheel = @appium.tags("XCUIElementTypePickerWheel")
    return pickerwheel[1]
  end
  
  def minute_pickerWheel
    #Element.new(@selenium, :xpath, "//XCUIElementTypePickerWheel[3]")
    pickerwheel = @appium.tags("XCUIElementTypePickerWheel")
    return pickerwheel[2]
  end
  
  def meridiem_pickerWheel
    #Element.new(@selenium, :xpath, "//XCUIElementTypePickerWheel[4]")
    pickerwheel = @appium.tags("XCUIElementTypePickerWheel")
    return pickerwheel[3]
  end
  
  def now_text
	Appium_lib.predicate(@appium, "XCUIElementTypeStaticText", "Now")
  end
  
  def today_text
	Appium_lib.predicate_include(@appium, "XCUIElementTypeStaticText", "Today")
  end
  
  def chs_time_button
	Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Choose Time")
  end
  
  def chooseTime_button
    #Element.new(@selenium, :xpath, "//XCUIElementTypeButton[@name='Choose Time']")
    #Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Choose Time")
    #parent = @selenium.find_element(:class, 'XCUIElementTypeNavigationBar')
    #buttons = parent.find_elements(:class, 'XCUIElementTypeButton')
    #return buttons[1]
    
    #parent = @selenium.find_element(:class, 'XCUIElementTypeToolbar')
    
    parent = @selenium.find_element(:class, 'XCUIElementTypeToolbar')
    buttons = parent.find_elements(:class, 'XCUIElementTypeButton')
       
	for i in 0..(buttons.count)
		if buttons[i].text == "Choose Time"
			return 
		end
	end
  end
  
  def cancel_button
    Element.new(@selenium, :xpath, "//XCUIElementTypeButton[@name='Cancel']")
  end 
  
end