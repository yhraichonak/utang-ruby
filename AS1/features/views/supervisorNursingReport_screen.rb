# frozen_string_literal: true

Dir["#{File.dirname(__FILE__)}/../*.rb"].sort.each { |file| require file }

class SupervisorNursingReport_Screen
  def initialize(selenium)
    @selenium = selenium
  end

  def snippetReport_div
    @selenium.find_element(:class, 'snippet-report')
  end

  def snippetReport_header
    @selenium.find_element(:css, "div.table>div.header")
  end
  def from_datepicker
    @selenium.find_element(:css, 'div.date.start')
  end

  def from_datepicker_clear_button
    object = @selenium.find_element(:css, 'div.date.start')
    object.find_element(:css, 'button.react-datepicker__close-icon')
  end

  def to_datepicker
    @selenium.find_element(:css, 'div.date.end')
  end

  def to_datepicker_clear_button
    object = @selenium.find_element(:css, 'div.date.end')
    object.find_element(:css, 'button.react-datepicker__close-icon')
  end

  def from_bed_search
    object = @selenium.find_element(:css, 'div.filter.bed-filter')
    object.find_element(:css,  "input[placeholder='from']")
  end

  def to_bed_search
    object = @selenium.find_element(:css, 'div.filter.bed-filter')
    object.find_element(:css, "input[placeholder='to']")
  end

  def column_filter(filter_name)
    report = @selenium.find_element(:class, 'snippet-report')
    table = report.find_element(:class, 'table')
    tableHeader = table.find_element(:class, 'header')
    titleRow = tableHeader.find_elements(:css, 'div')
    columnSorts = titleRow[0].find_elements(:class, 'sortable')

    filterRows = tableHeader.find_element(:class, 'filters-row')
    filterObjects = filterRows.find_elements(:css, 'div.select__control')
    # selectIndicators = filterRows.find_elements(:css, ".select__indicators")

    clearIndicator = []
    dropDownIndicator = []
    # clearIndicator = tableRows[1].find_elements(:css, ".select__clear-indicator")
    sortOrder = []
    secondary = []

    (0..(columnSorts.count - 1)).each do |i|
      next unless columnSorts[i].text == filter_name

      # # simple fix for not filters for 2 columns
      # case filter_name
      # when 'Captured By'
      #   i -= 1
      # when 'Snippet Type'
      #   i -= 2
      # when 'Reviewed By'
      #   i -= 2
      # end

      begin
        selectIndicators = filterObjects[i].find_elements(:css, '.select__indicator')

        if selectIndicators.count > 1
          clearIndicator[i] = selectIndicators[0]
          dropDownIndicator[i] = selectIndicators[1]
        else
          clearIndicator[i] = nil
          dropDownIndicator[i] = selectIndicators[0]
        end
      rescue StandardError
        # continue; not all columns have filters/select indicators
      end

      sortOrder[i] = if columnSorts[i].attribute('className').include? 'desc'
                       'descending'
                     elsif columnSorts[i].attribute('className').include? 'sorted'
                       'ascending'
                     end

      secondary[i] = false

      secondary[i] = true if columnSorts[i].attribute('className').include? 'secondary'

      return {
        'filter_obj' => filterObjects[i],
        'header_obj' => columnSorts[i],
        'sortOrder' => sortOrder[i],
        'secondarySort' => secondary,
        'dropDownIndicator' => dropDownIndicator[i],
        'clearIndicator' => clearIndicator[i]
      }
    end
  end

  def selectOption_menu(option)
    menu = @selenium.find_element(:css, '.select-menu-outer, .select__menu')
    options = menu.find_elements(:css, '.select-option, .select__option')

    for i in 0..(options.count - 1)
      puts options[i].text
    end

    options.each do |object|
      return object if object.text == option
    end
  end

  def statusFilter_control
    controls = @selenium.find_element(:class, 'filters')
    fields = controls.find_elements(:css, '.select')
    puts fields.count
    control_obj = fields[0].find_element(:css, '.select__control')
    puts 'Yes2'
    label = control_obj.find_element(:css, '.select__value-container')
    puts 'Yes3'

    clearButton = nil

    if label.attribute('className').include? 'select__value-container--has-value'
      puts 'Yes'
      clearButton = control_obj.find_element(:css, '.select__clear-indicator')
    end

    {
      'control_obj' => control_obj,
      'label' => label,
      'clearButton' => clearButton
    }
  end

  def list_window
    @selenium.find_element(:class, 'list-window')
  end

  def reportData_body
    report = @selenium.find_element(:class, 'snippet-report')
    table = report.find_element(:class, 'list-window')
    tbody = table.find_element(:css, 'div')
    rows = tbody.find_elements(:class, 'row')

    view_link = []
    status = []
    patientName = []
    mrn = []
    unit = []
    bed = []
    capturedBy = []
    dateTime = []
    description = []
    snippetType = []
    reviewedBy = []

    rowcount = rows.count

    puts rowcount if INFO == true

    (0..(rows.count - 1)).each do |i|
      columns = rows[i].find_elements(:class, 'cell')

      viewLinkColumn = columns[0]
      view_link[i] = viewLinkColumn.find_element(:class, 'view-link')
      statusIcon = view_link[i].find_element(:css, '.todo')
      status[i] = if statusIcon.attribute('className').include? 'hidden'
                    'Saved'
                  elsif statusIcon.attribute('className').include? 'done'
                    'Approved'
                  elsif statusIcon.attribute('className').include? 'rejected'
                    puts "found rejected"
                    'Rejected'
                  else
                    'Unapproved'
                  end

      patientName[i] = columns[1]
      mrn[i] = columns[2]
      unit[i] = columns[3]
      bed[i] = columns[4]
      capturedBy[i] = columns[5]
      dateTime[i] = columns[6]
      description[i] = columns[7]
      snippetType[i] = columns[8]
      reviewedBy[i] = columns[9]
    end

    {
      'report_obj' => report,
      'rowcount' => rowcount,
      'view_link' => view_link,
      'status' => status,
      'patientName' => patientName,
      'mrn' => mrn,
      'unit' => unit,
      'bed' => bed,
      'capturedBy' => capturedBy,
      'dateTime' => dateTime,
      'description' => description,
      'snippetType' => snippetType,
      'reviewedBy' => reviewedBy
    }
  end

  def snippet_window_title
    @selenium.find_element(:id, 'swal2-title')
  end

  def snippet_window_content
    @selenium.find_element(:css, 'div.swal2-content')
  end

  def snippet_window_ok_button
    @selenium.find_element(:class, 'swal2-confirm')
  end

  def snippet_window_approve_button
    @selenium.find_element(:class, 'swal2-confirm')
  end

  def snippet_window_reject_button
    @selenium.find_element(:class, 'swal2-cancel')
  end

  def alert_window
    @selenium.find_element(:class, 'swal2-header')
  end

  def alert_title
    @selenium.find_element(:class, 'swal2-title')
  end

  def alert_content
    @selenium.find_element(:class, 'swal2-content')
  end

  def alert_reject_button
    @selenium.find_element(:class, 'swal2-confirm')
  end

  def alert_cancel_button
    @selenium.find_element(:class, 'swal2-cancel')
  end

  def hideShowColumns_button
    @selenium.find_element(:xpath, ".//button[contains(.,'Hide/Show Columns')]")
  end
  def show_top_panel
    if @selenium.find_element(:xpath, ".//div[@class='drawer-handle']").attribute("innerHTML").include? "angle-down"
        @selenium.find_element(:xpath, ".//div[@class='drawer-handle']").click
        sleep 1
        end
  end

  def toggleColumns_switches(column_name)
    window = @selenium.find_element(:class, 'swal2-content')
    toggles = window.find_elements(:css, '.toggle')

    toggles.each do |object|
      switch = object.find_element(:css, '.onoffswitch')
      checkbox = switch.find_element(:css, '.onoffswitch-checkbox')
      label = object.find_element(:class, 'label')
      if label.text == column_name
        return {
          'toggle_obj' => switch,
          'buttonOn' => checkbox.selected?
        }
      end
    end
  end

  def showHideColumns_ok_button
    @selenium.find_element(:class, 'swal2-confirm')
  end

  def filterWarning_text
    @selenium.find_element(:class, 'filter-warning')
  end

  def search_warning
    @selenium.find_element(:class, 'simple-search-no-results')
  end

  def search_button
    @selenium.find_element(:class, 'search')
  end

  def unit_filter_dropdown
    @selenium.find_element(:class, 'css-yk16xz-control')
  end

  def drawer_handle
    @selenium.find_element(:class, 'drawer-handle')
  end

  def snippet_summary
    @selenium.find_element(:class, 'snippet-summary')
  end

  def start_date
    dates = @selenium.find_element(:class, 'date-filter-container')
    start_date = dates.find_element(:class, 'start')
    @start_date_value = start_date.find_element(:css, 'input')
  end

  def end_date
    dates = @selenium.find_element(:class, 'date-filter-container')
    end_date = dates.find_element(:class, 'end')
    @end_date_value = end_date.find_element(:css, 'input')
  end

  def unit_selection(unit)
    unit_filter = @selenium.find_element(:class, 'unit-filter')
    unit_list = unit_filter.find_element(:class, 'rct-node')
    unit_checkbox = unit_list.find_elements(:class, 'rct-checkbox')
    unit_choice = unit_list.find_elements(:class, 'rct-title')

    (0..unit_choice.count - 1).each do |x|
      puts unit_choice[x].text
      return unit_choice[x] if unit_choice[x].text.include? unit
    end
  end

  def unit_filter_dropdown_values(unit)
    control_obj = @selenium.find_element(:class, 'unit-filter')

    list_obj = control_obj.find_element(:css, 'div.css-26l3qy-menu')
    list = list_obj.find_element(:css, 'div')
    values = list.find_elements(:css, 'div')

    (0..values.count - 1).each do |x|
      puts values[x].text
      return values[x] if values[x].text.include? unit
    end

    # return {
    #  "value" => values[x]
    # }
  end

  def search_criteria_headers
    unit_filter = @selenium.find_element(:class, 'unit-filter')
    options = unit_filter.find_elements(:class, 'rct-text')
    return options
  end

  def is_sidebar_visible
    begin
      sidebar = @selenium.find_element(:class, 'sidebar')
    rescue Selenium::WebDriver::Error::NoSuchElementError
      return false
    end
    return true
  end

  def is_search_criteria_collapsed
    # report = @selenium.find_element(:class, 'snippet-report')
    # drawer = report.find_element(:class, 'drawer')
    if @selenium.find_element(:class, 'drawer').attribute('class').include?('expanded')
      return false
    else
      return true
    end
  end

  def grid_button
    grid_button = @selenium.find_element(:class, 'grid-btn')
    return grid_button
  end

  def search_button_retrieve_reports
    search_button = @selenium.find_element(:css, 'h2 .search.btn')
    return search_button
  end

  def view_report_for_patient(default_patient)
    report = @selenium.find_element(:class, 'snippet-report')
    table = report.find_element(:class, 'list-window')
    tbody = table.find_element(:css, 'div')
    rows = tbody.find_elements(:class, 'row')
    puts rows.count

    (0..(rows.count - 1)).each do |i|
      patient_names = rows[i].find_elements(:css, '.cell:nth-child(2)')
      puts "Patient Element: #{patient_names[i].text}"
      puts "Default Patient Element: #{default_patient}"
      name = patient_names[i].text
      if name == default_patient then
        view_link = rows[i].find_elements(:class, 'view-link')
        return view_link[i].click
      end
    end
  end

  def get_column_data(column_name)
    column_no = nil
    column_data = []
    report = @selenium.find_element(:class, 'snippet-report')
    table = report.find_element(:class, 'table')
    tableHeader = table.find_element(:class, 'header')
    titleRow = tableHeader.find_elements(:css, 'div')
    columnSorts = titleRow[0].find_elements(:class, 'sortable')
    (0..(columnSorts.count - 1)).each do |i|
      next unless columnSorts[i].text == column_name
      column_no = i+1
    end
    puts "column No: #{column_no}"
    column_data.clear()
    cells_data = @selenium.find_elements(:css, '.snippet-report .row .cell:nth-child(7)')
    puts "No of Snippets found: #{cells_data.count}"
    (0..(cells_data.count - 1)).each do |j|
      if INFO == true
        date_value = cells_data[j].text
        column_data[j] = date_value
      end
    end
    return column_data
  end

  def click_on_report_column_name(column_name)
    column_no =get_column_index(column_name)
    puts "column No: #{column_no}"
    drop_down_click = @selenium.find_element(:css, '.filters-row div:nth-child('"#{column_no+1}"') .select  .select__dropdown-indicator')
    drop_down_click.click
  end

  def clear_column_filter(column_name)
    column_no =get_column_index(column_name)
    elements = @selenium.find_elements(:css, '.filters-row div:nth-child('"#{column_no+1}"') .select  .select__clear-indicator')
    if elements.size>0
      elements.first.click
    end
  end


  def get_column_index(column_name)
    return @selenium.find_elements(:css, "div.table>div.header>div>.sortable").map{|t| t.text}.index(column_name)
  end

  def verify_options()
    menu_options = @selenium.find_elements(:css, 'div.select__option')
    menu_options_text = []
    (0..(menu_options.count - 1)).each do |i|
      puts "Option List Values: #{menu_options[i].text}"
      menu_options_text.push(menu_options[i].text)
    end
    puts "Final Option List: #{menu_options_text}"
    return menu_options_text
  end

  def select_option(option_to_select)
     @selenium.find_element(:xpath, ".//div[contains(@class,'select__option') and contains(.,'#{option_to_select}')]").click()
  end
end
