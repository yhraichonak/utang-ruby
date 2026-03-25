# frozen_string_literal: true

Dir["#{File.dirname(__FILE__)}/../*.rb"].sort.each { |file| require file }

class SnippetTool_Screen
  def initialize(selenium)
    @selenium = selenium
  end

  def snippet_widget
    @selenium.find_element(:css, 'div.monitor.snippets.widget')
  end

  def selectOption1_control
    controls = @selenium.find_element(:css, '.controls')
    fields = controls.find_elements(:css, '.Select')
    control_obj = fields[0].find_element(:css, '.Select-control, .Select__control')
    label = control_obj.find_element(:css, '.Select-value-label, .Select__value-container')

    {
      'control_obj' => control_obj,
      'label' => label
    }
  end

  def selectOption2_control
    controls = @selenium.find_element(:css, '.controls')
    fields = controls.find_elements(:css, '.Select')
    control_obj = fields[1].find_element(:css, '.Select-control, .Select__control')
    label = control_obj.find_element(:css, '.Select-value-label, .Select__value-container')

    {
      'control_obj' => control_obj,
      'label' => label
    }
  end

  def selectOption3_control
    controls = @selenium.find_element(:css, '.controls')
    fields = controls.find_elements(:css, '.Select')
    puts "fields count = #{fields.count}"
    control_obj = fields[2].find_element(:css, '.Select-control, .Select__control')
    label = control_obj.find_element(:css, '.Select-value-label, .Select__value-container')

    {
      'control_obj' => control_obj,
      'label' => label
    }
  end

  def selectOption_menu(option)
    options = selectOptions_menu()
    options.each do |object|
      return object if object.text.end_with?(option)
    end
  end

  def selectOptions_menu()
    menu = @selenium.find_element(:css, '.Select-menu-outer, .Select__menu')
    options = menu.find_elements(:css, '.Select-option, .Select__option')
    return options
  end

  def measure_button
    controls = @selenium.find_element(:css, '.marker-controls')
    group = controls.find_element(:css, '.button-group')
    buttons = group.find_elements(:css, 'button')

    buttons.each do |button|
      return button if button.text == 'Measure'
    end
  end

  def calipers_button
    controls = @selenium.find_element(:css, '.marker-controls')
    group = controls.find_element(:css, '.button-group')
    buttons = group.find_elements(:css, 'button')

    buttons.each do |button|
      return button if button.text == 'Calipers'
    end
  end

  def marchout_toggle
    controls = @selenium.find_element(:css, '.marker-controls')
    toggles = controls.find_elements(:css, '.toggle')
    switch = toggles[0].find_element(:css, '.onoffswitch')
    checkbox = switch.find_element(:css, '.onoffswitch-checkbox')

    disabled = if toggles[0].attribute('className').include? 'disabled'
                 true
               else
                 false
               end

    {
      'toggle_obj' => switch,
      'disabled' => disabled,
      'buttonOn' => checkbox.selected?
    }
  end

  def paperMode_toggle
    controls = @selenium.find_element(:css, '.marker-controls')
    toggles = controls.find_elements(:css, '.toggle')
    switch = toggles[1].find_element(:css, '.onoffswitch')
    checkbox = switch.find_element(:css, '.onoffswitch-checkbox')

    disabled = nil

    if toggles[1].attribute('className').include? 'disabled'
      disabled = true
    else
      disabled = false
    end


    #puts "the disabled = #{disabled}"
    {
      'toggle_obj' => switch,
      'disabled' => disabled,
      'buttonOn' => checkbox.selected?
    }
  end

  def createSnippet_button
    create_button = @selenium.find_element(:class, 'create-statement')
    return create_button
  end

  def chart_window
    @selenium.find_element(:css, '.chart')
  end

  def chart_wave_label(wave_number)
    chart = @selenium.find_element(:css, '.chart')
    waves = chart.find_elements(:css, '.monitor-chart')
    waves[wave_number - 1].find_element(:css, 'div.label')
  end

  def rhythm_strip
    @selenium.find_element(:css, '.rhythm-strip')
  end

  def rhythm_strip_handle_start
    rhythm_strip = @selenium.find_element(:css, '.rhythm-strip')
    rhythm_strip.find_element(:css, 'div.drag-handle.start.react-draggable')
  end

  def rhythm_strip_handle_end
    rhythm_strip = @selenium.find_element(:css, '.rhythm-strip')
    rhythm_strip.find_element(:css, 'div.drag-handle.end.react-draggable')
  end

  def snippet_heartrate
    chart_header = @selenium.find_element(:class, 'chart-header')
    hr = chart_header.find_element(:css, '.heart-rate')
    return hr
  end

  def snippet_date
    @selenium.find_element(:css, '.date')
  end

  def snippet_time
    time = @selenium.find_elements(:css, '.timestamp')
    time[0]
  end

  def rhythmScript_timestamp
    time = @selenium.find_elements(:css, '.timestamp')
    time[1]
  end

  def calc_distance_values
    main = @selenium.find_element(:css, '.calc-distances')
    values = main.find_elements(:css, 'div')

    pr = values[0].text
    qrs = values[1].text
    qt = values[2].text
    qtc = nil

    qtc = values[3].text if values.size > 3

    {
      'calc_obj' => main,
      'PR' => pr,
      'QRS' => qrs,
      'QT' => qt,
      'QTc' => qtc
    }
  end

  def measureCaliper(label)
    calipers = @selenium.find_elements(:css, '.caliper')
    (0..(calipers.count - 1)).each do |x|
      handle = calipers[x].find_element(:css, '.handle')
      #puts handle.text
      return calipers[x] if handle.text == label
    end
  end

  def caliper_distance
    main = @selenium.find_element(:css, '.caliper-distance')
    main.find_element(:css, 'div')
  end

  def caliper(which)
    calipers = @selenium.find_elements(:css, '.caliper')
    case which
    when 'left'
      calipers[1]
    when 'right'
      calipers[0]
    end
  end

  def snippet_zoom
    monitor = @selenium.find_element(:css, '.chart')
    zoom = monitor.find_element(:css, '.zoom-control')
    zoom.find_element(:css, 'input')
  end

  def overflow_control
    @selenium.find_element(:class, 'icon-gear')
  end

  def indicators
    mobile_ind = @selenium.find_element(:class, 'mobile-indicators')
    mobile_ind.find_elements(:class, 'indicator')
  end

  def tools_chart_canvas
    monitor_body = @selenium.find_element(:class, 'monitor-body')
    chart = monitor_body.find_element(:class, 'chart')
    canvas = chart.find_element(:css, 'canvas')
  end

  def boundary_marker(option)
    rhythm_strip = @selenium.find_element(:class, 'rhythm-strip')
    left_boundary_marker = rhythm_strip.find_element(:css, 'div.drag-handle.start.react-draggable')
    right_boundary_marker = rhythm_strip.find_element(:css, 'div.drag-handle.end.react-draggable')

    case option
    when 'left'
      return left_boundary_marker
    when 'right'
      return right_boundary_marker
    end
  end

  def rhythm_strip
    @selenium.find_element(:class, 'rhythm-strip')
  end

  def rhythm_strip_timestamp
    rhythm_strip.find_element(:class, 'timestamp').text
  end

  def waveform_length_number
    dropdown_elements = @selenium.find_elements(:class, 'Select__single-value')
    waveform_length_string = dropdown_elements[2].text
    waveform_split = waveform_length_string.split(' ', 2)
    return waveform_split[0].to_f
  end

  def error_window
    window = @selenium.find_element(:class, 'swal2-header')
    title = window.find_element(:class, 'swal2-title')
    ok_button = window.find_element(:tag_name, 'button')
    return {
      'title' => title,
      'button' => ok_button
    }
  end
end
