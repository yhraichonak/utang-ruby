Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class Group_sort_window

  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end
  
  def title
		@selenium.find_element(:id, 'android:id/alertTitle')
  end

  def group_by_spinner
		@selenium.find_element(:id, "#{APP_PACKAGE}:id/group_spinner")
  end
  
  def group_by_dropdown(choice)
		tryCount = 0
    row = 1
    found = false
    element = nil
	
		while not found and tryCount < 7
			for counter in 1..12 do
				row = counter
				list =  @selenium.find_element(:class, 'android.widget.ListView')
				txt = list.find_elements(:class, 'android.widget.TextView')
				for i in 0..(txt.count - 1)
					if(txt[i].text == choice)
						element = txt[i]
						found = true
						return element
					end
				end
			end

			if found == false
				e1 = txt[1]
				e1_x = e1.location[:x]
				e1_y = e1.location[:y]

				e2 = txt[3]
				e2_x = e2.location[:x]
				e2_y = e2.location[:y]

				Appium::TouchAction.new.swipe(start_x: e2_x, start_y: e2_y, end_x: e1_x, end_y: e1_y, duration: 300).perform
			end

			sleep(1)
			tryCount += 1
		end
  end

  def group_by_invert
		@selenium.find_element(:id, "#{APP_PACKAGE}:id/group_invert")
  end
  
  def sort_by_first_spinner
		@selenium.find_element(:id, "#{APP_PACKAGE}:id/sort1_spinner")
  end
  
  def sort_by_first_invert
		@selenium.find_element(:id, "#{APP_PACKAGE}:id/sort1_invert")
  end
  
  def group_by_second_spinner
		@selenium.find_element(:id, "#{APP_PACKAGE}:id/sort2_spinner")
  end
  
  def group_by_second_invert
		@selenium.find_element(:id, "#{APP_PACKAGE}:id/sort2_invert")
  end
  
  def reset_button
		button_panel = @selenium.find_element(:id, 'android:id/buttonPanel')
    buttons = button_panel.find_elements(:class, 'android.widget.Button')
    
		for i in 0..buttons.count
			if(buttons[i].text == "RESET")
				return buttons[i]
			elsif(buttons[i].text == "Reset")
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
			elsif(buttons[i].text == "Cancel")
				return buttons[i]
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
end