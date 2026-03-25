Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class SMContactList_screen
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end

  def header_staticText
    Appium_lib.predicate(@appium, "XCUIElementTypeNavigationBar", "Select an utang User")
  end

  def contact_tableCell(contactName)
    return @selenium.find_element(:xpath,"//XCUIElementTypeButton[@name='#{contactName}']")
  end

  def contact_tableCell33(contactName)
    ps = @selenium.find_elements(:class, 'XCUIElementTypeTable')

    if $debug_flag == "debug"
      puts "the table count is (#{ps.count})"
    end

    if $device_version == "12.4"
      texts = ps[0].find_elements(:class, 'XCUIElementTypeStaticText')
    else
      texts = ps[0].find_elements(:class, 'XCUIElementTypeStaticText')
    end

    puts "txt count"
    puts texts.count
    puts "----------"

    found = false
    txt = nil


      for i in 0..(texts.count - 1)
        value = nil

        begin
         value = texts[i].visible
         puts value
        rescue

        end

        if(value == "false")
          puts "the value is false and i = #{i}"
        else
          puts " in the else part of the if value = false and i = #{i}"
          #if $debug_flag == "debug"
          #  puts "#{i} text value = #{texts[i].text} and visible = #{texts[i].visible}"
          #end
          puts "+++++++"
          puts texts[i].text
          puts "+++"
          if (texts[i].nil?)
            puts "nil txt"
          elsif(texts[i].text == contactName)
            puts "found #{contactName} in the contact_tableCell"
            txt = texts[i]
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

    return txt
  end

  def searc_field
    el = @selenium.find_element(:class, 'XCUIElementTypeTextField')
    return el
  end

  def staticText_A_User
    puts "in the static text user method"
    #Appium_lib.predicate(@appium, "XCUIElementTypeStaticText", "Select an utang User:")
    stat_text = @selenium.find_elements(:class, 'XCUIElementTypeStaticText')
    puts stat_text.count
    puts "________________"
    found = false
    stat = nil

    for i in 0..(stat_text.count - 1)
      puts stat_text[i].text
      if (stat_text[i].text == "")
        stat = stat_text[i]
        found = true
        break
      end
      if found == true
        break
      end
    end

    return stat
  end
end
