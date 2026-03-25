Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class Search_screen
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end

  def search_result_returned
    e = @appium .find_element(:xpath, '//XCUIElementTypeStaticText[contains(@name,"Search results for")]')
    if e.nil?
      e = @appium .find_element(:xpath, '//XCUIElementTypeStaticText[contains(@name,"Search results for")]')
    end
    return e
  end

  def nav_clear_button
    parent = @selenium.find_element(:class, "XCUIElementTypeNavigationBar")
    buttons = parent.find_elements(:class, "XCUIElementTypeButton")
    button = nil
    found = false
    for i in 0..(buttons.count - 1)
      if buttons[i].name == "Clear text"
        button = buttons[i]
        found = true
        break
      end
      if found == true
        break
      end
    end

    return button
  end

  def nav_cancel_button
    parent = @selenium.find_element(:class, "XCUIElementTypeNavigationBar")
    buttons = parent.find_elements(:class, "XCUIElementTypeButton")
    button = nil
    found = false
    for i in 0..(buttons.count - 1)
      if buttons[i].name == "Cancel"
        button = buttons[i]
        found = true
        break
      end
      if found == true
        break
      end
    end

    return button
  end

  def nav_search_button
    parent = @selenium.find_element(:class, "XCUIElementTypeNavigationBar")
    buttons = parent.find_elements(:class, "XCUIElementTypeButton")
    button = nil
    found = false
    for i in 0..(buttons.count - 1)
      if buttons[i].name == "Cancel"
        button = buttons[i]
        found = true
        break
      end
      if found == true
        break
      end
    end

    return button
  end

  def search_navigation
	#obj = @selenium.find_elements(:class, 'XCUIElementTypeNavigationBar')
	#return obj[0]
	Appium_lib.predicate(@appium, "XCUIElementTypeNavigationBar", "Search")
  end

  def search_title
	parent = @selenium.find_element(:class, 'XCUIElementTypeNavigationBar')
	static_text = parent.find_elements(:class, 'XCUIElementTypeOther')
	found = false
	for i in 0..static_text.count
		if(static_text[i].text == "Search")
			found = true
			return static_text[i]
		end
		if found == true
			break
		end
	end
  end

  def searchField_searchBar
    Element.new(@selenium, :xpath, '//UIASearchBar')
  end

  def first_button
    #Appium_lib.predicate(@appium, "XCUIElementTypeStaticText", "First")
    parent = @selenium.find_element(:class, 'XCUIElementTypeTable')
    txts = parent.find_elements(:class, 'XCUIElementTypeStaticText')
    found = false
    text = nil
    for i in 0..(txts.count - 1)
      if(txts[i].text == "First")
        found = true
        text = txts[i]
      end
      if found == true
        break
      end
    end

    return text
  end

  def last_button
    #Appium_lib.predicate(@appium, "XCUIElementTypeStaticText", "Last")
    parent = @selenium.find_element(:class, 'XCUIElementTypeTable')
    txts = parent.find_elements(:class, 'XCUIElementTypeStaticText')
    found = false
    text = nil
    for i in 0..(txts.count - 1)
      if(txts[i].text == "Last")
        found = true
        text = txts[i]
      end
      if found == true
        break
      end
    end

    return text
  end

  def dob_button
    #Appium_lib.predicate(@appium, "XCUIElementTypeStaticText", "MM/DD/YYYY")
    parent = @selenium.find_element(:class, 'XCUIElementTypeTable')
    txts = parent.find_elements(:class, 'XCUIElementTypeStaticText')
    found = false
    text = nil
    for i in 0..(txts.count - 1)
      if(txts[i].text == "MM/DD/YYYY")
        found = true
        text = txts[i]
      end
      if found == true
        break
      end
    end

    return text
  end

  def search_button
    #if ENV['DEVICE'] !~ /iPad/
    #  Appium_lib.predicate(@appium, "XCUIElementTypeStaticText", "Search")
    #else
    #  buttons = Appium_lib.predicates(@appium, "XCUIElementTypeStaticText", "Search")
    #  return buttons[1]
    #end
    parent = @selenium.find_elements(:class, 'XCUIElementTypeTable')
    txts = parent[1].find_elements(:class, 'XCUIElementTypeButton')
    found = false
    value = nil

    for i in 0..(txts.count - 1)
      #puts txts[i].name
      if(txts[i].name == "Search")
        value = txts[i]
        found = true
        break
      end

      if found == true
        break
      end
    end

    return value
    #Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Search")
  end

  def search_criteria_button(which)
    puts "search criteria button name = #{which}"
    #windows = @selenium.find_elements(:class, 'XCUIElementTypeWindow')
    #puts "the window count is #{windows.count}"
    parent = @selenium.find_elements(:class, 'XCUIElementTypeTable')
    puts "found the table object"
    puts "the count of tables is #{parent.count}"
    cells = parent[1].find_elements(:class, 'XCUIElementTypeCell')
    puts cells.count

    #cells2 = parent[1].find_elements(:class, 'XCUIElementTypeCell')
    #puts cells2.count

    found = false
    cell = nil
    text = nil
    for x in 0..(cells.count - 1)
       txts = cells[x].find_elements(:class, 'XCUIElementTypeStaticText')
        for i in 0..(txts.count - 1)
          puts txts[i].text
          if(txts[i].text == which)
            found = true
            cell = cells[x]
          end
          if found == true
            break
          end
        end
        if found == true
          break
        end
    end

    text = cell.find_element(:class, 'XCUIElementTypeTextField')

    return text
    #Appium_lib.predicate(@appium, "XCUIElementTypeStaticText", "Age")
  end

  def age_button_old
    windows = @selenium.find_elements(:class, 'XCUIElementTypeWindow')
    puts "the window cound is #{windows.count}"
    parent = windows[0].find_elements(:class, 'XCUIElementTypeTable')
    puts "found the table object"
    puts "the count of tables is #{parent.count}"
    txts = parent[0].find_elements(:class, 'XCUIElementTypeStaticText')
    puts txts.count
    found = false
    text = nil
    for i in 0..(txts.count - 1)
      puts txts[i].text
      if(txts[i].text == "Age")
        found = true
        text = txts[i]
      end
      if found == true
        break
      end
    end

    return text
    #Appium_lib.predicate(@appium, "XCUIElementTypeStaticText", "Age")
  end

  def mrn_button
        #Appium_lib.predicate(@appium, "XCUIElementTypeStaticText", "MRN/PID")
        parent = @selenium.find_element(:class, 'XCUIElementTypeTable')
    txts = parent.find_elements(:class, 'XCUIElementTypeStaticText')
    found = false
    text = nil
    for i in 0..(txts.count - 1)
      if(txts[i].text == "MRN/PID")
        found = true
        text = txts[i]
      end
      if found == true
        break
      end
    end

    return text
  end

  def pm_mrn
    Element.new(@selenium, :uiautomation, "#{UIAWINDOW}.tableViews()[0].cells()[4].textFields()[0]")
    #Element.new(@selenium, :xpath, '//UIAApplication[1]/UIAWindow[2]/UIATableView[1]/UIATableCell[4]/UIATextField[1]')
  end

  def pm_last_name
    Element.new(@selenium, :uiautomation, "#{UIAWINDOW}.tableViews()[0].cells()[2].textFields()[0]")
    #Element.new(@selenium, :xpath, '//UIAApplication[1]/UIAWindow[2]/UIATableView[1]/UIATableCell[2]/UIATextField[1]')
  end

  def pm_first_name
    Element.new(@selenium, :uiautomation, "#{UIAWINDOW}.tableViews()[0].cells()[1].textFields()[0]")
    #Element.new(@selenium, :xpath, '//UIAApplication[1]/UIAWindow[2]/UIATableView[1]/UIATableCell[1]/UIATextField[1]')
  end

  def unit_button
    Element.new(@selenium, :uiautomation, "#{UIAWINDOW}.tableViews()[0].cells()[2].textFields()[0]")
    #Element.new(@selenium, :xpath, '//UIAStaticText[@name="Unit"]')
  end

  def pm_bed
    Element.new(@selenium, :uiautomation, "#{UIAWINDOW}.tableViews()[0].cells()[3].textFields()[0]")
    #Element.new(@selenium, :xpath, '//UIAApplication[1]/UIAWindow[2]/UIATableView[1]/UIATableCell[3]/UIATextField[1]/UIATextField[1]')
  end

  def search_nav_bar
    Element.new(@selenium, :xpath, '//XCUIElementTypeStaticText[@name="Search"]')
  end

  def emr_last_name
    Element.new(@selenium, :xpath, '//XCUIElementTypeStaticText[@name="Last"]')
  end

  def emr_last_name_field
    Element.new(@selenium, :xpath, '//XCUIElementTypeApplication[1]/XCUIElementTypeWindow[1]/XCUIElementTypeOther[1]/XCUIElementTypeOther[1]/XCUIElementTypeOther[1]/XCUIElementTypeOther[1]/XCUIElementTypeTable[1]/XCUIElementTypeCell[1]/XCUIElementTypeTextField[1]')
  end

  def emr_first_name
    Element.new(@selenium, :xpath, '//XCUIElementTypeStaticText[@name="First"]')
  end

  def emr_first_name_field
    Element.new(@selenium, :xpath, '//XCUIElementTypeApplication[1]/XCUIElementTypeWindow[1]/XCUIElementTypeOther[1]/XCUIElementTypeOther[1]/XCUIElementTypeOther[1]/XCUIElementTypeOther[1]/XCUIElementTypeTable[1]/XCUIElementTypeCell[2]/XCUIElementTypeTextField[1]')
  end

  def emr_dob
    Element.new(@selenium, :xpath, '//XCUIElementTypeStaticText[@name="MM/DD/YYYY"]')
  end

  def emr_dob_field
    Element.new(@selenium, :xpath, '//XCUIElementTypeApplication[1]/XCUIElementTypeWindow[1]/XCUIElementTypeOther[1]/XCUIElementTypeOther[1]/XCUIElementTypeOther[1]/XCUIElementTypeOther[1]/XCUIElementTypeTable[1]/XCUIElementTypeCell[3]/XCUIElementTypeTextField[1]')
  end

  def emr_mrn
    Element.new(@selenium, :xpath, '//XCUIElementTypeStaticText[@name="MRN"]')
  end

  def emr_mrn_field
    Element.new(@selenium, :xpath, '//XCUIElementTypeApplication[1]/XCUIElementTypeWindow[1]/XCUIElementTypeOther[1]/XCUIElementTypeOther[1]/XCUIElementTypeOther[1]/XCUIElementTypeOther[1]/XCUIElementTypeTable[1]/XCUIElementTypeCell[4]/XCUIElementTypeTextField[1]')
  end

  def emr_fin
    Element.new(@selenium, :xpath, '//XCUIElementTypeStaticText[@name="FIN"]')
  end

  def emr_fin_field
    Element.new(@selenium, :xpath, '//XCUIElementTypeApplication[1]/XCUIElementTypeWindow[1]/XCUIElementTypeOther[1]/XCUIElementTypeOther[1]/XCUIElementTypeOther[1]/XCUIElementTypeOther[1]/XCUIElementTypeTable[1]/XCUIElementTypeCell[5]/XCUIElementTypeTextField[1]')
  end

  def clear_form_button
    Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Clear Form")
  end

  def done_button
    Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Done")
  end

  def missing_criteria_dialog
    Element.new(@selenium, :xpath, "//XCUIElementTypeStaticText[@name='Missing Criteria']")
    Element.new(@selenium, :xpath, "//XCUIElementTypeStaticText[@name='Please enter some search criteria.']")
  end

  def missing_criteria_ok_button
    Element.new(@selenium, :xpath, "//XCUIElementTypeOther[@type='Other']")
  end

end
