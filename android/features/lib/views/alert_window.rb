Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class Alert_window
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
    include Constants
  end

  # Android system alert windows
  def alert_title
    Element.new(@selenium, :id, 'android:id/alertTitle')
  end
  
  def alert_description
    Element.new(@selenium, :id, 'android:id/message')
  end

  def alert_message
    return @selenium.find_element(:id, 'android:id/message')
  end

  def alert_accept
    return @selenium.find_element(:id, 'android:id/button1')
  end

  def yes_button
    Element.new(@selenium, :id, 'android:id/button1')
  end

  def no_button
    Element.new(@selenium, :id, 'android:id/button2')
  end

  # Alternate button setups
  def cancel_button
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/cancel")
  end

  def continue_button
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/continue")
  end

  # Custom alert windows
  def custom_alert_title
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/title")
  end

  def custom_alert_description
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_message")
  end

  def custom_cancel_button
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/button_cancel")
  end

  def custom_continue_button
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/button_continue")
  end

  def handle_alert(expected_title, action, wait=2)
    # ECG & custom alert window handler. Needs more dev work.
    alert_title_text = Selenium::WebDriver::Wait.new(timeout: wait).until {
      custom_alert_title.exists.should be true
      custom_alert_title.text
    }

    if alert_title_text == expected_title # Take action; if expected alert is present
      if ALERT_CONDITIONS.include? action # Handle alert with action parameter
        if action == ALERT_CONTINUE
          custom_continue_button.click
        elsif action == ALERT_CANCEL
          custom_cancel_button.click
        end
      end
    end
  end

end