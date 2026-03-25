# frozen_string_literal: true

Dir["#{File.dirname(__FILE__)}/../*.rb"].sort.each { |file| require file }

class ECG_Screen
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

  def ecg_toolbar
    @selenium.find_element(:class, 'ecg-toolbar')
  end

  def second_ecg_toolbar
    parent = @selenium.find_element(:css, 'div.ecg.widget')
    parent.find_element(:class, 'ecg-toolbar')
  end

  def list_option_toolbar
    tool_bar = @selenium.find_element(:class, 'ecg-toolbar')
    tool_bar.find_element(:class, 'list-option')
  end

  def second_ecg_list_option_toolbar
    tool_bar = @selenium.find_elements(:class, 'ecg-toolbar')
    tool_bar[1].find_element(:class, 'list-option')
  end

  def waveform_toolbar
    tool_bar = @selenium.find_element(:class, 'ecg-toolbar')
    tool_bar.find_element(:class, 'waveform-tool')
  end

  def waveform_list
    ecg_body = @selenium.find_element(:class, 'ecg-body')
    ecg_body.find_element(:class, 'waveform-list')
  end

  def waveform_toolbar_lead(lead_text)
    waveform_list = @selenium.find_element(:class, 'waveform-list')
    leads = waveform_list.find_elements(:class, 'waveform-item')

    (0..(leads.count - 1)).each do |i|
      lead = leads[i].find_element(:class, 'title')
      return leads[i] if lead.text == lead_text
    end
  end

  def waveform_toolbar_close
    waveform_list = @selenium.find_element(:class, 'waveform-list')
    waveform_list.find_element(:class, 'close')
  end

  def second_waveform_toolbar
    tool_bar = @selenium.find_elements(:class, 'ecg-toolbar')
    tool_bar[1].find_element(:class, 'waveform-tool')
  end

  def second_waveform_list
    ecg_body = @selenium.find_elements(:class, 'ecg-body')
    ecg_body[1].find_element(:class, 'waveform-list')
  end

  def second_waveform_toolbar_lead(lead_text)
    waveform_list = @selenium.find_elements(:class, 'waveform-list')
    leads = waveform_list[1].find_elements(:class, 'waveform-item')

    (0..(leads.count - 1)).each do |i|
      lead = leads[i].find_element(:class, 'title')
      return leads[i] if lead.text == lead_text
    end
  end

  def second_waveform_toolbar_close
    waveform_list = @selenium.find_elements(:class, 'waveform-list')
    waveform_list[1].find_element(:class, 'close')
  end

  def info_toolbar
    tool_bar = @selenium.find_element(:class, 'ecg-toolbar')
    tool_bar.find_element(:class, 'icon-info')
  end

  def second_info_toolbar
    tool_bar = @selenium.find_elements(:class, 'ecg-toolbar')
    tool_bar[1].find_element(:class, 'icon-info')
  end

  def ecg_detail_info_drawer
    @selenium.find_element(:css, 'div.ecg-detail.tool-drawer')
  end

  def second_ecg_detail_info_drawer
    drawer = @selenium.find_elements(:css, 'div.ecg-detail.tool-drawer')
    drawer[1]
  end

  def ecg_detail_object
    drawer = @selenium.find_elements(:css, 'div.ecg-detail.tool-drawer')
    body = drawer[0].find_element(:class, 'detail-body')
    date_time = body.find_element(:class, 'date-time')
    diagnosis = body.find_element(:class, 'diagnosis')
    patient_info = body.find_element(:class, 'patient-info')
    stats = body.find_element(:class, 'stats')
    values = stats.find_elements(:css, 'td.value')

    {
      'object' => body,
      'date_time' => date_time,
      'diagnosis' => diagnosis,
      'patient_info' => patient_info,
      'stats' => stats,
      'vhr' => values[0],
      'pr' => values[1],
      'qrs' => values[2],
      'prt' => values[3],
      'ahr' => values[4],
      'qt' => values[5],
      'qtc' => values[6]
    }
  end

  def compare_ecg_detail_object
    drawer = @selenium.find_elements(:css, 'div.ecg-detail.tool-drawer')
    body = drawer[1].find_element(:class, 'detail-body')
    date_time = body.find_element(:class, 'date-time')
    diagnosis = body.find_element(:class, 'diagnosis')
    patient_info = body.find_element(:class, 'patient-info')
    stats = body.find_element(:class, 'stats')
    values = stats.find_elements(:css, 'td.value')

    {
      'date_time' => date_time,
      'diagnosis' => diagnosis,
      'patient_info' => patient_info,
      'stats' => stats,
      'vhr' => values[0],
      'pr' => values[1],
      'qrs' => values[2],
      'prt' => values[3],
      'ahr' => values[4],
      'qt' => values[5],
      'qtc' => values[6]
    }
  end

  def ecg_list_drawer
    @selenium.find_element(:class, 'ecg-list')
  end

  def second_ecg_list_drawer
    parent = @selenium.find_element(:css, 'div.ecg.widget')
    parent.find_element(:class, 'ecg-list')
  end

  def ecg_list_all
    parent = @selenium.find_element(:class, 'ecg-list')
    children = parent.find_elements(:class, 'ecg-item')
  end

  def ecg_list(which)
    row = which.to_i - 1
    parent = @selenium.find_element(:class, 'ecg-list')
    children = parent.find_elements(:class, 'ecg-item')

    children[row.to_i]
  end

  def second_ecg_list(which)
    row = which.to_i - 1

    compare_mode = @selenium.find_element(:class, 'compare-mode')
    ecg_body = compare_mode.find_element(:class, 'ecg-body')
    ecg_widget = ecg_body.find_element(:class, 'widget')
    body = ecg_widget.find_element(:class, 'ecg-body')

    list = body.find_element(:class, 'ecg-list')
    children = list.find_elements(:class, 'ecg-item')

    children[row.to_i]
  end

  def ecg_banner
    @selenium.find
  end

  def first_ecg_banner
    compare_mode = @selenium.find_element(:class, 'compare-mode')
    ecg_body = compare_mode.find_element(:class, 'ecg-body')

    twelve_lead = ecg_body.find_element(:class, 'ecg-12-lead')
    ecg_header = twelve_lead.find_element(:class, 'ecg-header')
    header_info = ecg_header.find_element(:class, 'header-info')

    date = header_info.find_element(:class, 'date').text
    diagnosis = header_info.find_element(:class, 'diagnosis').text

    {
      'date' => date,
      'diagnosis' => diagnosis
    }
  end

  def second_ecg_banner
    compare_mode = @selenium.find_element(:class, 'compare-mode')
    ecg_body = compare_mode.find_element(:class, 'ecg-body')
    ecg_widget = ecg_body.find_element(:class, 'widget')
    body = ecg_widget.find_element(:class, 'ecg-body')
    twelve_lead = body.find_element(:class, 'ecg-12-lead')
    ecg_header = twelve_lead.find_element(:class, 'ecg-header')
    header_info = ecg_header.find_element(:class, 'header-info')

    date = header_info.find_element(:class, 'date').text
    diagnosis = header_info.find_element(:class, 'diagnosis').text

    {
      'date' => date,
      'diagnosis' => diagnosis
    }
  end

  def twelve_lead_link
    @selenium.find_element(:xpath, "//a[@href='ecgs']")
  end

  def single_lead_link
    @selenium.find_element(:xpath, "//a[@href='ecgs/lead']")
  end

  def compare_link
    @selenium.find_element(:class, 'compare-link')
  end

  # def compare_link_disabled
  #  @selenium.find_element(:class, "compare-link")
  # end

  def ecg_header_info
    Selenium::WebDriver::Wait.new(timeout: DEFAULT_EXPLICIT_WAIT)
                             .until { @selenium.find_element(:class, 'ecg-12-lead').displayed? == true }
    ecg_twelve = @selenium.find_element(:class, 'ecg-12-lead')
    ecg_header = ecg_twelve.find_element(:class, 'ecg-header')
    header_info = ecg_header.find_element(:class, 'header-info')
    date = header_info.find_element(:class, 'date').text
    diagnosis = header_info.find_element(:class, 'diagnosis').text

    {
      'date' => date,
      'diagnosis' => diagnosis
    }
  end

  def ecg_list_details(which)
    row = which.to_i - 1
    parent = @selenium.find_element(:class, 'ecg-list')
    children = parent.find_elements(:class, 'ecg-item')

    date_time = children[row].find_element(:class, 'date-time')
    date = date_time.find_element(:class, 'date').text
    time = date_time.find_element(:class, 'time').text
    diagnosis = children[row].find_element(:class, 'diagnosis').text
    analysis = children[row].find_element(:class, 'analysis').text

    selected = false
    selected = true if children[row].attribute('className').include? 'selected'

    {
      'date'	=> date,
      'time'	=> time,
      'diagnosis'	=> diagnosis,
      'analysis'	=> analysis,
      'selected' => selected
    }
  end

  def ecg_list_object
    parent = @selenium.find_element(:class, 'ecg-list')
    ecg_rows = parent.find_elements(:class, 'ecg-item')
    ecg_count = ecg_rows.count

    ecg_date = []
    ecg_time = []
    ecg_diagnosis = []
    ecg_analysis = []

    (0..ecg_count - 1).each do |i|
      ecg_dt = ecg_rows[i].find_element(:class, 'date-time')
      ecg_date[i] = ecg_dt.find_element(:class, 'date').text
      ecg_time[i] = ecg_dt.find_element(:class, 'time').text
      ecg_diagnosis[i] = ecg_rows[i].find_element(:class, 'diagnosis').text
      ecg_analysis[i] = ecg_rows[i].find_element(:class, 'analysis').text
    end

    {
      'ecg_count' => ecg_count,
      'ecg_date' => ecg_date,
      'ecg_time' => ecg_time,
      'ecg_diagnosis' => ecg_diagnosis,
      'ecg_analysis' => ecg_analysis
    }
  end

  def second_ecg_list_details(which)
    row = which.to_i - 1
    compare_mode = @selenium.find_element(:class, 'compare-mode')
    ecg_body = compare_mode.find_element(:class, 'ecg-body')
    ecg_widget = ecg_body.find_element(:class, 'widget')
    body = ecg_widget.find_element(:class, 'ecg-body')

    parent = body.find_element(:class, 'ecg-list')
    children = parent.find_elements(:class, 'ecg-item')

    date_time = children[row].find_element(:class, 'date-time')
    date = date_time.find_element(:class, 'date').text
    time = date_time.find_element(:class, 'time').text
    diagnosis = children[row].find_element(:class, 'diagnosis').text
    analysis = children[row].find_element(:class, 'analysis').text

    selected = false
    selected = true if children[row].attribute('className').include? 'selected'

    {
      'date'	=> date,
      'time'	=> time,
      'diagnosis'	=> diagnosis,
      'analysis'	=> analysis,
      'selected' => selected
    }
  end

  def three_second_lead_element(which)
    ecg_grid = @selenium.find_element(:class, 'ecg-grid')
    rows = ecg_grid.find_elements(:class, 'canvas-holder')

    (0..(rows.count - 1)).each do |i|
      title = rows[i].find_element(:class, 'title')
      scale_key = nil
      scale_key = rows[i].find_element(:class, 'scale-key') if title.text == 'I'

      if title.text == which
        return {
          'ecg_cell' => rows[i],
          'title' => title,
          'scale_key' => scale_key
        }
      end
    end
  end

  def sc_three_second_lead_element(which)
    ecg_grid = @selenium.find_elements(:class, 'ecg-grid')
    rows = ecg_grid[1].find_elements(:class, 'canvas-holder')

    (0..(rows.count - 1)).each do |i|
      title = rows[i].find_element(:class, 'title')
      scale_key = nil
      scale_key = rows[i].find_element(:class, 'scale-key') if title.text == 'I'

      if title.text == which
        return {
          'ecg_cell' => rows[i],
          'title' => title,
          'scale_key' => scale_key
        }
      end
    end
  end

  def ten_second_lead_element(which = nil)
    rhythm_grid = @selenium.find_element(:class, 'strips')
    rhythm_strips = rhythm_grid.find_elements(:class, 'rhythm-strip')

    if !which.nil?
      (0..(rhythm_strips.count - 1)).each do |i|
        title = rhythm_strips[i].find_element(:class, 'title')
        scale_key = nil
        scale_key = rhythm_strips[i].find_element(:class, 'scale-key') if title.text == 'I'

        if title.text == which
          return {
            'ecg_cell' => rhythm_strips[i],
            'title' => title,
            'scale_key' => scale_key
          }
        end
      end
    else
      {
        'count' => rhythm_strips.count
      }
    end
  end

  def sc_ten_second_lead_element(which = nil)
    rhythm_grid = @selenium.find_elements(:class, 'strips')
    rhythm_strips = rhythm_grid[1].find_elements(:class, 'rhythm-strip')

    if !which.nil?
      (0..(rhythm_strips.count - 1)).each do |i|
        title = rhythm_strips[i].find_element(:class, 'title')
        scale_key = nil
        scale_key = rhythm_strips[i].find_element(:class, 'scale-key') if title.text == 'I'

        if title.text == which
          return {
            'ecg_cell' => rhythm_strips[i],
            'title' => title,
            'scale_key' => scale_key
          }
        end
      end
    else
      {
        'count' => rhythm_strips.count
      }
    end
  end

  def zoom_lead_text(_which)
    ecg_grid = @selenium.find_element(:class, 'ecg-grid')
    row = ecg_grid.find_element(:class, 'canvas-holder')

    scale_key = row.find_element(:class, 'scale-key')
    title = row.find_element(:class, 'title')

    {
      'title' => title,
      'scale_key' => scale_key
    }
  end

  def second_zoom_lead_text(_which)
    ecg_grid = @selenium.find_elements(:class, 'ecg-grid')
    row = ecg_grid[1].find_element(:class, 'canvas-holder')

    scale_key = row.find_element(:class, 'scale-key')
    title = row.find_element(:class, 'title')

    {
      'title' => title,
      'scale_key' => scale_key
    }
  end

  def zoom_lead
    ecg_grid = @selenium.find_element(:class, 'ecg-grid')
    ecg_grid.find_element(:class, 'canvas-holder')
  end

  def ecgPrevious_button
    @selenium.find_element(:class, 'prev')
  end

  def sc_ecgPrevious_button
    buttons = @selenium.find_elements(:class, 'prev')
    buttons[1]
  end

  def ecgNext_button
    @selenium.find_element(:class, 'next')
  end

  def sc_ecgNext_button
    buttons = @selenium.find_elements(:class, 'next')
    buttons[1]
  end

  def ecgScrubber_div
    @selenium.find_element(:class, 'scrubber')
  end

  def ecgScrubberHandleStart_div
    @selenium.find_element(:css, 'div.drag-handle.start.react-draggable')
  end

  def ecgScrubberHandleEnd_div
    @selenium.find_element(:css, 'div.drag-handle.end.react-draggable')
  end

  def serialComparsionStatement_div
    @selenium.find_element(:css, 'div.non-compare-warning')
  end

  def header_stats(which_ecg)
    stats = @selenium.find_elements(:css, 'div.header-stats')

    stats[which_ecg]
  end

  def caliper_distance
    main = @selenium.find_element(:css, '.caliper-distance')
    main.find_element(:css, 'div')
  end

  def caliper(which)
    calipers = @selenium.find_elements(:css, '.marker')
    case which
    when 'left'
      calipers[0]
    when 'right'
      calipers[1]
    when 'top'
      calipers[0]
    when 'bottom'
      calipers[1]
    end
  end

  def timeCaliperToolbar_button
    calipers = @selenium.find_elements(:class, 'calipers')
    calipers[0]
  end

  def voltageCaliperToolbar_button
    calipers = @selenium.find_elements(:class, 'calipers')
    calipers[1]
  end

  def toolsToolbar_label
    toolbar = @selenium.find_element(:class, 'ecg-toolbar')
    toolbar.find_element(:class, 'label')
  end

  def enableMarchOut_switch
    toggle = @selenium.find_element(:class, 'march-out-toggle')
    status = toggle.find_element(:class, 'onoffswitch-checkbox')
    switch = toggle.find_element(:class, 'onoffswitch')

    {
      'status' => status,
      'switch' => switch
    }
  end

  def ecg_loader
    @selenium.find_element(:class, 'loader')
  end

  def edit_button
    button = @selenium.find_element(:class, 'edit')
    disabled = false

    disabled = true if button.attribute('className').include? 'disabled'

    {
      'button_obj' => button,
      'disabled' => disabled
    }
  end

  def expand_ecgdetails_icon(which)
    header = @selenium.find_elements(:class, 'header-info')
    diagnosis = header[which].find_element(:class, 'diagnosis')
    diagnosis.find_element(:css, 'img.icon')
  end

  def expanded_ecg_detail_header
    details = @selenium.find_element(:class, 'ecg-details')
    # date_time = details.find_element(:class, "date-time")
    diagnosis = details.find_element(:class, 'analysis')
    patient_info = details.find_element(:class, 'patient-info')
    stats = details.find_element(:class, 'stats')
    values = stats.find_elements(:css, 'td.value')

    {
      # "date_time" => date_time,
      'diagnosis' => diagnosis,
      'patient_info' => patient_info,
      'stats' => stats,
      'vhr' => values[0],
      'pr' => values[1],
      'qrs' => values[2],
      'prt' => values[3],
      'ahr' => values[4],
      'qt' => values[5],
      'qtc' => values[6]
    }
  end
end
