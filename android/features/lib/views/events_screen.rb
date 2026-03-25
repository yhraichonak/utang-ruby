Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class PM_Events_screen
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end
  
  def live_monitor_button
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/live_button")
  end
  
  def events_count
		grid = @selenium.find_element(:id, "#{APP_PACKAGE}:id/events_list")
		frames = grid.find_elements(:class, 'android.widget.FrameLayout')
		return frames.count
  end
  
  def event_row(which)
		parent = @selenium.find_element(:id, "#{APP_PACKAGE}:id/events_list")
		frames = parent.find_elements(:class, 'android.widget.FrameLayout')
		return frames[which.to_i]
	end

	def events_list
		return Element.new(@selenium, :id, "#{APP_PACKAGE}:id/events_list")
	end

  def return_events_info(which)
		sleep(1)
		which = which + 1

		parent = @selenium.find_element(:id, "#{APP_PACKAGE}:id/events_list")
		frames = parent.find_elements(:class, 'android.widget.FrameLayout')

		frame_layout = ""

		(0..frames.count).each { |i|
			txt = frames[i].find_elements(:class, "android.widget.TextView")

			if txt.count >= 1
				frame_layout = frames[i]
			end
		}

		discrete_p = frame_layout.find_element(:id, "#{APP_PACKAGE}:id/discretes")
		txt_views = discrete_p.find_elements(:class, 'android.widget.TextView')

		return {
				"mesasge" => frames[which].find_element(:id, "#{APP_PACKAGE}:id/message").text,
				"time" => frames[which].find_element(:id, "#{APP_PACKAGE}:id/time").text,
				"hr" => txt_views[0].text,
				"pvc" => txt_views[1].text#,
				#"nbp" => txt_views[2].text,
				#"ar1" => txt_views[3].text
			}
	end

	def navigation_bar
		@selenium.find_element(:id, "#{APP_PACKAGE}:id/patientDetailsNavigation")
	end
end

