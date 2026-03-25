Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class C3PO_screen
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end
  
  def site_id_textfield
	@selenium.find_element(:id, "com.utang.c3p0:id/site_id")
  end
  
  def ad_name_textfield
    @selenium.find_element(:id, "com.utang.c3p0:id/ad_name")
  end
  
  def bed_textfield
    @selenium.find_element(:id, "com.utang.c3p0:id/bed")
  end
  
  def unit_textfield
    @selenium.find_element(:id, "com.utang.c3p0:id/unit")
  end  
  
  def now_button
    @selenium.find_element(:id, "com.utang.c3p0:id/btn_now")
  end

  def fire_encrypted_url_button
     @selenium.find_element(:id, "com.utang.c3p0:id/fire_url_button")
  end
  
  def returnApp_button
    @selenium.find_element(:id, "com.utang.c3p0:id/site_id")
  end
end