Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

require 'test/unit'
extend Test::Unit::Assertions

ABOUT ||= 'About'
APPLICATION_INFO ||= 'Application Info'
APP_NAME ||= 'App Name'
APP_VERSION ||= 'App Version'
AU_AUTH_REP ||= 'AU Authorized Representative'
BUILD ||= 'Build'
CARDIOSCAN_SERVICES ||= 'Cardioscan Services Pty Ltd.'
COPYRIGHT ||= 'Copyright'
DEVICE_INFO ||= 'Device Info'
DEVICE_MODEL ||= 'Device Model'
EMAIL_SUPPORT ||= 'Email Support'
EULA ||= 'End User License Agreement'
EU_AUTH_REP ||= 'EU Authorized Representative & Importer'
MANUFACTURED_BY ||= 'Manufactured By'
MANUFACTURED_DATE ||= 'Date'
ONLINE_USER_GUIDE ||= 'Online User Guide'
PATENT_NUMBER ||= 'Patent Number'
PHONE_US ||= 'Phone US Toll-free (24/7)'
PHONE_UK ||= 'Phone UK (24/7)'
PHONE_CA ||= 'Phone CA (24/7)'
PHONE_AU ||= 'Phone AU (24/7)'
REGISTRATION_CODE ||= 'Registration Code'
REGISTRATION_EMAIL ||= 'Registration Email'
SYSTEM_VERSION ||= 'System Version'
TECHNICAL_SUPPORT ||= 'Technical Support'
UDI ||= 'UDI'
UNIQUE_ID ||= 'Unique Id'
VARIANT ||= 'Variant'

EXCLUSIONS ||= ["RESET PASSWORD", "OK", "User Guides and Training" ]
HEADERS ||= [
  'About',
  'Application Info',
  'Device Info',
  'Technical Support',
  'Online User Guide',
  "End User License Agreement",
]

