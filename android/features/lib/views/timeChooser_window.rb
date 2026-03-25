Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class Time_Chooser
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end
  
  def window_title
	Element.new(@selenium, :id, 'android:id/alertTitle')
  end
  
  def ok_button
	Element.new(@selenium, :id, 'android:id/button1')	  
  end
  
  def cancel_button
	Element.new(@selenium, :id, 'android:id/button2')	  
  end
  
  def picker_object
	custom_panel = @selenium.find_element(:id, 'android:id/customPanel')
	custom = custom_panel.find_element(:id, 'android:id/custom')
	number_pickers = custom.find_elements(:class, 'android.widget.NumberPicker')
	  
	day = number_pickers[0]
	day_buttons = day.find_elements(:class, 'android.widget.Button')
	hour = number_pickers[1]
	hours_buttons = hour.find_elements(:class, 'android.widget.Button')
	minute = number_pickers[2]
	minute_buttons = minute.find_elements(:class, 'android.widget.Button')
	
	day_top = day_buttons[0]
	day_middle = day.find_element(:id, 'android:id/numberpicker_input')
	day_bottom = day_buttons[1]
	
	hour_top = hours_buttons[0]
	hour_middle = hour.find_element(:id, 'android:id/numberpicker_input')
	hour_bottom = hours_buttons[1]
	
	minute_top = minute_buttons[0]
	minute_middle = minute.find_element(:id, 'android:id/numberpicker_input')
	minute_bottom = minute_buttons[1]
	
	return {      
		"day_top" => day_top,
		"day_middle" => day_middle,
		"day_bottom" => day_bottom,
		"hour_top" => hour_top,
		"hour_middle" => hour_middle,
		"hour_bottom" => hour_bottom,
		"minute_top" => minute_top,
		"minute_middle" => minute_middle,
		"minute_bottom" => minute_bottom
		}
  end
  
  def days_number_picker
	number_picker = @selenium.find_elements(:class, 'android.widget.NumberPicker')
	buttons = number_picker[0].find_elements(:class, 'android.widget.Button')
	editTxt = number_picker[0].find_elements(:class, 'android.widget.EditText')
	top = buttons[0]
	middle = editTxt[0]
	bottom = buttons[1]
	
	return {      
		"top" => top,
		"middle" => middle,
		"bottom" => bottom
		}
  end
  
  def hours_number_picker
	number_picker = @selenium.find_elements(:class, 'android.widget.NumberPicker')
	buttons = number_picker[1].find_elements(:class, 'android.widget.Button')
	editTxt = number_picker[1].find_elements(:class, 'android.widget.EditText')
	top = buttons[0]
	middle = editTxt[0]
	bottom = buttons[1]
	
	return {      
		"top" => top,
		"middle" => middle,
		"bottom" => bottom
		}
  end
  
  def minutes_number_picker
	number_picker = @selenium.find_elements(:class, 'android.widget.NumberPicker')
	buttons = number_picker[2].find_elements(:class, 'android.widget.Button')
	editTxt = number_picker[2].find_elements(:class, 'android.widget.EditText')
	top = buttons[0]
	middle = editTxt[0]
	bottom = buttons[1]
	
	return {      
		"top" => top,
		"middle" => middle,
		"bottom" => bottom
		}
  end
end