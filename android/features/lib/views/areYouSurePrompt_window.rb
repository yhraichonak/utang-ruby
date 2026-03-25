Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class AreYouSurePrompt_window
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end
  
  def alert_title
	  Element.new(@selenium, :id, 'android:id/alertTitle')
	   #if(DEVICE_NAME == 'Nexus6')
	   #	Element.new(@selenium, :id, 'android:id/alertTitle')
	   #else
	   #	Element.new(@selenium, :id, 'android:id/alertTitle')
	   #end    
  end
  
  def alert_description
	  Element.new(@selenium, :id, 'android:id/message')
	   #if(DEVICE_NAME == 'Nexus6')
	   #	Element.new(@selenium, :id, 'android:id/message')
	   #else
	   #	Element.new(@selenium, :id, 'android:id/message')
	   #end       
  end
  
  def alert_no
	  Element.new(@selenium, :id, 'android:id/button2')
	   #if(DEVICE_NAME == 'Nexus6')
	   #	Element.new(@selenium, :id, 'android:id/button2')
	   #else
	   #	Element.new(@selenium, :id, 'android:id/button2')
	   #end         
  end
  
  def alert_yes
	  Element.new(@selenium, :id, 'android:id/button1')
	   #if(DEVICE_NAME == 'Nexus6')
	   #	Element.new(@selenium, :id, 'android:id/button1')
	   #else
	   #	Element.new(@selenium, :id, 'android:id/button1')
	   #end         
  end
  
end