Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class Share_window
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end
  
  def share_window_title
    Element.new(@selenium, :id, 'android:id/alertTitle') #text = Share Patient Details
  end
 
  def recipient_editText
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/select_recipient") #text = To: (tap to select recipient)
  end

  def content_panel
    Element.new(@selenium, :id, 'android:id/contentPanel')
  end
  
  def choose_contact_editText
    e = @selenium.find_element(:id, 'android:id/parentPanel')
    top_panel = e.find_element(:id, 'android:id/topPanel')
    element = top_panel.find_element(:class, 'android.widget.EditText')

		if element.text == "Choose Contact"
			return element
		end
  end
  
  def shareLink_icon
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/share_link_icon") #text =
  end
  
  def shareLink_label
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/share_link_label") #text = ESRON, NESBIT or patients actual name
  end
  
  def message_editText
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/send_text") #text = Type Message
  end
  
  def send_message_button
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/send_button") #text =
  end

  def cancel_message_button
    Element.new(@selenium, :id, 'android:id/button2') #text = Cancel
  end
  
  def contact_in_list(contact_name)
	e = @selenium.find_element(:id, "android:id/select_dialog_listview")
	
	elements = e.find_elements(:id, 'android:id/text1')
	
	for i in 0..(elements.count)
		if(elements[i].text == contact_name)
			return elements[i]
		end		
	end 
  end
  
  def response_title
	Element.new(@selenium, :id, 'android:id/alertTitle') #text = Success	
  end
  
  def response_message
	Element.new(@selenium, :id, 'android:id/message') #text = Message Sent Successfully
  end
  
  def view_conversation_button
	Element.new(@selenium, :id, 'android:id/button2') #text = View Conversation
  end
  
  def close_response_button
	Element.new(@selenium, :id, 'android:id/button1') #text = Close
  end
end