Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class EditConfirmStatement_window
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end
  
  def test_already_condirmed_window
    Appium_lib.predicate_include(@appium, "XCUIElementTypeStaticText", "This test was already confirmed by")
  end
  
  #def statementMessage_staticText(cellNumber)
  #  Element.new(@selenium, :xpath, "//XCUIElementTypeTable[1]/XCUIElementTypeCell[#{cellNumber}]/XCUIElementTypeStaticText[1]")
  #end
  #Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Insert Append Statement")
  
  def statementMessage_staticText(which)
	parent = @selenium.find_element(:class, 'XCUIElementTypeTable')
	cells = parent.find_elements(:class, 'XCUIElementTypeCell')
	
	#for i in 0..cells.count
	#	txt = cells[i].find_element(:class, 'XCUIElementTypeStaticText')
	#	puts txt.text
	#end

	txt = cells[which].find_element(:class, 'XCUIElementTypeStaticText')

	return txt
  end
  
  #def statementMessageRemove_switch(cellNumber)
  #  Element.new(@selenium, :xpath, "//XCUIElementTypeTable[1]/XCUIElementTypeCell[#{cellNumber}]/XCUIElementTypeButton[contains(@name,'Delete')]")
  #end
  
  def statementMessageRemove_switch(which)
	parent = @selenium.find_element(:class, 'XCUIElementTypeTable')
	cells = parent.find_elements(:class, 'XCUIElementTypeCell')
	
	#for i in 0..cells.count
	#	txt = cells[i].find_element(:class, 'XCUIElementTypeStaticText')
	#	puts txt.text
	#end

	buttons = cells[which].find_elements(:class, 'XCUIElementTypeButton')

	for z in 0..buttons.count
		if(buttons[z].text.include? "Delete")
			return buttons[z]
		end
	end
  end
  
  #def statementMessageReorder_button(cellNumber)
  #  Element.new(@selenium, :xpath, "//XCUIElementTypeTable[1]/XCUIElementTypeCell[#{cellNumber}]/XCUIElementTypeButton[contains(@name,'Reorder')]")
  #end
  
  def statementMessageReorder_button(which)
	parent = @selenium.find_element(:class, 'XCUIElementTypeTable')
	cells = parent.find_elements(:class, 'XCUIElementTypeCell')
	
	#for i in 0..cells.count
	#	txt = cells[i].find_element(:class, 'XCUIElementTypeStaticText')
	#	puts txt.text
	#end

	buttons = cells[which].find_elements(:class, 'XCUIElementTypeButton')

	for z in 0..buttons.count
		if(buttons[z].text.include? "Reorder")
			return buttons[z]
		end
	end
  end
  
  def statementMessageAdd_button(cellNumber)
    #Element.new(@selenium, :xpath, "//XCUIElementTypeTable[1]/XCUIElementTypeCell[#{cellNumber}]/XCUIElementTypeButton[@name='Insert Add Statement']")
    Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Insert Append Statement")
  end
  
  def statementMessageAdd_staticText
    #Element.new(@selenium, :xpath, "//XCUIElementTypeTable[1]/XCUIElementTypeCell[#{cellNumber}]/XCUIElementTypeStaticText[1]")
    
    parent = @selenium.find_element(:class, "XCUIElementTypeTable")
    buttons = parent.find_elements(:class, "XCUIElementTypeButton")
    
    button = nil
    
    for i in 0..(buttons.count - 1)
      if(buttons[i].text == "Insert Append Statement")
        button = buttons[i]
      end
    end
    
    return button
  end
  

	 #parent = @selenium.find_element(:class, 'XCUIElementTypeTable')
	 #cells = parent.find_elements(:class, 'XCUIElementTypeCell')
	 #puts cells.count
	 #
	 ##for i in 0..cells.count
	 ##	txt = cells[i].find_element(:class, 'XCUIElementTypeStaticText')
	 ##	puts txt.text
	 ##end
	 #
	 #buttons = cells[cellNumber].find_elements(:class, 'XCUIElementTypeButton')
	 #puts buttons.count
	 #
	 #for z in 0..buttons.count
	 #	puts buttons[z].text
	 #	if(buttons[z].text.include? "Delete")
	 #		puts "found it"
	 #		return buttons[z]
	 #	end
	 #end 
	  
  #Element.new(@selenium, :xpath, "//XCUIElementTypeTable[1]/XCUIElementTypeCell[#{cellNumber}]/XCUIElementTypeButton[@name='Delete']")
  def statementMessageDelete_button(cellNumber) 
	parent = @selenium.find_element(:class, 'XCUIElementTypeTable')
																	
	buttons = parent.find_elements(:class, 'XCUIElementTypeButton')
	
	for i in 0..buttons.count
		if(buttons[i].text ==  "Delete")
			return buttons[i]
		end
	end	
  end
  
  def getCountOfStatements
    puts "in the get count of statements"
    @selenium.find_elements(:xpath, "//XCUIElementTypeTable[1]/XCUIElementTypeCell").count - 1
  end
  
  def cancel_button
    Element.new(@selenium, :xpath, "//XCUIElementTypeButton[@name='Cancel']")
  end
  
  def confirm_button
    #Element.new(@selenium, :xpath, "//XCUIElementTypeButton[@name='Confirm']")
    Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Confirm")
  end
  
  def undoEdits_button
    #Element.new(@selenium, :xpath, "//XCUIElementTypeButton[@name='Undo Edits']")
    Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Undo Edits")
  end
  
  def undo_message_text
	  parent = @selenium.find_element(:class, "XCUIElementTypeSheet")
	  message = "Any information you edited will be undone. Are you sure you want to undo edits?"
	  txts = parent.find_elements(:class, "XCUIElementTypeStaticText")
	  for i in 0..txts.count
		  if(txts[i].text == message)
			  return txts[i]
		  end
	  end
  end
  def undoEditsCancel_button
	Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Cancel")
    #Element.new(@selenium, :xpath, "//XCUIElementTypeSheet[1]/XCUIElementTypeOther[1]/XCUIElementTypeOther[2]/XCUIElementTypeOther[2]/XCUIElementTypeOther[1]/XCUIElementTypeOther[1]/XCUIElementTypeOther[1]/XCUIElementTypeOther[1]/XCUIElementTypeButton[@name='Cancel']")
  end
  
  def alert_continue
    Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Continue")
  end
  
  def alertConfirm_button
   #Element.new(@selenium, :xpath, "//XCUIElementTypeAlert[1]/XCUIElementTypeOther[1]/XCUIElementTypeOther[1]/XCUIElementTypeOther[2]/XCUIElementTypeOther[3]/XCUIElementTypeOther[1]/XCUIElementTypeOther[1]/XCUIElementTypeOther[3]/XCUIElementTypeButton[@name='Confirm']")
	  #Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Confirm")
  	alert = @selenium.find_element(:class, 'XCUIElementTypeAlert')
  	buttons = alert.find_elements(:class, 'XCUIElementTypeButton')
  	for i in 0..buttons.count
		if(buttons[i].text == "Confirm")
			return buttons[i]
		end
	end
  end	
  
  def alertCancel_button
	parent =  @selenium.find_element(:class, 'XCUIElementTypeAlert')
	buttons = parent.find_elements(:class, 'XCUIElementTypeButton')
	for i in 0..buttons.count
		if(buttons[i].text == "Cancel")
			return buttons[i]
		end
	end
	   #Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Cancel")
    #Element.new(@selenium, :xpath, "//XCUIElementTypeAlert[1]/XCUIElementTypeOther[1]/XCUIElementTypeOther[1]/XCUIElementTypeOther[2]/XCUIElementTypeOther[3]/XCUIElementTypeOther[1]/XCUIElementTypeOther[1]/XCUIElementTypeOther[1]/XCUIElementTypeButton[@name='Cancel']")
  end
  
  def alertOk_button
    #Element.new(@selenium, :xpath, "//XCUIElementTypeAlert[1]/XCUIElementTypeOther[1]/XCUIElementTypeOther[1]/XCUIElementTypeOther[2]/XCUIElementTypeOther[3]/XCUIElementTypeOther[1]/XCUIElementTypeOther[1]/XCUIElementTypeOther[1]/XCUIElementTypeButton[@name='OK']")
    Appium_lib.predicate(@appium, "XCUIElementTypeButton", "OK")
  end
  
  def alertContinue_button
    Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Continue")
    #Element.new(@selenium, :xpath, "//XCUIElementTypeAlert[1]/XCUIElementTypeOther[1]/XCUIElementTypeOther[1]/XCUIElementTypeOther[2]/XCUIElementTypeOther[3]/XCUIElementTypeOther[1]/XCUIElementTypeOther[1]/XCUIElementTypeOther[3]/XCUIElementTypeButton[@name='Continue']")
  end
  
  def alert_header
	alert = @selenium.find_element(:class, 'XCUIElementTypeAlert')
	static_text = alert.find_elements(:class, 'XCUIElementTypeStaticText')
	
	return static_text[0]
  end
  
  def alert_description
	alert = @selenium.find_element(:class, 'XCUIElementTypeAlert')
	static_text = alert.find_elements(:class, 'XCUIElementTypeStaticText')
	
	return static_text[1]
  end
  
end