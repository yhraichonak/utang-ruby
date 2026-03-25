# frozen_string_literal: true

Before do
  @SupervisorNursingReport_Screen = SupervisorNursingReport_Screen.new @selenium
  @PatientList_Screen = PatientList_Screen.new @selenium
end

Then(/^Select all units at Supervisor Snippet Report screen$/) do
    if @SupervisorNursingReport_Screen.unit_selection("All").find_element(xpath:"./..").attribute("innerHTML").include? 'aria-checked="false"'
      @SupervisorNursingReport_Screen.unit_selection("All").click
    end
end

Then(/^Search across "(.*)" units at Supervisor Snippet Report screen$/) do |units_string|
  units_string = process_param(units_string)
  if @SupervisorNursingReport_Screen.unit_selection("All").find_element(xpath:"./..").attribute("innerHTML").include? 'rct-icon-half-check'
    @SupervisorNursingReport_Screen.unit_selection("All").click
  end
  if @SupervisorNursingReport_Screen.unit_selection("All").find_element(xpath:"./..").attribute("innerHTML").include? 'rct-icon-check'
    @SupervisorNursingReport_Screen.unit_selection("All").click
  end
  units_string.split(",").each{ |t|
    @SupervisorNursingReport_Screen.unit_selection(t).click
  }
  @SupervisorNursingReport_Screen.search_button.click
end

Then(/^I should see the Supervisor Snippet Report screen$/) do
  sleep 2
  if  @SupervisorNursingReport_Screen.search_button.displayed?
    if @SupervisorNursingReport_Screen.unit_selection("All").find_element(xpath:"./..").attribute("innerHTML").include? 'aria-checked="false"'
      @SupervisorNursingReport_Screen.unit_selection("All").click
    end
    @SupervisorNursingReport_Screen.search_button.click
  end
  @wait.until { @SupervisorNursingReport_Screen.snippetReport_div.displayed? == true }

  puts @SupervisorNursingReport_Screen.snippetReport_div.text if INFO == true

  snippetColumns = 'Status Patient Name MRN Unit Bed Captured By Date/Time of Strip Event Description Snippet Type Reviewed By'

  expect(@SupervisorNursingReport_Screen.snippetReport_div).to be_truthy
  # expect(@SupervisorNursingReport_Screen.snippetReport_div.text).to include "Nursing Supervisor Snippets Report"

  if snippetColumns == @SupervisorNursingReport_Screen.snippetReport_div.text
    expect(@SupervisorNursingReport_Screen.snippetReport_div.text).to include snippetColumns

    report_data = @SupervisorNursingReport_Screen.reportData_body
    rows = report_data['rowcount']

    (0..(rows - 1)).each do |i|
      next unless INFO == true

      puts "Row #: #{i} | #{report_data['status'][i]} | #{report_data['patientName'][i].text} | #{report_data['mrn'][i].text} | #{report_data['unit'][i].text} | #{report_data['bed'][i].text} | #{report_data['capturedBy'][i].text} | #{report_data['dateTime'][i].text} | #{report_data['description'][i].text} | #{report_data['snippetType'][i].text} | #{report_data['reviewedBy'][i].text}"
    end
  end
  sleep 1

end

Then(/^I should see the total number of results in the date range format$/) do
  @snippet_summary = @SupervisorNursingReport_Screen.snippet_summary
  @start_date = @SupervisorNursingReport_Screen.start_date
  @start_date_value = @start_date['value']
  @end_date = @SupervisorNursingReport_Screen.end_date
  @end_date_value = @end_date['value']

  puts "Start Date: #{@start_date_value}"
  puts "End Date: #{@end_date_value}"
  puts @snippet_summary.text

  # expect(@snippet_summary.text).to include @start_date_value
  expect(@snippet_summary.text).to include @end_date_value
end

Then(/^I should see column header "(.*?)" in Supervisor Snippet Report screen$/) do |column|
  expect(@SupervisorNursingReport_Screen.column_filter(column)['header_obj'].displayed?).to be_truthy
end

Then(/^I should see from and to date filters in Supervisor Snippet Report screen$/) do
  sleep 5
  date = @SupervisorNursingReport_Screen.start_date
  drawer_handle = @SupervisorNursingReport_Screen.drawer_handle
  unless date.displayed?
    drawer_handle.click
    @wait.until { date.displayed? == true }
  end

  expect(@SupervisorNursingReport_Screen.from_datepicker.displayed?).to be_truthy
  expect(@SupervisorNursingReport_Screen.to_datepicker.displayed?).to be_truthy
