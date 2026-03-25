Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class Unit_filter_window
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end
  
  def title
    top_panel = @selenium.find_element(:id, 'android:id/topPanel')
    title = top_panel.find_element(:class, 'android.widget.TextView')
    return title
  end
  
  def toggle_all_button
	@selenium.find_element(:id, "#{APP_PACKAGE}:id/select")
  end
  
  def unit_selection(which)
	list = @selenium.find_element(:id, 'android:id/select_dialog_listview')
	
	check_views = list.find_elements(:class, 'android.widget.CheckedTextView')
	
	for i in 0..check_views.count
		if(check_views[i].text == which)
			return check_views[i]
		end
	end	
  end
  
  def ok_button
	button_panel = @selenium.find_element(:id, 'android:id/buttonPanel')
	buttons = button_panel.find_elements(:class, 'android.widget.Button')
	
	for i in 0..buttons.count
		if(buttons[i].text == "OK")
			return buttons[i]
		end
	end	
  end

  def cancel_button
	button_panel = @selenium.find_element(:id, 'android:id/buttonPanel')
	buttons = button_panel.find_elements(:class, 'android.widget.Button')
	
	for i in 0..buttons.count
		if(buttons[i].text == "CANCEL")
			return buttons[i]
		end
	end	
  end
  
  def unit_selection_object
	list = @selenium.find_element(:id, 'android:id/select_dialog_listview')
	check_views = list.find_elements(:class, 'android.widget.CheckedTextView')
	
	values = Array.new(check_views.count) { Array.new(2) }
	
	for i in 0..(check_views.count - 1)
		values[i] = [check_views[i], check_views[i].attribute('checked')]
	end
	
	return values
  end
end