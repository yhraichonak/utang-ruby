Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class StatementEditor_window
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end
  
  def windowTitleBar
    Element.new(@selenium, :id, 'android:id/alertTitle')
  end
  
  def statementEditor_textView
    e = @selenium.find_element(:class, 'android.widget.MultiAutoCompleteTextView')
    return e
  end
  
  def cancel_button
    Element.new(@selenium, :id, 'android:id/button2')
  end
  
  def ok_button
    Element.new(@selenium, :id, 'android:id/button1')
  end

  def button_panel
    button_panel = @selenium.find_element(:id, 'android:id/buttonPanel')
  end
end

