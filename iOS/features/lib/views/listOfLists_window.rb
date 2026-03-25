Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class ListOfLists_window
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end

  def nav_bar
    nav = @selenium.find_element(:class, 'XCUIElementTypeNavigationBar')
    return nav
  end

  def list_sprocket
    parent = @selenium.find_element(:class, 'XCUIElementTypeToolbar')
    button = parent.find_element(:class, 'XCUIElementTypeButton')
    return button
  end

  def list_done_button
    buttons = @selenium.find_elements(:class, 'XCUIElementTypeButton')
    btn = nil
    found = false
    for i in 0..(buttons.count - 1)
      if buttons[i].name == "Done"
        btn = buttons[i]
        break
      end
      if found == true
        break
      end
    end
    return btn
  end

  def list_table
    @selenium.find_element(:class, 'XCUIElementTypeTable')
  end

  def pop_over
    @selenium.find_element(:class, 'XCUIElementTypePopover')
  end

  def navigationBar
    Element.new(@selenium, :xpath, "//XCUIElementTypeNavigationBar['A I R S T R I P']")
  end

def list_name_training
	parent = @selenium.find_element(:class, 'XCUIElementTypeTable')
	cells = parent.find_elements(:class, 'XCUIElementTypeStaticText')

	#for i in 0..(cells.count - 1)
	#	puts "#{i} = #{cells[i].text}"
	#end

	#this worked with the iPhone 7 11.0
	if ENV['DEVICE'] == "iPhone 7"
		emr_recent = cells[19]
		emr_search = cells[20]
		com_launcher = cells[21]
		com_sec_message = cells[22]
		com_notification = cells[23]
		pm_recent = cells[24]
		pm_snippet = cells[25]
		pm_search = cells[26]
		cardio_recent = cells[27]
		cardio_in_basket = cells[28]
		cardio_ems = cells[29]
		cardio_search = cells[30]
		ob_census = cells[31]
	else
		#emr_recent = cells[20]
		#emr_search = cells[21]
		#com_launcher = cells[22]
		#com_sec_message = cells[23]
		#com_notification = cells[24]
		#pm_recent = cells[25]
		#pm_snippet = cells[26]
		#pm_search = cells[27]
		#cardio_recent = cells[28]
		#cardio_in_basket = cells[29]
		#cardio_ems = cells[30]
		#cardio_search = cells[31]
		#ob_census = cells[32]
		#ob_search = cells[33]

		emr_recent = cells[1]
		emr_search = cells[2]

		com_launcher = cells[4]
		com_sec_message = cells[5]
		com_notification = cells[6]

		pm_recent = cells[9]
		pm_vent = cells[10]
		pm_snippet = cells[11]

		cardio_recent = cells[13]
		cardio_in_basket = cells[14]
		cardio_ems = cells[15]
		cardio_search = cells[16]

		ob_census = cells[18]
	end

	return {
		"emr_recent" => emr_recent,
		"emr_search" => emr_search,
		"com_launcher" => com_launcher,
		"com_sec_message" => com_sec_message,
		"com_notification" => com_notification,
		"pm_recent" => pm_recent,
		"pm_vent" => pm_vent,
		"pm_snippet" => pm_snippet,
		"pm_search" => pm_search,
		"cardio_recent" => cardio_recent,
		"cardio_in_basket" => cardio_in_basket,
		"cardio_ems" => cardio_ems,
		"cardio_search" => cardio_search,
		"ob_census" => ob_census
	}
end

def list_name_training_ob
	parent = @selenium.find_element(:class, 'XCUIElementTypeTable')
	cells = parent.find_elements(:class, 'XCUIElementTypeStaticText')

	 #for i in 0..(cells.count - 1)
	 #	puts "#{i} = #{cells[i].text}"
	 #end


		emr_recent = cells[0]
		emr_search = cells[1]

		com_launcher = cells[2]
		com_sec_message = cells[3]
		com_notification = cells[4]

		pm_recent = cells[7]
		pm_vent = cells[8]
		pm_snippet = cells[9]

		cardio_recent = cells[11]
		cardio_in_basket = cells[12]
		cardio_ems = cells[13]
		cardio_search = cells[14]

		ob_census = cells[16]

	return {
		"emr_recent" => emr_recent,
		"emr_search" => emr_search,
		"com_launcher" => com_launcher,
		"com_sec_message" => com_sec_message,
		"com_notification" => com_notification,
		"pm_recent" => pm_recent,
		"pm_vent" => pm_vent,
		"pm_snippet" => pm_snippet,
		"cardio_recent" => cardio_recent,
		"cardio_in_basket" => cardio_in_basket,
		"cardio_ems" => cardio_ems,
		"cardio_search" => cardio_search,
		"ob_census" => ob_census
	}