end

Then(/^I should see from and to bed filters in Supervisor Snippet Report screen$/) do
  expect(@SupervisorNursingReport_Screen.from_bed_search.displayed?).to be_truthy
  expect(@SupervisorNursingReport_Screen.to_bed_search.displayed?).to be_truthy
end

When(/^I enter "(.*?)" into Bed search "(.*?)" textfield on Supervisor Snippet Report Screen$/) do |search_text, search_field|
  case search_field
  when 'From'
    target_element=@SupervisorNursingReport_Screen.from_bed_search
    target_element.clear
    target_element.send_keys(search_text)
  when 'To'
    target_element=@SupervisorNursingReport_Screen.to_bed_search
    target_element.clear
    target_element.send_keys(search_text)
  end
end
When(/^I clear Bed search textfields on Supervisor Snippet Report Screen$/) do
  @SupervisorNursingReport_Screen.from_bed_search.clear()
  @SupervisorNursingReport_Screen.to_bed_search.clear()
end

When(/^I clear Bed search "(.*?)" textfield on Supervisor Snippet Report Screen$/) do |search_field|
  sleep 1
  case search_field
  when 'From'
    @selenium.action.move_to(@SupervisorNursingReport_Screen.from_bed_search).double_click.perform
    @selenium.action.send_keys(:delete).perform
  when 'To'
    @selenium.action.move_to(@SupervisorNursingReport_Screen.to_bed_search).double_click.perform
    @selenium.action.send_keys(:delete).perform
  end
end

When(/^I click on the View link of "(.*?)" snippet in Supervisor Snippet Report$/) do |search|
  # if  @SupervisorNursingReport_Screen.search_button.displayed?
  #    @SupervisorNursingReport_Screen.search_button.click
  # end
  sleep 1
  @wait.until { @SupervisorNursingReport_Screen.list_window }

  report_data = @SupervisorNursingReport_Screen.reportData_body
  rows = report_data['rowcount']
  puts "the rows count is:  #{rows}"
  viewlink = nil

  (0..(rows - 1)).each do |i|
    status = report_data['status'][i]

    next unless status == search

    viewlink = report_data['view_link'][i]
    @viewedSnippetRow = i
    break
  end

  viewlink.click
end

Then(/^I see the snippet appear in viewer window$/) do
  sleep 3
  expect(@SupervisorNursingReport_Screen.snippet_window_title.text).to eql 'Snippet Report'
end

Then(/^I see a OK button in snippet viewer window$/) do
  expect(@SupervisorNursingReport_Screen.snippet_window_ok_button.text).to eql 'OK'
end

When(/^I click the OK button in snippet viewer window$/) do
  @SupervisorNursingReport_Screen.snippet_window_ok_button.click
end

Then(/^I see a Approve button in snippet viewer window$/) do
  expect(@SupervisorNursingReport_Screen.snippet_window_approve_button.text).to eql 'Approve'
end

Then(/^I see a Reject button in snippet viewer window$/) do
  expect(@SupervisorNursingReport_Screen.snippet_window_reject_button.text).to eql 'Reject'
end

When(/^I click the Approve button in snippet viewer window$/) do
  @SupervisorNursingReport_Screen.snippet_window_approve_button.click
end

When(/^I click the Reject button in snippet viewer window$/) do
  sleep 2
  @SupervisorNursingReport_Screen.snippet_window_reject_button.click
end

Then(/^I see the Reject Snippet prompt window$/) do
  sleep 2
  expect(@SupervisorNursingReport_Screen.alert_title.text).to eql 'Reject Snippet'
  expect(@SupervisorNursingReport_Screen.alert_content.text).to eql 'Are you sure you want to Reject?'
end

When(/^I click Cancel button in reject snippet prompt$/) do
  @SupervisorNursingReport_Screen.alert_cancel_button.click
end

When(/^I click Reject button in reject snippet prompt$/) do
  @SupervisorNursingReport_Screen.alert_reject_button.click
end

Then(/^the Snippet display as "(.*?)" in Supervisor Snippet Report$/) do |status|
  sleep 5

  begin
    report_data = @SupervisorNursingReport_Screen.reportData_body
    expect(report_data['status'][@viewedSnippetRow]).to eql status
  rescue StandardError
    sleep 3
    report_data = @SupervisorNursingReport_Screen.reportData_body
    expect(report_data['status'][@viewedSnippetRow]).to eql s
  end
