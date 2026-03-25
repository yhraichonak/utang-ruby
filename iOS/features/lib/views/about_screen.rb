Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class About_screen
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end

  def about_table
    @selenium.find_element(:class, "XCUIElementTypeTable")
  end

  def navigation_bar
    nav_bar = Appium_lib.predicate(@appium, "XCUIElementTypeNavigationBar", "About")
    return nav_bar
  end

  def cancel_button
    buttons = @selenium.find_elements(:class, "XCUIElementTypeButton")

    button = nil
    found = false

    for i in 0..(buttons.count - 1)
      if(buttons[i].text == "Cancel")
        button = buttons[i]
        found = true
        break
      end
      if found == true
        break
      end
    end

    return button
  end

  def cancel_button_3
    parent = @selenium.find_element(:class, 'XCUIElementTypeNavigationBar')
    buttons = parent.find_elements(:class, 'XCUIElementTypeButton')
    return buttons[0]
  end

  def done_button
    Element.new(@selenium, :xpath, "//UIAButton[@name='Done']")
  end

  def signOut_button
    #Ement.new(@selenium, :xpath, "//XCUIElementTypeButton[@name='Sign Out']")
    Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Sign Out")
  end

  def table_section(sectionName)
    parent = @selenium.find_element(:class, 'XCUIElementTypeTable')
    return parent.find_element(:name, sectionName)
  end

  def oltable_section(sectionName)
    #Element.new(@selenium, :xpath, "//XCUIElementTypeOther[@name='#{sectionName}']")
    Appium_lib.predicate(@appium, "XCUIElementTypeOther", "#{sectionName}")
  end

  def information_header(rowNumber)
    Element.new(@selenium, :xpath, "//XCUIElementTypeTable[1]/XCUIElementTypeCell[#{rowNumber}]/XCUIElementTypeStaticText[1]")
  end

  def about_info_data_object
      parent = @selenium.find_element(:class, 'XCUIElementTypeTable')
      cells = parent.find_elements(:class, 'XCUIElementTypeCell')

      #App Name
      cell_needed = nil
      found = false
      for i in 0..(cells.count - 1)
        stat_txt = cells[i].find_elements(:class, 'XCUIElementTypeStaticText')
        #puts stat_txt[0].name
        if(stat_txt[0].name == "App Name")
          app_name_label = stat_txt[0]
          cell_needed = cells[i]
          found = true
          break
        end
        if found == true
          break
        end
      end

      if $device_version == "12.4"
        more_txts = cell_needed.find_elements(:class, 'XCUIElementTypeStaticText')
        app_name_button = more_txts[1]
      else
        more_txts = cell_needed.find_elements(:class, 'XCUIElementTypeButton')
        app_name_button = more_txts[1]
      end

      #App Version
      cell_needed = nil
      found = false
      for i in 0..(cells.count - 1)
        stat_txt = cells[i].find_elements(:class, 'XCUIElementTypeStaticText')
        #puts stat_txt[0].name
        if(stat_txt[0].name == "App Version")
          app_version_label = stat_txt[0]
          cell_needed = cells[i]
          found = true
          break
        end
        if found == true
          break
        end
      end

      if $device_version == "12.4"
        more_txts = cell_needed.find_elements(:class, 'XCUIElementTypeStaticText')
        app_version_button = more_txts[1]
      else
        more_txts = cell_needed.find_elements(:class, 'XCUIElementTypeButton')
        app_version_button = more_txts[1]
      end

      #Build Number
      cell_needed = nil
      found = false
      for i in 0..(cells.count - 1)
        stat_txt = cells[i].find_elements(:class, 'XCUIElementTypeStaticText')
        #puts stat_txt[0].name
        if(stat_txt[0].name == "Build Number")
          build_number_label = stat_txt[0]
          cell_needed = cells[i]
          found = true
          break
        end
        if found == true
          break
        end
      end

      if $device_version == "12.4"
        more_txts = cell_needed.find_elements(:class, 'XCUIElementTypeStaticText')
        build_number_button = more_txts[1]
      else
        more_txts = cell_needed.find_elements(:class, 'XCUIElementTypeButton')
        build_number_button = more_txts[1]
      end

      #UDI
      cell_needed = nil
      found = false
      for i in 0..(cells.count - 1)
        stat_txt = cells[i].find_elements(:class, 'XCUIElementTypeStaticText')
        #puts stat_txt[0].name
        if(stat_txt[0].name == "UDI")
          udi_label = stat_txt[0]
          cell_needed = cells[i]
          found = true
          break
        end
        if found == true
          break
        end
      end

      if $device_version == "12.4"
        more_txts = cell_needed.find_elements(:class, 'XCUIElementTypeStaticText')
        udi_button = more_txts[1]
      else
        more_txts = cell_needed.find_elements(:class, 'XCUIElementTypeButton')
        udi_button = more_txts[1]
      end

      #CopyRight
      cell_needed = nil
      found = false
      for i in 0..(cells.count - 1)
        stat_txt = cells[i].find_elements(:class, 'XCUIElementTypeStaticText')
        #puts stat_txt[0].name
        if(stat_txt[0].name == "Copyright")
          copyright_label = stat_txt[0]
          cell_needed = cells[i]
          found = true
          break
        end
        if found == true
          break
        end
      end

      if $device_version == "12.4"
        more_txts = cell_needed.find_elements(:class, 'XCUIElementTypeStaticText')
        copyright_button = more_txts[1]
      else
        more_txts = cell_needed.find_elements(:class, 'XCUIElementTypeButton')
        copyright_button = more_txts[1]
      end

      #Patent Number
      cell_needed = nil
      found = false
      for i in 0..(cells.count - 1)
        stat_txt = cells[i].find_elements(:class, 'XCUIElementTypeStaticText')
        #puts stat_txt[0].name
        if(stat_txt[0].name == "Patent Number")
          patent_number_label = stat_txt[0]
          cell_needed = cells[i]
          found = true
          break
        end
        if found == true
          break
        end
      end

      if $device_version == "12.4"
        more_txts = cell_needed.find_elements(:class, 'XCUIElementTypeStaticText')
        patent_number_button = more_txts[1]
      else
        more_txts = cell_needed.find_elements(:class, 'XCUIElementTypeButton')
        patent_number_button = more_txts[1]
      end

      #Registration Code
      cell_needed = nil
      found = false
      for i in 0..(cells.count - 1)
        stat_txt = cells[i].find_elements(:class, 'XCUIElementTypeStaticText')
        #puts stat_txt[0].name
        if(stat_txt[0].name == "Registration Code")
          registration_code_label = stat_txt[0]
          cell_needed = cells[i]
          found = true
          break
        end
        if found == true
          break
        end
      end

      if $device_version == "12.4"
        more_txts = cell_needed.find_elements(:class, 'XCUIElementTypeStaticText')
        registration_code_button = more_txts[1]
      else
        more_txts = cell_needed.find_elements(:class, 'XCUIElementTypeButton')
        registration_code_button = more_txts[1]
      end

      #Registration Email
      cell_needed = nil
      found = false
      for i in 0..(cells.count - 1)
        stat_txt = cells[i].find_elements(:class, 'XCUIElementTypeStaticText')
        #puts stat_txt[0].name
        if(stat_txt[0].name == "Registration Email")
          registration_email_label = stat_txt[0]
          cell_needed = cells[i]
          found = true
          break
        end
        if found == true
          break
        end
      end

      if $device_version == "12.4"
        more_txts = cell_needed.find_elements(:class, 'XCUIElementTypeStaticText')
        registration_email_button = more_txts[1]
      else
        more_txts = cell_needed.find_elements(:class, 'XCUIElementTypeButton')
        registration_email_button = more_txts[1]
      end

      #Unique ID
      cell_needed = nil
      found = false
      for i in 0..(cells.count - 1)
        stat_txt = cells[i].find_elements(:class, 'XCUIElementTypeStaticText')
        #puts stat_txt[0].name
        if(stat_txt[0].name == "Unique ID")
          unique_id_label = stat_txt[0]
          cell_needed = cells[i]
          found = true
          break
        end
        if found == true
          break
        end
      end

      if $device_version == "12.4"
        more_txts = cell_needed.find_elements(:class, 'XCUIElementTypeStaticText')
        unique_id_button = more_txts[1]
      else
        more_txts = cell_needed.find_elements(:class, 'XCUIElementTypeButton')
        unique_id_button = more_txts[1]
      end

      #Device Name
      cell_needed = nil
      found = false
      for i in 0..(cells.count - 1)
        stat_txt = cells[i].find_elements(:class, 'XCUIElementTypeStaticText')
        #puts stat_txt[0].name
        if(stat_txt[0].name == "Device Name")
          device_name_label = stat_txt[0]
          cell_needed = cells[i]
          found = true
          break
        end
        if found == true
          break
        end
      end

      if $device_version == "12.4"
        more_txts = cell_needed.find_elements(:class, 'XCUIElementTypeStaticText')
        device_name_button = more_txts[1]
      else
        more_txts = cell_needed.find_elements(:class, 'XCUIElementTypeButton')
        device_name_button = more_txts[1]
      end

      #Device model
      cell_needed = nil
      found = false
      for i in 0..(cells.count - 1)
        stat_txt = cells[i].find_elements(:class, 'XCUIElementTypeStaticText')
        #puts stat_txt[0].name
        if(stat_txt[0].name == "Device Model")
          device_model_label = stat_txt[0]
          cell_needed = cells[i]
          found = true
          break
        end
        if found == true
          break
        end
      end

      if $device_version == "12.4"
        more_txts = cell_needed.find_elements(:class, 'XCUIElementTypeStaticText')
        device_model_button = more_txts[1]
      else
        more_txts = cell_needed.find_elements(:class, 'XCUIElementTypeButton')
        device_model_button = more_txts[1]
      end

      #System Name
      cell_needed = nil
      found = false
      for i in 0..(cells.count - 1)
        stat_txt = cells[i].find_elements(:class, 'XCUIElementTypeStaticText')
        #puts stat_txt[0].name
        if(stat_txt[0].name == "System Name")
          system_name_label = stat_txt[0]
          cell_needed = cells[i]
          found = true
          break
        end
        if found == true
          break
        end
      end

      if $device_version == "12.4"
        more_txts = cell_needed.find_elements(:class, 'XCUIElementTypeStaticText')
        system_name_button = more_txts[1]
      else
        more_txts = cell_needed.find_elements(:class, 'XCUIElementTypeButton')
        system_name_button = more_txts[1]
      end

      #System Version
      cell_needed = nil
      found = false
      for i in 0..(cells.count - 1)
        stat_txt = cells[i].find_elements(:class, 'XCUIElementTypeStaticText')
        #puts stat_txt[0].name
        if(stat_txt[0].name == "System Version")
          system_version_label = stat_txt[0]
          cell_needed = cells[i]
          found = true
          break
        end
        if found == true
          break
        end
      end

      if $device_version == "12.4"
        more_txts = cell_needed.find_elements(:class, 'XCUIElementTypeStaticText')
        system_version_button = more_txts[1]
      else
        more_txts = cell_needed.find_elements(:class, 'XCUIElementTypeButton')
        system_version_button = more_txts[1]
      end

      return {
      "app_name_label" => app_name_label,
      "app_name_button" => app_name_button,
      "app_version_label" => app_version_label,
      "app_version_button" => app_version_button,
      "build_number_label" => build_number_label,
      "build_number_button" => build_number_button,
      "udi_label" => udi_label,
      "udi_button" => udi_button,
      "copyright_label" => copyright_label,
      "copyright_button" => copyright_button,
      "patent_number_label" => patent_number_label,
      "patent_number_button" => patent_number_button,
      "registration_code_label" => registration_code_label,
      "registration_code_button" => registration_code_button,
      "registration_email_label" => registration_email_label,
      "registration_email_button" => registration_email_button,
      "unique_id_label" => unique_id_label,
      "unique_id_button" => unique_id_button,
      "device_name_label" => device_name_label,
      "device_name_button" => device_name_button,
      "device_model_label" => device_model_label,
      "device_model_button" => device_model_button,
      "system_name_label" => system_name_label,
      "system_name_button" => system_name_button,
      "system_version_label" => system_version_label,
      "system_version_button" => system_version_button
      }
  end

  def about_info_txts
      parent = @selenium.find_element(:class, 'XCUIElementTypeTable')
      cells = parent.find_elements(:class, 'XCUIElementTypeCell')

      cell_needed = nil
      found = false
      for i in 0..(cells.count - 1)
        stat_txt = cells[i].find_elements(:class, 'XCUIElementTypeStaticText')
        #puts stat_txt[0].name
        if(stat_txt[0].name == "Registration Code")
          cell_needed = cells[i]
          found = true
          break
        end
        if found == true
          break
        end
      end

      more_txts = cell_needed.find_elements(:class, 'XCUIElementTypeStaticText')
      reg_button = more_txts[1]

      cell_needed = nil
      found = false
      for i in 0..(cells.count - 1)
        stat_txt = cells[i].find_elements(:class, 'XCUIElementTypeStaticText')

        if(stat_txt[0].name == "App Version")
          cell_needed = cells[i]
          found = true
          break
        end
        if found == true
          break
        end
      end

      more_txts = cell_needed.find_elements(:class, 'XCUIElementTypeStaticText')
      app_ver_button = more_txts[1]

      cell_needed = nil
      found = false
      for i in 0..(cells.count - 1)
        stat_txt = cells[i].find_elements(:class, 'XCUIElementTypeStaticText')

        if(stat_txt[0].name == "Build Number")
          cell_needed = cells[i]
          found = true
          break
        end
        if found == true
          break
        end
      end

      more_txts = cell_needed.find_elements(:class, 'XCUIElementTypeStaticText')
      build_num_button = more_txts[1]

      cell_needed = nil
      found = false
      for i in 0..(cells.count - 1)
        stat_txt = cells[i].find_elements(:class, 'XCUIElementTypeStaticText')

        if(stat_txt[0].name == "UDI")
          cell_needed = cells[i]
          found = true
          break
        end
        if found == true
          break
        end
      end

      more_txts = cell_needed.find_elements(:class, 'XCUIElementTypeStaticText')
      udi_button = more_txts[1]

      return {
      "registration_code" => reg_button,
      "app_version" => app_ver_button,
      "build_number" => build_num_button,
      "udi"=> udi_button
      }
  end

  def about_info_buttons
      parent = @selenium.find_element(:class, 'XCUIElementTypeTable')
      cell_needed = parent.find_element(:xpath, ".//XCUIElementTypeStaticText[@name='Registration Code']/..")
      if $device_version == "12.4"
        txts = cell_needed.find_elements(:class, 'XCUIElementTypeStaticText')
        if $debug_flag == "debug"
          puts txts[0].text
          puts txts[1].text
        end
        reg_button = txts[1]
      else
        reg_button = cell_needed.find_element(:class, 'XCUIElementTypeButton')
      end

      # cell_needed = parent.find_element(:xpath, ".//XCUIElementTypeStaticText[@name='Version']/..")
      cell_needed = parent.find_element(:xpath, ".//XCUIElementTypeStaticText[contains(@name,'Version')]/..")

      if $device_version == "12.4"
        txts = cell_needed.find_elements(:class, 'XCUIElementTypeStaticText')
        if $debug_flag == "debug"
          puts txts[0].text
          puts txts[1].text
        end
        app_ver_button = txts[1]
      else
        app_ver_button = cell_needed.find_element(:class, 'XCUIElementTypeButton')
      end

      cell_needed = parent.find_element(:xpath, ".//XCUIElementTypeStaticText[contains(@name,'Build')]/..")
      # cell_needed = parent.find_element(:xpath, ".//XCUIElementTypeStaticText[@name='Build']/..")

      if $device_version == "12.4"
        txts = cell_needed.find_elements(:class, 'XCUIElementTypeStaticText')
        if $debug_flag == "debug"
          puts txts[0].text
          puts txts[1].text
        end
        build_num_button = txts[1]
      else
        build_num_button = cell_needed.find_element(:class, 'XCUIElementTypeButton')
      end

      cell_needed = parent.find_element(:xpath, ".//XCUIElementTypeStaticText[@name='UDI']/..")

      if $device_version == "12.4"
        txts = cell_needed.find_elements(:class, 'XCUIElementTypeStaticText')
        if $debug_flag == "debug"
          puts txts[0].text
          puts txts[1].text
        end
        udi_button = txts[1]
      else
        udi_button = cell_needed.find_element(:class, 'XCUIElementTypeButton')
      end

      return {
      "registration_code" => reg_button,
      "app_version" => app_ver_button,
      "build_number" => build_num_button,
      "udi"=> udi_button
      }
  end

  def information_txt(which)

    if $D_PLATFORM == "13.0" || $D_PLATFORM == "13.3"

      parent = @selenium.find_element(:class, 'XCUIElementTypeTable')
      cells = parent.find_elements(:class, 'XCUIElementTypeCell')
      cell_needed = nil
      found = false
      for i in 0..(cells.count - 1)
        stat_txt = cells[i].find_elements(:class, 'XCUIElementTypeStaticText')

        if(stat_txt[0].name == which)
          cell_needed = cells[i]
          found = true
          break
        end
        if found == true
          break
        end
      end

      button = cell_needed.find_element(:class, 'XCUIElementTypeButton')
      return button
    else
      parent = @selenium.find_element(:class, 'XCUIElementTypeTable')
      cells = parent.find_elements(:class, 'XCUIElementTypeCell')

      for i in 0..(cells.count - 1)
        stat_txt = cells[i].find_elements(:class, 'XCUIElementTypeStaticText')
        if(stat_txt[0].name == which)
          return stat_txt[1]
        end
      end
    end
  end

  def information_cell(rowNumber)
    Element.new(@selenium, :xpath, "//XCUIElementTypeTable[1]/XCUIElementTypeCell[#{rowNumber}]/XCUIElementTypeStaticText[2]")
  end

  def information_textView
    Element.new(@selenium, :xpath, "//UIATextView[2]")
  end

  def alert_header
    #Element.new(@selenium, :xpath, "//UIAAlert[1]/UIAScrollView[1]/UIAStaticText[1]")
    if DEVICE == 'iPhone 6'
      Element.new(@selenium, :xpath, "//UIAApplication[1]/UIAWindow[5]/UIAAlert[1]/UIAScrollView[1]/UIAStaticText[1]")
    elsif(DEVICE == 'iPad 2')
      Element.new(@selenium, :xpath, "//UIAApplication[1]/UIAWindow[4]/UIAAlert[1]/UIAScrollView[1]/UIAStaticText[1]")
    end
  end

  def alert_description
    if DEVICE == 'iPhone 6'
      Element.new(@selenium, :xpath, "//UIAAlert[1]/UIAScrollView[1]/UIAStaticText[2]")
    elsif (DEVICE == 'iPad 2')
      Element.new(@selenium, :xpath, "//UIAApplication[1]/UIAWindow[4]/UIAAlert[1]/UIAScrollView[1]/UIAStaticText[2]")
    end
  end

  def alertOk_button
    Element.new(@selenium, :xpath, "//UIAAlert[1]/UIATableView[1]/UIATableCell[@name='OK']")
    #Element.new(@selenium, :xpath, "//UIAAlert[1]/UIATableView[1]/UIATableCell[@name='OK']")
  end

  def signout_cancel_button
    Element.new(@selenium, :xpath, "//UIAAlert[1]/UIACollectionView[1]/UIACollectionCell[1]/UIAButton[@name='Cancel']")

  end

  def signout_signout_button
    #Element.new(@selenium, :xpath, "//UIAAlert[1]/UIACollectionView[1]/UIACollectionCell[2]/UIAButton[@name='Sign Out']")

    #Element.new(@selenium, :xpath, "//XCUIElementTypeAlert/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeButton[@name='Sign Out']")
    #Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Sign Out")
    e = @selenium.find_elements(:class, 'XCUIElementTypeScrollView')
    parent = e[1]

    buttons = parent.find_elements(:class, 'XCUIElementTypeButton')
    button = nil
    found = false
    for i in 0..(buttons.count - 1)
      if(buttons[i].name == "Sign Out")

        button = buttons[i]
        found = true
        break
      end
      if found == true
        break
      end
    end
    return button
  end

  def success_ok_button
    #Element.new(@selenium, :xpath, "//XCUIElementTypeAlert/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeButton[@name='OK']")
    e = @selenium.find_elements(:class, 'XCUIElementTypeScrollView')
    parent = e[1]
    buttons = parent.find_elements(:class, 'XCUIElementTypeButton')
    button = nil
    for i in 0..(buttons.count - 1)
      if(buttons[i].name == "OK")
        button = buttons[i]
        break
      end
    end
    return button
  end

  def application_info_data_object
       label_locator="//XCUIElementTypeStaticText[@name=\"%s\"]"
       labeled_button_locator="#{label_locator}/following-sibling::XCUIElementTypeButton"
       labeled_static_text_locator="#{label_locator}/following-sibling::XCUIElementTypeStaticText"
      return {
              "app_name_label" => @selenium.find_element(:xpath, label_locator % "App Name"),
              "app_name_button" => @selenium.find_element(:xpath, labeled_button_locator % "App Name"),
              "app_version_label" => @selenium.find_element(:xpath, label_locator % "App Version"),
              "app_version_button" => @selenium.find_element(:xpath, labeled_button_locator % "App Version"),
              "build_number_label" => @selenium.find_element(:xpath, label_locator % "Build Number"),
              "build_number_button" => @selenium.find_element(:xpath, labeled_button_locator % "Build Number"),
              "udi_label" => @selenium.find_element(:xpath, label_locator % "UDI"),
              "udi_button" => @selenium.find_element(:xpath, labeled_button_locator % "UDI"),
              "copyright_label" => @selenium.find_element(:xpath, label_locator % "Copyright"),
              "copyright_button" => @selenium.find_element(:xpath, labeled_button_locator % "Copyright"),
              "patent_number_label" => @selenium.find_element(:xpath, label_locator % "Patent Number"),
              "patent_number_button" => @selenium.find_element(:xpath, labeled_button_locator % "Patent Number"),
              }
  end ######

  def device_info_data_object
      label_locator="//XCUIElementTypeStaticText[@name=\"%s\"]"
      button_locator="#{label_locator}/following-sibling::XCUIElementTypeButton"
      return {
              "registration_code_label" => @selenium.find_element(:xpath, label_locator % "Registration Code"),
              "registration_code_button" => @selenium.find_element(:xpath, button_locator % "Registration Code"),
              "registration_email_label" => @selenium.find_element(:xpath, label_locator % "Registration Email"),
              "registration_email_button" => @selenium.find_element(:xpath, button_locator % "Registration Email"),
              "unique_id_label" => @selenium.find_element(:xpath, label_locator % "Unique ID"),
              "unique_id_button" => @selenium.find_element(:xpath, button_locator % "Unique ID"),
              # "device_name_label" => @selenium.find_element(:xpath, label_locator % "Device Name"),
              # "device_name_button" => @selenium.find_element(:xpath, button_locator % "Device Name"),
              "device_model_label" => @selenium.find_element(:xpath, label_locator % "Device Model"),
              "device_model_button" => @selenium.find_element(:xpath, button_locator % "Device Model"),
              "system_name_label" => @selenium.find_element(:xpath, label_locator % "System Name"),
              "system_name_button" => @selenium.find_element(:xpath, button_locator % "System Name"),
              "system_version_label" => @selenium.find_element(:xpath, label_locator % "System Version"),
              "system_version_button" => @selenium.find_element(:xpath, button_locator % "System Version")
              }
  end

  def tech_support_data_object
     do_swipe(600, 550, 600, 500)
      # Appium::TouchAction.new.swipe(:start_x => 600, :start_y => 550, :end_x => 600, :end_y => 150, :duration => 1000).perform

      #getting the new screen objects
      parent = @selenium.find_element(:class, 'XCUIElementTypeTable')
      cells = parent.find_elements(:class, 'XCUIElementTypeCell')

      #Phone US
      cell_needed = nil
      found = false
      for i in 0..(cells.count - 1)
        if cells[i].displayed? == true
          stat_txt = cells[i].find_elements(:class, 'XCUIElementTypeStaticText')
          # puts stat_txt[0].name
          if(stat_txt[0].name == "Phone US Toll-free (24/7)")
            phone_us_label = stat_txt[0]
            cell_needed = cells[i]
            found = true
            break
          end
          if found == true
            break
          end
        end
      end

      if $device_version == "12.4"
        more_txts = cell_needed.find_elements(:class, 'XCUIElementTypeStaticText')
        phone_us_button = more_txts[1]
      else
        more_txts = cell_needed.find_elements(:class, 'XCUIElementTypeButton')
        phone_us_button = more_txts[0]
      end

      #Phone UK
      cell_needed = nil
      found = false
      for i in 0..(cells.count - 1)
        if cells[i].displayed? == true
          stat_txt = cells[i].find_elements(:class, 'XCUIElementTypeStaticText')
          #puts stat_txt[0].name
          if(stat_txt[0].name == "Phone UK (24/7)")
            phone_uk_label = stat_txt[0]
            cell_needed = cells[i]
            found = true
            break
          end
          if found == true
            break
          end
        end
      end

      if $device_version == "12.4"
        more_txts = cell_needed.find_elements(:class, 'XCUIElementTypeStaticText')
        phone_uk_button = more_txts[1]
      else
        more_txts = cell_needed.find_elements(:class, 'XCUIElementTypeButton')
        phone_uk_button = more_txts[0]
      end

      #Phone CA
      cell_needed = nil
      found = false
      for i in 0..(cells.count - 1)
        if cells[i].displayed? == true
          stat_txt = cells[i].find_elements(:class, 'XCUIElementTypeStaticText')
          #puts stat_txt[0].name
          if(stat_txt[0].name == "Phone CA (24/7)")
            phone_ca_label = stat_txt[0]
            cell_needed = cells[i]
            found = true
            break
          end
          if found == true
            break
          end
        end
      end

      if $device_version == "12.4"
        more_txts = cell_needed.find_elements(:class, 'XCUIElementTypeStaticText')
        phone_ca_button = more_txts[1]
      else
        more_txts = cell_needed.find_elements(:class, 'XCUIElementTypeButton')
        phone_ca_button = more_txts[0]
      end

      #Phone AU
      cell_needed = nil
      found = false
      for i in 0..(cells.count - 1)
        if cells[i].displayed? == true
          stat_txt = cells[i].find_elements(:class, 'XCUIElementTypeStaticText')
          #puts stat_txt[0].name
          if(stat_txt[0].name == "Phone AU (24/7)")
            phone_au_label = stat_txt[0]
            cell_needed = cells[i]
            found = true
            break
          end
          if found == true
            break
          end
        end
      end

      if $device_version == "12.4"
        more_txts = cell_needed.find_elements(:class, 'XCUIElementTypeStaticText')
        phone_au_button = more_txts[1]
      else
        more_txts = cell_needed.find_elements(:class, 'XCUIElementTypeButton')
        phone_au_button = more_txts[0]
      end

      #Email
      cell_needed = nil
      found = false
      for i in 0..(cells.count - 1)
        if cells[i].displayed? == true
          stat_txt = cells[i].find_elements(:class, 'XCUIElementTypeStaticText')
          #puts stat_txt[0].name
          if(stat_txt[0].name == "Email")
            email_label = stat_txt[0]
            cell_needed = cells[i]
            found = true
            break
          end
          if found == true
            break
          end
        end
      end

      if $device_version == "12.4"
        more_txts = cell_needed.find_elements(:class, 'XCUIElementTypeStaticText')
        email_button = more_txts[1]
      else
        more_txts = cell_needed.find_elements(:class, 'XCUIElementTypeButton')
        email_button = more_txts[0]
      end

      return {
      "phone_us_label" => phone_us_label,
      "phone_us_button" => phone_us_button,
      "phone_uk_label" => phone_uk_label,
      "phone_uk_button" => phone_uk_button,
      "phone_ca_label" => phone_ca_label,
      "phone_ca_button" => phone_ca_button,
      "phone_au_label" => phone_au_label,
      "phone_au_button" => phone_au_button,
      "email_label" => email_label,
      "email_button" => email_button
      }
  end

  def manu_by_data_object
      # Appium::TouchAction.new.swipe(:start_x => 600, :start_y => 550, :end_x => 600, :end_y => 200, :duration => 1000).perform
      # $GLOBAL_APPIUM.action.move_to_location(600, 550).pointer_down(:left).move_to_location(600, 200).release.perform
      do_swipe
      manuf_contacts=@selenium.find_elements(:xpath, '//XCUIElementTypeStaticText[@name="Manufactured By"]/../following-sibling::*/XCUIElementTypeStaticText')
      man_address_txt = manuf_contacts[0]
      man_date_txt = manuf_contacts[1]

      return {
      "man_address_txt" => man_address_txt,
      "man_date_txt" => man_date_txt,
      }
  end

  def eu_auth_data_object
       do_swipe
       do_swipe
      # Appium::TouchAction.new.swipe(:start_x => 600, :start_y => 550, :end_x => 600, :end_y => 200, :duration => 1000).perform
      # Appium::TouchAction.new.swipe(:start_x => 600, :start_y => 550, :end_x => 600, :end_y => 200, :duration => 1000).perform

      if $device_name.include? "iPad"
        do_swipe
        # Appium::TouchAction.new.swipe(:start_x => 600, :start_y => 550, :end_x => 600, :end_y => 200, :duration => 1000).perform
      end
      repr_in_eu=@selenium.find_element(:xpath, '//XCUIElementTypeStaticText[@name="EU Authorized Representative & Importer"]/../following-sibling::*/XCUIElementTypeStaticText')
      return {
       "eu_address_txt" => repr_in_eu
      }
  end

  def au_auth_data_object

      # parent = @selenium.find_element(:class, 'XCUIElementTypeTable')
      # section
      cells = @selenium.find_elements(:class, 'XCUIElementTypeCell')

      #AU Authorized Rep
      cell_needed = nil
      found = false
      for i in 0..(cells.count - 1)
        if cells[i].displayed? == true
          txts = cells[i].find_elements(:class, 'XCUIElementTypeStaticText')
          #puts stat_txt[0].name
          if(txts[0].name.include? "Cardioscan Services Pty")
            cell_needed = cells[i]
            found = true
            break
          end
          if found == true
            break
          end
        end
      end

      more_txts = cell_needed.find_elements(:class, 'XCUIElementTypeStaticText')
      au_address_txt = more_txts[0]


      return {
      "au_address_txt" => au_address_txt
      }
  end
end