end

  def options_button
    parent = @selenium.find_element(:class, "XCUIElementTypeNavigationBar")
    puts "found parent"

    buttons = parent.find_elements(:class, "XCUIElementTypeButton")

    puts buttons.count



	  found = false
    for i in 0..(buttons.count - 1)

        # if $debug_flag == "views"
        puts buttons[i].name
      #end

      if(buttons[i].name == "slider 3Bar")
        found = true

        return buttons[i]
      end
      if found == true
        break
      end
    end
	   #Appium_lib.predicate(@appium, "XCUIElementTypeButton", "slider 3Bar")
  end

  def options_button14
    # TODO: get rid of hardcoded sleep
    sleep 3
    parent = @selenium.find_element(:class, "XCUIElementTypeNavigationBar")
    parent.find_element(:class, "XCUIElementTypeButton")
    buttons = parent.find_elements(:class, "XCUIElementTypeButton")

   return buttons[1]
  end

  def group_table(groupName)
    Element.new(@selenium, :uiautomation, "#{UIAWINDOW}.tableViews()[0].elements()['#{groupName}']")
  end

  def list_button(listName)
    cell_needed = nil
    found = false

    if (listName == "SECURE MESSAGING")
      @selenium.execute_script 'mobile: scroll', :direction => 'down'
    elsif (listName == "SECURE MESSAGES")
      @selenium.execute_script 'mobile: scroll', :direction => 'down'
    elsif (listName == "NOTIFICATIONS")
      @selenium.execute_script 'mobile: scroll', :direction => 'down'
    end

    if (listName == "SECURE MESSAGING") || (listName == "SECURE MESSAGES")
      for r in 0..5
          #puts "looping to retry #{r}"
          tables = @selenium.find_elements(:class, 'XCUIElementTypeTable')
          table = tables.find{|t|t.displayed?}
          # if tables.count == 1
          #   table = tables[0]
          # elsif tables.count > 1
          #   if(ENV['DEVICE'].include? "iPad")
          #     table = tables[0]
          #   else
          #     table = tables[1]
          #   end
          # end

          cells = table.find_elements(:class, "XCUIElementTypeCell")

          for j in 0..(cells.count - 1)
            txts = cells[j].find_elements(:class, "XCUIElementTypeStaticText")

            for i in 0..(txts.count - 1)
              puts "#{i} #{txts[i].text}"
              if(txts[i].text == listName)
                cell_needed = cells[j]
                found = true
                break
              end
              if found == true
                break
              end
            end
            if found == true
                break
            end
          end
        if found == true
          break
        end
      end
    else
      table = @selenium.find_elements(:class, 'XCUIElementTypeTable')

      if ($debug_flag == "debug")
        puts "table count = #{table.count}"
      end
      tbl=table.find{|it| it.displayed?}
      cells = tbl.find_elements(:class, "XCUIElementTypeCell")
      puts "the count of cells = #{cells.count}"
      for z in 0..(cells.count - 1)
        txts = cells[z].find_elements(:class, "XCUIElementTypeStaticText")
        puts "txts.count = #{txts.count}"
        for i in 0..(txts.count - 1)
          puts "i = #{i} = text = #{txts[i].text}"
          if txts[i].text.nil?
            puts "nill text found at #{i}"
          elsif txts[i].text != listName
            puts "not the text you want"
          elsif txts[i].text == listName
            cell_needed = cells[z]
            puts "found the #{listName} button on the list of list"
            found = true
          end
          if found == true
            break
          end
        end
        if found == true
          break
        end
      end
    end # end of the if secure messaging

    return cell_needed
  end

  def list_button22(listName)

    if (listName == "SECURE MESSAGING")
      @selenium.execute_script 'mobile: scroll', :direction => 'down'
    elsif (listName == "NOTIFICATIONS")
      @selenium.execute_script 'mobile: scroll', :direction => 'down'
    end


    if $debug_flag == "debug"
      puts "trying to find the table object"
    end

    table = @selenium.find_elements(:class, 'XCUIElementTypeTable')

    if ($debug_flag == "debug")
      puts "table count = #{table.count}"
    end

    if table.count == 1
      txts = table[0].find_elements(:class, 'XCUIElementTypeStaticText')
    elsif table.count > 1
      txts = table[1].find_elements(:class, 'XCUIElementTypeStaticText')
    end

    found = false
    text_needed = nil
      for x in 0..(txts.count - 1)
        if ($debug_flag == "debug")
          puts "x = #{x} #{txts[x].text}"
          #puts "x = #{x} #{txts[x].name}"
          #puts "x = #{x} #{txts[x].value}"
        end
        if (txts[x].text == "COMMUNICATION")
          puts "current txt = #{txts[x].text}"
          puts "next txt = #{txts[x + 1].text}"
          puts "next next txt = #{txts[x + 2].text}"

          puts "next txt = #{txts[x + 1].name}"
          puts "next next txt = #{txts[x + 2].name}"

          puts "next txt = #{txts[x + 1].value}"
          puts "next next txt = #{txts[x + 2].value}"

          text_needed = txts[x + 1]
          puts "txt - #{text_needed.text}"

           found = true
           break
        elsif(txts[x].text == listName)
            text_needed = txts[x]
            found = true
            break
        end
        if found == true
          break
        end
      end
    return text_needed
  end

  def list_button124(listName)
    puts "in the list button 12.4"
    if (listName == "SECURE MESSAGING")
      @selenium.execute_script 'mobile: scroll', :direction => 'down'
    elsif (listName == "NOTIFICATIONS")
      @selenium.execute_script 'mobile: scroll', :direction => 'down'
    end

    table = @selenium.find_elements(:class, 'XCUIElementTypeTable')

    if $debug_flag == "debug"
    puts table.count
    puts "found the table object"
    end

    txts = table[0].find_elements(:class, 'XCUIElementTypeStaticText')
    #puts txts.count

    found = false
    cell_needed = nil
      for x in 0..(txts.count - 1)
        if $debug_flag == "debug"
          puts "x = #{x} #{txts[x].name}"
        end
        if(txts[x].name == listName)
            cell_needed = txts[x]
            found = true
            break
        end
        if found == true
          break
        end
      end
    return cell_needed
  end

    def list_button124ipad(listName)
    puts "in the list button 12.4"
    if (listName == "SECURE MESSAGING")
      @selenium.execute_script 'mobile: scroll', :direction => 'down'
    elsif (listName == "NOTIFICATIONS")
      @selenium.execute_script 'mobile: scroll', :direction => 'down'
    end

    table = @selenium.find_elements(:class, 'XCUIElementTypeTable')

    if $debug_flag == "debug"
    puts table.count
    puts "found the table object"
    end

    txts = table[1].find_elements(:class, 'XCUIElementTypeStaticText')
    #puts txts.count

    found = false
    cell_needed = nil
      for x in 0..(txts.count - 1)
        if $debug_flag == "debug"
          puts "x = #{x} #{txts[x].name}"
        end
        if(txts[x].name == listName)
            cell_needed = txts[x]
            found = true
            break
        end
        if found == true
          break
        end
      end
    return cell_needed
  end

  def emr_training_list_of_list_btn(button_name, version)
	  parent = @selenium.find_element(:class, 'XCUIElementTypeTable')
	  text_views = parent.find_elements(:class, "XCUIElementTypeStaticText")

	  #for i in 0..(text_views.count - 1)
	  #	puts "#{i} = #{text_views[i].text}"
	  #end

    if version == 1
      if button_name == "RECENT"
        return text_views[18]
      elsif button_name == "SEARCH"
        return text_views[19]
      end
    elsif version == 2
      if button_name == "RECENT"
        return text_views[19]
      elsif button_name == "SEARCH"
        return text_views[20]
      end
    elsif version == 3
      if button_name == "RECENT"
        return text_views[1]
      elsif button_name == "SEARCH"
        return text_views[2]
      end
    end
  end

  def training_list_of_list_button(which)
    parent = @selenium.find_element(:class, 'XCUIElementTypeTable')
    text_views = parent.find_elements(:class, "XCUIElementTypeStaticText")

    #for i in 0..(text_views.count - 1)
    #	puts "#{i} = #{text_views[i].text}"
    #end

    current_flag = 1

    if current_flag == 1
      case which
      when "EMR RECENT"
        return text_views[19]
      when "EMR SEARCH"
        return text_views[20]
      when "PM RECENT"
        return text_views[21]
      when "PM SNIPPET WORKLIST"
        return text_views[22]
      when "PM SEARCH"
        return text_views[23]
      when "CARDIO RECENT"
        return text_views[24]
      when "CARDIO IN BASKET"
        return text_views[25]
      when "CARIO EMS"
        return text_views[26]
      when "CARIO SEARCH"
        return text_views[27]
      when "OB CENSUS"
        return text_views[28]
      when "OB SEARCH"
        return text_views[29]
      when "SECURE MESSAGES"
        return text_views[30]
      when "NOTIFICATIONS"
        return text_views[31]
      end
    elsif current_flag == 2
      case which
      when "EMR RECENT"
        return text_views[20]
      when "EMR SEARCH"
        return text_views[21]
      when "LAUNCHER"
        return text_views[22]
      when "SECURE MESSAGES"
        return text_views[23]
      when "NOTIFICATIONS"
        return text_views[24]
      when "PM RECENT"
        return text_views[25]
      when "PM SNIPPET WORKLIST"
        return text_views[26]
      when "PM SEARCH"
        return text_views[27]
      when "CARDIO RECENT"
        return text_views[28]
      when "CARDIO IN BASKET"
        return text_views[29]
      when "CARIO EMS"
        return text_views[30]
      when "CARIO SEARCH"
        return text_views[31]
      when "OB CENSUS"
        return text_views[32]
      when "OB SEARCH"
        return text_views[33]
      end
    elsif current_flag == 3
      case which
      when "EMR RECENT"
        return text_views[1]
      when "EMR SEARCH"
        return text_views[2]
      when "LAUNCHER"
        return text_views[4]
      when "SECURE MESSAGES"
        return text_views[6]
      when "NOTIFICATIONS"
        return text_views[8]
      when "PM RECENT"
        return text_views[11]
      when "PM SNIPPET WORKLIST"
        return text_views[12]
      when "PM SEARCH"
        return text_views[13]
      when "CARDIO RECENT"
        return text_views[15]
      when "CARDIO IN BASKET"
        return text_views[16]
      when "CARIO EMS"
        return text_views[17]
      when "CARIO SEARCH"
        return text_views[18]
      when "OB CENSUS"
        return text_views[20]
      when "OB SEARCH"
        return text_views[21]
      end
    end
  end

  def obCensusList_button
	parent = @selenium.find_element(:class, 'XCUIElementTypeTable')
	all_children = parent.find_elements(:xpath, ".//*")

	value = nil
	found = false
	for i in 0..(all_children.count - 1)

		if(all_children[i].text ==  "OB")

			for z in 1..20
				if(all_children[i + z].text == "CENSUS")

					value = all_children[i + z]
					found = true
					break
				end
				if found
					break
				end
			end
		end

		if found
			break
		end
	end

	return value
  end

  def obCensusList_button_old
    elements = @selenium.find_elements(:xpath, "//XCUIElementTypeTable/*")
    count = elements.count

    for i in 1..(count)
      view = "//XCUIElementTypeTable/*[#{i}]/XCUIElementTypeStaticText[1]"
      if i == 9
        @appium.swipe(:direction => "up")
        @appium.swipe(:direction => "up")
        @appium.swipe(:direction => "up")
      end

      begin
        e =  @selenium.find_element(:xpath, view)
        #puts e.attribute("name")
        if (e.attribute("name") == "OB")
          view2 = "//XCUIElementTypeTable/*[#{i+1}]/XCUIElementTypeStaticText[1]"
          e2 =  @selenium.find_element(:xpath, view2)
          #puts e2.attribute("name")
          if (e2.attribute("name") == "CENSUS")
            return e2
          end
        end
      rescue
        # skip i increment due to some elements not returning name attribute
      end
    end

    elements = @appium.find_eles_by_attr("XCUIElementTypeStaticText", "name", "CENSUS")
    return elements[elements.count-1]
  end

  def getNumberOfLists
    @selenium.find_elements(:uiautomation, "#{UIAWINDOW}.tableViews()[0].cells()").count
  end

  def siteName_text(siteName)
    #UIAStaticText "MainMenuSiteNameLabel" {{16, 537}, {183, 25}}
    Element.new(@selenium, :xpath, '//#{WINDOW}/UIAStaticText[@name="'+siteName.upcase+'"]')
  end

  def gear_button
    #@appium.last_button
    parent = @selenium.find_element(:class, "XCUIElementTypeToolbar")
    button = parent.find_element(:class, "XCUIElementTypeButton")
    return button
  end

  def about_button
    Appium_lib.predicate(@appium, "XCUIElementTypeButton", "About")
  end

  def logoff_button
    Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Log Off")
  end

  def logout_button
    Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Logout")
  end

  def cardioSearchList_button
    @selenium.find_element(:xpath, '//XCUIElementTypeStaticText[@name="SEARCH"]')
  end

  def pmSearchList_button
    search = Appium_lib.predicates(@appium, "XCUIElementTypeStaticText", "SEARCH")
    return search[1]
  end

  def censusList_button
    table = @selenium.find_element(:class, 'XCUIElementTypeTable')
    list = table.find_elements(:class, 'XCUIElementTypeStaticText')
    if list.name == 'CENSUS'
      return census
    end
  end

  def cardio_most_recent_button
    recent = Appium_lib.predicates(@appium, "XCUIElementTypeStaticText", "MOST RECENT")
    return recent
  end

  def list_of_lists_text
    table = @selenium.find_elements(:class, 'XCUIElementTypeTable')

    if ($debug_flag == "debug")
      puts "table count = #{table.count}"
    end

    if table.count == 1
      tbl = table[0]
    elsif table.count > 1
      if(ENV['DEVICE'].include? "iPad")
        tbl = table[0]
      else
        tbl = table[1]
      end
    else
      tbl = table[0]
    end
    text = tbl.find_elements(:class, 'XCUIElementTypeStaticText')
    return text
  end
end
