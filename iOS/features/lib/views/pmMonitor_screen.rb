Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class PMMonitor_screen
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end

  def top_navbar_elements
    @selenium.find_element(:class, 'XCUIElementTypeNavigationBar').find_elements(:class, 'XCUIElementTypeStaticText')
  end
  def patient_name
    top_navbar_elements[0]
  end
  def patient_info
    top_navbar_elements[0]
  end
  def navigationBar
    #Element.new(@selenium, :xpath, "//XCUIElementTypeNavigationBar[@name='APMonitorView']")
    Appium_lib.predicate(@appium, "XCUIElementTypeNavigationBar", "APMonitorView")
  end
  
  def waveform_collectionCell(waveform)
    Element.new(@selenium, :xpath, "//UIACollectionCell[@name='#{waveform}']")
  end
  
  def aawaveform_button(waveform)
    #Element.new(@selenium, :xpath, "//XCUIElementTypeStaticText[@name='#{waveform}']")
    Appium_lib.predicate(@appium, "XCUIElementTypeStaticText", "#{waveform}")
  end
  
  def waveform_button(waveform)
    collection = @selenium.find_element(:class, 'XCUIElementTypeCollectionView')
    cells = collection.find_elements(:class, 'XCUIElementTypeCell')
    cell_i_need = nil
    found = false
    
    for i in 0..cells.count
      txt = cells[i].find_element(:class, 'XCUIElementTypeStaticText')
      
      if txt.name == waveform
        cell_i_need = cells[i]
        found = true
        break
      end
      if found == true
        break
      end
    end
    
    button = cell_i_need.find_element(:class, 'XCUIElementTypeButton')
    return button
  end
  
  def waveform_indicator_button(waveform_num)
    waveform = Appium_lib.predicates(@appium, "XCUIElementTypeButton", "pm wave off")
    return waveform[waveform_num-1]
  
    #if $platform_version == "11.0"
    #  Element.new(@selenium, :xpath, "//XCUIElementTypeCell[#{waveform_num}]/XCUIElementTypeOther[1]/XCUIElementTypeButton[1]")
    #else
    #  Element.new(@selenium, :xpath, "//XCUIElementTypeCell[#{waveform_num}]/XCUIElementTypeOther[1]/XCUIElementTypeButton[1]")
    #end
  end
  
  def discreet_elementType(discreet)
    Appium_lib.predicate_include(@appium, "XCUIElementTypeStaticText", "#{discreet}")
  end
  
  def close_button
    Appium_lib.predicate(@appium, "XCUIElementTypeButton", "common close")
  end
  
  def back_button
    Appium_lib.predicate_include(@appium, "XCUIElementTypeButton", "PM > Census")
  end
  
  def live_button
    Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Live")
  end
  
  def options_button
    Appium_lib.predicate(@appium, "XCUIElementTypeButton", "common action icon")
  end
  
  def share_button
    Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Share")
  end
  
  def chooseTime_button
    #if ENV['DEVICE'] =~ /iPad/
    #  buttons = @appium.buttons
    #  return buttons[1]
    #else
    #  Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Choose Time")
    #end
    
    #Element.new(@selenium, :xpath, "//XCUIElementTypeButton[@name='Choose Time']")
    #Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Choose Time")
    parent = @selenium.find_element(:class, 'XCUIElementTypeNavigationBar')
    buttons = parent.find_elements(:class, 'XCUIElementTypeButton')
    return buttons[2]
  end
  
  def choose_time_btn
    #if ENV['DEVICEE'] =~ /iPad/
    #  buttons = @appium.buttons
    #  return buttons[1]
    #else
    #  Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Choose Time")
    #end
    
    #Element.new(@selenium, :xpath, "//XCUIElementTypeButton[@name='Choose Time']")
    #Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Choose Time")
    #parent = @selenium.find_element(:class, 'XCUIElementTypeNavigationBar')
    #buttons = parent.find_elements(:class, 'XCUIElementTypeButton')
    #return buttons[1]
    Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Choose Time")
  end
  
  def choose_time_btn_ipad
    #if ENV['DEVICE'] =~ /iPad/
    #  buttons = @appium.buttons
    #  return buttons[1]
    #else
    #  Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Choose Time")
    #end
    
    #Element.new(@selenium, :xpath, "//XCUIElementTypeButton[@name='Choose Time']")
    #Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Choose Time")
    parent = @selenium.find_element(:class, 'XCUIElementTypeNavigationBar')
    buttons = parent.find_elements(:class, 'XCUIElementTypeButton')
    return buttons[1]
    #Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Choose Time")
  end
  
  def snippets_button
    Element.new(@selenium, :xpath, "//XCUIElementTypeButton[@name='Snippets']")
  end
  
  def choose_time_overflow_button
	parent = @selenium.find_element(:class, 'XCUIElementTypeSheet')
	buttons = parent.find_elements(:class, 'XCUIElementTypeButton')
	for i in 0..buttons.count
		if(buttons[i].text ==  "Choose Time")
			return buttons[i]
		end
	end
  end
  
  def choose_time_ipad_five
    parent = @selenium.find_element(:class, 'XCUIElementTypeNavigationBar')
    buttons = parent.find_elements(:class, 'XCUIElementTypeButton')
    return buttons[1]
  end  
  
  def choose_time_ipad_six
    parent = @selenium.find_element(:class, 'XCUIElementTypeNavigationBar')
    buttons = parent.find_elements(:class, 'XCUIElementTypeButton')
    return buttons[2]
  end  
end