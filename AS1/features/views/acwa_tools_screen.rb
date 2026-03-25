Dir["#{File.dirname(__FILE__)}/../*.rb"].sort.each { |file| require file }

class ACWA_Tools_Screen
  def initialize(selenium)
    @selenium = selenium
  end

  def patientInfo_header
    patient_info = @selenium.find_element(:class, 'patient-info')
    name = patient_info.find_element(:css, 'div.name').text
    age = patient_info.find_element(:css, 'span.age').text
    info = patient_info.find_element(:class, 'info').text

    diff = name.length - age.length

    {
      'name' => name[0..diff - 2],
      'age' => age,
      'info' => info
    }
  end

  def acwa_tools_chart_container
    container = @selenium.find_element(:class, 'acwa-tools-chart-container')
    return container
  end
  
  def measure_button
    vertical_toolbar = @selenium.find_element(:class, 'vertical-toolbar')
    button = vertical_toolbar.find_element(:class, 'measure-button')
    tooltip = button.find_element(:class, 'toolbar-tooltip')

    return {
        'button' => button,
        'tooltip' => tooltip
      }
  end

  def calipers_button
    button = @selenium.find_element(:class, 'calipers-button')
    tooltip = button.find_element(:class, 'toolbar-tooltip')

    return {
        'button' => button,
        'tooltip' => tooltip
      }
  end

  def pvc_button
    button = @selenium.find_element(:class, 'pvc-button')
    tooltip = button.find_element(:class, 'toolbar-tooltip')

    return {
        'button' => button,
        'tooltip' => tooltip
      }
  end

  def march_out_button
    button = @selenium.find_element(:class, 'march-out-button')
    tooltip = button.find_element(:class, 'toolbar-tooltip')

    return {
        'button' => button,
        'tooltip' => tooltip
      }
  end

  def papermode_button
    button = @selenium.find_element(:class, 'paper-mode-button')
    tooltip = button.find_element(:class, 'toolbar-tooltip')

    return {
        'button' => button,
        'tooltip' => tooltip
      }
  end

  def chart_header_info_first_lead
    chart_container = @selenium.find_element(:class, 'acwa-tools-chart-container')
    tools_chart = chart_container.find_elements(:class, 'acwa-tools-chart')
    chart_header = tools_chart[0].find_element(:class, 'chart-header')

    heart_rate = chart_header.find_element(:class, 'heart-rate')

    calculated_distances = chart_header.find_element(:class, 'calc-distances')
    divs = calculated_distances.find_elements(:css, 'div')
    pr_label = divs[0].find_element(:class, 'label')
    pr = divs[0]
    qrs_label = divs[1].find_element(:class, 'label')
    qrs = divs[1]
    qt_label = divs[2].find_element(:class, 'label')
    qt = divs[2]
    qtc_label = divs[3].find_element(:class, 'label')
    qtc = divs[3]
    
    chart_header_time = chart_header.find_element(:class, 'timestamp')

    return {
        'heart_rate' => heart_rate,
        'pr_label' => pr_label,
        'pr' => pr,
        'qrs_label' => qrs_label,
        'qrs' => qrs,
        'qt_label' => qt_label,
        'qt' => qt,
        'qtc_label' => qtc_label,
        'qtc' => qtc,
        'chart_header_time' => chart_header_time
      }
  end

  def chart_header_info_second_lead
    chart_container = @selenium.find_element(:class, 'acwa-tools-chart-container')
    tools_chart = chart_container.find_elements(:class, 'acwa-tools-chart')
    chart_header = tools_chart[1].find_element(:class, 'chart-header')

    heart_rate = chart_header.find_element(:class, 'heart-rate')

    calculated_distances = chart_header.find_element(:class, 'calc-distances')
    divs = calculated_distances.find_elements(:css, 'div')
    pr_label = divs[0].find_element(:class, 'label')
    pr = divs[0]
    qrs_label = divs[1].find_element(:class, 'label')
    qrs = divs[1]
    qt_label = divs[2].find_element(:class, 'label')
    qt = divs[2]
    qtc_label = divs[3].find_element(:class, 'label')
    qtc = divs[3]
    
    chart_header_time = chart_header.find_element(:class, 'timestamp')

    return {
        'heart_rate' => heart_rate,
        'pr_label' => pr_label,
        'pr' => pr,
        'qrs_label' => qrs_label,
        'qrs' => qrs,
        'qt_label' => qt_label,
        'qt' => qt,
        'qtc_label' => qtc_label,
        'qtc' => qtc,
        'chart_header_time' => chart_header_time
      }
  end

  def chart_body_info_lead_one
    chart_container = @selenium.find_element(:class, 'acwa-tools-chart-container')
    tools_chart = chart_container.find_elements(:class, 'acwa-tools-chart')
    chart_body = tools_chart[0].find_element(:class, 'chart')

    monitor_chart = chart_body.find_element(:class, 'monitor-chart')
    ecg_label = monitor_chart.find_element(:class, 'label')

    zoom_control = chart_body.find_element(:class, 'zoom-control')

    calipers = chart_body.find_elements(:class, 'caliper')
    p_caliper = calipers[0]
    p_caliper_handle = calipers[0].find_element(:class, 'handle')
    p_caliper_label = p_caliper_handle.find_element(:class, 'label')
    p_caliper_strike = p_caliper_handle.find_element(:class, 'pvc-strike')

    qr_caliper = calipers[1]
    qr_caliper_handle = calipers[1].find_element(:class, 'handle')
    qr_caliper_label = qr_caliper_handle.find_element(:class, 'label')
    qr_caliper_strike = qr_caliper_handle.find_element(:class, 'pvc-strike')

    qrs_complex = calipers[2]
    qrs_complex_handle = calipers[2].find_element(:class, 'handle')
    qrs_complex_label = qrs_complex_handle.find_element(:class, 'label')
    #qrs_complex_strike = qrs_complex_handle.find_element(:class, 'pvc-strike')

    s_caliper = calipers[3]
    s_caliper_handle = calipers[3].find_element(:class, 'handle')
    s_caliper_label = s_caliper_handle.find_element(:class, 'label')
    s_caliper_strike = s_caliper_handle.find_element(:class, 'pvc-strike')

    t_caliper = calipers[4]
    t_caliper_handle = calipers[4].find_element(:class, 'handle')
    t_caliper_label = t_caliper_handle.find_element(:class, 'label')
    t_caliper_strike = t_caliper_handle.find_element(:class, 'pvc-strike')

    return {
      'ecg_label' => ecg_label,
      'zoom_control' => zoom_control,
      'p_caliper' => p_caliper,
      'p_caliper_handle' => p_caliper_handle,
      'p_caliper_label' => p_caliper_label,
      'p_caliper_strike' => p_caliper_strike,
      'qr_caliper' => qr_caliper,
      'qr_caliper_handle' => qr_caliper_handle,
      'qr_caliper_label' => qr_caliper_label,
      'qr_caliper_strike' => qr_caliper_strike,
      'qrs_complex' => qrs_complex,
      'qrs_complex_handle' => qrs_complex_handle,
      'qrs_complex_label' => qrs_complex_label,
      #'qrs_complex_strike' => qrs_complex_strike,
      's_caliper' => s_caliper,
      's_caliper_handle' => s_caliper_handle,
      's_caliper_label' => s_caliper_label,
      's_caliper_strike' => s_caliper_strike,
      't_caliper' => t_caliper,
      't_caliper_handle' => t_caliper_handle,
      't_caliper_label' => t_caliper_label,
      't_caliper_strike' => t_caliper_strike
    }
  end

  def chart_body_info_lead_two
    chart_container = @selenium.find_element(:class, 'acwa-tools-chart-container')
    tools_chart = chart_container.find_elements(:class, 'acwa-tools-chart')
    chart_body = tools_chart[1].find_element(:class, 'chart')

    monitor_chart = chart_body.find_element(:class, 'monitor-chart')
    ecg_label = monitor_chart.find_element(:class, 'label')

    zoom_control = chart_body.find_element(:class, 'zoom-control')

    calipers = chart_body.find_elements(:class, 'caliper')
    p_caliper = calipers[0]
    p_caliper_handle = calipers[0].find_element(:class, 'handle')
    p_caliper_label = p_caliper_handle.find_element(:class, 'label')
    p_caliper_strike = p_caliper_handle.find_element(:class, 'pvc-strike')

    qr_caliper = calipers[1]
    qr_caliper_handle = calipers[1].find_element(:class, 'handle')
    qr_caliper_label = qr_caliper_handle.find_element(:class, 'label')
    qr_caliper_strike = qr_caliper_handle.find_element(:class, 'pvc-strike')

    qrs_complex = calipers[2]
    qrs_complex_handle = calipers[2].find_element(:class, 'handle')
    qrs_complex_label = qrs_complex_handle.find_element(:class, 'label')
    #qrs_complex_strike = qrs_complex_handle.find_element(:class, 'pvc-strike')

    s_caliper = calipers[3]
    s_caliper_handle = calipers[3].find_element(:class, 'handle')
    s_caliper_label = s_caliper_handle.find_element(:class, 'label')
    s_caliper_strike = s_caliper_handle.find_element(:class, 'pvc-strike')

    t_caliper = calipers[4]
    t_caliper_handle = calipers[4].find_element(:class, 'handle')
    t_caliper_label = t_caliper_handle.find_element(:class, 'label')
    t_caliper_strike = t_caliper_handle.find_element(:class, 'pvc-strike')

    return {
      'ecg_label' => ecg_label,
      'zoom_control' => zoom_control,
      'p_caliper' => p_caliper,
      'p_caliper_handle' => p_caliper_handle,
      'p_caliper_label' => p_caliper_label,
      'p_caliper_strike' => p_caliper_strike,
      'qr_caliper' => qr_caliper,
      'qr_caliper_handle' => qr_caliper_handle,
      'qr_caliper_label' => qr_caliper_label,
      'qr_caliper_strike' => qr_caliper_strike,
      'qrs_complex' => qrs_complex,
      'qrs_complex_handle' => qrs_complex_handle,
      'qrs_complex_label' => qrs_complex_label,
      #'qrs_complex_strike' => qrs_complex_strike,
      's_caliper' => s_caliper,
      's_caliper_handle' => s_caliper_handle,
      's_caliper_label' => s_caliper_label,
      's_caliper_strike' => s_caliper_strike,
      't_caliper' => t_caliper,
      't_caliper_handle' => t_caliper_handle,
      't_caliper_label' => t_caliper_label,
      't_caliper_strike' => t_caliper_strike
    }
  end

  def rhythm_strip_info_lead_one
    chart_container = @selenium.find_element(:class, 'acwa-tools-chart-container')
    tools_chart = chart_container.find_elements(:class, 'acwa-tools-chart')
    rhythm_strip = tools_chart[0].find_element(:class, 'rhythm-strip')

    drag_handles = rhythm_strip.find_elements(:class, 'drag-handle')
    left_handle = drag_handles[0]
    right_handle = drag_handles[1]

    calipers = rhythm_strip.find_elements(:class, 'caliper')
    p_caliper = calipers[0]
    p_caliper_handle = calipers[0].find_element(:class, 'handle')
    qr_caliper = calipers[1]
    qr_caliper_handle = calipers[1].find_element(:class, 'handle')
    qrs_complex = calipers[2]
    qrs_complex_handle = calipers[2].find_element(:class, 'handle')
    s_caliper = calipers[3]
    s_caliper_handle = calipers[3].find_element(:class, 'handle')
    t_caliper = calipers[4]
    t_caliper_handle = calipers[4].find_element(:class, 'handle')

    return {
      'left_handle' => left_handle,
      'right_handle' => right_handle,
      'p_caliper' => p_caliper,
      'p_caliper_handle' => p_caliper_handle,
      'qr_caliper' => qr_caliper,
      'qr_caliper_handle' => qr_caliper_handle,
      'qrs_complex' => qrs_complex,
      'qrs_complex_handle' => qrs_complex_handle,
      's_caliper' => s_caliper,
      's_caliper_handle' => s_caliper_handle,
      't_caliper' => t_caliper,
      't_caliper_handle' => t_caliper_handle    
    }
  end

  def rhythm_strip_info_lead_two
    chart_container = @selenium.find_element(:class, 'acwa-tools-chart-container')
    tools_chart = chart_container.find_elements(:class, 'acwa-tools-chart')
    rhythm_strip = tools_chart[1].find_element(:class, 'rhythm-strip')

    drag_handles = rhythm_strip.find_elements(:class, 'drag-handle')
    left_handle = drag_handles[0]
    right_handle = drag_handles[1]

    calipers = rhythm_strip.find_elements(:class, 'caliper')
    p_caliper = calipers[0]
    p_caliper_handle = calipers[0].find_element(:class, 'handle')
    qr_caliper = calipers[1]
    qr_caliper_handle = calipers[1].find_element(:class, 'handle')
    qrs_complex = calipers[2]
    qrs_complex_handle = calipers[2].find_element(:class, 'handle')
    s_caliper = calipers[3]
    s_caliper_handle = calipers[3].find_element(:class, 'handle')
    t_caliper = calipers[4]
    t_caliper_handle = calipers[4].find_element(:class, 'handle')

    return {
      'left_handle' => left_handle,
      'right_handle' => right_handle,
      'p_caliper' => p_caliper,
      'p_caliper_handle' => p_caliper_handle,
      'qr_caliper' => qr_caliper,
      'qr_caliper_handle' => qr_caliper_handle,
      'qrs_complex' => qrs_complex,
      'qrs_complex_handle' => qrs_complex_handle,
      's_caliper' => s_caliper,
      's_caliper_handle' => s_caliper_handle,
      't_caliper' => t_caliper,
      't_caliper_handle' => t_caliper_handle
    }
  end

  def frat_controls_object  
    clock_and_tools = @selenium.find_element(:class, 'clock-and-tools-wrapper')
    controls = clock_and_tools.find_element(:class, 'controls')
    select_controls = controls.find_elements(:class, 'Select')
    lead_one_ecg = select_controls[0]
    lead_two_ecg = select_controls[1]
    event_description = select_controls[3]
    create_frat_record_button = controls.find_element(:class, 'create-statement')

    return {
      'lead_one_ecg' => lead_one_ecg,
      'lead_two_ecg' => lead_two_ecg,
      'event_description' => event_description,
      'create_frat_record_button' => create_frat_record_button
    }
  end

  def record_created_window_object
    container = @selenium.find_element(:class, 'swal2-container')
    header = container.find_element(:class, 'swal2-header')
    message = header.find_element(:class, 'swal2-title')
    #actions = container.find_element(:class, 'swal2-actions')
    close_button = container.find_element(:class, 'swal2-cancel')

    return {
      'header' => header,
      'message' => message,
      'close_button' => close_button
    }
  end

  def controls_dropdown_object
    controls = @selenium.find_element(:class, 'controls')
    parent = controls.find_elements(:class, 'Select')
    first_lead_indicator = parent[0].find_element(:class, 'Select__indicator')
    second_lead_indicator = parent[1].find_element(:class, 'Select__indicator')
    event_description_indicator = parent[2].find_element(:class, 'Select__indicator')

    return {
      'first_lead_indicator' =>  first_lead_indicator,
      'second_lead_indicator' =>  second_lead_indicator,
      'event_description_indicator' =>  event_description_indicator
    }
  end

  def lead_one_list_box(name)
    controls = @selenium.find_element(:class, 'controls')
    parent = controls.find_elements(:class, 'Select')
    list = parent[0].find_element(:class, 'Select__menu-list')
    values = list.find_elements(:css, 'div')

    (0..values.count - 1).each do |x|
      label = list.find_elements(:css, 'div')
      puts label[x].text if INFO == true
      return label[x] if label[x].text.include? name
    end
  end

  def lead_two_list_box(name)
    controls = @selenium.find_element(:class, 'controls')
    parent = controls.find_elements(:class, 'Select')
    list = parent[1].find_element(:class, 'Select__menu-list')
    values = list.find_elements(:css, 'div')

    (0..values.count - 1).each do |x|
      label = list.find_elements(:css, 'div')
      puts label[x].text if INFO == true
      return label[x] if label[x].text.include? name
    end
  end

  def event_description_list_box(name)
    controls = @selenium.find_element(:class, 'controls')
    parent = controls.find_elements(:class, 'Select')
    list = parent[2].find_element(:class, 'Select__menu-list')
    values = list.find_elements(:css, 'div')

    (0..values.count - 1).each do |x|
      label = list.find_elements(:css, 'div')
      puts label[x].text if INFO == true
      return label[x] if label[x].text.include? name
    end
  end
end
