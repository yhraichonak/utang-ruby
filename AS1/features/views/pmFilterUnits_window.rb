# frozen_string_literal: true

Dir["#{File.dirname(__FILE__)}/../*.rb"].sort.each { |file| require file }

class PMFilterUnits_Window
  def initialize(selenium)
    @selenium = selenium
  end

  def popup_window
    window = @selenium.find_element(:class, 'swal2-popup')
  end

  def filter_units_window
    @selenium.find_element(:id, 'swal2-title')
  end

  def toggle_switch
    @selenium.find_elements(:class, 'onoffswitch')
  end

  def toggle_all_button
    #puts "in the toggle all button method......"
    window = @selenium.find_element(:class, 'unit-filter')
    #puts "found the window"
    buttons = window.find_elements(:class, 'btn')
    #puts "the buttons count = #{buttons.count}"
    toggle_button = nil
    for i in 0..(buttons.count - 1)
      #puts buttons[i].text
      if buttons[i].text == "Toggle All"
        toggle_button = buttons[i]
        #puts "found it."
      end
    end
    
    return toggle_button
  end

  def unit_toggle_status
    window = @selenium.find_element(:class, 'unit-filter')
    onoffswitch = window.find_elements(:class, 'onoffswitch')
    
    for i in 0..(onoffswitch.count - 1)
      puts "the toggle status is #{i} #{onoffswitch[i].get_attribute("checked")}"
    end
    #.get_attribute("checked")
  end

  def toggle
    return @selenium.find_elements(:class, 'toggle')
  end

  def unit_toggle_button(name)
    window = @selenium.find_element(:class, 'unit-filter')
    units = window.find_elements(:class, 'unit')

    (0..(units.count - 1)).each do |i|
      toggle = units[i].find_element(:class, 'toggle')
      label = toggle.find_element(:class, 'label')
      return toggle.find_element(:class, 'onoffswitch') if label.text == name
    end
  end

  def ok_button
    @selenium.find_element(:class, 'swal2-confirm')
  end

  def cancel_button
    @selenium.find_element(:class, 'swal2-cancel')
  end
end
