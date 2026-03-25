Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class List_Of_Lists_window
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end
 
  def as_one_button
		@selenium.find_element(:accessibility_id, 'Open')
	end

	def as_one_close_button
		@selenium.find_element(:accessibility_id, 'Close')
	end

	def site_list_refresh_button
		@selenium.find_element(:id, "#{APP_PACKAGE}:id/patient_navigation_site")
	end

  def list_drawer
		@selenium.find_element(:id, "#{APP_PACKAGE}:id/drawer_content")
  end
  
  def cardio_pm_list(name)
    counter = 0
    cardio_counter = 0
    pm_counter = 0
    found = false
    tryCount = 0

		while not found and tryCount < 7
			elements = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/plist_config_title")

			if name == "Cardio Search"
				while cardio_counter < elements.count
					puts elements[cardio_counter].text
					if elements[cardio_counter].text == "MOST RECENT"
						while cardio_counter < elements.count
							puts elements[cardio_counter].text
							if elements[cardio_counter].text == "SEARCH"
								return elements[cardio_counter]
							elsif cardio_counter == elements.count - 1
								cardio_counter = 0
								@selenium.action
												 .move_to_location(100, 1000)  # Start point
												 .click_and_hold
												 .move_to_location(100, 500)   # End point
												 .release
												 .perform
								# Appium::TouchAction.new.swipe(:start_x => 100, :start_y => 1000, :end_x => 100, :end_y => 500, :duration => 1000).perform
								elements = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/plist_config_title")
								break
							else
								cardio_counter += 1
							end
						end
					else
						cardio_counter += 1
					end
				end

			elsif(name == "PM Search")
				while pm_counter < elements.count
					# elements[pm_counter].text
					if(elements[pm_counter].text == "Census" || elements[pm_counter].text == "CENSUS")
						while pm_counter < elements.count
								if(elements[pm_counter].text == "Search" || elements[pm_counter].text == "SEARCH")
									return elements[pm_counter]
								elsif(pm_counter == elements.count - 1)
									pm_counter = 0
									@selenium.action
													 .move_to_location(100, 1000)  # Start point
													 .click_and_hold
													 .move_to_location(100, 500)   # End point
													 .release
													 .perform
									# Appium::TouchAction.new.swipe(:start_x => 100, :start_y => 1000, :end_x => 100, :end_y => 500, :duration => 1000).perform
									elements = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/plist_config_title")
									break
								else
									pm_counter += 1
								end
						end
					else
						pm_counter += 1
					end
				end

			elsif(name == "PM Census")
				while pm_counter < elements.count
					if(elements[pm_counter].text == "Census" || elements[pm_counter].text == "CENSUS")
						return elements[pm_counter]
					elsif(pm_counter == elements.count - 1)
						pm_counter = 0
						@selenium.action
										 .move_to_location(100, 1000)  # Start point
										 .click_and_hold
										 .move_to_location(100, 500)   # End point
										 .release
										 .perform
						# Appium::TouchAction.new.swipe(:start_x => 100, :start_y => 1000, :end_x => 100, :end_y => 500, :duration => 1000).perform
						elements = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/plist_config_title")
						break
					else
						pm_counter += 1
					end
				end

			elsif(name == "OB Census")
				while pm_counter < elements.count
					if(elements[pm_counter].text == "Census" || elements[pm_counter].text == "CENSUS")
						pm_counter =  pm_counter + 1
						while pm_counter < elements.count
							if(elements[pm_counter].text == "Census" || elements[pm_counter].text == "CENSUS")
								return elements[pm_counter]
							elsif(pm_counter == elements.count - 1)
								pm_counter = 0
								@selenium.action
												 .move_to_location(100, 1000)  # Start point
												 .click_and_hold
												 .move_to_location(100, 500)   # End point
												 .release
												 .perform
								# Appium::TouchAction.new.swipe(:start_x => 100, :start_y => 1000, :end_x => 100, :end_y => 500, :duration => 1000).perform
								elements = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/plist_config_title")
								break
							else
								pm_counter += 1
							end
						end
					else
						pm_counter += 1
					end
				end

			elsif(name == "VENTILATOR") || name == ("Ventilator")
				while counter < elements.count
					if(elements[counter].text == "VENTILATOR" || elements[counter].text == "Ventilator")
						return elements[counter]
					elsif(counter == elements.count - 1)
						counter = 0
						@selenium.action
										 .move_to_location(100, 1000)  # Start point
										 .click_and_hold
										 .move_to_location(100, 500)   # End point
										 .release
										 .perform
						# Appium::TouchAction.new.swipe(:start_x => 100, :start_y => 1000, :end_x => 100, :end_y => 500, :duration => 1000).perform
						elements = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/plist_config_title")
						break
					else
						counter += 1
						found = false
					end
				end

			elsif(name == "CENSUS") || name == ("Census")
				while counter < elements.count
					if(elements[counter].text == "CENSUS" || elements[counter].text == "Census")
						return elements[counter]
					elsif(counter == elements.count - 1)
						counter = 0
						@selenium.action
										 .move_to_location(100, 1000)  # Start point
										 .click_and_hold
										 .move_to_location(100, 500)   # End point
										 .release
										 .perform
						# Appium::TouchAction.new.swipe(:start_x => 100, :start_y => 1000, :end_x => 100, :end_y => 500, :duration => 1000).perform
						elements = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/plist_config_title")
						break
					else
						counter += 1
						found = false
					end
				end
				if(elements.count >= counter)
					return "not found in list"
				end

			elsif(name == "FIRST LAST")
				while counter < elements.count
					if(elements[counter].text == name)
						return elements[counter]
					elsif(counter == elements.count - 1)
						counter = 0
						@selenium.action
										 .move_to_location(100, 1000)  # Start point
										 .click_and_hold
										 .move_to_location(100, 500)   # End point
										 .release
										 .perform
						# Appium::TouchAction.new.swipe(:start_x => 100, :start_y => 1000, :end_x => 100, :end_y => 500, :duration => 1000).perform
						elements = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/plist_config_title")
						break
					else
						counter += 1
						found = false
					end
				end

			elsif(name == "Search" || name == "SEARCH")
				while counter < elements.count
					if(elements[counter].text == "Search" ||elements[counter].text == "SEARCH")
						return elements[counter]
					elsif(counter == elements.count - 1)
						counter = 0
						@selenium.action
										 .move_to_location(100, 1000)  # Start point
										 .click_and_hold
										 .move_to_location(100, 500)   # End point
										 .release
										 .perform
						# Appium::TouchAction.new.swipe(:start_x => 100, :start_y => 1000, :end_x => 100, :end_y => 500, :duration => 1000).perform
						elements = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/plist_config_title")
						break
					else
						counter += 1
						found = false
					end
				end
				if(elements.count >= counter)
					return "not found in list"
				end

			else
				while counter < elements.count
					#puts "#{counter} = #{elements[counter].text}"
					if(elements[counter].text == name)
						return elements[counter]
					elsif(counter == elements.count - 1)
						counter = 0
						@selenium.action
										 .move_to_location(100, 1000)  # Start point
										 .click_and_hold
										 .move_to_location(100, 500)   # End point
										 .release
										 .perform
						# Appium::TouchAction.new.swipe(:start_x => 100, :start_y => 1000, :end_x => 100, :end_y => 500, :duration => 1000).perform
						elements = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/plist_config_title")
						break
					else
						counter += 1
						found = false
					end
				end
			end

			if found == false
				#swipe down on screen
				@selenium.action
								 .move_to_location(100, 1000)  # Start point
								 .click_and_hold
								 .move_to_location(100, 500)   # End point
								 .release
								 .perform
				# Appium::TouchAction.new.swipe(:start_x => 100, :start_y => 1000, :end_x => 100, :end_y => 500, :duration => 1000).perform				#Appium::TouchAction.new.swipe(start_x: 700, start_y: 2100, end_x: 700, end_y: 1200, duration: 1000).perform
			end

			sleep(1)
			tryCount += 1
		end # the end of the while not found

	end
  
  def on_call_text
    Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.view.View[1]/android.widget.LinearLayout[1]/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.widget.GridView[1]/android.widget.FrameLayout[13]/android.widget.LinearLayout[1]/android.widget.TextView[2]')
  end
  
  def on_call_cm_text
    Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.view.View[1]/android.widget.LinearLayout[1]/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.widget.GridView[1]/android.widget.FrameLayout[14]/android.widget.LinearLayout[1]/android.widget.TextView[2]')
  end
  
  def site_text
    Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.view.View[1]/android.widget.RelativeLayout[1]/android.widget.TextView[1]')
  end
  
  def list_button(listName)
    Element.new(@selenium, :xpath, 'android.widget.TextView[@text="'+listName+'"]')
  end
  
  def list_item(listName)
    Element.new(@selenium, :uiautomator, 'new UiSelector().className("android.widget.TextView").text("ECGs")')
	end

	def list_element(list_name)
		list_elements = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/plist_config_title")

		list_elements.each_with_index do |list_title,index|
			if list_title.text.downcase == list_name.downcase
				return list_elements[index]
			end
		end
	end

	def is_list_menu_displayed
		begin
			wait_for(1) { @selenium.find_element(:id, "#{APP_PACKAGE}:id/drawer_content") }
			return true
		rescue
			return false
		end
	end
  
  def siteName_text2
		parent = @selenium.find_element(:id, "#{APP_PACKAGE}:id/drawer_content")
		e = parent.find_elements(:class, 'android.widget.TextView')
		for i in 0..e.count
			puts "#{i} = #{e[i].text}"
			if(e[i].text == $CI_SITE)
				puts $CI_SITE
				puts "found it"
				return e[i]
			end
		end
    #Element.new(@selenium, :id, "#{APP_PACKAGE}:id/patient_navigation_site")
  end
  
  def lol_refresh   
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/")
  end
  
  def training_census
		e = @selenium.find_element(:id, "#{APP_PACKAGE}:id/drawer_content")
    elements = e.find_elements(:class, "android.widget.TextView")
    
		for i in 0..elements.count
			if (elements[i].attribute("text") == "MY PATIENTS")
				return elements[i]
      end    
    end
  end

  def siteName_text
	  sleep(2)
	 @selenium.find_element(:id, "#{APP_PACKAGE}:id/patient_navigation_site")
  end
  
  def siteName_text3
		sleep (2)
		found = false
		e = @selenium.find_elements(:class, 'android.widget.TextView')
		puts e.count
		
		for i in 0..(e.count - 1)
			puts "#{i} = #{e[i].text}"

			if(e[i].text == "NOTIFICATIONS")
				counter = i

				while counter < e.count
					if(e[counter].text == $CI_SITE)
						found = true
						return e[counter]
					elsif(counter == elements.count - 1)
						counter = 0
						break
					else
						counter += 1
						found = false
					end
				end

				#while place_holder < (e.count + 1)
				#	if(e[place_holder].text == $CI_SITE)
				#		puts "found the site name #{$CI_SITE}"
				#		return e[place_holder]
				#	end
				#	place_holder =  place_holder + 1
				#end
				#place_holder = i
				#for z in place_holder..e.count
				#	if (e[z].text == $CI_SITE)
				#		puts e[z].text
				#		return e[z]
				#	end
				#end
			end
		end
  end

end
