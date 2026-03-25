# frozen_string_literal: true

Dir["#{File.dirname(__FILE__)}/../*.rb"].sort.each { |file| require file }

class SnippetDocEdit_Screen
  def initialize(selenium)
    @selenium = selenium
  end

  def createStatement_window
    @selenium.find_element(:css, 'div.widget.create-statement')
  end

  def patient_name_header
    @selenium.find_element(:css, 'div.patient-info .name')
  end

  def patient_information_header
    @selenium.find_element(:css, 'div.patient-info .info')
  end

  def preview_button
    @selenium.find_element(:css, 'div.actions').find_element(:xpath, './/button[.="Preview"]')
  end

  def save_button
    @selenium.find_element(:css, 'div.actions').find_element(:xpath, './/button[.="Save"]')
  end

  def cancel_button
    @selenium.find_element(:css, 'div.actions').find_element(:xpath, './/button[.="Cancel"]')
  end

  def back_button
    actions = @selenium.find_element(:class, 'swal2-actions')
    #@selenium.find_element(:css, 'button.cancel.btn.secondary')
    button = actions.find_element(:class, 'swal2-cancel')
    return button
  end

  def snippet_not_saved_window
    title = @selenium.find_element(:class, 'swal2-title')
    title.find_element(:css, 'span')
  end

  def snippet_not_saved_leave_button
    @selenium.find_element(:class, 'swal2-confirm')
  end

  def event_description_dropdown_arrow
    @selenium.find_element(:class, 'Select__dropdown-indicator')
    # @selenium.find_element(:css, '.css-1wy0on6')
  end

  def event_description_input(type)
    # control = @selenium.find_element(:class, 'Select-control')
    # input =  control.find_element(:class, 'Select-input')
    # return input.find_element(:css, 'input')
    if type == 'input#react-select-2-input'
      @selenium.find_element(:css, type)
    else
      @selenium.find_element(:class, type)
    end
  end

  def event_description_select_placeholder
    @selenium.find_element(:class, 'Select__placeholder')
  end

  def event_description_select_input(name)
    # control = @selenium.find_element(:class, 'Select-control')
    # wrapper = control.find_element(:class, 'Select-multi-value-wrapper')
    values = @selenium.find_elements(:class, 'Select__multi-value__label')

    (0..values.count - 1).each do |x|
      return values[x] if values[x].text.include? name
    end
  end

  def event_description_listbox_count
    # menu = @selenium.find_element(:class, 'Select-menu-outer')
    # listbox = menu.find_element(:class, 'Select-menu')
    # options = listbox.find_elements(:class, 'Select-option')
    # return options.count
    list = @selenium.find_element(:css, '.css-11unzgr')
    values = list.find_elements(:css, 'div')
    values.count
  end

  def event_description_listbox(name)
    # menu = @selenium.find_element(:class, 'Select-menu-outer')
    # listbox = menu.find_element(:class, 'Select-menu')
    # options = listbox.find_elements(:class, 'Select-option')
    # for x in 0..options.count-1
    #  #puts options[x].text
    #  if options[x].text == name
    #    return options[x]
    #  end
    # end

    list = @selenium.find_element(:class, 'Select__menu-list')
    values = list.find_elements(:css, 'div')

    (0..values.count - 1).each do |x|
      label = list.find_elements(:css, 'div')
      puts label[x].text if INFO == true
      return label[x] if label[x].text.include? name
    end
  end

  def snippet_document_edit_heart_rate_value 
    measurements = @selenium.find_element(:class, 'fieldset')
    labels = measurements.find_elements(:css, 'label')
    
    (0..labels.count - 1).each do |x|
      case labels[x].text
      when "HR:"
        return labels[x].find_element(:css, 'input').attribute('value')
      end
    end     
  end

  def measurement_input(name)
    measurements = @selenium.find_element(:class, 'fieldset')
    labels = measurements.find_elements(:css, 'label')

    (0..labels.count - 1).each do |x|
      case labels[x].text
      when "#{name} (s):"
        return labels[x].find_element(:css, 'input')
      when "#{name}:"
        return labels[x].find_element(:css, 'input')
      end
    end
  end

  def all_leads_toggle
    toggle = @selenium.find_element(:class, 'toggle')
    switch = toggle.find_element(:class, 'onoffswitch')
    checkbox = switch.find_element(:class, 'onoffswitch-checkbox')

    {
      'toggle_obj' => switch,
      'buttonOn' => checkbox.selected?
    }
  end

  def edit_snippet_timestamp
    @selenium.find_element(:css, 'div.date')
  end

  def leads_time
    @selenium.find_element(:class, 'leads')
  end

  def waveform_div
    @selenium.find_element(:class, 'waveform')
  end

  def progress_bar
    @selenium.find_element(:class, 'progress-bar')
  end

  def progress_div
    @selenium.find_element(:class, 'progress')
  end

  def progress_count
    @selenium.find_element(:css, 'span.count')
  end

  def description_header
    createStatement_window = @selenium.find_element(:class, 'create-statement')
    createStatement_window.find_element(:css, 'h2')
  end

  def snippet_doc_type_selector
    @selenium.find_element(:class, 'snippet-doc-type-select')
  end

  def snippet_doc_type_selector_dropdown
    @selenium.find_element(:class, 'css-26l3qy-menu')
  end

  def snippet_doc_type_count
    menu = @selenium.find_element(:class, 'css-11unzgr')
    selectors = menu.find_elements(:css, 'div')

    (0..selectors.count - 1).each do |x|
      puts selectors[x].text if INFO == true
    end
    selectors.count
  end

  def snippet_doc_type_option(option)
    case option
    when 'PRN'
      optionNumber = 0
    when 'Admission Baseline'
      optionNumber = 1
    when 'Event'
      optionNumber = 2
    end

    @selenium.find_element(:class, "react-select-5-option-#{optionNumber}")
  end

  def measurement_label
    @selenium.find_element(:css, 'h3')
  end
end
