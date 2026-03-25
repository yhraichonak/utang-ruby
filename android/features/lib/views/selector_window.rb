Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class Selector_window
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end
  
  def selector_title
    Element.new(@selenium, :id, 'android:id/alertTitle')
    #Element.new(@selenium, :xpath, '//android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[1]/android.widget.TextView[1]')
  end
  
  def as_one_button
    Element.new(@selenium, :id, 'android:id/text1')
    #Element.new(@selenium, :xpath, '//android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.widget.LinearLayout[1]/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.widget.LinearLayout[1]/android.widget.FrameLayout[1]/android.widget.GridView[1]/android.widget.LinearLayout[1]/android.widget.TextView[1]')
  end
  
  def just_once_button
    Element.new(@selenium, :id, 'android:id/button_once')
    #Element.new(@selenium, :xpath, '//android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.widget.LinearLayout[1]/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[1]/android.widget.Button[2]')
  end

end