end

When(/^I click on "(.*?)" sort button until sorted by "(.*?)" in Supervisor Snippet Report$/) do |sort_button, sort_order_requested|
  sort_order = @SupervisorNursingReport_Screen.column_filter(sort_button)['sortOrder']
  while sort_order != sort_order_requested
    @SupervisorNursingReport_Screen.column_filter(sort_button)['header_obj'].click
    sleep 1
    sort_order = @SupervisorNursingReport_Screen.column_filter(sort_button)['sortOrder']
  end
end

Then(/^I should see the "(.*?)" column sorted by "(.*?)" in Supervisor Snippet Report$/) do |sort_button, sort_order_requested|
  expect(@SupervisorNursingReport_Screen.column_filter(sort_button)['sortOrder']).to eql sort_order_requested
end

When(/^I sort the "(.*?)" column "(.*?)" on Supervisor Snippet Report screen$/) do |column, sort|
  sleep 5
  columnSort = @SupervisorNursingReport_Screen.column_filter(column)['sortOrder']
  case sort
  when 'ascending'
    while columnSort != 'ascending'
      @SupervisorNursingReport_Screen.column_filter(column)['header_obj'].click
      columnSort = @SupervisorNursingReport_Screen.column_filter(column)['sortOrder']
      expect(columnSort).to be_truthy
    end
  when 'descending'
    while columnSort != 'descending'
      @SupervisorNursingReport_Screen.column_filter(column)['header_obj'].click
      columnSort = @SupervisorNursingReport_Screen.column_filter(column)['sortOrder']
      expect(columnSort).to be_truthy
    end
  end
end

Then(/^if no columns sorted report is sorted LIFO$/) do
  sleep 2
  report_data = @SupervisorNursingReport_Screen.reportData_body
  rows = report_data['rowcount']
  (0..(rows - 2)).each do |i|
    puts "#{report_data['dateTime'][i].text} >= #{report_data['dateTime'][i + 1].text}" if INFO == true
    expect(DateTime.strptime(report_data['dateTime'][i].text,
                             '%m/%d/%Y - %H:%M:%S')).to be >= DateTime.strptime(report_data['dateTime'][i + 1].text,
                                                                                '%m/%d/%Y - %H:%M:%S')
  end
end

