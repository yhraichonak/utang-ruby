Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class SerialPresentZoom_screen
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end
  
  def done_button
    Element.new(@selenium, :name, "Done")
  end
  
  def close_button
    Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Close")
  end

  def nav_bar
    nav = @selenium.find_element(:class, 'XCUIElementTypeButton')
    return nav
  end

  def ecg_one_close_button
    buttons = @selenium.find_elements(:class, 'XCUIElementTypeButton')
    return buttons[0]
  end

  def ecg_two_close_button
    buttons = @selenium.find_elements(:class, 'XCUIElementTypeButton')
    return buttons[1]
  end
  
  def caret1_button
    Appium_lib.predicate(@appium, "XCUIElementTypeButton", "caretDN")
    #Element.new(@selenium, :xpath, "//XCUIElementTypeOther[1]/XCUIElementTypeOther[1]/XCUIElementTypeButton[@name='caretDN']")
  end
  
  def caret2_button
    Appium_lib.predicate(@appium, "XCUIElementTypeButton", "caretDN")
    #Element.new(@selenium, :xpath, "//XCUIElementTypeOther[3]/XCUIElementTypeOther[1]/XCUIElementTypeButton[@name='caretDN']")
  end
  
  def getPatientInfoFromHeader
    if desired_capabilities['deviceName'].include? 'iPad'
      patientName = Element.new(@selenium, :xpath, '//UIAWindow/UIAStaticText[13]').name
      patientGenderAndAge = Element.new(@selenium, :xpath, '//UIAWindow/UIAStaticText[14]').name
      patientSiteAndMRN = Element.new(@selenium, :xpath, '//UIAWindow/UIAStaticText[15]').name
      return [patientName,patientGenderAndAge,patientSiteAndMRN]
    else
      patientName = Element.new(@selenium, :xpath, '//UIAWindow/UIAStaticText[12]').name
      patientGenderAndAge = Element.new(@selenium, :xpath, '//UIAWindow/UIAStaticText[13]').name
      patientSiteAndMRN = Element.new(@selenium, :xpath, '//UIAWindow/UIAStaticText[14]').name
      return [patientName,patientGenderAndAge,patientSiteAndMRN]
    end 
  end
  
  def mainThreeSecondLead_element
    EcgLead.new(@selenium, :xpath, "//XCUIElementTypeScrollView/XCUIElementTypeOther[4]/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeStaticText[1]")
    
  end
  
  def comparisonThreeSecondLead_element
    EcgLead.new(@selenium, :xpath, "//XCUIElementTypeScrollView/XCUIElementTypeOther[6]/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeStaticText[1]")
    
  end

  def getDetailPatientInfoFromMainEcg
    if desired_capabilities['deviceName'].include? 'iPad'
      view = "//#{WINDOW}/UIAScrollView[2]/UIAStaticText"
      textView = "//#{WINDOW}/UIAScrollView[2]/UIATextView"
      
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
      view = "//#{WINDOW}/UIAScrollView[2]/UIAStaticText"
      textView = "//#{WINDOW}/UIAScrollView[2]/UIATextView"
      
      mainStatement = Element.new(@selenium, :xpath, view + '[1]').name
      #name = Element.new(@selenium, :xpath, view + '[2]').name
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
      #"name" => name,
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

  def getDetailPatientInfoFromComparisonEcg
    if desired_capabilities['deviceName'].include? 'iPad'
      view = "//#{WINDOW}/UIAScrollView[2]/UIAStaticText"
      textView = "//#{WINDOW}/UIAScrollView[2]/UIATextView"
      
      mainStatement = Element.new(@selenium, :xpath, view + '[26]').name
      acquistionDate = Element.new(@selenium, :xpath, view + '[27]').name
      gender = Element.new(@selenium, :xpath, view + '[29]').name
      dob = Element.new(@selenium, :xpath, view + '[31]').name
      age = Element.new(@selenium, :xpath, view + '[33]').name
      race = Element.new(@selenium, :xpath, view + '[35]').name
      vhr = Element.new(@selenium, :xpath, view + '[37]').name
      pr = Element.new(@selenium, :xpath, view + '[39]').name
      qrs = Element.new(@selenium, :xpath, view + '[41]').name
      prt = Element.new(@selenium, :xpath, view + '[43]').name,
      ahr = Element.new(@selenium, :xpath, view + '[45]').name
      qt = Element.new(@selenium, :xpath, view + '[47]').name
      qtc = Element.new(@selenium, :xpath, view + '[49]').name
      diagnosisStatements = Element.new(@selenium, :xpath, textView + '[2]').name
      
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
      view = "//#{WINDOW}/UIAScrollView[2]/UIAStaticText"
      textView = "//#{WINDOW}/UIAScrollView[2]/UIATextView"
      
      mainStatement = Element.new(@selenium, :xpath, view + '[29]').name
      #name = Element.new(@selenium, :xpath, view + '[2]').name
      acquistionDate = Element.new(@selenium, :xpath, view + '[31]').name
      mrn = Element.new(@selenium, :xpath, view + '[33]').name
      gender = Element.new(@selenium, :xpath, view + '[35]').name
      dob = Element.new(@selenium, :xpath, view + '[49]').name
      age = Element.new(@selenium, :xpath, view + '[37]').name
      race = Element.new(@selenium, :xpath, view + '[47]').name
      vhr = Element.new(@selenium, :xpath, view + '[39]').name
      pr = Element.new(@selenium, :xpath, view + '[41]').name
      qrs = Element.new(@selenium, :xpath, view + '[43]').name
      prt = Element.new(@selenium, :xpath, view + '[45]').name,
      ahr = Element.new(@selenium, :xpath, view + '[51]').name
      qt = Element.new(@selenium, :xpath, view + '[53]').name
      qtc = Element.new(@selenium, :xpath, view + '[55]').name
      diagnosisStatements = Element.new(@selenium, :xpath, textView + '[2]').name
      
      return {
      "mainStatement" => mainStatement,
      #"name" => name,
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
