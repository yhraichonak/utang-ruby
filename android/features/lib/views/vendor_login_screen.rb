Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class VendorLogIn_screen
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end
  
  def title
	Element.new(@selenium, :id, "#{APP_PACKAGE}:id/vendor_status_title")
  end
  
  def message
	Element.new(@selenium, :id , "#{APP_PACKAGE}:id/vendor_status_message")
  end
  
  def username_editText
	Element.new(@selenium, :id, "#{APP_PACKAGE}:id/vendor_login_username")
  end
  
  def password_editText
	Element.new(@selenium, :id, "#{APP_PACKAGE}:id/vendor_login_password")
  end
  
  def login_button
	Element.new(@selenium, :id, "#{APP_PACKAGE}:id/vendor_login_verify")
  end
  
  def cancel_button
	Element.new(@selenium, :id, "#{APP_PACKAGE}:id/cancel")
  end
end



