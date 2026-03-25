Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class C3PO_screen
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end

  def site_url_textfield
    txts = @selenium.find_elements(:class, "XCUIElementTypeTextField")
    return txts[0] 
  end

  def partner_textfield
    txts = @selenium.find_elements(:class, "XCUIElementTypeTextField")
    return txts[1] 
  end
  
  def target_textfield    
    txts = @selenium.find_elements(:class, "XCUIElementTypeTextField")
    return txts[2] 
  end

  def site_id_textfield
    txts = @selenium.find_elements(:class, "XCUIElementTypeTextField")
    return txts[3] 
  end

  def ad_name_textfield
    txts = @selenium.find_elements(:class, "XCUIElementTypeTextField")
    return txts[4] 
  end

  def query_textfield
    txts = @selenium.find_elements(:class, "XCUIElementTypeTextField")
    return txts[5] 
  end

  def shared_key_textfield(type)
    txts = @selenium.find_elements(:class, "XCUIElementTypeTextField")
    case type
    when "QA"
      return txts[6]
    when "ASCOM"
      return txts[8]
    when "ASCOM(Events)"
      return txts[7]
    when "ECG(mrn)"
      return txts[7]
    when "ECG(ecgID)"
      return txts[7]
    when "PK"
      return txts[6]
    when "ENGAGE"
      return txts[8]
    when "ENGAGE(Events)"
      return txts[7]
    end
  end

  def unit_textfield(type)   
    txts = @selenium.find_elements(:class, "XCUIElementTypeTextField")    
    case type
    when "ASCOM"      
      return txts[5] 
    when "ASCOM(Events)"
      return txts[5] 
    when "ENGAGE"
      return txts[5]   
    when "ENGAGE(Events)"
      return txts[5] 
    end
  end

  def bed_textfield(type)
    txts = @selenium.find_elements(:class, "XCUIElementTypeTextField")
    case type
    when "ASCOM"
      return txts[6] 
    when "ASCOM(Events)"
      return txts[6]
    when "ENGAGE"
      return txts[6]
    when "ENGAGE(Events)"
      return txts[6]
    end
  end

  def time_textfield(type)
    txts = @selenium.find_elements(:class, "XCUIElementTypeTextField")
    case type
    when "ASCOM"
      return txts[7]
    when "ECG(mrn)"
      return txts[6]
    when "ENGAGE"
      return txts[7]
    end
  end

  def mrn_textfield(type)
    txts = @selenium.find_elements(:class, "XCUIElementTypeTextField")
    case type
    when "ECG(mrn)"
      return txts[5]
    when "PK"
      return txts[5]
    end
  end
 
  def asmpid_textfield(type)
    txts = @selenium.find_elements(:class, "XCUIElementTypeTextField")
    case type
    when "ECG(ecgID)"
      return txts[5]
    end
  end  

  def ecgid_textfield(type)
    txts = @selenium.find_elements(:class, "XCUIElementTypeTextField")
    case type
    when "ECG(ecgID)"
      return txts[6]
    end
  end

  def facilityid_textfield(type)
    txts = @selenium.find_elements(:class, "XCUIElementTypeTextField")
    case type
    when "PK"
      return txts[3]
    end
  end

  def share_link_mobile_link
    stat_txts = @selenium.find_elements(:class, 'XCUIElementTypeStaticText')
    stat_txt = nil
    found = false
    for i in 0..(stat_txts.count - 1)
      if stat_txts[i].text.include? "Share Link - Mobile"
        stat_txt = stat_txts[i + 4]
        found = true
        break        
      end
      if found == true
        break
      end
    end
    return stat_txt
  end

  def share_link_web_link
    stat_txts = @selenium.find_elements(:class, 'XCUIElementTypeStaticText')
    stat_txt = nil
    found = false
    for i in 0..(stat_txts.count - 1)
      if stat_txts[i].text.include? "Share Link - Web"
        stat_txt = stat_txts[i + 4]
        found = true
        break        
      end
      if found == true
        break
      end
    end
    return stat_txt
  end

  def encrypted_mobile_link
    stat_txts = @selenium.find_elements(:class, 'XCUIElementTypeStaticText')
    stat_txt = nil
    found = false
    for i in 0..(stat_txts.count - 1)
      if stat_txts[i].text.include? "Encrypted - Mobile"
        stat_txt = stat_txts[i + 4]
        found = true
        break        
      end
      if found == true
        break
      end
    end
    return stat_txt
  end

  def encrypted_web_link
    stat_txts = @selenium.find_elements(:class, 'XCUIElementTypeStaticText')
    stat_txt = nil
    found = false
    for i in 0..(stat_txts.count - 1)
      if stat_txts[i].text.include? "Encrypted - Web"
        stat_txt = stat_txts[i + 4]
        found = true
        break        
      end
      if found == true
        break
      end
    end
    return stat_txt
  end

  def all_objects
    navs = @selenium.find_elements(:class, 'XCUIElementTypeStaticText')
    for i in 0..(navs.count - 1)
      puts "--i = #{i} = #{navs[i].text}--"
    end
  end

  def nav_link(which)
    navs = @selenium.find_elements(:class, 'XCUIElementTypeStaticText')
    nav = nil
    found = false

    for i in 0..(navs.count - 1)
      if navs[i].text == which
        puts "found the correct value = #{navs[i].text}"
        nav = navs[i]
        found = true
        break
      end
      if found == true
        break
      end
    end

    return nav
  end

  def open_button
    buttons = @selenium.find_elements(:class, 'XCUIElementTypeButton')
    button = nil
    found = false
    for i in 0..(buttons.count - 1)
      if buttons[i].text == "Open"
        found = true
        button = buttons[i]
        break
      end
      if found == true
        break
      end
    end
    return button
  end
end