# frozen_string_literal: true

class PM_Navigation_Menu
  def initialize(selenium)
    @selenium = selenium
  end

  def back_button
    p_header = @selenium.find_element(:class, 'patient-header')
    p_info = p_header.find_element(:class, 'patient-info')
    p_info.find_element(:class, 'back')
  end

  def mpv_back_button
    sub_nav = @selenium.find_element(:class, 'sub-nav')
    back_button = sub_nav.find_element(:class, 'back-btn')
    return back_button
  end

  def main_nav_button(name)
    main_nav_menu = @selenium.find_element(:class, 'main-nav')
    buttons = main_nav_menu.find_elements(:css, 'a')

    (0..(buttons.count - 1)).each do |x|
      status = nil
      
      puts "the button name = #{buttons[x].text}"

      next unless buttons[x].text == name

      if buttons[x].attribute('className').include? 'active'
        status = true
        disabled = false
      elsif buttons[x].attribute('className').include? 'disabled' or ! buttons[x].attribute('className').include? 'active'
        disabled = true
        status = false
      else
        status = false
        disabled = false
      end
      
      return {
        'button_obj' => buttons[x],
        'status' => status,
        'disabled' => disabled
      }
    end
  end

  def sub_nav_button(name)
    sub_nav_menu = @selenium.find_element(:class, 'sub-nav')
    spans = sub_nav_menu.find_elements(:css, 'span')

    (0..(spans.count - 1)).each do |i|
      buttons = spans[i].find_elements(:css, 'a')

      (0..(buttons.count - 1)).each do |x|
        status = nil
        #puts "object name = #{buttons[x].text}"
        next unless buttons[x].text == name

        button_status = buttons[x].attribute('className')
        status = button_status.include?('active') ? true : false
        disabled = button_status.include?('disabled') ? true : false
        css_color = buttons[x].css_value('color')
        return {
          'button_obj' => buttons[x],
          'status' => status,
          'disabled' => disabled,
          'color' => css_color
        }
      end
    end
  end

  def vents_sub_nav_button(name)
    sub_nav_menu = @selenium.find_element(:class, 'sub-nav')
    buttons = sub_nav_menu.find_elements(:css, 'a')

    (0..(buttons.count - 1)).each do |x|
      next unless buttons[x].text == name

      status = if buttons[x].attribute('className').include? 'active'
                 true
               else
                 false
               end
      return {
        'button_obj' => buttons[x],
        'status' => status
      }
    end
  end

  def pm_monitor_sub_nav(text)
    sub_nav_menu = @selenium.find_element(:class, 'pm-side-nav')
    buttons = sub_nav_menu.find_elements(:css, 'a')
    if text == 'events'
      fore_color = buttons[0].style('color')
      puts "The Color #{fore_color}"
      status = if buttons[0].attribute('className').include? 'selected'
                 true
               else
                 false
               end
    else
      fore_color = buttons[1].style('color')
      status = if buttons[1].attribute('className').include? 'selected'
                 true
               else
                 false
               end
    end
    return {
      'status' => status,
      'fore_color' => fore_color
    }
  end

  def pm_monitor_sub_nav_isDisabled(text)
    sub_nav_menu = @selenium.find_element(:class, 'pm-side-nav')
    buttons = sub_nav_menu.find_elements(:css, 'a')
    puts "Attribute Class For Events: #{buttons[0].attribute('className')}"
    puts "Attribute Class For Patient: #{buttons[1].attribute('className')}"
    if text == 'events'
      status = if buttons[0].attribute('className').include? 'disabled'
                 false
               else
                 true
               end
    else
      status = if buttons[1].attribute('className').include? 'disabled'
                 false
               else
                 true
               end
    end
    return {
      'enabled' => status
    }
  end
end
