Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class Demographics_window
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end
  
  def close_button
    buttons = @selenium.find_elements(:class_name, "XCUIElementTypeButton")
    lastbutton = buttons.count
    buttons[lastbutton-1]
  end
  
  def back_button
     buttons = @selenium.find_elements(:class_name, "UIAButton")
     button = buttons.find {|btn| btn.text == "Back"}
    #  found = nil
    #  for i in 0..(buttons.count - 1)
    #    if buttons[i].text == "Back"
    #      button = buttons[i]
    #      found = true
    #    end
    #    if found == true
    #     break
    #    end
    #  end
     return button
  end
  
  def getPatientInfoFromDemographicWindow
    if desired_capabilities['deviceName'].include? 'iPad'
      view = "//UIAWindow/UIATableView[1]/UIATableCell"
    else
      view = "//UIATableView[2]/UIATableCell"
    end
    
    name = Element.new(@selenium, :xpath, view + '[1]/UIAStaticText[2]').name
    pid = Element.new(@selenium, :xpath, view + '[2]/UIAStaticText[2]').name
    sex = Element.new(@selenium, :xpath, view + '[3]/UIAStaticText[2]').name
    race = Element.new(@selenium, :xpath, view + '[4]/UIAStaticText[2]').name
    dob = Element.new(@selenium, :xpath, view + '[5]/UIAStaticText[2]').name
    age = Element.new(@selenium, :xpath, view + '[6]/UIAStaticText[2]').name
    
    return {
      "name" => name,
      "pid" => pid,
      "sex" => sex,
      "race" => race,
      "dob" => dob,
      "age" => age
    }
  end
  
  def getPatientInfoFromPMDemographicWindow
    if desired_capabilities['deviceName'].include? 'iPad'
      view = "//UIAWindow/UIATableView[1]/UIATableCell"
    else
      view = "//UIATableView[2]/UIATableCell"
    end
    
    name = Element.new(@selenium, :xpath, view + '[1]').name
    mrn = Element.new(@selenium, :xpath, view + '[2]').name
    dob = Element.new(@selenium, :xpath, view + '[3]').name
    gender = Element.new(@selenium, :xpath, view + '[4]').name
    age = Element.new(@selenium, :xpath, view + '[5]').name
    
    return {
      "name" => name,
      "mrn" => mrn,
      "dob" => dob,
      "gender" => gender,
      "age" => age
    }
  end
  
  def getPatientInfoFromEMRDemographicWindow
    if desired_capabilities['deviceName'].include? 'iPad'
      view = "//UIAWindow/UIAStaticText"
    else
      view = "//UIAWindow/UIATableView[2]/UIATableCell"
    end
    
    weight = Element.new(@selenium, :xpath, view + '[1]').name
    admit_date = Element.new(@selenium, :xpath, view + '[2]').name
    primary_md = Element.new(@selenium, :xpath, view + '[3]').name
    code_status = Element.new(@selenium, :xpath, view + '[4]').name
    location = Element.new(@selenium, :xpath, view + '[5]').name
    admit_dx = Element.new(@selenium, :xpath, view + '[6]').name
    isolation_status = Element.new(@selenium, :xpath, view + '[7]').name
    fin = Element.new(@selenium, :xpath, view + '[8]').name
    dob = Element.new(@selenium, :xpath, view + '[9]').name
    religion = Element.new(@selenium, :xpath, view + '[10]').name
    language = Element.new(@selenium, :xpath, view + '[11]').name
    primary_contact = Element.new(@selenium, :xpath, view + '[12]').name
    secondary_contact = Element.new(@selenium, :xpath, view + '[13]').name
    
    return {
      "weight" => weight,
      "admit_date" => admit_date,
      "primary_md" => primary_md,
      "code_status" => code_status,
      "location" => location,
      "admit_dx" => admit_dx,
      "isolation_status" => isolation_status,
      "fin" => fin,
      "dob" => dob,
      "religion" => religion,
      "language" => language,
      "primary_contact" => primary_contact,
      "secondary_contact" => secondary_contact
    }
  end
  
end