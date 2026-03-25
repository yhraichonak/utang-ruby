Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class Log_In_screen
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end
  
  def navigation_bar
    @selenium.find_element(:id, "#{APP_PACKAGE}:id/site_name")
  end
  
  def username_field
	  Element.new(@selenium, :id, "#{APP_PACKAGE}:id/login_username")
  end
  
  def password_field
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/login_password")
  end
  
  def login_button
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/action")
  end
   
  def login_window_title
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/title")
  end
  
  def login_window_message    
    e = @selenium.find_element(:id, "#{APP_PACKAGE}:id/login_form")
    elements = e.find_elements(:class, "android.widget.TextView")
    
    for i in 0..(elements.count - 1)
      if (elements[i].text == "Please Enter Your Site Credentials")
        return elements[i]
      end
    end
  end
end
