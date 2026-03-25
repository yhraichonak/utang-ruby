Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class PatientList_screen
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end

  def search_keyboard_button
    Appium_lib.predicate(@appium, "XCUIElementTypeButton", "search")
  end

  def nav_bar
    e = @selenium.find_element(:class, 'XCUIElementTypeNavigationBar')
    return e
  end

  def patient_search_field
    @selenium.find_element(:class, "XCUIElementTypeSearchField")
  end

  def patient_search_cells
    @selenium.find_elements(:class, 'XCUIElementTypeCell')
  end

  def navigation_bar(title)
    #@appium.find_ele_by_predicate_include(class_name: "XCUIElementTypeNavigationBar", value: "#{title}")
    parent = @selenium.find_element(:class, 'XCUIElementTypeWindow')
    navbar = parent.find_element(:class, 'XCUIElementTypeNavigationBar')
    return navbar
  end

  def close_button
    Element.new(@selenium, :xpath, '//UIAButton["icon close"]')
  end

  def hamburgerIcon_button
    @appium.button_exact("icon slide")
  end

  def get_patient(name)
    txts = @selenium.find_elements(:class, "XCUIElementTypeStaticText")

    for i in 0..(txts.count - 1)
      #puts txts[i].text
      if txts[i].text.upcase == name.upcase
        return txts[i]
      end
    end
  end

  def search_on_keyboard
    buttons = @selenium.find_elements(:class, "XCUIElementTypeButton")
    btn = nil
    found = false
    for i in 0..(buttons.count - 1)
      #puts buttons[i].text
      if(buttons[i].text == "Search")
        btn = buttons[i]
        found = false
        break
      end

      if found == true
        break
      end

    end
    return btn
  end

  def patient_cell(name)

    patient_name = name.upcase
    #puts "+"
    #puts patient_name
    #puts "+"
    #puts " in the patient cell method for the patient list screen class "
    patient_found = false
    return_txt = nil
    found = false
    cell_needed = nil


    for i in 0..5
            counter = 0
            #works with 6.2.5
            collection = @selenium.find_element(:class, 'XCUIElementTypeTable')

            cells = collection.find_elements(:class, 'XCUIElementTypeCell')
            #puts cells.count

            for x in 0..(cells.count - 1) #the txt for loop
              txts = cells[x].find_elements(:class, "XCUIElementTypeStaticText")

              #for z in 0..(txts.count - 1)
              #   puts "#{z} = #{txts[z].text.upcase}"
              # end

              for i in 0..(txts.count - 1)
                    if $debug_flag == "debug"
                      #puts "#{i} = #{txts[i].name.upcase}"
                      #puts "## #{i} = #{txts[i].visible}"
                    end
                    if(txts[i].attribute("visible") == "false")

                    else
                      if(txts[i].name.upcase == patient_name)
                        if $debug_flag == "debug"
                          #puts "found patient: #{txts[i].name.upcase}"
                        end
                        found = true
                        patient_found = true
                        cell_needed = cells[x]
                        return_txt = txts[i]
                        break
                      end
                    end

                    if found == true
                      break
                    end

                    if patient_found == true
                      break
                    end
                  counter = counter + 1
              end
              if patient_found == true
                      break
              end
            end   #txt for loop

            found = false

            if counter > (txts.count - 1)
              do_swipe
              # Appium::TouchAction.new.swipe(:start_x => 600, :start_y => 550, :end_x => 600, :end_y => 200, :duration => 1000).perform
            end

            if patient_found == true
              break
            end
    end #end of for loop

    #return return_txt
    return cell_needed
  end

  def patient_cell124(patient_name)
    patient_found = false
    return_txt = nil
    found = false
    cell_needed = nil


    for i in 0..30
            counter = 0

            #this should work with > 6.2.2
            #collection = @selenium.find_element(:class, 'XCUIElementTypeCollectionView')
            #this should work with > 6.2.2

            collection = @selenium.find_elements(:class, 'XCUIElementTypeTable')
            #puts collection.count


            #txts = @appium.find_eles_by_attr("XCUIElementTypeStaticText", "visible", "true")
            cells = collection[0].find_elements(:class, 'XCUIElementTypeCell')

            for x in 0..(cells.count - 1) #the txt for loop
              txts = cells[x].find_elements(:class, "XCUIElementTypeStaticText")
              for i in 0..(txts.count - 1)
                    #puts "#{i} = #{txts[i].name}"
                    #puts "## #{i} = #{txts[i].visible}"
                    if(txts[i].attribute("visible") == "false")

                    else
                      if(txts[i].name == patient_name)
                        #puts "found it"
                        found = true
                        patient_found = true
                        cell_needed = cells[x]
                        return_txt = txts[i]
                        break
                      end
                    end

                    if found == true
                      break
                    end
                  counter = counter + 1
              end

            end   #txt for loop

            found = false

            if counter > (txts.count - 1)
              do_swipe
              # Appium::TouchAction.new.swipe(:start_x => 600, :start_y => 550, :end_x => 600, :end_y => 200, :duration => 1000).perform
            end

            if patient_found == true
              break
            end
    end #end of for loop

    #return return_txt
    return cell_needed
  end

  def patientRow_cell(row)
    cells = @appium.tags("XCUIElementTypeCell")
    return cells[row.to_i-1]
  end

  def getPatientInfoFromPatientList(rowNumber, search=nil)
    #puts "row number = #{rowNumber}"
    cells = @selenium.find_elements(:class, 'XCUIElementTypeCell')
    patientText = cells[rowNumber.to_i].find_elements(:class, 'XCUIElementTypeStaticText')

    for i in 0..(patientText.count - 1)
      #puts "#{i} = #{patientText[0].attribute("value")}"
    end

    patientName = patientText[0].attribute("value")
    patientGender = patientText[2].attribute("value")
    patientAge = patientText[4].attribute("value")
    patientAcquistionDate = patientText[5].attribute("value")
    patientEcgCount = patientText[6].attribute("value")
    patientDiagnosisStatement = patientText[7].attribute("value")
    return [patientName,patientGender,patientAge,patientAcquistionDate,patientEcgCount,patientDiagnosisStatement]
  end

  def OLDgetPatientInfoFromPatientList(rowNumber, search=nil)
    objects = ""
    if $platform_version.include? "11" or desired_capabilities['deviceName'].include? 'iPad'
      objects = "XCUIElementTypeOther[1]/XCUIElementTypeOther[1]/"
    end

    objects = "XCUIElementTypeOther[1]/XCUIElementTypeOther[1]/"

    patientText = @selenium.find_elements(:xpath, "//XCUIElementTypeCollectionView[1]/XCUIElementTypeCell[#{rowNumber}]/#{objects}XCUIElementTypeStaticText")

    patientName = patientText[0].attribute("value")
    patientGender = patientText[2].attribute("value")
    patientAge = patientText[4].attribute("value")
    patientAcquistionDate = patientText[5].attribute("value")
    patientEcgCount = patientText[6].attribute("value")
    patientDiagnosisStatement = patientText[7].attribute("value")
    return [patientName,patientGender,patientAge,patientAcquistionDate,patientEcgCount,patientDiagnosisStatement]
  end

  def getNumOfPatientsInList
    #parent = @selenium.find_element(:class, "XCUIElementTypeCollectionView")
    #puts "found p"
    parent = @selenium.find_element(:class, "XCUIElementTypeTable")
    #puts "found table"

    count = parent.find_elements(:class, "XCUIElementTypeCell").count

    return count
  end

  def getNumOfPatientsInList124
    parent = @selenium.find_element(:class, "XCUIElementTypeCollectionView")
    #parent = @selenium.find_element(:class, "XCUIElementTypeTable")
    count = parent.find_elements(:class, "XCUIElementTypeCell").count
    return count
  end

  def getRowOfPatientNameFromPatientList_ecg_count(name, ecg)
    patientList = @selenium.find_elements(:xpath, "//XCUIElementTypeCollectionView/XCUIElementTypeCell")
	   scrol
    for i in 0..(patientList.count - 1)
      detail_info =  @selenium.find_elements(:xpath, "//XCUIElementTypeCollectionView/XCUIElementTypeCell[#{i}]/XCUIElementTypeStaticText")
      if (detail_info.count > 0)
      for z in 0..(detail_info.count - 1)
        name_value =  @selenium.find_elements(:xpath, "//XCUIElementTypeCollectionView/XCUIElementTypeCell[#{i}]/XCUIElementTypeStaticText[#{z}]")
        ecg_count =  @selenium.find_elements(:xpath, "//XCUIElementTypeCollectionView/XCUIElementTypeCell[#{i}]/XCUIElementTypeStaticText[#{z + 5}]")
        if (name_value[0].attribute("name") == name)
        if(ecg_count[0].attribute("name") == ecg)
          return name_value[0]
        end
        end
      end
      end
    end
  end

  def getRowOfPatientNameFromPatientList(name)
    #puts "name searched for #{name}"
    cells = @selenium.find_elements(:class, 'XCUIElementTypeCell')
    found = false
    row = 0
    for i in 0..(cells.count - 1)
      static_texts = cells[i].find_elements(:class, 'XCUIElementTypeStaticText')
      for x in (0..static_texts.count - 1)
        # puts "x = #{x} = #{static_texts[x].name}"
        if static_texts[x].text.nil?

        elsif (static_texts[x].name == name)
          # puts "found patient #{static_texts[x].text}"
          row = i
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
    return row
  end

  def getRowOfPatientNameFromPMPatientList(name)
    parent = @selenium.find_element(:class, 'XCUIElementTypeCollectionView')
    #puts "found the parent"
    #parent = @selenium.find_element(:class, 'XCUIElementTypeTable')
    rows = parent.find_elements(:class, 'XCUIElementTypeCell')
    #puts "found rows = #{rows.count}"
    value = nil

    for i in 0..(rows.count - 1)
      #puts "row = #{i}"
      txts = rows[i].find_elements(:class, 'XCUIElementTypeStaticText')
      #puts "found #{txts.count} txts for row #{i}"
      for x in 0..(txts.count - 1 )
        if(txts[x].attribute("name") == name)
          value = i
          found = true
          break
        end
        if found
          break
        end
      end
      if found
        break
      end
    end

    return value
  end

  def getRowOfPatientNameFromPMPatientListolder(name)
    objects = ""
    if $platform_version.include? "11" or desired_capabilities['deviceName'].include? 'iPad'
      objects = "XCUIElementTypeOther[1]/XCUIElementTypeOther[1]/"
    end

    patientList = @selenium.find_elements(:xpath, "//XCUIElementTypeCollectionView[1]/XCUIElementTypeCell")

    row = 1
    patientList.each { |patientCell|
      if patientCell.find_element(:xpath, "#{objects}XCUIElementTypeStaticText").attribute("name") == name
      break
      else
      row += 1
      end
    }
    #puts name
    #puts "Row: #{row}"
    return row
  end

  def pm_list_options_button_old(row)
    #parent = @selenium.find_element(:class, 'XCUIElementTypeCollectionView')
    parent = @selenium.find_element(:class, 'XCUIElementTypeTable')
    rows = parent.find_elements(:class, 'XCUIElementTypeCell')

    buttons = rows[row].find_elements(:class, 'XCUIElementTypeButton')

    if buttons.count > 1
      for i in 0..buttons.count
      if(buttons[i].attribute("name") == "common action" || buttons[i].attribute("label") == "common action")
        return buttons[i]
      end
      end
    else
      return buttons[0]
    end
  end

  def pm_list_options_button(row)
    #parent = @selenium.find_element(:class, 'XCUIElementTypeCollectionView')
    parent = @selenium.find_element(:class, 'XCUIElementTypeTable')

    rows = parent.find_elements(:class, 'XCUIElementTypeCell')
    #puts rows.count

    #buttons = rows[row].find_elements(:class, 'XCUIElementTypeButton')
    #
    #if buttons.count > 1
    #  for i in 0..buttons.count
    #  if(buttons[i].attribute("name") == "common action" || buttons[i].attribute("label") == "common action")
    #    return buttons[i]
    #  end
    #  end
    #else
    #  return buttons[0]
    #end

    img = rows[row].find_element(:class, 'XCUIElementTypeImage')
    return img
  end

  def pm_list_events_button(row)
    parent = @selenium.find_element(:class, 'XCUIElementTypeCollectionView')
    rows = parent.find_elements(:class, 'XCUIElementTypeCell')

    buttons = rows[row].find_elements(:class, 'XCUIElementTypeButton')

    for i in 0..buttons.count

      if(buttons[i].attribute("name") == "Events" || buttons[i].attribute("label") == "Events")
      return buttons[i]
      end
    end
  end

  def pm_list_monitor_button(row)
    parent = @selenium.find_element(:class, 'XCUIElementTypeCollectionView')
    rows = parent.find_elements(:class, 'XCUIElementTypeCell')

    buttons = rows[row].find_elements(:class, 'XCUIElementTypeButton')

    for i in 0..buttons.count
      if(buttons[i].attribute("name") == "Monitor" || buttons[i].attribute("label") == "Monitor")
      return buttons[i]
      end
    end
  end

  def pm_list_bed(bed)
    parent = @selenium.find_element(:class, 'XCUIElementTypeCollectionView')
    txts = parent.find_elements(:class, 'XCUIElementTypeStaticText')
    found = false
    for i in 0..txts.count
      #puts txts[i].text
      if(txts[i].text == bed)
        found = true
        return txts[i]
      end

      if found == true
        break
      end
    end
  end

  def pm_list_options_buttonolder(row)
    if $platform_version.include? "11"
      Element.new(@selenium, :xpath, "//XCUIElementTypeCollectionView[1]/XCUIElementTypeCell[#{row}]/XCUIElementTypeOther[1]/XCUIElementTypeOther[1]/XCUIElementTypeButton[@label='common action']")
    else
      Element.new(@selenium, :xpath, "//XCUIElementTypeCollectionView[1]/XCUIElementTypeCell[#{row}]/XCUIElementTypeButton[@name='common action']")
    end
  end

  def pm_list_events_buttonolder(row)
    if $platform_version.include? "11"
      Element.new(@selenium, :xpath, "//XCUIElementTypeCollectionView[1]/XCUIElementTypeCell[#{row}]/XCUIElementTypeButton[@label='Events']")
    else
      Element.new(@selenium, :xpath, "//XCUIElementTypeCollectionView[1]/XCUIElementTypeCell[#{row}]/XCUIElementTypeButton[@name='Events']")
    end
  end

  def pm_list_monitor_buttonolder(row)
    if $platform_version.include? "11"
      Element.new(@selenium, :xpath, "//XCUIElementTypeCollectionView[1]/XCUIElementTypeCell[#{row}]/XCUIElementTypeButton[@label='Monitor']")
    else
      Element.new(@selenium, :xpath, "//XCUIElementTypeCollectionView[1]/XCUIElementTypeCell[#{row}]/XCUIElementTypeButton[@name='Monitor']")
    end
  end

  def getPatientInfoFromPatientList_ob(rowNumber, search=nil)
    patientText = @selenium.find_elements(:xpath, "//XCUIElementTypeCollectionView[1]/XCUIElementTypeCell[#{rowNumber}]/XCUIElementTypeOther[1]/XCUIElementTypeStaticText")

    patientEAG = patientText[4].attribute("value")
    patientPhysician = patientText[1].attribute("value")
    patientMembraneStatus = patientText[2].attribute("value")
    patientName = patientText[0].attribute("value")
    patientGravidaPara = patientText[6].attribute("value")
    patientCervicalExam = patientText[8].attribute("value")

    if patientText.count > 10
      patientCervicalExamTime = patientText[9].attribute("value")
      patientRoomNumber = patientText[10].attribute("value")

      return [patientEAG,patientPhysician,patientMembraneStatus,patientName,patientGravidaPara,patientCervicalExam,patientCervicalExamTime,patientRoomNumber]
    else
      patientRoomNumber = patientText[9].attribute("value")

      return [patientEAG,patientPhysician,patientMembraneStatus,patientName,patientGravidaPara,patientCervicalExam,patientRoomNumber]
    end
  end

end
