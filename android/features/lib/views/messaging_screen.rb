Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class Messaging_screen
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end

  def check_for_dismiss_button(attempts=5) # Notes: This doesn't look to work, or be used. Consider removing.
    sleep(2)
    (0..attempts).each {
      begin
        if Element.new(@selenium, :id, "#{APP_PACKAGE}:id/button_negative")
          return Element.new(@selenium, :id, "#{APP_PACKAGE}:id/button_negative")
        end
      rescue
        # Ignored
      end
      sleep(1)
    }
  end

  def conversation_container
    return Element.new(@selenium,:id, "#{APP_PACKAGE}:id/content_container")
  end

  def conversation_list(name)
    (0..10).each do
      from_list = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/from")
      from_list.each do |name_cell|
        return name_cell if name_cell.text == name
      end
      Common.swipe_window(@selnium, x_pct_start=0.5, x_pct_end=0.5, y_pct_start=0.80, y_pct_end=0.10, dur_ms=2250)
    end
  end

  def conversation_list_first_user
    return @selenium.find_element(:id, "#{APP_PACKAGE}:id/from")
  end

  def conversation_list_object
    parent = @selenium.find_element(:id, "#{APP_PACKAGE}:id/main_content")
    list_obj = parent.find_element(:id, "#{APP_PACKAGE}:id/list")
    return list_obj
  end
  
  def conversation_message_count
    begin
      return @selenium.find_elements(:id, "#{APP_PACKAGE}:id/conversation_root").count
    rescue
      return 0
    end
  end

  def dismiss_button
    elements = @selenium.find_elements(:class, "android.widget.Button")

    (0..10).each {
      if elements.count > 0
        (0..elements.count).each { |i|
          if elements[i].text == "Dismiss"
            return elements[i]
          end
        }
      end
      sleep(1)
    }
  end

  def get_ecg_message(ecg)
    elements = @selenium.find_elements(:class, "android.widget.TextView")

    (0..elements.count).each { |i|
      if elements[i].text == ecg.to_s
        return elements[i + 1]
      end
    }
  end

  def get_message(message)
    parent = @selenium.find_element(:id, 'android:id/list')
    elements = parent.find_elements(:id, "#{APP_PACKAGE}:id/conversation_item_body")

    (0..elements.count).each { |i|
      if elements[i].text == message
        return elements[i]
      end
    }
  end

  def get_last_message_in_list
    messages = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/conversation_item_body")
    return messages[messages.count-1]
  end

  def message_field
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/send_text")
  end

  def message_list_count
    return @selenium.find_elements(:id, "#{APP_PACKAGE}:id/from").count
  end

  def message_list_view
    @selenium.find_element(:id, "#{APP_PACKAGE}:id/list")
  end

  def navigation_bar
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_title")
  end
  
  def new_msg_element
		Element.new(@selenium, :accessibility_id, '+')
  end

  def new_msg_button
    return @selenium.find_element(:id, "#{APP_PACKAGE}:id/menu_new_message")
  end
  
  def return_share_link(message_txt)
    e = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/conversation_content")
    (0..(e.count - 1)).each { |i|
      text_views = e[i].find_elements(:class, 'android.widget.TextView')
      (0..(text_views.count - 1)).each { |z|
        if text_views[z].text == message_txt
          return e[i].find_element(:id, "#{APP_PACKAGE}:id/share_link_label")
        end
      }
    }
  end

  def send_message_button
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/send_button")
  end

  def title
    return @selenium.find_element(:id, "#{APP_PACKAGE}:id/tv_title")
  end

end