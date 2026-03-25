Dir[File.dirname(__FILE__) + '/../*.rb'].each {|file| require file }

class PM_Snippet
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end

  def measure_button
    # @selenium.find_element(:id, "#{APP_PACKAGE}:id/measure_button")
    return Element.new(@selenium, :id, "#{APP_PACKAGE}:id/measure_button")
  end

  def navbar_cancel_button
    @selenium.find_element(:id, "#{APP_PACKAGE}:id/cancel_button")
  end

  def navbar_create_button
    @selenium.find_element(:id, "#{APP_PACKAGE}:id/continue_button")
  end

  def preview_navbar_back_button
    @selenium.find_element(:id, "#{APP_PACKAGE}:id/back_button")
  end

  def preview_navbar_save_button
    @selenium.find_element(:id, "#{APP_PACKAGE}:id/preview_save")
  end

  def preview_pdf_layout
    @selenium.find_element(:id, "#{APP_PACKAGE}:id/pdf")
  end

  def preview_button
    @selenium.find_element(:id, "#{APP_PACKAGE}:id/preview_button")
  end

  def save_button
    @selenium.find_element(:id, "#{APP_PACKAGE}:id/save_button")
  end

  def snippet_create_element
    return Element.new(@selenium, :id, "#{APP_PACKAGE}:id/continue_button")
  end

  def tool_jump_to_element
    return Element.new(@selenium, :accessibility_id, 'Jump To')
  end

  def tool_button
    return @selenium.find_element(:accessibility_id, 'TOOLS')
  end

  def wave_view_p_button
    @selenium.find_element(:id, "#{APP_PACKAGE}:id/p")
  end

  def wave_view_p_element
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/p")
  end

  def wave_view_qr_button
    @selenium.find_element(:id, "#{APP_PACKAGE}:id/q")
  end

  def wave_view_qr_element
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/q")
  end

  def wave_view_s_button
    @selenium.find_element(:id, "#{APP_PACKAGE}:id/s")
  end

  def wave_view_s_element
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/s")
  end

  def wave_view_t_button
    @selenium.find_element(:id, "#{APP_PACKAGE}:id/t")
  end

  def wave_view_t_element
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/t")
  end
  
  def legend
    @selenium.find_element(:id, "#{APP_PACKAGE}:id/legend")
  end

  def lead_title_container
    @selenium.find_element(:id, "#{APP_PACKAGE}:id/lead_title_container")
  end

end