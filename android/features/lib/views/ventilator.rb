Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class Ventilator_screen
	def initialize(selenium, appium)
		@selenium = selenium
		@appium = appium
	end
	
	def settings_grid
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/grid_view")
	end
	
	def trend_graph
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/trend_graph")
	end
	
	def discrete_row
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/horizontal_discretes")
	end
	
	def discretes_toggle
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/menu_vent_trends")
	end
	
	def grid_toggle
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/menu_vent_settings")
	end
	
	def vent_options
	e = @selenium.find_element(:id, "#{APP_PACKAGE}:id/action_bar")
    elements = e.find_elements(:class, "android.widget.ImageView")
    
	for i in 0..(elements.count)
		if (elements[i].tag_name == "More options")
			return elements[i]    
		end    
	end
	end

	def vent_events
    elements = @selenium.find_elements(:class,  "android.widget.TextView")
    for i in 0..elements.count
      if (elements[i].text == "Events")
          return elements[i]    
      end    
    end  
    end
	
	def vent_share
    elements = @selenium.find_elements(:class,  "android.widget.TextView")
    for i in 0..elements.count
      if (elements[i].tag_name == "Share")
          return elements[i]    
      end    
    end  
    end
	
	def vent_about
    elements = @selenium.find_elements(:class,  "android.widget.TextView")
    for i in 0..elements.count
      if (elements[i].tag_name == "About")
          return elements[i]    
      end    
    end  
    end
		
				def vent_settings
    elements = @selenium.find_elements(:class,  "android.widget.TextView")
    for i in 0..elements.count
      if (elements[i].tag_name == "Settings")
          return elements[i]    
      end    
    end  
	end
						def vent_logout
    elements = @selenium.find_elements(:class,  "android.widget.TextView")
    for i in 0..elements.count
      if (elements[i].tag_name == "Logout")
          return elements[i]    
      end    
    end  
    end
	
	def vent_refresh
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/menu_reload")
	end
	
	def select_discrete
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/vent_trend_select_discrete_instructions")
	end
	
	def alarm_date_list
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/date_list")
	end
	
	def alarm_time
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/time_list")
	end
	
	def alarm_type
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/type_list")
	end
	
	def alarm_status
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/status_list")
	end
	
	def about_title
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/about_logo")
	end
	
	def vent_icon
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/summary_header_icon")
	end
	
	def share_patientdetail
		Element.new(@selenium, :id, 'android:id/alertTitle')
	end
	
	def select_recip
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/select_recipient")
	end
		
	def share_msg
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/send_text")
	end
			
	def view_convo
		Element.new(@selenium, :id, 'android:id/button2')
	end
	
	def recip
		Element.new(@selenium, :id, 'android:id/text1')
	end
	
	def msg_success
		Element.new(@selenium, :id, 'android:id/message')
	end
	
	def vent_link
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/share_link_label")
	end
	
	def msg_item
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/conversation_item_content")
	end
	
	def vent_pName
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_name")
	end
	
	def vent_pGender
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_gender")
	end
	
	def vent_pAge
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_age")
	end
	
	def vent_pMRN
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_mrn")
	end
	
	def vent_pLocation
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_location")
	end
	
	def vent_pSite
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_site")
	end
	
	def vent_refresh
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/menu_reload")
	end
	
	def app_v
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/version")
	end
	
	def build_v
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/build")
	end
	
	def device_mod
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/device_model")
	end
	
	def device_OS
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/system_version")
	end
	
	def tablet_alarm
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/menu_vent_events")
	end
	
end