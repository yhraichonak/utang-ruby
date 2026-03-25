Dir["#{File.dirname(__FILE__)}/../*.rb"].sort.each { |file| require file }
Dir["#{File.dirname(__FILE__)}/../pages/common_page.rb"].sort.each { |file| require file }

class AlertTracker_CommonPage < CommonPage
  def initialize(selenium)
    @selenium = selenium
  end

  def alerts_list_panel()
    @selenium.find_element(:xpath,"//div[@data-testid='alert-list-pane'][descendant::div[@data-testid='alert-list-header']/descendant::div[text()='Alerts List']]")
  end
  def get_table()
    @selenium.find_element(:css,"table")
  end

  def get_num_ui_flights()
    sleep(1)
    num_flights = @selenium.find_elements(:xpath,"//table/descendant::tr[contains(@data-testid,'alert-list-row')]").length()
  end

  def get_alert_table_item_by_filght_id(flight_id)
    @selenium.find_element(:css,"tr[data-testid='alert-list-row-#{flight_id}']")
  end

  def alert_table_item_attribute(flight_id, attribute)
    flight_card = get_alert_table_item_by_filght_id(flight_id)
    flight_card.find_element(:css, "td[data-testid='#{attribute}'")
  end

  def flight_time_elapsed(flight_id)
    flight_card = get_alert_table_item_by_filght_id(flight_id)
    flight_card.find_element(:css, "td[data-testid='totalTime']")
  end

  def filter_button(column_header)
    #valid choices: severity, alarmLabel, room, delivered, accepted
    @selenium.find_element(:xpath,"//table/descendant::thead/descendant::th[@data-testid='#{column_header}']/descendant::span[contains(@data-testid,'filter')]")
  end

  def filter_table_by_severity(severity_value)
    filter_button('severity').click
    @selenium.find_element(:xpath,"//div[@data-testid='severity-multi-list-filter']/descendant::div[contains(@data-testid,'option')][descendant::label[text()='#{severity_value}']]/button").click
    filter_button('severity').click
  end

  def filter_table_by_alarmLabel(alarmLabel_value)
    filter_button('alarmLabel').click
    @selenium.find_element(:xpath,"//div[@data-testid='alarmLabel-text-filter']/descendant::input").send_keys(alarmLabel_value)
    filter_button('alarmLabel').click
  end

  def filter_table_by_room(room_value)
    filter_button('room').click
    @selenium.find_element(:xpath,"//div[@data-testid='room-text-filter']/descendant::input").send_keys(room_value)
    filter_button('room').click
  end

  def filter_table_by_delivered_status(delivered_status)
    filter_button('delivered').click
    @selenium.find_element(:xpath,"//div[@data-testid='delivered-radio-list-filter']/descendant::div[contains(@data-testid,'option')][descendant::label[text()='#{delivered_status}']]/button").click
    filter_button('delivered').click
  end

  def filter_table_by_accepted_status(accepted_status)
    filter_button('accepted').click
    @selenium.find_element(:xpath,"//div[@data-testid='accepted-radio-list-filter']/descendant::div[contains(@data-testid,'option')][descendant::label[text()='#{accepted_status}']]/button").click
    filter_button('accepted').click
  end

  def clearAllColumnFilters()
    @selenium.find_element(:xpath,"//div[@data-testid='active-filters']/button").click
    @selenium.find_element(:xpath,"//div[@data-testid='active-filters-display']/descendant::button[descendant::span[text()='Clear All']]").click
  end

  def anyActiveColumnFilter()
    text = @selenium.find_element(:xpath,"//div[@data-testid='active-filters']/span").text
    flag = nil
    if text == 'No Filters Selected'
      flag = false
    else
      flag = true
    end
  end
end
