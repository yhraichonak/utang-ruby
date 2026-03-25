Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class Snippets_preview_screen
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end
  
  def title_bar
    t_bar = Appium_lib.predicate(@appium, "XCUIElementTypeNavigationBar", "Preview")    
    
    return t_bar
  end
  
  def back_button    
    nav = @selenium.find_element(:class, 'XCUIElementTypeNavigationBar')
    button = nav.find_element(:class, 'XCUIElementTypeButton')
    
    return button
  end
  
  def save_button    
    toolbar = @selenium.find_element(:class, 'XCUIElementTypeToolbar')
    button = toolbar.find_element(:class, 'XCUIElementTypeButton')
    
    return button
  end
end