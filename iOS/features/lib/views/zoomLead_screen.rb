Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class ZoomLead_screen
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end

  def back_button
	Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Back")
  end

  def close_button
    button = Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Close")
    if button.nil?
      button = Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Close")
    end
    button
  end

  def caret_button
    #Element.new(@selenium, :xpath, 'UIAButton[@name="caretDN"]')
    #Element.new(@selenium, :xpath, "//XCUIElementTypeButton[@name='caretDN']")
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

  def getPatientInfoFromHeader
    if desired_capabilities['deviceName'].include? 'iPad'
      patientName = Element.new(@selenium, :xpath, '//#{WINDOW}/UIAStaticText[2]').name
      patientGenderAndAge = Element.new(@selenium, :xpath, '//#{WINDOW}/UIAStaticText[3]').name
      patientSiteAndMRN = Element.new(@selenium, :xpath, '//#{WINDOW}/UIAStaticText[4]').name
    else
      patientName = Element.new(@selenium, :xpath, '//UIAWindow/UIAStaticText[1]').name
      patientGenderAndAge = Element.new(@selenium, :xpath, '//UIAWindow/UIAStaticText[2]').name
      patientSiteAndMRN = Element.new(@selenium, :xpath, '//UIAWindow/UIAStaticText[3]').name
    end
    return [patientName,patientGenderAndAge,patientSiteAndMRN]
  end

  def threeSecondLead_element
    EcgLead.new(@selenium, :xpath, "//XCUIElementTypeStaticText[@name='#{lead}']")
    #if desired_capabilities['deviceName'].include? 'iPad'
    #  EcgLead.new(@selenium, :xpath, "//#{WINDOW}/UIAScrollView[2]/UIACollectionView[1]/UIACollectionCell[1]")
    #else
    #  EcgLead.new(@selenium, :xpath, "//#{WINDOW}/UIAScrollView[1]/UIACollectionView[1]/UIACollectionCell[1]")
    #end
  end

  def tenSecondLead_element
    EcgLead.new(@selenium, :xpath, "//XCUIElementTypeStaticText[@name='#{lead}']")
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
      view = "//#{WINDOW}/UIAScrollView[1]/UIAStaticText"
      textView = "//#{WINDOW}/UIAScrollView[1]/UIATextView"

      mainStatement = Element.new(@selenium, :xpath, view + '[1]').name
      name = Element.new(@selenium, :xpath, view + '[2]').name
      acquistionDate = Element.new(@selenium, :xpath, view + '[3]').name
      mrn = Element.new(@selenium, :xpath, view + '[5]').name
      gender = Element.new(@selenium, :xpath, view + '[7]').name
      dob = Element.new(@selenium, :xpath, view + '[21]').name
      age = Element.new(@selenium, :xpath, view + '[9]').name
      race = Element.new(@selenium, :xpath, view + '[19]').name
      vhr = Element.new(@selenium, :xpath, view + '[11]').name
      pr = Element.new(@selenium, :xpath, view + '[13]').name
      qrs = Element.new(@selenium, :xpath, view + '[15]').name
      prt = Element.new(@selenium, :xpath, view + '[17]').name,
      ahr = Element.new(@selenium, :xpath, view + '[23]').name
      qt = Element.new(@selenium, :xpath, view + '[25]').name
      qtc = Element.new(@selenium, :xpath, view + '[27]').name
      diagnosisStatements = Element.new(@selenium, :xpath, textView + '[1]').name

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