class About_window
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
    @up = 'up'
    @down = 'down'
  end

  def app_version
    @selenium.find_element(:id, "#{APP_PACKAGE}:id/version")
  end

  def build
    @selenium.find_element(:id, "#{APP_PACKAGE}:id/build")
  end

  def variant
    @selenium.find_element(:id, "#{APP_PACKAGE}:id/variant")
  end

  def unique_id
    @selenium.find_element(:id, "#{APP_PACKAGE}:id/unique_id")
  end

  def device_model
    if @selenium.find_elements(:id, "#{APP_PACKAGE}:id/device_model").empty?
      pos, size = get_window_size
      center_x = pos[:x] + size[:width] / 2
      center_y = pos[:y] + size[:height] / 2
      action_builder = @selenium.action
      touch = action_builder.add_pointer_input(:touch, 'finger')
      touch.create_pointer_move(duration: 0, x: center_x, y: center_y)
      touch.create_pointer_down(:left)
      touch.create_pointer_move(duration: 1, x: center_x, y: center_y - 200)
      touch.create_pause(1)
      touch.create_pointer_up(:left)
      action_builder.perform
    end
    @selenium.find_element(:id, "#{APP_PACKAGE}:id/device_model")
  end

  def system_version
    @selenium.find_element(:id, "#{APP_PACKAGE}:id/system_version")
  end

  def about_grid
    @selenium.find_element(:id, "#{APP_PACKAGE}:id/about_grid")
  end

  private def collect_all_elements_text(array=[], type=:class, locator='android.widget.TextView')
    # Collects all elements text in DOM, given an element type and it's locator string, and returns
    # them in an array.
    # type -> :class, :id, (etc.)
    # locator -> "#{APP_PACKAGE}:id/some_id", 'android.widget.TextView', (etc.)
    elements = @selenium.find_elements(type, locator)
    (0..(elements.count - 1)).each { |i|
      # puts "#{i} #{elements[i].text}"
      array.append(elements[i].text)
    }
    return array
  end

  private def get_window_size(locator="#{APP_PACKAGE}:id/about_grid")
    grid = @selenium.find_element(:id, locator)
    return grid.location, grid.size
  end

  private def swipe_about_screen(direction, center_x, center_y, wait_ms=800, offset=300, sleep_sec=2)
    # Swipe screen in 'direction' [@up, @down]
    if direction == @down
      action_builder = @selenium.action
      touch = action_builder.add_pointer_input(:touch, 'finger')
      touch.create_pointer_move(duration: 0, x: center_x, y: center_y)
      touch.create_pointer_down(:left)
      touch.create_pointer_move(duration: 1, x: center_x, y: center_y - offset)
      touch.create_pause(1)
      touch.create_pointer_up(:left)
      action_builder.perform
      # Appium::TouchAction.new.press(:x => center_x, :y => center_y).wait(wait_ms).move_to(:x => center_x, :y => center_y - offset).release.perform
    elsif direction == @up
      action_builder = @selenium.action
      touch = action_builder.add_pointer_input(:touch, 'finger')
      touch.create_pointer_move(duration: 0, x: center_x, y: center_y - offset)
      touch.create_pointer_down(:left)
      touch.create_pointer_move(duration: 1, x: center_x, y: center_y)
      touch.create_pause(1)
      touch.create_pointer_up(:left)
      action_builder.perform
      # Appium::TouchAction.new.press(:x => center_x, :y => center_y - offset).wait(wait_ms).move_to(:x => center_x, :y => center_y).release.perform
    sleep(sleep_sec)
    end
  end

  def about_screen_details
    # Setting screen swipe variables
    pos, size = get_window_size
    center_x = pos[:x] + size[:width] / 2
    center_y = pos[:y] + size[:height] / 2
    offset = 500
    wait_ms = 600

    # Element text array collection logic
    element_text_array = collect_all_elements_text([])
    until element_text_array.any? { |item| item.include? CARDIOSCAN_SERVICES }
      element_text_array = collect_all_elements_text(element_text_array)
      swipe_about_screen('down', center_x, center_y, wait_ms, offset, 2)
    end

    # Create element text hash
    result_hash = ElementHasher.create_element_hash(element_text_array, HEADERS, EXCLUSIONS, remove_date=true)

    return {
      "about_header" => result_hash[ABOUT],
      "app_info_header" => result_hash[APPLICATION_INFO],
      "app_name_label" => result_hash.key?(APP_NAME),
      "app_name_text" => result_hash[APP_NAME],
      "app_version_label" => result_hash.key?(APP_VERSION),
      "app_version_text" => result_hash[APP_VERSION],
      "build_label" => result_hash.key?(BUILD),
      "build_text" => result_hash[BUILD],
      "variant_label" => result_hash.key?(VARIANT),
      "variant_text" => result_hash[VARIANT],
      "udi_label" => result_hash.key?(UDI),
      "udi_text" => result_hash[UDI],
      "copyright_label" => result_hash.key?(COPYRIGHT),
      "copyright_text" => result_hash[COPYRIGHT],
      "patent_label" => result_hash.key?(PATENT_NUMBER),
      "patent_text" => result_hash[PATENT_NUMBER],
      "device_info_header" => result_hash[DEVICE_INFO],
      "reg_code_label" => result_hash.key?(REGISTRATION_CODE),
      "reg_code_text" => result_hash[REGISTRATION_CODE],
      "reg_email_label" => result_hash.key?(REGISTRATION_EMAIL),
      "reg_email_text" => result_hash[REGISTRATION_EMAIL],
      "unique_id_label" => result_hash.key?(UNIQUE_ID),
      "unique_id_text" => result_hash[UNIQUE_ID],
      "device_model_label" => result_hash.key?(DEVICE_MODEL),
      "device_model_text" => result_hash[DEVICE_MODEL],
      "system_version_label" => result_hash.key?(SYSTEM_VERSION),
      "system_version_text" => result_hash[SYSTEM_VERSION],
      "technical_support_label" => result_hash[TECHNICAL_SUPPORT],
      "online_user_guide_link" => result_hash[ONLINE_USER_GUIDE],
      "phone_us_label" => result_hash.key?(PHONE_US),
      "phone_us_text" => result_hash[PHONE_US],
      "phone_uk_label" => result_hash.key?(PHONE_UK),
      "phone_uk_text" => result_hash[PHONE_UK],
      "phone_ca_label" => result_hash.key?(PHONE_CA),
      "phone_ca_text" => result_hash[PHONE_CA],
      "phone_au_label" => result_hash.key?(PHONE_AU),
      "phone_au_text" => result_hash[PHONE_AU],
      "email_support_label" => result_hash.key?(EMAIL_SUPPORT),
      "email_support_text" => result_hash[EMAIL_SUPPORT],
      "manufactured_by_header" => result_hash.key?(MANUFACTURED_BY),
      "manufactured_by_text" => result_hash[MANUFACTURED_BY],
      "eu_auth_rep_label" => result_hash.key?(EU_AUTH_REP),
      "eu_auth_rep_text" => result_hash[EU_AUTH_REP],
      "au_auth_rep_label" => result_hash.key?(AU_AUTH_REP),
      "au_auth_rep_text" => result_hash[AU_AUTH_REP],
      "man_date_text" => result_hash[MANUFACTURED_DATE],
      "eula_link" => result_hash[EULA]
    }
  end

  def end_user_lic_agreement_link
	  @selenium.find_element(:id, "#{APP_PACKAGE}:id/eula")
  end

  def end_user_lic_agreement_element
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/eula")
  end

  def sign_off_button
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/dialogSignOutTextView")
  end

  def reset_password_button
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/dialogResetPasswordTextView")
  end

  def ok_button
    @selenium.find_element(:id, "#{APP_PACKAGE}:id/dialogOkTextView")
  end

  def alert_ok_button
    Element.new(@selenium, :id, 'android:id/button1')
  end

  def webview_title
    Element.new(@selenium, :id, "android:id/alertTitle")
  end

  def alert_title
    @selenium.find_element(:id, "android:id/alertTitle")
  end

  def reg_code_text
    @selenium.find_element(:id, "#{APP_PACKAGE}:id/registration_code").text
  end

end
