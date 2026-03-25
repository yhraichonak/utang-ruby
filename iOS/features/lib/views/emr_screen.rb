Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class Emr_screen
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end
 
  def choose_role_text
	Appium_lib.predicate(@appium, "XCUIElementTypeStaticText", "Choose a role")
  end
  
  def role_selection(role_name)
	Appium_lib.predicate(@appium, "XCUIElementTypeStaticText", role_name)
  end
end