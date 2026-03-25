Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class TrendedData_screen
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end

  def navigationBar
    Element.new(@selenium, :xpath, "//XCUIElementTypeNavigationBar[contains(@name,'TrendsView')]")
  end

  def close_button
    Element.new(@selenium, :xpath, "//XCUIElementTypeButton[@name='common close']")
  end

  def back_button
    @appium.find_element(:xpath,'//XCUIElementTypeButton[@name="Back"]')
  end

  def done_button
    Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Done")
  end
end
