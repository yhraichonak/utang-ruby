Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class ConversationList_screen
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end

  def navigation_bar
    Appium_lib.predicate(@appium, "XCUIElementTypeNavigationBar", "Secure Messaging")
  end

  def conversation_table
    @selenium.find_element(:class, 'XCUIElementTypeTable')
  end

  def conversation_tableCell(conversationName)
    table = @selenium.find_element(:xpath, '//XCUIElementTypeCollectionView | //XCUIElementTypeTable')
    value = table.find_element(:xpath, '//XCUIElementTypeButton[contains(@name,"'+conversationName+'")]')
    return value
  end

  def add_button
    Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Add")
  end

  #def conversationList_tableCell(person)
  #  count = @selenium.find_elements(:uiautomation, "#{UIAWINDOW}.tableViews()[0].cells()").count
  #
  #  for i in 0..(count)
  #    view = "#{UIAWINDOW}.tableViews()[0].cells()[#{i}]"
  #    e =  @selenium.find_element(:uiautomation, view)
  #    if (e.attribute("name") == person)
  #      return e
  #    end
  #  end
  #end
end

