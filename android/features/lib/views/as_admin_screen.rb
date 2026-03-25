Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class AS_Admin_Screen
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end
  
  def title
	@selenium.find_element(:id, 'android:id/action_bar_title')
  end
  
  def alert_title
	@selenium.find_element(:id, 'android:id/alertTitle')
  end
  
  def checked_text_selection(which)
	checked_txts = @selenium.find_elements(:class, 'android.widget.CheckedTextView')
	  
	for i in 0..(checked_txts.count - 1)
		if(checked_txts[i].text == which)
			return checked_txts[i]
		end
	end
		
  end
  
  def selection(which)
	parent = @selenium.find_element(:id, 'android:id/list')
	txt_views = parent.find_elements(:class, 'android.widget.TextView')
	
	for i in 0..txt_views.count
		if(txt_views[i].text == which)
			return txt_views[i]
		end
	end 
  end
end