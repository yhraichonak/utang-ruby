Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class ZoomLead_screen
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end
  
  def back_button    
    e = @selenium.find_element(:id, "#{APP_PACKAGE}:id/action_bar")
    elements = e.find_elements(:class, "android.widget.ImageButton")
    
	for i in 0..(elements.count)
		if (elements[i].tag_name == "Navigate up")
			return elements[i]    
		end    
	end  
  end
  
  def ecg_scrubber_object
	e = @selenium.find_element(:id, "#{APP_PACKAGE}:id/cardio_ecg_stackcell")
	return e
  end
  
  def threeSecondLeadGrid_element
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/cardio_ecg_grid")
  end
  
  def tenSecondLeadGrid_element
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/cardio_ecg_stackcell")
  end
  
  def threeSecondLead_element
	parent = @selenium.find_element(:id, "#{APP_PACKAGE}:id/cardio_ecg_gridcell")
	child = parent.find_element(:id, "#{APP_PACKAGE}:id/tv_label")
	return child	
  end
  
  def tenSecondLead_element
	parent = @selenium.find_element(:id, "#{APP_PACKAGE}:id/cardio_ecg_stackcell")
	child = parent.find_element(:id, "#{APP_PACKAGE}:id/tv_label")
	return child	
  end
  
  def getPatientInfoFromHeader
    patientName = Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_name").text
    patientSex = Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_gender").text
    patientAge = Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_age").text
    patientSite = Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_site").text
    patientMrn = Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_mrn").text
    return {"name" => patientName, "gender" => patientSex, "age" => patientAge, "site" => patientSite, "mrn" => patientMrn}
  end
  
  def chevron
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tb_cardio_drawer_indicator")
  end
  
  def ecg_details_chevron
    ecg_diagnosis = Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_cardio_analysis")
    ecg_time = Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_cardio_datetime")
        
    sex = Element.new(@selenium, :id, "#{APP_PACKAGE}:id/cardio_details_sex")
        
    vhr = Element.new(@selenium, :id, "#{APP_PACKAGE}:id/cardio_details_vhr")
                                             
    ahr = Element.new(@selenium, :id, "#{APP_PACKAGE}:id/cardio_details_ahr")
        
    dob = Element.new(@selenium, :id, "#{APP_PACKAGE}:id/cardio_details_dob")
    
    pr = Element.new(@selenium, :id, "#{APP_PACKAGE}:id/cardio_details_pr")
    
    qt = Element.new(@selenium, :id, "#{APP_PACKAGE}:id/cardio_details_qt")
    
    age = Element.new(@selenium, :id, "#{APP_PACKAGE}:id/cardio_details_age")
    
    qrs = Element.new(@selenium, :id, "#{APP_PACKAGE}:id/cardio_details_qrs")
    
    qtc = Element.new(@selenium, :id, "#{APP_PACKAGE}:id/cardio_details_qtc")
    
    prt = Element.new(@selenium, :id, "#{APP_PACKAGE}:id/cardio_details_prt")
    
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
  