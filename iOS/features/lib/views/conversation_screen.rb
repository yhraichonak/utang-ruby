Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class Conversation_screen
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end

  def conversation_table
    @selenium.find_element(:xpath, '//XCUIElementTypeCollectionView | //XCUIElementTypeTable')
  end

  def navigation_bar(name)
    #Appium_lib.predicate(@appium, "XCUIElementTypeNavigationBar", "#{name}")
    window = @selenium.find_element(:class, 'XCUIElementTypeWindow')
    nav_bar = window.find_element(:class, 'XCUIElementTypeNavigationBar')
    other = nav_bar.find_element(:class, 'XCUIElementTypeOther')
	return nav_bar
    #    puts nav_bar.nil?
    #    puts nav_bar.attribute("name")
    #    puts nav_bar.attribute("text")
    #	if(nav_bar.text == name)
    #		puts "found it"
    #		return nav_bar
    #	end
  end

  def message_enter_text
    #Element.new(@selenium, :xpath, "//XCUIElementTypeTextView[1]")
    enter_texts = @selenium.find_elements(:class, 'XCUIElementTypeTextField')
    return enter_texts[0]
  end

  def message_share_label
    Appium_lib.predicate(@appium, "XCUIElementTypeStaticText", "You are about to share the monitor")
  end

  def send_button
    Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Send")
  end

  def conversation_tableCells(message)
    #count = @selenium.find_elements(:uiautomation, "#{UIAWINDOW}.tableViews()[0].cells()").count
    cells = @selenium.find_elements(:class, ' XCUIElementTypeCell')

    for i in 0..(cells.count)
		txt = cells[i].find_element(:class, 'XCUIElementTypeStaticText')
      if (txt.attribute("name") == message)
        return e
      end
    end
  end

  def message_text(message)
    txts = @selenium.find_elements(:class, 'XCUIElementTypeStaticText')

    value = txts.select {|txt| txt.name.include? message}.first
  end

  def message_with_share(first_message, second_message)
    txts = @selenium.find_elements(:class, 'XCUIElementTypeStaticText')
    assembled_message = "#{first_message} #{second_message}"
    found = false
    value = nil
    #iOS test - 76139459 Tap to open monitor for GRN10, GRN10

    for i in 0..(txts.count - 1)
      # puts "#{i} = #{txts[i].text}"
      if txts[i].nil? or txts[i].name.nil?
        puts "nil detected"
      else
          if (txts[i].name.include? first_message) && (txts[i].name.include? second_message)
            puts "found it"
            found = true
            value = txts[i]
            break
          # else
          #   puts "not it:"
          #   puts "#{txts[i].name}"
          end
      end
      if found == true
        break
      end
    end
    puts "value = #{value.name} ******"
    return value
  end

  #updated 05/25/22
  def message_with_share_old(first_message, second_message)
    puts "first message = #{first_message}"
    puts "second message = #{second_message}"

    #use first message is a marker then increment by one and then verify the second_message
    txts = @selenium.find_elements(:class, 'XCUIElementTypeStaticText')
      puts "found #{txts.count} static texts"

      found = false
      value = nil

      for i in 0..(txts.count - 2)
        puts "trying #{i} of the texts"
         puts "#{i} = #{txts[i].text}"

        if txts[i].nil?
          puts "nil detected"
        else
            if txts[i].text == first_message

              if txts[i + 1].text == second_message

                  found = true
                  if $debug_flag == "debug"
                    puts "---------"
                    puts txts[i].text
                    puts txts[i + 1].text
                    puts "---------"

                  end
                  value = txts[i + 1]
                  break
              elsif txts[i + 2].text == second_message
                  found = true
                  puts "found what i needed for second message i + 2"
                  if $debug_flag == "debug"
                    puts "---------"
                    puts txts[i].text
                    puts txts[i + 2].text
                    puts "---------"

                  end
                  value = txts[i + 2]

                  break

              end
            end
        end

        if found == true

          break
        end
      end
      puts "value = #{value} #{value.text}"
      return value
  end

  def message_textold(message)
    if $debug_flag == "debug"
      puts "the messaging coming into the message_text #{message}"
      puts $r_num
    end

    found = false
    value = nil

    table = @selenium.find_elements(:class, 'XCUIElementTypeTable')
    if $debug_flag == "debug"
    puts table.count
    puts "*******"
    puts table[0].find_elements(:class, 'XCUIElementTypeCells').count
    puts table[1].find_elements(:class, 'XCUIElementTypeCells').count
    puts "*******"
    end


    cells = table[0].find_elements(:class, 'XCUIElementTypeCells')
    if $debug_flag == "debug"
    puts "==============="
    puts cells.count
    puts "==============="
    end

    #cells2 = table[1].find_elements(:class, 'XCUIElementTypeCells')
    #puts cells2.count

    for z in 0..(cells.count - 1)
      txts = cells[z].find_elements(:class, 'XCUIElementTypeTextView')
      puts txts.count
      for i in 0..(txts.count - 1)
        if txts[i].text == message
            found = true
            value = txts[i]
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
    return value
  end
end
