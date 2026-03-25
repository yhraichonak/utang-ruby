Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class Summary_screen
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end
  
  def expanded_tile_back_button
	  nav_bar = @selenium.find_element(:class, 'XCUIElementTypeNavigationBar')
	  buttons = nav_bar.find_elements(:class, 'XCUIElementTypeButton')
	  for i in 0..buttons.count
		  if(buttons[i].text == "Back")
			  return buttons[i]
		  end
	  end
	   #Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Back")
  end
  
  def expanded_tile_close_button
	  nav_bar = @selenium.find_element(:class, "XCUIElementTypeNavigationBar")
	  buttons = nav_bar.find_elements(:class, "XCUIElementTypeButton")
	  return buttons[1]
  end
  
  def expanded_tile_close_solo_button
  	  nav_bar = @selenium.find_element(:class, "XCUIElementTypeNavigationBar")
	  buttons = nav_bar.find_elements(:class, "XCUIElementTypeButton")
	  return buttons[0]
  end
    
  def doc_expanded_tile_close_button
	  nav_bar = @selenium.find_element(:class, "XCUIElementTypeNavigationBar")
	  buttons = nav_bar.find_elements(:class, "XCUIElementTypeButton")
	  return buttons[2]
  end
  
  def vent_expanded_tile_close_button
	  nav_bar = @selenium.find_element(:class, "XCUIElementTypeNavigationBar")
	  buttons = nav_bar.find_elements(:class, "XCUIElementTypeButton")
	  return buttons[4]
  end
  
  def summary_collection_view
	@selenium.find_element(:class, "XCUIElementTypeCollectionView")
  end
  
  def first_cell
	  parent = @selenium.find_element(:class, "XCUIElementTypeCollectionView")
	  cells = parent.find_elements(:class, 'XCUIElementTypeCell')
	  return cells[0]
	  
  end
  
  def summary_header
    Element.new(@selenium, :xpath, '//XCUIElementTypeStaticText[@name="Summary"]')
  end
    
  def close_button
	Appium_lib.predicate(@appium, "XCUIElementTypeButton", "common close")
  end
  
  def x_button
    Element.new(@selenium, :xpath, "//XCUIElementTypeButton[@name='common close']")
  end
  
  def close_button
    #Element.new(@selenium, :xpath, "//XCUIElementTypeButton[@name='common close']")
    Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Back")
  end  
    
  def hamburgerIcon_button
    Element.new(@selenium, :uiautomation, "#{UIAWINDOW}.buttons()['slider 3Bar']")
  end
  
  def ecgTile_button
    #Element.new(@selenium, :xpath, "//XCUIElementTypeStaticText[@name='ECGs']")
    parent =  @selenium.find_elements(:class, 'XCUIElementTypeCollectionView')
    
    txts = parent[0].find_elements(:class, 'XCUIElementTypeStaticText')
    
    text = nil
    found = false
    for i in 0..(txts.count - 1)
      #puts "i = #{i} = #{txts[i].name}"
      if txts[i].name == "ECGs"
        text = txts[i]
        found = true
      end
      if found == true
        break
      end
    end
    return text
  end
  
  def monitorTile_button  
    Appium_lib.predicate_include(@appium, "XCUIElementTypeStaticText", "MONITOR") 
  end
  
  def monitor_tile_training
    Element.new(@selenium, :xpath, '//XCUIElementTypeStaticText[@name="MONITOR (23h)"]')
  end
    
  def demographicsTile_button   
    parent = @selenium.find_element(:class, 'XCUIElementTypeCollectionView')
    txts = parent.find_elements(:class, 'XCUIElementTypeStaticText')
    found = false
    txt = nil
    
    for i in 0..(txts.count - 1)
      if (txts[i].text == "GENERAL INFO")
        txt = txts[i]
        found = true
      end
      
      if found == true
        break
      end
    end
    return txt
    #Element.new(@selenium, :xpath, "//XCUIElementTypeStaticText[@name='GENERAL INFO']")
  end
  
  def generalInfo_tile
	Appium_lib.predicate(@appium, "XCUIElementTypeStaticText", "GENERAL INFO")
  end
  
  def generalInfo_expanded_tile
    Element.new(@selenium, :xpath, '//XCUIElementTypeNavigationBar[@name="APExpandedDemographicsView"]')
  end
      
  def allergies_tile
    Element.new(@selenium, :xpath, '//XCUIElementTypeStaticText[@name="ALLERGIES"]')
  end
  
  def allergies_expanded_tile
    Element.new(@selenium, :xpath, '//XCUIElementTypeNavigationBar[@name="APExpandedAllergiesView"]')
  end
    
  def careTeam_tile
    Element.new(@selenium, :xpath, '//XCUIElementTypeStaticText[@name="CARE TEAM"]')
  end
  
  def careTeam_expanded_tile
    Element.new(@selenium, :xpath, '//XCUIElementTypeNavigationBar[@name="APExpandedCareteamView"]')
  end 
    
  def dxProblems_tile
    Element.new(@selenium, :xpath, '//XCUIElementTypeStaticText[@name="Dx/PROBLEMS"]')
  end
  
  def dxProblems_expanded_tile
    Element.new(@selenium, :xpath, '//XCUIElementTypeNavigationBar[@name="APExpandedDxProblemsView"]')
  end
  
  def ventilator_tile
    Appium_lib.predicate(@appium, "XCUIElementTypeStaticText", "VENTILATOR")
  end
  
  def ventilator_expanded_tile
     #Element.new(@selenium, :xpath, '//XCUIElementTypeNavigationBar[@name="APVentExpandedView"]')
     #Appium_lib.predicate(@appium, "XCUIElementTypeButton", "vent trend")
     buttons = @selenium.find_elements(:class, 'XCUIElementTypeButton')
     
     for i in 0..(buttons.count - 1)
      if buttons[i].name == "vent trend"
         return buttons[i]
      end
     end
     
  end
  
  def vitals_tile
    Appium_lib.predicate(@appium, "XCUIElementTypeStaticText", "VITALS (1d)")
  end
  
  def vitals_expanded_tile
    Appium_lib.predicate(@appium, "XCUIElementTypeStaticText", "Vitals")
  end
    
  def activeMeds_tile
    Appium_lib.predicate(@appium, "XCUIElementTypeStaticText", "ACTIVE MEDS")
  end
  
  def activeMeds_expanded_tile       
    Appium_lib.predicate_include(@appium, "XCUIElementTypeStaticText", "PHARMACY")    
  end
  
  def labs_tile
	Appium_lib.predicate(@appium, "XCUIElementTypeStaticText", "LABS (23h)")
    #Element.new(@selenium, :xpath, '//XCUIElementTypeStaticText[@name="LABS (1d)"]')
  end
  
  def labs_expanded_tile
    obj = @selenium.find_element(:class, 'XCUIElementTypeNavigationBar')
    return obj
  end
    
  def documents_tile
    Element.new(@selenium, :xpath, '//XCUIElementTypeStaticText[@name="DOCUMENTS"]')
  end
  
  def docs_button
	Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Docs")
    #Element.new(@selenium, :xpath, '//XCUIElementTypeStaticText[@name="LABS (1d)"]')
  end
  
  def documents_expanded_tile
    Element.new(@selenium, :xpath, '//XCUIElementTypeNavigationBar[@name="APNotesListView"]')
  end  
  
  def getPatientECGCountFromEcgTile
    if desired_capabilities['deviceName'].include? 'iPad'
      deviceView = 5
    else
      deviceView = 2
    end
    count = @selenium.find_elements(:xpath, "//UIAWindow/UIACollectionView[#{deviceView}]/UIACollectionCell").count
    tileNum = 2
    while tileNum <= count
      view = "//UIAWindow/UIACollectionView[#{deviceView}]/UIACollectionCell[#{tileNum}]"
      if @selenium.find_element(:xpath, view).attribute("name") == "ECGs"
        break
      else
        tileNum += 1
      end
      tileNum += 1
    end
    view = "//UIAWindow/UIACollectionView[#{deviceView}]/UIACollectionCell[#{tileNum}]/UIAStaticText[2]"
    
    #if desired_capabilities['deviceName'].include? 'iPad'
    #  view = "//window/UIACollectionView[5]/UIACollectionCell[2]/text[2]"
    #else
    #  view = "//window/UIACollectionView[2]/UIACollectionCell[2]/text[2]"
    #end
    ecgTile = Element.new(@selenium, :xpath, view)
    return ecgTile.name
  end
  
  def getPatientInfoFromHeader
    if desired_capabilities['deviceName'].include? 'iPad'
      patientName = Element.new(@selenium, :xpath, '//UIAWindow/UIAStaticText[2]').name
      patientGenderAndAge = Element.new(@selenium, :xpath, '//UIAWindow/UIAStaticText[3]').name
      patientSiteAndMRN = Element.new(@selenium, :xpath, '//UIAWindow/UIAStaticText[4]').name
      return [patientName,patientGenderAndAge,patientSiteAndMRN]
    else
      patientName = Element.new(@selenium, :uiautomation, "#{UIAWINDOW}.staticTexts()[1]").name
      patientGenderAndAge = Element.new(@selenium, :uiautomation, "#{UIAWINDOW}.staticTexts()[2]").name
      patientSiteAndMRN = Element.new(@selenium, :uiautomation, "#{UIAWINDOW}.staticTexts()[3]").name
      return [patientName,patientGenderAndAge,patientSiteAndMRN]
    end
  end
  
  def getPatientInfoFromDemographicTile
    if desired_capabilities['deviceName'].include? 'iPad'
      view = "//UIAWindow/UIACollectionView[5]/UIACollectionCell[1]/UIATableView[1]/UIATableCell"
    else
      view = "//UIAWindow/UIACollectionView[2]/UIACollectionCell[1]/UIACollectionView[1]/UIACollectionCell[1]/UIATableView[1]/UIATableCell"
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
  
  def getPatientInfoFromPMDemographicTile
    if desired_capabilities['deviceName'].include? 'iPad'
      view = "//UIAWindow/UIACollectionView[5]/UIACollectionCell[1]/UIATableView[1]/UIATableCell"
    else
      view = "//UIAApplication[1]/UIAWindow[2]/UIACollectionView[1]/UIACollectionCell[1]/UIACollectionView[1]/UIACollectionCell[1]/UIATableView[1]/UIATableCell"
      
    end
    name = Element.new(@selenium, :xpath, view + '[1]' + '/UIAStaticText[2]').name 
    mrn = Element.new(@selenium, :xpath, view + '[2]' + '/UIAStaticText[2]').name
    dob = ""#Element.new(@selenium, :xpath, view + '[3]' + '/UIAStaticText[2]').name
    gender = Element.new(@selenium, :xpath, view + '[4]' + '/UIAStaticText[2]').name
    age = Element.new(@selenium, :xpath, view + '[5]' + '/UIAStaticText[2]').name
    
    return {
      "name" => name,
      "mrn" => mrn,
      "dob" => dob,
      "gender" => gender,
      "age" => age
    }
  end
  
  def getPatientInfoFromEMRDemographicTile
    if desired_capabilities['deviceName'].include? 'iPad'
      view = "//UIAWindow/UIACollectionView[5]/UIACollectionCell[1]/UIAStaticText"
    else
      view = "//UIAWindow/UIACollectionView[2]/UIACollectionCell[1]/UIACollectionView[1]/UIACollectionCell[1]/UIATableView[1]/UIATableCell"
    end
    
    weight = Element.new(@selenium, :xpath, view + '[1]').name
    admit_date = Element.new(@selenium, :xpath, view + '[2]').name
    primary_md = Element.new(@selenium, :xpath, view + '[3]').name
    code_status = Element.new(@selenium, :xpath, view + '[4]').name
    location = Element.new(@selenium, :xpath, view + '[5]').name
    admit_dx = Element.new(@selenium, :xpath, view + '[6]').name
    
    return {
      "weight" => weight,
      "admit_date" => admit_date,
      "primary_md" => primary_md,
      "code_status" => code_status,
      "location" => location,
      "admit_dx" => admit_dx
    }
  end

  def summary_tiles_training(which)
	  collection = @selenium.find_element(:class, 'XCUIElementTypeCollectionView')
	  cells = collection.find_elements(:class, 'XCUIElementTypeCell')
	  	
	       #found = false
	  
        for i in 0..(cells.count - 1)
            txts = cells[i].find_elements(:class, 'XCUIElementTypeStaticText')
          #puts txts[0].name
          if txts[0].name.include? which
            found = true
              return cells[i]
          end
                #for x in 0..(txts.count - 1)
                #  #if x == 0
                #      #puts "txt count = #{txts.count}"
                #  #end
                #    
                #  puts " #{i}.#{x} #{txts[x].name}"
                #    
                #  if(txts[x].name.nil?)
                #    #puts "txt is nil"	  
                #  elsif(txts[x].name.include? which)
                #    #puts "found #{which}"
                #    found = true
                #    return cells[i]
                #  end
                #  
                #  if found
                #    #puts found
                #    puts "breaking out of the for loop"
                #    break
                #  end
                #end
                if found
                  #puts found
                  puts "breaking out of the for loop"
                  break
                end
        end
  end
end