Then(/^I should see the "(.*?)" column data sorted "(.*?)"$/) do |column, sort|
  beforeSortReport = []
  sort_init = sort
  sort = sort.gsub("string:", "")
  sleep 5
  expect(@SupervisorNursingReport_Screen.column_filter(column)['sortOrder']).to eql sort

  report_data = @SupervisorNursingReport_Screen.reportData_body
  rows = report_data['rowcount']

  case column
  when 'Status'
    columnName = 'status'
  when 'Patient Name'
    columnName = 'patientName'
  when 'MRN'
    columnName = 'mrn'
  when 'Unit'
    columnName = 'unit'
  when 'Bed'
    columnName = 'bed'
  when 'Captured By'
    columnName = 'capturedBy'
  when 'Created Date/Time'
    columnName = 'dateTime'
  when 'Event Description'
    columnName = 'description'
  when 'Snippet Type'
    columnName = 'snippetType'
  when 'Reviewed By'
    columnName = 'reviewedBy'
  end

  (0..(rows - 2)).each do |i|
    if sort == 'ascending'
      case columnName
      when 'status'
        case report_data[columnName][i]
        when 'Unapproved'
          case report_data[columnName][i + 1]
          when 'Unapproved', 'Rejected', 'Approved', 'Saved'
          else
            raise "Sorting of status column is incorrect #{report_data[columnName][i]} <= #{report_data[columnName][i + 1]}"
          end
        when 'Rejected'
          case report_data[columnName][i + 1]
          when 'Rejected', 'Approved', 'Saved'
          else
            raise "Sorting of status column is incorrect #{report_data[columnName][i]} <= #{report_data[columnName][i + 1]}"
          end
        when 'Approved'
          case report_data[columnName][i + 1]
          when 'Approved', 'Saved'
          else
            raise "Sorting of status column is incorrect #{report_data[columnName][i]} <= #{report_data[columnName][i + 1]}"
          end
        when 'Saved'
          case report_data[columnName][i + 1]
          when 'Saved'
          else
            raise "Sorting of status column is incorrect #{report_data[columnName][i]} <= #{report_data[columnName][i + 1]}"
          end
        else
          raise "Unknown status detected " + report_data[columnName][i]
        end
      when 'datetime'
        expect(DateTime.strptime(report_data['dateTime'][i].text,
                                 '%m/%d/%Y %H:%M:%S')).to be <= DateTime.strptime(report_data['dateTime'][i + 1].text,
                                                                                  '%m/%d/%Y %H:%M:%S')

      else
        beforeSort = beforeSortReport.push(report_data[columnName][i].text)
        expect(beforeSort.should == beforeSort.sort)
      end
    else
      case columnName
      when 'status'
        case report_data[columnName][i]
        when 'Unapproved'
          case report_data[columnName][i + 1]
          when 'Unapproved'
          else
            raise "Sorting of status column is incorrect #{report_data[columnName][i]} <= #{report_data[columnName][i + 1]}"
          end
        when 'Rejected'
          case report_data[columnName][i + 1]
          when 'Unapproved', 'Rejected'
          else
            raise "Sorting of status column is incorrect #{report_data[columnName][i]} <= #{report_data[columnName][i + 1]}"
          end
        when 'Approved'
          case report_data[columnName][i + 1]
          when 'Unapproved', 'Rejected', 'Approved'
          else
            raise "Sorting of status column is incorrect #{report_data[columnName][i]} <= #{report_data[columnName][i + 1]}"
          end
        when 'Saved'
          case report_data[columnName][i + 1]
          when 'Unapproved', 'Rejected', 'Approved', 'Saved'
          else
            raise "Sorting of status column is incorrect #{report_data[columnName][i]} <= #{report_data[columnName][i + 1]}"
          end
        else
          raise "Unknown status detected " + report_data[columnName][i]
        end
      when 'datetime'
        expect(DateTime.strptime(report_data['dateTime'][i].text,
                                 '%m/%d/%Y %H:%M:%S')).to be >= DateTime.strptime(report_data['dateTime'][i + 1].text,
                                                                                  '%m/%d/%Y %H:%M:%S')
      else
        beforeSort = beforeSortReport.push(report_data[columnName][i].text)
        expect(beforeSort.should == beforeSort.sort.reverse)
      end
    end
  end
end

Then(/^I should see the "(.*?)" column data displayed as secondary sort "(.*?)"$/) do |column, sort|
  expect(@SupervisorNursingReport_Screen.column_filter(column)['sortOrder']).to eql sort
  expect(@SupervisorNursingReport_Screen.column_filter(column)['secondarySort']).to be_truthy
end

When(/^I filter the "(.*?)" column by "(.*?)" on Supervisor Snippet Report screen$/) do |column, filter|
  retries ||= 0
  @wait.until { @SupervisorNursingReport_Screen.column_filter(column)['filter_obj'].displayed? == true }
  @SupervisorNursingReport_Screen.column_filter(column)['dropDownIndicator'].click

  @wait.until { @SupervisorNursingReport_Screen.selectOption_menu(filter).displayed? == true }
  @SupervisorNursingReport_Screen.selectOption_menu(filter).click
rescue Selenium::WebDriver::Error::StaleElementReferenceError
  sleep 0.5
  retry if (retries += 1) < 3
end

When(/^I clear the "(.*?)" column filter$/) do |column|
  @SupervisorNursingReport_Screen.column_filter(column)['clearIndicator'].click
end

When(/^I should see "(.*?)" column filter cleared$/) do |column|
  expect(@SupervisorNursingReport_Screen.column_filter(column)['clearIndicator']).to be nil
end

Then(/^I should see the "(.*?)" column data filtered by "(.*?)"$/) do |column, filter|
  sleep 2
  report_data = @SupervisorNursingReport_Screen.reportData_body
  rows = report_data['rowcount']

  case column
  when 'Status'
    columnName = 'status'
  when 'Patient Name'
    columnName = 'patientName'
  when 'MRN'
    columnName = 'mrn'
  when 'Unit'
    columnName = 'unit'
  when 'Bed'
    columnName = 'bed'
  when 'Captured By'
    columnName = 'capturedBy'
  when 'Created Date/Time'
    columnName = 'dateTime'
  when 'Description'
    columnName = 'description'
  when 'Snippet Type'
    columnName = 'snippetType'
  when 'Reviewed By'
    columnName = 'reviewedBy'
  end

  (0..(rows - 1)).each do |i|
    case columnName
    when 'status'
      expect(report_data[columnName][i]).to eql filter
    when 'bed'
      expect(report_data[columnName][i].text).to be_between(filter[0..0], filter)
    else
      expect(report_data[columnName][i].text).to eql filter
    end
  end
