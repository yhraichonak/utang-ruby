Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class Menu
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end
  
  def action_bar
    action_bar = @selenium.find_element(:id, "#{APP_PACKAGE}:id/action_bar")
    return action_bar.find_element(:class, 'android.widget.TextView')
  end

  def sites_container
    sites_container = @selenium.find_element(:id, "#{APP_PACKAGE}:id/fragment_container")
    return sites_container
  end
  
  def patient_header_object
    parent = @selenium.find_element(:id, "#{APP_PACKAGE}:id/action_bar")
    name = parent.find_element(:id, "#{APP_PACKAGE}:id/tv_name")
    gender = parent.find_element(:id, "#{APP_PACKAGE}:id/tv_gender")
    mrn = parent.find_element(:id, "#{APP_PACKAGE}:id/tv_mrn")
    location = parent.find_element(:id, "#{APP_PACKAGE}:id/tv_location")

    return {
      'name' => name,
      'gender' => gender,
      'mrn' => mrn,
      'location' => location
    }
  end
  
  def back_button
    parent = @selenium.find_element(:id, "#{APP_PACKAGE}:id/action_bar")
    back = parent.find_element(:class, 'android.widget.ImageButton')
    return back
  end
  
  def unit_filter_button
    @selenium.find_element(:id, "#{APP_PACKAGE}:id/menu_unit_filter")
  end
  
  def group_sort_button
    @selenium.find_element(:id, "#{APP_PACKAGE}:id/menu_sort")
  end
  
  def refresh_button
   Element.new(@selenium, :id, "#{APP_PACKAGE}:id/menu_reload")
  end
  
  def miviewer_button
    begin
      element = Element.new(@selenium, :id, "#{APP_PACKAGE}:id/menu_cardio_miview")
      return element
    rescue
      return nil
    end
  end
  
  def color_icon
    begin
      element = Element.new(@selenium, :id, "#{APP_PACKAGE}:id/menu_color")
      return element
    rescue
      return nil
    end
  end
    
  def new_message_button
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/menu_new_message")
  end

  def more_options_button
    elements = @selenium.find_elements(:class, 'android.widget.ImageView')
    (0..(elements.count)).each do |i|
      #if (elements[i].name == "More options")
      return elements[i] if (elements[i].attribute('content-desc') == 'More options')
    end
  end
  
  def summary_home_button
    return @selenium.find_element(:id, "#{APP_PACKAGE}:id/menu_home")
  end

  def summary_home_element
    return Element.new(@selenium, :id, "#{APP_PACKAGE}:id/menu_home")
  end
  
  def summary_vent_button
    parent = @selenium.find_element(:id, "#{APP_PACKAGE}:id/menu_3")
    back = parent.find_element(:id, "#{APP_PACKAGE}:id/icon")
    return back
  end
  
  def time_chooser_button
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/menu_events_time_chooser")
  end
  
  def jump_to_button
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/menu_monitor_jump_to")
  end
  
  def live_button
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/menu_monitor_live")
  end
  
  def filtered_button
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/menu_filter")
  end
  
  def delete_button
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/menu_delete")
  end
  
  def share_icon
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/menu_share")
  end
  
  def logout_button
    sleep(1)
    elements = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/title")
    (0..elements.count).each do |i|
      return elements[i] if (elements[i].text == 'Logout')
    end
  end
  
  def settings_button
    elements = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/title")
    (0..elements.count).each do |i|
      return elements[i] if (elements[i].text == 'Settings')
    end
  end
  
  def about_button
    elements = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/title")
    (0..elements.count).each do |i|
      return elements[i] if elements[i].text == 'About'
    end
  end
  
  def share_button_overflow
    @selenium.find_element(:id, "#{APP_PACKAGE}:id/menu_share")
  end
  
  def share_button
  txt_views = @selenium.find_elements(:class, 'android.widget.TextView')
  puts txt_views.count
  (0..txt_views.count).each do |i|
    return txt_views[i] if (txt_views[i].text == 'Share')
  end
     #e = parent.find_element(:id, "#{APP_PACKAGE}:id/menu_share')
     #puts e.tag_name
     #return e
  end
  
  def ecg_list_button
    begin
      element = Element.new(@selenium, :id, "#{APP_PACKAGE}:id/menu_toggle_master_list")
      return element
    rescue e
      return nil
    end
  end
  
  def ecgs_button
    parent = @selenium.find_element(:id, "#{APP_PACKAGE}:id/action_bar")
    elements = parent.find_elements(:class,  'android.widget.ImageButton')
    (0..elements.count).each do |i|
      return elements[i] if (elements[i].text == 'ECGs')
    end
  end
  
  def ecgs_button_overflow
    elements = @selenium.find_elements(:id,  "#{APP_PACKAGE}:id/title")
    (0..elements.count).each do |i|
      return elements[i] if (elements[i].text == 'ECGs')
    end
  end
  
  def toggle_color_overflow
    elements = @selenium.find_elements(:id,  "#{APP_PACKAGE}:id/title")
    (0..elements.count).each do |i|
      return elements[i] if (elements[i].tag_name == 'Toggle Color')
    end
  end
  
  def ecg_banner_button
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/menu_toggle_master_list")
  end
  
  def refresh_overflow
    elements = @selenium.find_elements(:id,  "#{APP_PACKAGE}:id/title")
    (0..elements.count).each do |i|
      return elements[i] if (elements[i].text == 'Refresh')
    end
  end
  
  def edit_button
    elements = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/menu_cardio_edit")
    (0..elements.count).each do |i|
      return elements[i] if (elements[i].tag_name == 'ECGs')
    end
  end
  
  def as_one_secure_message_button
    Element.new(@selenium, :xpath, '//android.widget.ListView[1]/android.widget.LinearLayout[1]/android.widget.TextView[1]')
  end
  
  def as_one_secure_message_button_old
    elements = @selenium.find_elements(:class, 'android.widget.TextView')
    (0..elements.count).each do |i|
      #puts elements[i].text
      return elements[i] if (elements[i].text == 'utang ONE Secure Messaging')
    end
  end
  
  def app_error_network
    Element.new(@selenium, :id, 'android:id/alertTitle')
  end
  
  def app_error_OK
    Element.new(@selenium, :id, 'android:id/button1')
  end

  def main_content_window
    return Element.new(@selenium,:id, "#{APP_PACKAGE}:id/main_content")
  end
end