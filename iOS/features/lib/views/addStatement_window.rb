Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class AddStatement_window
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end
  
  def cancel_button
    if desired_capabilities['deviceName'].include? 'iPad'
      buttons = Appium_lib.predicates(@appium, "XCUIElementTypeButton", "Cancel")
      return buttons[1]
      #Element.new(@selenium, :xpath, "//XCUIElementTypeWindow[1]/XCUIElementTypeOther[2]/XCUIElementTypeOther[2]/XCUIElementTypeOther[1]/XCUIElementTypeToolbar[1]/XCUIElementTypeButton[@name='Cancel']")
    else
      Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Cancel")
      #Element.new(@selenium, :xpath, "//XCUIElementTypeButton[@name='Cancel']")
    end
  end
  
  def done_button
    if desired_capabilities['deviceName'].include? 'iPad'
      Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Done")
    else
      Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Done")
      #buttons = Appium_lib.predicates(@appium, "XCUIElementTypeButton", "Done")
      #return buttons[buttons.count-1]
    end
    #if desired_capabilities['deviceName'].include? 'iPad'
    #  buttons = Appium_lib.predicates(@appium, "XCUIElementTypeButton", "Done")
    #  return buttons[buttons.count-1]
    #else
    #  Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Done")
    #end
  end
  
  def statement_searchBar
    #iPhone only
    Element.new(@selenium, :xpath, "//XCUIElementTypeSearchField[1]")
  end
  
  def statementMessageEdit_staticText
    Element.new(@selenium, :xpath, "//XCUIElementTypeTextView[1]")
  end
  
  def statementSearchClear_button
    #iPhone only
    Element.new(@selenium, :name, "Clear text")
  end
  
  def statementSearchCancel_button
    #iPhone only
    Element.new(@selenium, :xpath, "//XCUIElementTypeButton[@name='Cancel']")
  end
  
  def statementSearchResults_cell(row)
    parent = @selenium.find_element(:class, "XCUIElementTypeTable")
    cells = parent.find_elements(:class, "XCUIElementTypeCell")
    return cells[row.to_i]
    #cells = @appium.tags("XCUIElementTypeCell")
    #return cells[row-1]
    #if desired_capabilities['deviceName'].include? 'iPad'
    #Element.new(@selenium, :xpath, "//XCUIElementTypeWindow[1]/XCUIElementTypeOther[3]/XCUIElementTypeOther[3]/XCUIElementTypeOther[2]/XCUIElementTypeTable[1]/XCUIElementTypeCell[#{row}]")
    #  Element.new(@selenium, :xpath, "//XCUIElementTypeCell[#{row}]")
    #else
    #  Element.new(@selenium, :xpath, "//XCUIElementTypeCell[#{row}]")
    #end
  end
end

