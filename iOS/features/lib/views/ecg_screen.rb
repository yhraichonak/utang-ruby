Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class ECG_screen
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end

  def ecg_list
    parent = @selenium.find_element(:xpath, "//XCUIElementTypeCollectionView | //XCUIElementTypeTable")
    cells = parent.find_elements(:class, 'XCUIElementTypeCell')
    return cells[0]
  end

  def ecg_scrollview
    puts "in the ecg scroll view"
    scrollviews = @selenium.find_elements(:class, 'XCUIElementTypeScrollView')
    puts scrollviews.count
    return scrollviews[2]
  end

  def navigationBar
    @selenium.find_element(:xpath,'//XCUIElementTypeNavigationBar' )
  end

  def new_nav_home_button
    #puts @selenium.page_source
    scrollviews = @selenium.find_elements(:class, 'XCUIElementTypeScrollView')
    buttons = scrollviews[0].find_elements(:class, 'XCUIElementTypeButton')
    return buttons[0]
  end

  def new_nav_home_button14
    #puts @selenium.page_source
    buttons = @selenium.find_elements(:class, 'XCUIElementTypeButton')
    if (ENV['DEVICE'].include? "iPad")
      return buttons[5]
    else
      return buttons[3]
    end

  end

  def new_nav_ecg_button
    buttons = @selenium.find_elements(:class, 'XCUIElementTypeButton')
    return buttons[7]
  end

  def new_nav_share_button
    buttons = @selenium.find_elements(:class, 'XCUIElementTypeButton')
    return buttons[9]
  end

  def close_button
    Element.new(@selenium, :uiautomation, "#{UIAWINDOW}.buttons()[6]")
  end

  def ecgScrubber_image
    Element.new(@selenium, :xpath, "//XCUIElementTypeScrollView[1]/XCUIElementTypeOther[1]/XCUIElementTypeOther[3]/XCUIElementTypeImage[1]")
  end

  def ecgs_button
    buttons = @selenium.find_elements(:class, 'XCUIElementTypeButton')
    return buttons[1]
  end

  def ecg_tableCell(rowNumber)
    row = rowNumber.to_i - 1

    parent = @selenium.find_element(:xpath, "//XCUIElementTypeCollectionView | //XCUIElementTypeTable")
    cells = parent.find_elements(:class, 'XCUIElementTypeCell')
    txts = cells[row].find_elements(:class, 'XCUIElementTypeStaticText')
    puts txts[0].name
    puts txts[1].name
    puts txts[2].name
    return txts[0]
  end

  def options_button
    Appium_lib.predicate(@appium, "XCUIElementTypeButton","common action icon")
  end

  def options_button14
    parent = @selenium.find_element(:class, "XCUIElementTypeNavigationBar")

    buttons = parent.find_elements(:class, "XCUIElementTypeButton")
    return buttons[2]
  end

  def options_button14
    parent = @selenium.find_element(:class, "XCUIElementTypeNavigationBar")

    buttons = parent.find_elements(:class, "XCUIElementTypeButton")

    for i in 0..(buttons.count - 1)
      puts "#{i} = #{buttons[i].text}"
    end
    return buttons[2]
  end

  def caret_button
    found = false
    button = nil
    buttons = @selenium.find_elements(:class, 'XCUIElementTypeButton')
    for i in 0..(buttons.count - 1)
      if(buttons[i].name == "caretDN")
        found = true
        button = buttons[i]
      end
      if found == true
        break
      end
    end
    return button
  end

  def editAndConfirms_button
    found = false
    button = nil
    buttons = @selenium.find_elements(:class, 'XCUIElementTypeButton')
    for i in 0..(buttons.count - 1)
      if(buttons[i].name == "Edit / Confirm")
        found = true
        button = buttons[i]
      end
      if found == true
        break
      end
    end
    return button
  end

  def paperMode_button
    #iPad only
    if desired_capabilities['deviceName'].include? 'iPad'
      elements = @appium.tags("XCUIElementTypeButton")
      return elements[4]
    else
      Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Paper Mode")
    end
  end

  def paperMode_button_ipad
      #iPad only
      parent = @selenium.find_element(:class, "XCUIElementTypeNavigationBar")
      elements = parent.find_elements(:class, "XCUIElementTypeButton")
      return elements[3]
  end

  def share_button
    Element.new(@selenium, :xpath, '//XCUIElementTypeButton[@name="Share"]')
  end

  def cancel_button
    Element.new(@selenium, :xpath, '//XCUIElementTypeButton[@name="Cancel"]')
  end

  def edit_button
    #iPad only
    Element.new(@selenium, :xpath, '//XCUIElementTypeButton[@name="Edit"]')
  end

  def x_button
    #iPad only
    Element.new(@selenium, :xpath, '//XCUIElementTypeButton[@name="common close"]')
  end

  def back_button
    Appium_lib.predicate_include(@appium, "XCUIElementTypeButton", "Back")
  end

  def alert_message
    Element.new(@selenium, :xpath, "XCUIElementTypeAlert[1]/XCUIElementTypeOther[1]/XCUIElementTypeOther[1]/XCUIElementTypeOther[2]/XCUIElementTypeOther[1]/XCUIElementTypeOther[1]/XCUIElementTypeStaticText[1]")
  end

  def getPatientInfoFromHeader
    if desired_capabilities['deviceName'].include? 'iPad'
      patientName = Element.new(@selenium, :xpath, '//#{WINDOW}/UIAStaticText[2]').name
      patientGenderAndAge = Element.new(@selenium, :xpath, '//#{WINDOW}/UIAStaticText[3]').name
      patientSiteAndMRN = Element.new(@selenium, :xpath, '//#{WINDOW}/UIAStaticText[4]').name
    else
      patientName = Element.new(@selenium, :uiautomation, "#{UIAWINDOW}.staticTexts()[4]").name
      patientGenderAndAge = Element.new(@selenium, :uiautomation, "#{UIAWINDOW}.staticTexts()[5]").name
      patientSiteAndMRN = Element.new(@selenium, :uiautomation, "#{UIAWINDOW}.staticTexts()[6]").name
    end
    return [patientName,patientGenderAndAge,patientSiteAndMRN]
  end

  def getCountOf3SecLeadsOnScreen
    @selenium.find_elements(:uiautomation, "#{UIAWINDOW}.scrollViews()[0].elements().withPredicate(\"name LIKE '*titleLabel*'\")").count
  end

  def getCountOf10SecLeadsOnScreen
    @selenium.find_elements(:uiautomation, "#{UIAWINDOW}.scrollViews()[0].elements().withPredicate(\"name LIKE '*titleLabel*'\")").count
  end

  def threeSecondLead_element(lead)
    #puts "in the three second lead element for the ecg screen class"
    #puts "the lead = #{lead}"
    #Element.new(@selenium, :xpath, "//XCUIElementTypeOther[contains(@name, ':#{lead};')]")
    #e = Appium_lib.predicate_include(@appium, "XCUIElementTypeOther", "'titleLabel':#{lead}; 'zoomScale':4")

    e_s = @selenium.find_elements(:class, "XCUIElementTypeOther")
    e = nil
    found = false

    for i in 0..(e_s.count - 1)
     # puts "#{i} = #{e_s[i].attribute('name')}"
      if e_s[i].name.nil? == true

      elsif e_s[i].name.include? "'titleLabel':#{lead}; 'zoomScale':4"
        found = true
        #puts e_s[i].text
        e = e_s[i]
        break
      end
      if found == true
        break
      end
    end
       puts "the three second lead element =  #{e.name}"
    return e
  end

  def tenSecondLead_element(lead)
    trycount = 0
    while trycount < 5
      e = @appium.find_eles_by_predicate_include(:class_name=>"XCUIElementTypeOther", :value=>"'titleLabel':#{lead};").filter{|t|  t.displayed?}
      if !e[0].nil? && e[0].displayed?
        return e[0]
      else
        do_small_swipe
        sleep 1
      end
    end
    raise "Unable find tenSecondLead with label #{lead}"
  end

  def getPatientInfoFromDetailView
    if desired_capabilities['deviceName'].include? 'iPad'
      view = "//#{WINDOW}/UIAScrollView[1]/UIAStaticText"
      textView = "//#{WINDOW}/UIAScrollView[1]/UIATextView"

      mainStatement = Element.new(@selenium, :xpath, view + '[1]').name
      acquistionDate = Element.new(@selenium, :xpath, view + '[2]').name
      gender = Element.new(@selenium, :xpath, view + '[4]').name
      dob = Element.new(@selenium, :xpath, view + '[6]').name
      age = Element.new(@selenium, :xpath, view + '[8]').name
      race = Element.new(@selenium, :xpath, view + '[10]').name
      vhr = Element.new(@selenium, :xpath, view + '[12]').name
      pr = Element.new(@selenium, :xpath, view + '[14]').name
      qrs = Element.new(@selenium, :xpath, view + '[16]').name
      prt = Element.new(@selenium, :xpath, view + '[18]').name,
      ahr = Element.new(@selenium, :xpath, view + '[20]').name
      qt = Element.new(@selenium, :xpath, view + '[22]').name
      qtc = Element.new(@selenium, :xpath, view + '[24]').name
      diagnosisStatements = Element.new(@selenium, :xpath, textView + '[1]').name

      return {
      "mainStatement" => mainStatement,
      "acquistionDate" => acquistionDate,
      "gender" => gender,
      "DOB" => dob,
      "age" => age,
      "race" => race,
      "VHR" => vhr,
      "PR" => pr,
      "QRS" => qrs,
      "PRT" => prt,
      "AHR" => ahr,
      "QT" => qt,
      "QTC" => qtc,
      "diagnosisStatements" => diagnosisStatements
      }
    else
      view = "#{UIAWINDOW}.scrollViews()[0].staticTexts()"
      #textView = "//#{UIAWINDOW}.scrollViews()[0].elements()"

      mainStatement = Element.new(@selenium, :uiautomation, view + '[0]').name
      name = Element.new(@selenium, :uiautomation, view + '[1]').name
      acquistionDate = Element.new(@selenium, :uiautomation, view + '[2]').name
      mrn = Element.new(@selenium, :uiautomation, view + '[4]').name
      gender = Element.new(@selenium, :uiautomation, view + '[6]').name
      dob = Element.new(@selenium, :uiautomation, view + '[20]').name
      age = Element.new(@selenium, :uiautomation, view + '[8]').name
      race = Element.new(@selenium, :uiautomation, view + '[18]').name
      vhr = Element.new(@selenium, :uiautomation, view + '[10]').name
      pr = Element.new(@selenium, :uiautomation, view + '[12]').name
      qrs = Element.new(@selenium, :uiautomation, view + '[14]').name
      prt = Element.new(@selenium, :uiautomation, view + '[16]').name,
      ahr = Element.new(@selenium, :uiautomation, view + '[22]').name
      qt = Element.new(@selenium, :uiautomation, view + '[24]').name
      qtc = Element.new(@selenium, :uiautomation, view + '[26]').name
      #diagnosisStatements = Element.new(@selenium, :uiautomation, textView + '[0]').name
      diagnosisStatements = Element.new(@selenium, :class_name, 'UIATextView').name

      return {
      "mainStatement" => mainStatement,
      "name" => name,
      "acquistionDate" => acquistionDate,
      "mrn" => mrn,
      "gender" => gender,
      "DOB" => dob,
      "age" => age,
      "race" => race,
      "VHR" => vhr,
      "PR" => pr,
      "QRS" => qrs,
      "PRT" => prt,
      "AHR" => ahr,
      "QT" => qt,
      "QTC" => qtc,
      "diagnosisStatements" => diagnosisStatements
      }
    end
  end
end
