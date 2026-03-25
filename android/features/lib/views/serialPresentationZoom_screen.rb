Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class SerialPresentationZoom_screen
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end
  
  def back_button
	e = @selenium.find_element(:id, "#{APP_PACKAGE}:id/action_bar")
	buttons = e.find_elements(:class, 'android.widget.ImageButton')
	
	for i in 0..(buttons.count - 1)
		if(buttons[i].tag_name == "Navigate up")
			return buttons[i]
		end
	end
  end
  
  def more_options_button
	e = @selenium.find_element(:id, "#{APP_PACKAGE}:id/action_bar")
	buttons = e.find_elements(:class, 'android.widget.ImageView')
	
	for i in 0..(buttons.count - 1)
		if(buttons[i].tag_name == "More options")
			return buttons[i]
		end
	end
  end
  
  def patient_name
	Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_name")
  end
  
  def patient_gender
	Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_gender")
  end
  
  def patient_mrn
	Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_mrn")
  end
  
  def patient_location
	Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_location")
  end
  
  def site
	Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_site")
  end
  
  def top_ecg_label	
	e = @selenium.find_element(:id, "#{APP_PACKAGE}:id/cardio_ecg_gridcell1")
	ecg_label = e.find_elements(:id, "#{APP_PACKAGE}:id/tv_label")
	
	return ecg_label[0]
  end
  
  def top_ecg_legend
	e = @selenium.find_element(:id, "#{APP_PACKAGE}:id/cardio_ecg_gridcell1")
	ecg_legend = e.find_element(:id, "#{APP_PACKAGE}:id/tv_legemd")
	return ecg_legend		
  end
  
  def bottom_ecg_label
	e = @selenium.find_element(:id, "#{APP_PACKAGE}:id/cardio_ecg_gridcell2")
	ecg_label = e.find_element(:id, "#{APP_PACKAGE}:id/tv_label")
	return ecg_label	
  end
  
  def bottom_ecg_legend
	e = @selenium.find_element(:id, "#{APP_PACKAGE}:id/cardio_ecg_gridcell2")
	ecg_legend = e.find_element(:id, "#{APP_PACKAGE}:id/tv_legemd")
	return ecg_legend
  end
  
  def top_ecg_analysis
	e = @selenium.find_element(:id, "#{APP_PACKAGE}:id/cardio_patient_banner1")
	analysis = e.find_element(:id, "#{APP_PACKAGE}:id/tv_cardio_analysis")
	return analysis
  end
  
  def top_ecg_date_info
	e = @selenium.find_element(:id, "#{APP_PACKAGE}:id/cardio_patient_banner1")
	dt = e.find_element(:id, "#{APP_PACKAGE}:id/tv_cardio_datetime")
	return dt
  end
  
  def top_ecg_carrot
	e = @selenium.find_element(:id, "#{APP_PACKAGE}:id/cardio_patient_banner1")
	dt = e.find_element(:id, "#{APP_PACKAGE}:id/tb_cardio_drawer_indicator")
	return dt
  end

  def bottom_ecg_analysis
	e = @selenium.find_element(:id, "#{APP_PACKAGE}:id/cardio_patient_banner2")
	analysis = e.find_element(:id, "#{APP_PACKAGE}:id/tv_cardio_analysis")
	return analysis
  end
  
  def bottom_ecg_date_info
	e = @selenium.find_element(:id, "#{APP_PACKAGE}:id/cardio_patient_banner2")
	dt = e.find_element(:id, "#{APP_PACKAGE}:id/tv_cardio_datetime")
	return dt
  end
  
  def bottom_ecg_carrot
	e = @selenium.find_element(:id, "#{APP_PACKAGE}:id/cardio_patient_banner2")
	dt = e.find_element(:id, "#{APP_PACKAGE}:id/tb_cardio_drawer_indicator")
	return dt
  end
  
  def getPatientInfoFromHeader
    patientName = Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_name").text
    patientSex = Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_gender").text
    patientAge = Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_age").text
    patientSite = Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_site").text
    patientMrn = Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_mrn").text
    return {"name" => patientName, "gender" => patientSex, "age" => patientAge, "site" => patientSite, "mrn" => patientMrn}
  end
  
  def mainThreeSecondLeadGrid_element
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/cardio_ecg_gridcell1")
  end
  
  def compThreeSecondLeadGrid_element
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/cardio_ecg_gridcell2")
  end
  
  def mainThreeSecondLead_element
    Element.new(@selenium, :xpath, "//android.view.View[1]/android.widget.FrameLayout[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[1]/android.widget.FrameLayout[1]/android.widget.TextView[1]") 
  end
  
  def compThreeSecondLead_element
    Element.new(@selenium, :xpath, "//android.view.View[1]/android.widget.FrameLayout[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[2]/android.widget.LinearLayout[1]/android.widget.LinearLayout[1]/android.widget.FrameLayout[1]/android.widget.TextView[1]") 
  end
  
  def getPatientEcgDetails(ecgNumber)    
    ecg_diagnosis = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/tv_cardio_analysis")
    ecg_diagnosis = ecg_diagnosis.at(ecgNumber-1)

    ecg_time = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/tv_cardio_datetime")
    ecg_time = ecg_time.at(ecgNumber-1)

    sex = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/cardio_details_sex")
    sex = sex.at(ecgNumber-1)

    vhr = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/cardio_details_vhr")
    vhr = vhr.at(ecgNumber-1)

    ahr = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/cardio_details_ahr")
    ahr = ahr.at(ecgNumber-1)

    dob = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/cardio_details_dob")
    dob = dob.at(ecgNumber-1)
    
    pr = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/cardio_details_pr")
    pr = pr.at(ecgNumber-1)
    
    qt = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/cardio_details_qt")
    qt = qt.at(ecgNumber-1)
    
    age = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/cardio_details_age")
    age = age.at(ecgNumber-1)
    
    qrs = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/cardio_details_qrs")
    qrs = qrs.at(ecgNumber-1)
    
    qtc = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/cardio_details_qtc")
    qtc = qtc.at(ecgNumber-1)
    
    prt = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/cardio_details_prt")
    prt = prt.at(ecgNumber-1)
    
    return {
      "diagnosis" => ecg_diagnosis.text,
      "time" => ecg_time.text,      
      "sex" => sex.text,
      "vhr" => vhr.text,
      "ahr" => ahr.text,
      "dob" => dob.text,
      "pr" => pr.text,
      "qt" => qt.text,
      "age" => age.text,
      "qrs" => qrs.text,
      "qtc" => qtc.text,
      "prt" => prt.text
    }
  end
  
end