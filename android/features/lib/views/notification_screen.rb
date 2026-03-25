Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class Notification_screen
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end
  
  def content_container
	Element.new(@selenium, :id, "#{APP_PACKAGE}:id/content_container")
  end
  
  def oncall_toggle
	Element.new(@selenium, :id, "#{APP_PACKAGE}:id/on_call")  #On Call ON or On Call OFF  checked true or false could be checked
  end
  
  def no_patients_text
	 Element.new(@selenium, :id, 'android:id/empty') 
  end
  
  def notifications_banner
	 Element.new(@selenium, :id, 'android:id/tv_title') 
  end
end