end

When(/^I click the Hide Show Columns button$/) do
  @SupervisorNursingReport_Screen.show_top_panel
  @SupervisorNursingReport_Screen.hideShowColumns_button.click
end

Then(/^I should see the Hide Show Column toggles window$/) do
  expect(@SupervisorNursingReport_Screen.toggleColumns_switches('Status')['toggle_obj'].displayed?).to be_truthy
  expect(@SupervisorNursingReport_Screen.toggleColumns_switches('Patient Name')['toggle_obj'].displayed?).to be_truthy
  expect(@SupervisorNursingReport_Screen.toggleColumns_switches('MRN')['toggle_obj'].displayed?).to be_truthy
  expect(@SupervisorNursingReport_Screen.toggleColumns_switches('Unit')['toggle_obj'].displayed?).to be_truthy
  expect(@SupervisorNursingReport_Screen.toggleColumns_switches('Bed')['toggle_obj'].displayed?).to be_truthy
  expect(@SupervisorNursingReport_Screen.toggleColumns_switches('Captured By')['toggle_obj'].displayed?).to be_truthy
  expect(@SupervisorNursingReport_Screen.toggleColumns_switches('Created Date/Time')['toggle_obj'].displayed?).to be_truthy
  expect(@SupervisorNursingReport_Screen.toggleColumns_switches('Event Description')['toggle_obj'].displayed?).to be_truthy
  expect(@SupervisorNursingReport_Screen.toggleColumns_switches('Snippet Type')['toggle_obj'].displayed?).to be_truthy
  expect(@SupervisorNursingReport_Screen.toggleColumns_switches('Reviewed By')['toggle_obj'].displayed?).to be_truthy
end

When(/^I click to "(.*?)" the "(.*?)" column$/) do |status, column_name|
  status = status != 'hide'
  current_status = @SupervisorNursingReport_Screen.toggleColumns_switches(column_name)['buttonOn']
  @SupervisorNursingReport_Screen.toggleColumns_switches(column_name)['toggle_obj'].click if current_status != status
end

When(/^I click the Ok button on the Hide Show Column toggle window$/) do
  @SupervisorNursingReport_Screen.showHideColumns_ok_button.click
  sleep 1
end

Then(/^I should see the Supervisor Snippet Report with "(.*?)" column hidden$/) do |column_name|
  puts @SupervisorNursingReport_Screen.snippetReport_div.text if INFO == true
  column_name = 'MRN Unit Bed' if column_name == 'Unit'

  expect(@SupervisorNursingReport_Screen.snippetReport_header.text).not_to include column_name
end

Then(/^I should see the Snippets Report refresh with message "(.*?)"$/) do |message_text|
  expect(@SupervisorNursingReport_Screen.filterWarning_text.text).to eql message_text
end

Then(/^I should see the Snippets Report display results with the search criteria "(.*?)"$/) do |option|
  case option
  when 'collapsed'
    report_data = @SupervisorNursingReport_Screen.reportData_body
    rows = report_data['rowcount']
    expect(rows).to be > 0
    expect(@SupervisorNursingReport_Screen.is_search_criteria_collapsed).to be_truthy
  when 'expanded'
    expect(@SupervisorNursingReport_Screen.is_search_criteria_collapsed).to be_falsey
  end
end

When(/^I filter the "(.*?)" selection box by "(.*?)" on Supervisor Snippet Report screen$/) do |_x, unit|
  list_window = @SupervisorNursingReport_Screen.list_window
  snippet_summary = @SupervisorNursingReport_Screen.snippet_summary

  @wait.until { list_window.displayed? == true }

  @SupervisorNursingReport_Screen.unit_selection(unit).click

  @SupervisorNursingReport_Screen.search_button.click
  sleep 5
  puts "search complete"
  @wait.until { list_window.displayed? == true }
  # @wait.until { snippet_summary.text.include? 'total of'}
end

