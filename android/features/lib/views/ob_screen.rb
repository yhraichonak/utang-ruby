Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class Ob_Summary_screen

	def initialize(selenium, appium)
		@selenium = selenium
		@appium = appium
	end
	
	def ob_refresh
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/menu_reload")
	end
		
	def ob_live
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/menu_ob_live")
	end
		
	def ob_about
		elements = @selenium.find_elements(:class,  "android.widget.TextView")
		for i in 0..elements.count
			if (elements[i].tag_name == "About")
				return elements[i]    
			end    
		end  
	end
		
	def ob_toggle
		elements = @selenium.find_elements(:class,  "android.widget.TextView")
		for i in 0..elements.count
			if (elements[i].text == "Toggle Color")
				return elements[i]    
			end    
		end  
	end
		
	def app_v
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/version")
	end
		
	def build_v
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/build")
	end
		
	def device_mdl
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/device_model")
	end
		
	def device_OSys
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/system_version")
	end
		
	def Ob_Summary_pName
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_name")
	end
		
	def Ob_Summary_pGender
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_gender")
	end
		
	def Ob_Summary_pAge
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_age")
	end
		
	def Ob_Summary_pMRN
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_mrn")
	end
		
	def Ob_Summary_pLocation
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_location")
	end
		
	def Ob_Summary_pSite
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_site")
	end
	
	def Ob_Summary_tvdate
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_date")
	end
	
	def Ob_Summary_tvname_sub
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_name_sub")
	end
		
	def app_ver
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/version")
	end
	
	def annotation
	elements = @selenium.find_elements(:id,  "#{APP_PACKAGE}:id/tv_value")
		for i in 0..elements.count
			if (elements[i].attribute("text") == "Mon Mode A: External, Baseline A: No Baseline Changes, LTV A: Average 6-25 bpm, Accels A: Absent, Decels A: None, Baseline Range 'A': 145 LEAL, VANESSA RN")
          return elements[i]    
			end    
		end  
	end
	
	def later_annotation
	elements = @selenium.find_elements(:id,  "#{APP_PACKAGE}:id/tv_value")
		for i in 0..elements.count
			if (elements[i].attribute("text") == "BP 112/73 M 87 P 102")
          return elements[i]    
			end    
		end  
	end
	
	def annotation_pointer
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/pointer")
	end
	
	def annotation_body
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/ob_annotation_body")
	end
		
	def build_ver
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/build")
	end
		
	def device_mdl
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/device_model")
	end
	
	def device_OSys
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/system_version")
	end
		
	def ob_fetal_strip
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/ob_strip_view")
	end
		
	def ob_fetal_strip
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/ob_strip_view")
	end
										  
	def ob_caret
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/ob_strip_hider")
	end
		
	def ob_Vrange
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_range")
	end
		
	def ob_Vvalue
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_value")
	end
				
	def tablet_color_toggle
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/menu_ob_color")
	end
	  
	def ob_search
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_title")
	end
	
	def ob_census_search
		elements = @selenium.find_elements(:class, "android.widget.EditText")
           
		for i in 0..elements.count
		  if (elements[i].attribute("text") == "Search")
			  return elements[i]    
		  end    
		end
	end
	  
	def ob_search_landscape
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/psearch_search_button")
	end
		
	def obcen_sitename
		Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_site")
	end
	
	def strip_from_time
		@selenium.find_element(:id, "#{APP_PACKAGE}:id/ob_strip_from_time")
	end
	
	def strip_zoom_level
		@selenium.find_element(:id, "#{APP_PACKAGE}:id/ob_strip_zoom_level")
	end
	
	def strip_to_time
		@selenium.find_element(:id, "#{APP_PACKAGE}:id/ob_strip_to_time")
	end
	
	def from_time_ago
		@selenium.find_element(:id, "#{APP_PACKAGE}:id/ob_strip_from_time_ago")
	end
	
	def to_time_ago
		@selenium.find_element(:id, "#{APP_PACKAGE}:id/ob_strip_to_time_ago")
	end
	
	def maternal_vitals_tile_object
		summary_grid = @selenium.find_element(:id, "#{APP_PACKAGE}:id/summary_grid")
		summary_tile_roots = summary_grid.find_elements(:id, "#{APP_PACKAGE}:id/summary_tile_root")
		
		for i in 0..summary_tile_roots.count
			summary_header = summary_tile_roots[i].find_element(:id, "#{APP_PACKAGE}:id/summary_header")
			summary_header_title = summary_header.find_element(:id, "#{APP_PACKAGE}:id/summary_header_title")
			if(summary_header_title.text.should include "MATERNAL")
				summary_table = summary_tile_roots[i].find_element(:id, "#{APP_PACKAGE}:id/summary_table")
				summary_table_rows = summary_table.find_elements(:class, 'android.widget.TableRow')
				r1_label = summary_table_rows[0].find_element(:id, "#{APP_PACKAGE}:id/tv_label")
				r1_range = summary_table_rows[0].find_element(:id, "#{APP_PACKAGE}:id/tv_range")
				r1_value = summary_table_rows[0].find_element(:id, "#{APP_PACKAGE}:id/tv_value")
				
				r2_label = summary_table_rows[1].find_element(:id, "#{APP_PACKAGE}:id/tv_label")
				r2_range = summary_table_rows[1].find_element(:id, "#{APP_PACKAGE}:id/tv_range")
				r2_value = summary_table_rows[1].find_element(:id, "#{APP_PACKAGE}:id/tv_value")
				
				r3_label = summary_table_rows[2].find_element(:id, "#{APP_PACKAGE}:id/tv_label")
				r3_range = summary_table_rows[2].find_element(:id, "#{APP_PACKAGE}:id/tv_range")
				r3_value = summary_table_rows[2].find_element(:id, "#{APP_PACKAGE}:id/tv_value")
			
				r4_label = summary_table_rows[3].find_element(:id, "#{APP_PACKAGE}:id/tv_label")
				r4_range = summary_table_rows[3].find_element(:id, "#{APP_PACKAGE}:id/tv_range")
				r4_value = summary_table_rows[3].find_element(:id, "#{APP_PACKAGE}:id/tv_value")
			end
		end
		
		return {
		  "r1_label" => r1_label.text,
		  "r1_range" => r1_range.text,		  
		  "r1_value" => r1_value.text,
		  "r2_label" => r2_label.text,
		  "r2_range" => r2_range.text,		  
		  "r2_value" => r2_value.text,
		  "r3_label" => r3_label.text,
		  "r3_range" => r3_range.text,		  
		  "r3_value" => r3_value.text,
		  "r4_label" => r4_label.text,
		  "r4_range" => r4_range.text,		  
		  "r4_value" => r4_value.text,
		  "tile_title" => summary_header_title.text		  
		}
	end
	
	def cervical_exam_tile_object
		summary_grid = @selenium.find_element(:id, "#{APP_PACKAGE}:id/summary_grid")
		summary_tile_roots = summary_grid.find_elements(:id, "#{APP_PACKAGE}:id/summary_tile_root")
		data_check = ""
		label = ""
		value = ""
		summary_header_title = ""
		
		for i in (0..summary_tile_roots.count - 1)
			summary_header = summary_tile_roots[i].find_element(:id, "#{APP_PACKAGE}:id/summary_header")
			summary_header_title = summary_header.find_element(:id, "#{APP_PACKAGE}:id/summary_header_title").text
			
			begin
				err_message = summary_tile_roots[i].find_element(:id, "#{APP_PACKAGE}:id/error_message")
				if(err_message)
					data_check = "data not found"
				end
			rescue
				data_check = "data found"  
			end
			
			if(data_check == "data found")
				if(summary_header_title == "CERVICAL EXAMS")
					summary_table = summary_tile_roots[i].find_element(:id, "#{APP_PACKAGE}:id/summary_table")
					summary_table_rows = summary_table.find_elements(:class, 'android.widget.TableRow')
					label = summary_table_rows[0].find_element(:id, "#{APP_PACKAGE}:id/tv_label").text
					value = summary_table_rows[0].find_element(:id, "#{APP_PACKAGE}:id/tv_value").text
					break
				end
			elsif(data_check == "data not found")
				if(summary_header_title == "CERVICAL EXAMS")
					break
				end
			end			
		end
		
		return {
		  "label" => label,
		  "value" => value,
		  "data_check" => data_check,
		  "tile_title" => summary_header_title	  
		}
	end
	
	def cervical_expanded_tile_obj
		ob_details_frag = @selenium.find_element(:id, "#{APP_PACKAGE}:id/ob_details_fragment")
		summary_root = ob_details_frag.find_element(:id, "#{APP_PACKAGE}:id/summary_root")
		parent = summary_root.find_element(:id, "#{APP_PACKAGE}:id/expanded_tile_main_container")
		sum_tile_header = parent.find_element(:id, "#{APP_PACKAGE}:id/summary_header_title").text
		
		begin
			if(parent.find_element(:id, "#{APP_PACKAGE}:id/error_message"))
				data_check = "data not found"
			end
		rescue
			data_check = "data found"  
		end
		
		if(data_check == "data found")
			expanded_tile_content = parent.find_element(:id, "#{APP_PACKAGE}:id/expanded_tile_content_scroll")
			summary_table = expanded_tile_content.find_element(:id, "#{APP_PACKAGE}:id/summary_table")
			table_rows = summary_table.find_elements(:class, 'android.widget.TableRow')
			label = table_rows[0].find_element(:id, "#{APP_PACKAGE}:id/tv_label").text
			value = table_rows[0].find_element(:id, "#{APP_PACKAGE}:id/tv_value").text
		end
		return {
		  "label" => label,
		  "value" => value,
		  "data_check" => data_check,
		  "tile_title" => sum_tile_header	  
		}
	end
	
	def annotations_tile_object
		summary_grid = @selenium.find_element(:id, "#{APP_PACKAGE}:id/summary_grid")
		summary_tile_roots = summary_grid.find_elements(:id, "#{APP_PACKAGE}:id/summary_tile_root")
		
		data_check = ""
		error_message = ""
		recent_label = ""
		value_one = ""
		value_two = ""
		value_three = ""
		
		for i in 0..summary_tile_roots.count
			parent = summary_tile_roots[i]
			summary_header = parent.find_element(:id, "#{APP_PACKAGE}:id/summary_header")
			summary_header_title = summary_header.find_element(:id, "#{APP_PACKAGE}:id/summary_header_title").text
			if(summary_header_title.text == "ANNOTATIONS")
				
				begin
					error_message = parent.find_element(:id, "#{APP_PACKAGE}:id/error_message").text
					if(error_message)
						data_check = "data not found"
					end
				rescue
					data_check = "data found"  
				end
				
				if(data_check == "data not found")
					puts error_message.text
					break
				elsif(data_check === "data found")
					summary_table = parent.find_element(:id, "#{APP_PACKAGE}:id/summary_table")
					summary_table_rows = summary_table.find_elements(:class, 'android.widget.TableRow')
					txt_values = summary_table_rows[0].find_elements(:id, "#{APP_PACKAGE}:id/tv_label")
					recent_label = txt_values[0].text
					value_one = txt_values[1].text
					value_two = txt_values[2].text
					value_three = txt_values[3].text
					break
				end
			end
		end
		
		return {
		  "recent_label" => recent_label,
		  "value_one" => value_one,		  
		  "value_two" => value_two,
		  "value_three" => value_three,
		  "error" => error_message,
		  "tile_title" => summary_header_title	  
		}
	end
	
	def misc_tile_object
		summary_grid = @selenium.find_element(:id, "#{APP_PACKAGE}:id/summary_grid")
		summary_tile_roots = summary_grid.find_elements(:id, "#{APP_PACKAGE}:id/summary_tile_root")
		
		for i in 0..summary_tile_roots.count
			summary_header = summary_tile_roots[i].find_element(:id, "#{APP_PACKAGE}:id/summary_header")
			summary_header_title = summary_header.find_element(:id, "#{APP_PACKAGE}:id/summary_header_title")
			if(summary_header_title.text == "MISC")
				summary_table = summary_tile_roots[i].find_element(:id, "#{APP_PACKAGE}:id/summary_table")
				summary_table_rows = summary_table.find_elements(:class, 'android.widget.TableRow')
				r1_label = summary_table_rows[0].find_element(:id, "#{APP_PACKAGE}:id/tv_label")
				r1_range = summary_table_rows[0].find_element(:id, "#{APP_PACKAGE}:id/tv_range")
				r1_value = summary_table_rows[0].find_element(:id, "#{APP_PACKAGE}:id/tv_value")
				
				r2_label = summary_table_rows[1].find_element(:id, "#{APP_PACKAGE}:id/tv_label")
				r2_range = summary_table_rows[1].find_element(:id, "#{APP_PACKAGE}:id/tv_range")
				r2_value = summary_table_rows[1].find_element(:id, "#{APP_PACKAGE}:id/tv_value")
				
				r3_label = summary_table_rows[2].find_element(:id, "#{APP_PACKAGE}:id/tv_label")
				r3_range = summary_table_rows[2].find_element(:id, "#{APP_PACKAGE}:id/tv_range")
				r3_value = summary_table_rows[2].find_element(:id, "#{APP_PACKAGE}:id/tv_value")
			end
		end
		
		return {
		  "r1_label" => r1_label.text,
		  "r1_range" => r1_range.text,		  
		  "r1_value" => r1_value.text,
		  "r2_label" => r2_label.text,
		  "r2_range" => r2_range.text,		  
		  "r2_value" => r2_value.text,
		  "r3_label" => r3_label.text,
		  "r3_range" => r3_range.text,		  
		  "r3_value" => r3_value.text,
		  "tile_title" => summary_header_title.text		  
		}
	end
	
	def summary_header_object   
		parent = @selenium.find_element(:id, "#{APP_PACKAGE}:id/action_bar") 
		
		full_name = parent.find_element(:id, "#{APP_PACKAGE}:id/tv_name")
		age = parent.find_element(:id, "#{APP_PACKAGE}:id/tv_age")
		location = parent.find_element(:id, "#{APP_PACKAGE}:id/tv_location")
		
		p_two = @selenium.find_element(:id, "#{APP_PACKAGE}:id/main_frame")
		ob_strip_status = p_two.find_element(:id, "#{APP_PACKAGE}:id/ob_strip_sub_status")
				
		return {
		  "full_name" => full_name.text,
		  "age" => age.text,		  
		  "location" => location.text,
		  "ob_strip_status" => ob_strip_status.text
		}
	end	
end
