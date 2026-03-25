Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class Welcome_screen
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end
  
  def navigation_bar
	e = @selenium.find_element(:id, "#{APP_PACKAGE}:id/action_bar")
	elements = e.find_elements(:class, "android.widget.TextView")
	return elements[0]
  end
  
  def as_welcome_logo
	Element.new(@selenium, :id, "#{APP_PACKAGE}:id/welcome_logo")
  end
  
  def as_welcome_text
	Element.new(@selenium, :id, "#{APP_PACKAGE}:id/welcome_text")
  end
  
  def reset_password_button
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/welcome_btn_reset_password")
  end
  
  def sign_in_button
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/welcome_btn_signin")
  end
  
  def sign_on_title
	Element.new(@selenium, :id, "#{APP_PACKAGE}:id/title")
  end
 
  def email_textfield
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/signin_email")
  end
  
  def email_password_textfield
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/signin_password")
  end
  
  def signon_dialog_button
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/sign_button")
  end
  
  def dialog_text
    Element.new(@selenium, :xpath, '//android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[1]/android.widget.TextView[1]')
  end
  
  def ce_marks
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/about_cemark")
  end
  
  def ce_numbers
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/about_cemark_number")
  end
  
  def sign_out
		  Element.new(@selenium, :id, 'android:id/button2')
  end
  
  def yes_button
		  Element.new(@selenium, :id, 'android:id/button1')
  end
end