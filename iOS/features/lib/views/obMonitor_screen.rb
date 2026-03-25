Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class OBMonitor_screen
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end
  
  def five_min_text
	Appium_lib.predicates(@appium, "XCUIElementTypeStaticText", "5 min")
  end
  
  def x_button
   #obj = Appium_lib.predicate(@appium, "XCUIElementTypeButton", "common dismiss")
	  buttons = @selenium.find_elements(:class, 'XCUIElementTypeButton')
    for i in 0..(buttons.count - 1)
     
      if buttons[i].text == "common dismiss"
       
        return buttons[i]
      else
        
      end
    end
  end
  
  def liveMonitor_collectionView
    @appium.tag("XCUIElementTypeCollectionView")
  end
  
  def monitorZoom_staticText
    objects = @appium.tags("XCUIElementTypeStaticText")
    for i in 0..objects.count-1
      #puts objects[i].attribute("value")
      if objects[i].attribute("value").include? "%)"
        return objects[i]
      end
    end
  end
  
  def monitorTime_staticText
    parent = @selenium.find_element(:class, "XCUIElementTypeCollectionView")
    objects = parent.find_elements(:class, "XCUIElementTypeStaticText")
    #objects = @appium.tags("XCUIElementTypeStaticText")
    for i in 0..objects.count-1
      #puts objects[i].attribute("value")
      if objects[i].attribute("value").include? "Now" or objects[i].attribute("value").include? "min ago"
        return objects[i]
      end
    end
  end
  
  def live_button
    Appium_lib.predicate_include(@appium, "XCUIElementTypeButton", "Live")
  end
    
  def section_tile(sectionName)
    objects = Appium_lib.predicates(@appium, "XCUIElementTypeStaticText", "#{sectionName}")
    for i in 0..objects.count-1
      if objects[i].displayed?
        return objects[i]
      end
    end
  end
  
  def sectionClose_button    
    #@appium.last_ele("XCUIElementTypeButton")
    #Appium_lib.predicate(@appium, "XCUIElementTypeButton", "common dismiss")
    buttons = @selenium.find_elements(:class, 'XCUIElementTypeButton')
    for i in 0..(buttons.count - 1)
      #puts buttons[i].name
      if (buttons[i].name ==  "common dismiss")
        #puts "found it"
        return buttons[i]
      end
    end
  end
  
  def liveMonitorCaret_button
    Appium_lib.predicate(@appium, "XCUIElementTypeButton", "caretDN")
  end
  
  def getPatientInfoFromHeader
    #patientInfo = @selenium.find_elements(:xpath, "//XCUIElementTypeNavigationBar/XCUIElementTypeStaticText")
    parent = @selenium.find_element(:class, "XCUIElementTypeNavigationBar")
    patientInfo = parent.find_elements(:class, "XCUIElementTypeStaticText")
    
    #for i in 0..(patientInfo.count - 1)
    #  puts patientInfo[i].name
    #end
    
    name = patientInfo[0].name
    location = patientInfo[1].name
    gender = patientInfo[2].name

    return [name,location,gender]
  end
  
  def getPatientInfoLiveMonitor
    patientInfo = @selenium.find_elements(:xpath, "//XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeStaticText")
    
    membraneStatus = patientInfo[0].attribute("value")
    ega = patientInfo[1].attribute("value")

    return [membraneStatus,ega]  
  end
    
  def cervical_exams_tile
    #tiles = Appium_lib.predicates(@appium, "XCUIElementTypeStaticText", "CERVICAL EXAMS")
    #return tiles[0]
  
    tiles = @selenium.find_elements(:class, "XCUIElementTypeStaticText") 
    for i in 0..(tiles.count - 1)
      puts tiles[i].text
      if(tiles[i].text == "CERVICAL EXAMS")
        return tiles[i]
      end
    end
    
  end
  
  def pitocin_tile
	tiles = Appium_lib.predicates(@appium, "XCUIElementTypeStaticText", "PITOCIN")
	return tiles[0]
  end
  
  def annotations_tile
	tiles = Appium_lib.predicates(@appium, "XCUIElementTypeStaticText", "ANNOTATIONS")
	return tiles[0]
  end
  
  def mv_tile
	t = @selenium.find_elements(:class, 'XCUIElementTypeStaticText')
	for i in 0..t.count
		if(t[i].text.include? "MATERNAL VITALS")
			return t[i]
		end
	end
	   #tiles = Appium_lib.predicates(@appium, "XCUIElementTypeStaticText", "MATERNAL VITALS")
	   #return tiles[0]
  end
  
  def misc_tile
	@selenium.execute_script 'mobile: scroll', :direction => 'down'
	tiles = Appium_lib.predicates(@appium, "XCUIElementTypeStaticText", "Misc")
	return tiles[0]
  end
  
  def pitocin_tile_exp
    patientInfo = @selenium.find_element(:xpath, "//XCUIElementTypeApplication/XCUIElementTypeWindow/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther[3]/XCUIElementTypeOther/XCUIElementTypeStaticText")
  end
  
  def mv_tile_exp
    patientInfo = @selenium.find_element(:xpath, "//XCUIElementTypeApplication/XCUIElementTypeWindow/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther[3]/XCUIElementTypeOther/XCUIElementTypeStaticText")
  end
  
  def misc_tile_exp
    patientInfo = @selenium.find_element(:xpath, "//XCUIElementTypeApplication/XCUIElementTypeWindow/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther[3]/XCUIElementTypeOther/XCUIElementTypeStaticText")
  end
  
  def anno_tile_exp
    patientInfo = @selenium.find_element(:xpath, "//XCUIElementTypeApplication/XCUIElementTypeWindow/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther[3]/XCUIElementTypeOther/XCUIElementTypeStaticText")
  end
    
  def cervX_tile_exp
    patientInfo = @selenium.find_element(:xpath, "//XCUIElementTypeApplication/XCUIElementTypeWindow/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther[3]/XCUIElementTypeOther/XCUIElementTypeStaticText")
  end
  
  def monitor_caret
    patientInfo = @selenium.find_element(:xpath, "//XCUIElementTypeWindow/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeButton[2]")
  end
  
  
  def fetal_strip
	collection_views = @selenium.find_elements(:class, 'XCUIElementTypeCollectionView')
	stat_text = collection_views[0].find_elements(:class, 'XCUIElementTypeStaticText')
	
	return stat_text[3]
    #patientInfo = @selenium.find_element(:xpath, "//XCUIElementTypeApplication/XCUIElementTypeWindow/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeCollectionView/XCUIElementTypeCell/XCUIElementTypeOther/XCUIElementTypeOther[2]/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeStaticText[4]")
  end
  
  
  def ob_census
    patientInfo = @selenium.find_element(:xpath, "//XCUIElementTypeApplication/XCUIElementTypeWindow/XCUIElementTypeOther/XCUIElementTypeNavigationBar/XCUIElementTypeOther")
  end
  
  def caretDN_button
	btn = Appium_lib.predicates(@appium, "XCUIElementTypeButton", "caretDN")
	puts "+++++"
	puts btn[0].attribute("value")
	puts "+++++"
	return btn[0]
    #patientInfo = @selenium.find_element(:xpath, "//XCUIElementTypeApplication/XCUIElementTypeWindow/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeButton[2]")
  end
  
  def ob_search
	Appium_lib.predicates(@appium, "XCUIElementTypeButton", "Search")
	   #return tiles[0]  
    #patientInfo = @selenium.find_element(:xpath, "//XCUIElementTypeApplication/XCUIElementTypeWindow/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeNavigationBar/XCUIElementTypeButton")
  end
  
  def ob_search_landscape
	Appium_lib.predicates(@appium, "XCUIElementTypeButton", "Search")
    #patientInfo = @selenium.find_element(:xpath, "//XCUIElementTypeApplication/XCUIElementTypeWindow/XCUIElementTypeOther[2]/XCUIElementTypeOther[2]/XCUIElementTypeOther/XCUIElementTypeNavigationBar/XCUIElementTypeButton")
  end  
end