Then(/^I should see the search criteria header in an expanded state$/) do
  if @selenium.find_element(:class, 'drawer').attribute('class').include?('collapsible')
    (expect(@SupervisorNursingReport_Screen.is_search_criteria_collapsed).to be_falsey)
  else
    (expect(@SupervisorNursingReport_Screen.search_button.displayed?).to be_truthy)
  end
end

Then(/^I should not see the List of Lists left-hand sidebar on the Supervisor Snippets Report screen$/) do
  expect(@SupervisorNursingReport_Screen.is_sidebar_visible).to be_falsey
end

When(/^I click the Search button to return the default results$/) do
  @SupervisorNursingReport_Screen.search_button.click
  sleep(1)
end

When(/^I click the blue divider$/) do
  @SupervisorNursingReport_Screen.drawer_handle.click
  sleep(1)
end

Then(/^I should be able to edit the search criteria header$/) do
  expect(@SupervisorNursingReport_Screen.search_criteria_headers[1].displayed?).to be_truthy
  expect(@SupervisorNursingReport_Screen.search_criteria_headers[2].displayed?).to be_truthy
end

When(/^I click the grid button in the top left-hand portion of the screen$/) do
  @SupervisorNursingReport_Screen.grid_button.click
end

When(/^I click search button to retrieve reports$/) do
  @SupervisorNursingReport_Screen.search_button_retrieve_reports.click
end

When(/^I click View button on the same patient$/) do
  defautl_patient = process_param("[props.DP_FULL_NAME]")
  @wait.until { @SupervisorNursingReport_Screen.list_window }
  sleep(2)
  @SupervisorNursingReport_Screen.view_report_for_patient(defautl_patient)
end

When(/^I should see reports column "(.*?)" arrow in "(.*?)" direction$/) do |column, direction|
  if(direction=="upward")
    elementup = "div[class='sortable sorted']"
    jsQueryup = 'return window.getComputedStyle(document.querySelector("'+elementup+'"),"::after").getPropertyValue("content")'
    contentup = @selenium.execute_script(jsQueryup)
    arrow_up = contentup.delete("\"")
    puts "Direction is: #{arrow_up}"
    expect(arrow_up).to eq "▲"
  else
    elementdown = "div[class='sortable sorted desc']"
    jsQuerydown = 'return window.getComputedStyle(document.querySelector("'+elementdown+'"),"::after").getPropertyValue("content")'
    contentdown = @selenium.execute_script(jsQuerydown)
    arrow_down = contentdown.delete("\"")
    puts "Direction is: #{arrow_down}"
    expect(arrow_down).to eq "▼"
  end
end

Then(/^I should see the "(.*?)" column in "(.*?)" order$/) do |column, sort|
  case
  when sort == "ascending"
    column_data_after_UI_sort = @SupervisorNursingReport_Screen.get_column_data(column)
    puts "value: #{column_data_after_UI_sort}"
    lifo = column_data_after_UI_sort.sort
    puts "sorted value: #{lifo}"
    expect(column_data_after_UI_sort.should == lifo)
  when sort == "descending"
    column_data_after_UI_sort = @SupervisorNursingReport_Screen.get_column_data(column)
    puts "value: #{column_data_after_UI_sort}"
    lifo_reverse = column_data_after_UI_sort.sort { |a,b| b <=> a}
    puts "sorted value: #{lifo_reverse}"
    expect(column_data_after_UI_sort.should == lifo_reverse)
  end
end

When(/^I click the Status field and should see the following options:$/) do |datatable|
  @SupervisorNursingReport_Screen.click_on_report_column_name('Status')
  menu_items = @SupervisorNursingReport_Screen.verify_options()
  expect(datatable.raw().flatten.should eql? menu_items)
end

When(/^I click on Status dropdown and select "(.*?)"$/) do |option|
  # @SupervisorNursingReport_Screen.click_on_report_column_name('Status')
  @SupervisorNursingReport_Screen.select_option(option)
end

When(/^I reset Status column filter$/) do
  @SupervisorNursingReport_Screen.clear_column_filter('Status')
end

Then(/^I should see the "(.*?)" present in the supervisor report$/) do |column|
  beforeSortReport = []
  report_data = @SupervisorNursingReport_Screen.reportData_body
  rows = report_data['rowcount']
  case column
  when 'Patient Name'
    columnName = 'patientName'
  end
  (0..(rows - 2)).each do |i|
    beforeSort = beforeSortReport.push(report_data[columnName][i].text)
    expect(beforeSort.include?(@patient_data))
  end
end
