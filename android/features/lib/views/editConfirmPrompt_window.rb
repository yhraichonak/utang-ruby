Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class EditConfirmPrompt_window
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end

  def alert_title
	elements = @selenium.find_elements(:class, "android.widget.TextView")
    return elements[0]
  end

  def alert_description
	elements = @selenium.find_elements(:class, "android.widget.TextView")
    return elements[1]
  end

  def alert_no
	if(DEVICE_NAME == 'Nexus6')
		Element.new(@selenium, :id, 'android:id/button2')
	else
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/button_cancel")
	end
  end

  def alert_yes
	if(DEVICE_NAME == 'Nexus6')
		Element.new(@selenium, :id, 'android:id/button1')
	else
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/button_continue")
	end
  end

  def are_you_sure_alert_description
    Element.new(@selenium, :id , 'android:id/message')
  end

  def ok_button
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/button_cancel")
  end

  def are_you_sure_ok_button
    Element.new(@selenium, :id, ' android:id/button1')
  end

  def continue_button
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/button_continue")
  end

  def cancel_button
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/button_cancel")
  end

  def are_you_sure_cancel_button
    Element.new(@selenium, :id, 'android:id/button2')
  end

  def saving_statements_ok_button
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/button_continue")
  end

  def edit_confirm_ok_button
    elements = @selenium.find_elements(:class, "android.widget.Button")
    return elements[0]
  end

  def edit_confirm_progress_bar
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/progressSpinner")
  end
end