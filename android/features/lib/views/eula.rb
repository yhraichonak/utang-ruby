Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class Eula_window
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end
  
  def title
    Element.new(@selenium, :xpath, '//android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[1]/android.widget.TextView[1]')
  end
  
  def eula_web_view
    Element.new(@selenium, :xpath, '//android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.widget.LinearLayout[1]/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.webkit.WebView[1]')
  end
  
  def accept_button
    Element.new(@selenium, :xpath, '//android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[2]/android.widget.LinearLayout[1]/android.widget.Button[1]')
  end
  
  def EULA_banner
    Element.new(@selenium, :id, "android:id/alertTitle")
  end  
end
