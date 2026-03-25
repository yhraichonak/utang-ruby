Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class SerialPresentation_screen
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end
  
  def close_button
	Appium_lib.predicate(@appium, "XCUIElementTypeButton", "common close")
  end
  
  def done_button
    Element.new(@selenium, :name, 'Done')
  end
  
  def caret1_button
    Element.new(@selenium, :xpath, '//XCUIElementTypeOther[1]/XCUIElementTypeOther[1]/XCUIElementTypeButton[1]')
  end
    
  def caret2_button
    Element.new(@selenium, :xpath, '//XCUIElementTypeOther[3]/XCUIElementTypeOther[1]/XCUIElementTypeButton[1]')
  end
  
  def getPatientInfoFromHeader
	  	parent = @selenium.find_element(:class, "XCUIElementTypeNavigationBar")
		texts = parent.find_elements(:class, "XCUIElementTypeStaticText")
      
		patientName = texts[0].text
		patientGenderAndAge = texts[1].text
		patientSiteAndMRN = texts[2].text
      return [patientName,patientGenderAndAge,patientSiteAndMRN]
	  
    #if desired_capabilities['deviceName'].include? 'iPad'
    #  patientName = Element.new(@selenium, :xpath, '//UIAWindow/UIAStaticText[6]').name
    #  patientGenderAndAge = Element.new(@selenium, :xpath, '//UIAWindow/UIAStaticText[7]').name
    #  patientSiteAndMRN = Element.new(@selenium, :xpath, '//UIAWindow/UIAStaticText[8]').name
    #  return [patientName,patientGenderAndAge,patientSiteAndMRN]
    #else
    #		parent = @selenium.find_element(:class, "XCUIElementTypeNavigationBar")
    #		texts = parent.find_elements(:class, "XCUIElementTypeStaticText")
    #      
    #		patientName = texts[0].text
    #		patientGenderAndAge = texts[1].text
    #		patientSiteAndMRN = texts[2].text
    #      return [patientName,patientGenderAndAge,patientSiteAndMRN]
    #    end
  end
  
  #def mainThreeSecondLead_element(lead)
  #  view = "//#{WINDOW}/UIAScrollView[2]/UIACollectionView[1]/UIACollectionCell"
  #  case lead
  #  when "I"
  #    EcgLead.new(@selenium, :xpath, view+"[1]")
  #  when "II"
  #    EcgLead.new(@selenium, :xpath, view+"[2]")
  #  when "III"
  #    EcgLead.new(@selenium, :xpath, view+"[3]")
  #  when "aVR"
  #    EcgLead.new(@selenium, :xpath, view+"[4]")
  #  when "aVL"
  #    EcgLead.new(@selenium, :xpath, view+"[5]")
  #  when "aVF"
  #    EcgLead.new(@selenium, :xpath, view+"[6]")
  #  when "V1"
  #    EcgLead.new(@selenium, :xpath, view+"[7]")
  #  when "V2"
  #    EcgLead.new(@selenium, :xpath, view+"[8]")
  #  when "V3"
  #    EcgLead.new(@selenium, :xpath, view+"[9]")
  #  when "V4"
  #    EcgLead.new(@selenium, :xpath, view+"[10]")
  #  when "V5"
  #    EcgLead.new(@selenium, :xpath, view+"[11]")
  #  when "V6"
  #    EcgLead.new(@selenium, :xpath, view+"[12]")
  #  end
  #end
  
  def mainThreeSecondLead_element(lead)
    #view = "#{UIAWINDOW}.scrollViews()[0].collectionViews()[0].cells().firstWithPredicate(\"name LIKE '*titleLabel*"
    #case lead
    #when "I"
    #  EcgLead.new(@selenium, :uiautomation, view+ ":I;*'\")")
    #when "II"
    #  EcgLead.new(@selenium, :uiautomation, view+":II;*'\")")
    #when "III"
    #  EcgLead.new(@selenium, :uiautomation, view+":III;*'\")")
    #when "aVR"
    #  EcgLead.new(@selenium, :uiautomation, view+":aVR;*'\")")
    #when "aVL"
    #  EcgLead.new(@selenium, :uiautomation, view+":aVL;*'\")")
    #when "aVF"
    #  EcgLead.new(@selenium, :uiautomation, view+":aVF;*'\")")
    #when "V1"
    #  EcgLead.new(@selenium, :uiautomation, view+":V1;*'\")")
    #when "V2"
    #  EcgLead.new(@selenium, :uiautomation, view+":V2;*'\")")
    #when "V3"
    #  EcgLead.new(@selenium, :uiautomation, view+":V3;*'\")")
    #when "V4"
    #  EcgLead.new(@selenium, :uiautomation, view+":V4;*'\")")
    #when "V5"
    #  EcgLead.new(@selenium, :uiautomation, view+":V5;*'\")")
    #when "V6"
    #  EcgLead.new(@selenium, :uiautomation, view+":V6;*'\")")
    #end
    #Element.new(@selenium, :xpath, "//XCUIElementTypeOther[2]/XCUIElementTypeCollectionView[1]/XCUIElementTypeCell[contains(@name, ':#{lead};')]")
    
    #@appium.find_ele_by_attr("XCUIElementTypeStaticText", "name", "#{lead}")
    Appium_lib.predicate(@appium, "XCUIElementTypeStaticText", "#{lead}")
  end
  
  def comparisonThreeSecondLead_element(lead)
    #view = "#{UIAWINDOW}.scrollViews()[1].collectionViews()[1].cells().firstWithPredicate(\"name LIKE '*titleLabel*"
    #case lead
    #when "I"
    #  EcgLead.new(@selenium, :uiautomation, view+ ":I;*'\")")
    #when "II"
    #  EcgLead.new(@selenium, :uiautomation, view+":II;*'\")")
    #when "III"
    #  EcgLead.new(@selenium, :uiautomation, view+":III;*'\")")
    #when "aVR"
    #  EcgLead.new(@selenium, :uiautomation, view+":aVR;*'\")")
    #when "aVL"
    #  EcgLead.new(@selenium, :uiautomation, view+":aVL;*'\")")
    #when "aVF"
    #  EcgLead.new(@selenium, :uiautomation, view+":aVF;*'\")")
    #when "V1"
    #  EcgLead.new(@selenium, :uiautomation, view+":V1;*'\")")
    #when "V2"
    #  EcgLead.new(@selenium, :uiautomation, view+":V2;*'\")")
    #when "V3"
    #  EcgLead.new(@selenium, :uiautomation, view+":V3;*'\")")
    #when "V4"
    #  EcgLead.new(@selenium, :uiautomation, view+":V4;*'\")")
    #when "V5"
    #  EcgLead.new(@selenium, :uiautomation, view+":V5;*'\")")
    #when "V6"
    #  EcgLead.new(@selenium, :uiautomation, view+":V6;*'\")")
    #end
    #Element.new(@selenium, :xpath, "//XCUIElementTypeOther[4]/XCUIElementTypeCollectionView[1]/XCUIElementTypeCell[contains(@name, ':#{lead};')]")
    elements = Appium_lib.predicates(@appium, "XCUIElementTypeStaticText", "#{lead}")
    return elements[elements.count-1]
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
      name = Element.new(@selenium, :xpath, view + '[30]').name
      acquistionDate = Element.new(@selenium, :xpath, view + '[31]').name
      mrn = Element.new(@selenium, :xpath, view + '[33]').name
      gender = Element.new(@selenium, :xpath, view + '[35]').name      
      age = Element.new(@selenium, :xpath, view + '[37]').name      
      vhr = Element.new(@selenium, :xpath, view + '[39]').name
      pr = Element.new(@selenium, :xpath, view + '[41]').name
      qrs = Element.new(@selenium, :xpath, view + '[43]').name      
      prt = Element.new(@selenium, :xpath, view + '[45]').name
      race = Element.new(@selenium, :xpath, view + '[47]').name
      dob = Element.new(@selenium, :xpath, view + '[49]').name
      ahr = Element.new(@selenium, :xpath, view + '[51]').name
      qt = Element.new(@selenium, :xpath, view + '[53]').name
      qtc = Element.new(@selenium, :xpath, view + '[55]').name
      diagnosisStatements = Element.new(@selenium, :xpath, textView + '[2]').name
      
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
  
  def previousEcg_button
    Element.new(@selenium, :xpath, '//UIAButton[@name="< Previous"]')
  end
  
  def nextEcg_button
    Element.new(@selenium, :xpath, '//UIAButton[@name="Next >"]')
  end
  
  def leadOrder1_staticText
    Element.new(@selenium, :xpath, '//UIAButton/UIAStaticText[59]')
  end
  
  def leadOrder2_staticText
    Element.new(@selenium, :xpath, '//UIAButton/UIAStaticText[60]')
  end

end