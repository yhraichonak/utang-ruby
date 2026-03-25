Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class GroupBySortBy
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end
  
  def group_by_option
	parent = @selenium.find_element(:class, 'XCUIElementTypeTable')
	cells = parent.find_elements(:class, 'XCUIElementTypeCell')
	return cells[0]
	   #Appium_lib.predicate(@appium, "XCUIElementTypeButton", "common close")
  end
  
  def primary_sort_option
	parent = @selenium.find_element(:class, 'XCUIElementTypeTable')
	cells = parent.find_elements(:class, 'XCUIElementTypeCell')
	return cells[1]
  end
  
  def secondary_sort_option
	parent = @selenium.find_element(:class, 'XCUIElementTypeTable')
	cells = parent.find_elements(:class, 'XCUIElementTypeCell')
	return cells[2]
  end
  
  def picker_wheel
	@selenium.find_element(:class, 'XCUIElementTypePickerWheel')
  end
  
  def group_by_picker
	@selenium.find_element(:class, 'XCUIElementTypePickerWheel')
  end
end