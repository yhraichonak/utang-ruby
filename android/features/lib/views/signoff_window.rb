Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class Signoff_window
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end
  
  def title
    #Element.new(@selenium, :xpath, '//android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[1]/android.widget.TextView[1]')
    Element.new(@selenium, :id, 'android:id/alertTitle')
  end
  
  def dialog_text
    Element.new(@selenium, :xpath, '//android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.widget.LinearLayout[1]/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.widget.TextView[1]')
  end
  
  def no_button
    Element.new(@selenium, :id, 'android:id/button2')
  end
  
  def yes_button
    Element.new(@selenium, :id, 'android:id/button1')
  end
end