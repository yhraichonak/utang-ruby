Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class Keyboard
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end

  def full_keyboard
    keyboard = @selenium.find_element(:class, "XCUIElementTypeKeyboard")
  end
  
  def done_button
    Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Done")
  end  

  def return_button
    Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Return")
  end  
end