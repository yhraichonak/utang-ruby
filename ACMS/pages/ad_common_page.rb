# frozen_string_literal: true

Dir["#{File.dirname(__FILE__)}/../*.rb"].sort.each { |file| require file }
require_relative './common_page.rb'
require_relative './ad_flight_card.rb'
@ad_flight_card = AlertDispatch_FlightCard.new @selenium
class AlertDispatch_CommonPage < CommonPage
  def initialize(selenium)
    @selenium = selenium
  end

  def alarm_queue_panel()
    @selenium.find_element(:xpath, "//div[@data-testid='alarm-queue-panel'][div[@data-testid='panel-header']/div[text()='Alarm Queue']]")
  end

  def alerts_panel()
    @selenium.find_element(:xpath, "//div[@data-testid='alerts-panel'][div[@data-testid='panel-header']/div[text()='Alerts']]")
  end

  def filter_modal
    @selenium.find_element(:css, "div[data-testid='select-filter-content']")
  end

  def filter_trigger
    filter_selecter = @selenium.find_element(:css, "div[data-testid='select-filter']")
    filter_selecter.find_element(:css, "button[data-testid='trigger']")
  end

  def alarmQueue_PrioritizeCheckbox
    @selenium.find_element(:xpath,
                           "//div[@data-testid='alarm-queue-panel']//div[contains(@data-testid,'flight-sort-options') and contains(.,'Prioritize by Severity')]/button")
  end

  def alerts_PrioritizeCheckbox
    @selenium.find_element(:xpath,
                           "//div[@data-testid='alerts-panel']//div[contains(@data-testid,'flight-sort-options') and contains(.,'Prioritize by Severity')]/button")
  end

  def isAlarmQueuePrioritizationChecked
    alarmQueue_PrioritizeCheckbox.attribute('data-state') == 'checked'
  end

  def isAlertsPrioritizationChecked
    return true if alerts_PrioritizeCheckbox.attribute('data-state') == 'checked'
    false
  end

  def toggleAlarmQueuePrioritizationCheckbox
    alarmQueue_PrioritizeCheckbox.click
  end

  def toggleAlertsPrioritizationCheckbox
    alerts_PrioritizeCheckbox.click
  end

  def get_table
    @selenium.find_element(:css, 'table')
  end

  def get_queue_panel
    @selenium.find_element(:css, "div[data-testid='alarm-queue-panel']")
  end

  def get_alerts_panel
    @selenium.find_element(:css, "div[data-testid='alerts-panel']")
  end

  def get_flight_details_panel
    @selenium.find_element(:css, "div[data-testid='flight-details-panel']")
  end

  def get_items_list_panel(list_text)
    if list_text.include? 'Queue'
      get_queue_panel
    else
      get_alerts_panel
    end
  end

  def get_flight_plan_item(list_text, flight_id, timeout)
    @flight_wait = Selenium::WebDriver::Wait.new(timeout:)
    @flight_wait.until { get_items_list_panel(list_text).find_element(:css, "div[data-flight-id='#{flight_id}']") }
  end

  def get_matching_flight_plan_items_no_wait(list_text, flight_id)
    get_matching_flight_plan_items(list_text, flight_id, 0)
  end

  def get_matching_flight_plan_items(list_text, flight_id, timeout, subsection_text = '')
    initial_timeout = @selenium.manage.timeouts.implicit_wait
    @selenium.manage.timeouts.implicit_wait = timeout
    if list_text.include?('Alerts')
      if subsection_text.blank?
        result = @selenium.find_elements(:css, "div[data-testid='alerts-panel'] div[data-flight-id='#{flight_id}']")
      else
        result = @selenium.find_elements(:css,
                                         "div[data-testid='alerts-panel'] div[data-testid='#{subsection_text}'] div[data-flight-id='#{flight_id}']")
      end
    else
      result = @selenium.find_elements(:css, "div[data-testid='alarm-queue-panel'] div[data-flight-id='#{flight_id}']")
    end
    @selenium.manage.timeouts.implicit_wait = initial_timeout
    result
  end

  def get_matching_flight_plan_items_by_text(list_text, alert_text, timeout, subsection_text = '')
    initial_timeout = @selenium.manage.timeouts.implicit_wait
    @selenium.manage.timeouts.implicit_wait = timeout
    if list_text.include?('Alerts')
      if subsection_text.blank?
        result = @selenium.find_elements(:xpath, ".//div[@data-testid='alerts-panel']//div[@data-testid='flight' and contains(., '#{alert_text}')]")
      else
        result = @selenium.find_elements(:xpath, ".//div[@data-testid='alerts-panel']//div[@data-testid='#{subsection_text}']//div[@data-testid='flight' and contains(., '#{alert_text}')]")
      end
    else
      result = @selenium.find_elements(:xpath, ".//div[@data-testid='alarm-queue-panel']//div[@data-testid='flight' and contains(.,'#{alert_text}')]")
    end
    @selenium.manage.timeouts.implicit_wait = initial_timeout
    result
  end

  def destination_field(field)
    @selenium.find_elements(:css, "div[data-testid='#{field.downcase}-to']")
  end

  def start_alert_dialog
    @selenium.find_element(:css, "div[data-testid='start-alert-dialog']")
  end

  def dialog_start_button
    dialog = start_alert_dialog
    dialog.find_element(:css, "button[data-testid='start']")
  end
  def dialog_button(type)
    dialog = start_alert_dialog
    dialog.find_element(:css, "button[data-testid='"+type.downcase+"']")
  end

  def dialog_button_no_wait(type)
    dialog = start_alert_dialog
    find_element_no_wait(@selenium,dialog,:css ,"button[data-testid='"+type.downcase+"']")
  end

  def manual_escalation_btn
    @selenium.find_element(:css, "div[data-testid='ellipsis-menu-item']")
  end
end
