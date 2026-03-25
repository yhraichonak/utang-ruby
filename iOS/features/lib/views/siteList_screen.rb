Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class SiteList_screen
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end

  def navigation_bar
    e = @selenium.find_element(:class, 'XCUIElementTypeNavigationBar')
    return e
  end

  def navigation_bar_title
    e = @selenium.find_element(:class, 'XCUIElementTypeStaticText')
    return e
  end

def verify_site_button(site_name)
  puts "in the verify site button"
    site_exists = "false"
    found = false
    if $is_7x_version
      collection = @selenium.find_element(:class, 'XCUIElementTypeScrollView')
      cells = collection.find_elements(:class, 'XCUIElementTypeButton')
    else
      collection = @selenium.find_element(:class, 'XCUIElementTypeCollectionView')
      cells = collection.find_elements(:class, 'XCUIElementTypeCell')
    end

    for x in 0..(cells.count - 1)

      stat_texts = cells[x].find_elements(:class, 'XCUIElementTypeStaticText')

      for i in 0..(stat_texts.count - 1)
        if(stat_texts[i].nil?)

        else
          if(stat_texts[i].text.strip == site_name)
            found = true
            site_exists = "true"
            break
          end

          if found == true
            break
          end
        end
      end #end of the stat for loop

      if found == true
        break
      end
    end # end of cells for loop

    return site_exists
end

def site_button(siteName)
  puts "site name in the site_button method = #{siteName}"
  if $is_7x_version
    collection = @selenium.find_element(:class, 'XCUIElementTypeScrollView')
    cells = collection.find_elements(:class, 'XCUIElementTypeButton')
  else
    collection = @selenium.find_element(:class, 'XCUIElementTypeCollectionView')
    cells = collection.find_elements(:class, 'XCUIElementTypeCell')
  end

  found = false
  text_needed = nil
  for i in 0..(cells.count - 1)
    txts = cells[i].find_elements(:class, 'XCUIElementTypeStaticText')

    for z in 0..(txts.count - 1)
      if(txts[z].name.strip == siteName)
        found = true
        text_needed = txts[z]
      end
      if found == true
        break
      end
    end
    if found == true
      break
    end
  end
  return text_needed
end

  def TESTsite_button(siteName)
    if $debug_flag == "debug"
      puts "++++++++"
      puts "in the site button method"
      puts "++++++++"
    end

    collection = @selenium.find_element(:class, 'XCUIElementTypeCollectionView')
    cells = collection.find_elements(:class, 'XCUIElementTypeCell')

    if $debug_flag == "debug"
      puts "the cell count is #{cells.count}"
    end

    found = false
    cell_needed = nil
    txt_needed = nil

    for x in 0..(cells.count - 1)
      stat_texts = cells[x].find_elements(:class, 'XCUIElementTypeStaticText')

        for i in 0..(stat_texts.count - 1)
        puts "#{i} = #{stat_texts[i].text}"
          if(stat_texts[i].nil?)

          else
                if $debug_flag == "views" || $debug_flag == "debug"
                    puts "cell = #{x} txt = #{i} -- #{stat_texts[i].text}"
                end

                if(stat_texts[i].text == siteName)
                  found = true
                  if $debug_flag == "views" || $debug_flag == "debug"
                       puts "i found the site.......... #{siteName}.....#{stat_texts[i].text}"
                  end
                  cell_needed = cells[x]
                  txt_needed = stat_texts[i]
                  break
                  #return cells[x]
                  #return stat_texts[i]
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

    return {
      "cell" => cell_needed,
      "text" => txt_needed
    }
  end

  def gear_button
    if $debug_flag == "views"
      puts "trying to click the gear button"
    end
    # parent = @selenium.find_element(:class, 'XCUIElementTypeNavigationBar')
    buttons = @selenium.find_elements(:class, 'XCUIElementTypeButton')

    if $debug_flag == "views"
      puts buttons.count
    end

    return buttons[0]
  end

  def notifications_alert
    Element.new(@selenium, :xpath, "//XCUIElementTypeStaticText[1][@name='\"utang\" Would Like to Send You Notifications']")
  end

  def notifications_switch
    @appium.tag("XCUIElementTypeSwitch")
  end

  def allow_button
    Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Allow")
  end

  def logout_button
    #Element.new(@selenium, :xpath, '//XCUIElementTypeButton[@name="Logout"]')
    buttons = @selenium.find_elements(:class, 'XCUIElementTypeButton')
	for i in 0..(buttons.count - 1)
		if(buttons[i].name == "Logout")
			return buttons[i]
		end
	end
  end
end
