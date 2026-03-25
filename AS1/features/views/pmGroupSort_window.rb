# frozen_string_literal: true

Dir["#{File.dirname(__FILE__)}/../*.rb"].sort.each { |file| require file }

class PMGroupSort_Window
  def initialize(selenium)
    @selenium = selenium
  end

  def group_sort_window
    @selenium.find_element(:id, 'swal2-title')
  end

  def dropdown_fields
    @selenium.find_element(:class, 'fields')
  end

  def cancel_button
    window = @selenium.find_element(:class, 'group-sort')
    buttons = window.find_elements(:css, 'button')
    (0..(buttons.count - 1)).each do |i|
      return buttons[i] if buttons[i].text == 'Cancel'
    end
  end

  def reset_button
    window = @selenium.find_element(:class, 'group-sort')
    buttons = window.find_elements(:css, 'button')
    (0..(buttons.count - 1)).each do |i|
      return buttons[i] if buttons[i].text == 'Reset'
    end
  end

  def ok_button
    window = @selenium.find_element(:class, 'group-sort')
    buttons = window.find_elements(:css, 'button')
    (0..(buttons.count - 1)).each do |i|
      return buttons[i] if buttons[i].text == 'Ok'
    end
  end

  def group_by_field_control
    fields = @selenium.find_elements(:class, 'field')
    fields[0].find_element(:class, 'Select__control')
  end

  def group_by_field_menu(option)
    fields = @selenium.find_elements(:class, 'field')
    menu = fields[0].find_element(:class, 'Select')
    options = menu.find_elements(:class, 'Select__option')

    options.each do |object|
      return object if object.text == option
    end
  end

  def first_sort_by_field_control
    fields = @selenium.find_elements(:class, 'field')
    fields[1].find_element(:class, 'Select__control')
  end

  def first_sort_by_field_menu(option)
    fields = @selenium.find_elements(:class, 'field')
    menu = fields[1].find_element(:class, 'Select')
    options = menu.find_elements(:class, 'Select__option')

    options.each do |object|
      return object if object.text == option
    end
  end

  def second_sort_by_field_control
    fields = @selenium.find_elements(:class, 'field')
    fields[2].find_element(:class, 'Select__control')
  end

  def second_sort_by_field_menu(option)
    fields = @selenium.find_elements(:class, 'field')
    menu = fields[2].find_element(:class, 'Select')
    options = menu.find_elements(:class, 'Select__option')

    options.each do |object|
      return object if object.text == option
    end
  end

  def group_sort_window_checkboxes(selection)
    #selection can be 0, 1, or 2. With 0 being group_by, 1 being first sort, and 2 being second sort

    parent = @selenium.find_element(:class, 'fields')
    field = parent.find_elements(:class, 'field')
    input = field[selection].find_elements(:css, 'input')
    item_needed = nil
    (0..(input.count - 1)).each { |index|
      puts input[index].attribute('type')
      if input[index].attribute('type') == 'checkbox'
        item_needed = input[index]
        break
      end
    }
    return item_needed
  end

  def group_by_field_options
    optionsText = []
    fields = @selenium.find_elements(:class, 'field')
    menu = fields[0].find_element(:class, 'Select')
    options = menu.find_elements(:class, 'Select__option')
    options.each do |object|
      optionsText.push object.text
    end
      return optionsText
  end

end
