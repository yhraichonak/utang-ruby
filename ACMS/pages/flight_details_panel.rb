
Dir["#{File.dirname(__FILE__)}/../*.rb"].sort.each { |file| require file }

class FlightDetailsPanel
  def initialize(selenium)
    @selenium=selenium
    @container_element = selenium.find_element(:css,"div[data-testid='flight-details-panel'] div[data-testid='flight'],div[data-testid='flight-details-panel'] div[data-testid='flight-details']")
  end

  def self.initialize_no_wait(selenium)
      @selenium=selenium
      @container_element = Common.find_element_no_wait(@selenium,  @selenium,:css,"div[data-testid='flight-details-panel'] div[data-testid='flight'],div[data-testid='flight-details-panel'] div[data-testid='flight-details']")
  end
  def get_container_element
    @container_element
  end
  def get_active_tab
    @container_element.find_element(:xpath,"button[role='tab'][aria-selected='true']")
  end
  def start_button
    @container_element.find_element(:css,"button[data-testid='start']")
  end

  def active_tab
    @container_element.find_element(:css,"button[role='tab'][aria-selected='true']")
  end

  def monitor
    @container_element.find_element(:xpath,"./../..").find_element(:css,"iframe#monitor-iframe")
  end

  def close
    @container_element.find_element(:xpath,"./..").find_element(:css,"button[data-testid='close']").click
  end
  def open_tab(target_tab)
    active_tab=get_active_tab
    if !active_tab.text.include?(target_tab)
      @container_element.find_elements(:css,"button[role='tab']").find{|t| t.text.include?(target_tab)}.click
    end
  end

  def click_tab(target_tab)
    @container_element.find_element(:css, "button[data-testid='tab-#{target_tab.downcase}']").click
  end

  def is_tab_flashed(target_tab)
    @container_element
      .find_element(:css, "button[data-testid='tab-#{target_tab.downcase}'] span[data-testid='flight-event-tab']")
      .attribute("class").include?("text-flashing")
  end

  def get_flight_events()
    @container_element.find_elements(:css,"div[data-testid='flight-event']")
  end

  def get_flight_events_text()
    array = @container_element.find_elements(:css,"div[data-testid='flight-event']")
    array2 = []
    for element in array
      array2.append(element.text)
    end
    array2
  end

  def alarm_severity_icon
    @container_element.find_element(:xpath, "//div[@data-testid='flight-details-panel']/descendant::img[@data-testid='alarm-severity-icon']")
  end

  def alarm_label
    @container_element.find_element(:xpath, "//div[@data-testid='flight-details-panel']/descendant::div[@data-testid='alarm-label']")
  end

  def flight_patient_name
    @container_element.find_element(:xpath, "//div[@data-testid='flight-details-panel']/descendant::div[@data-testid='name']")
  end

  def flight_patient_dob
    @container_element.find_element(:xpath, "//div[@data-testid='flight-details-panel']/descendant::div[@data-testid='date-of-birth']")
  end

  def flight_patient_mrn
    @container_element.find_element(:xpath, "//div[@data-testid='flight-details-panel']/descendant::div[@data-testid='mrn']")
  end

  def flight_location_facility
    @container_element.find_element(:xpath, "//div[@data-testid='flight-details-panel']/descendant::div[@data-testid='facility']")
  end

  def flight_location_unit
    @container_element.find_element(:xpath, "//div[@data-testid='flight-details-panel']/descendant::div[@data-testid='unit']")
  end

  def flight_location_room_and_bed
    @container_element.find_element(:xpath, "//div[@data-testid='flight-details-panel']/descendant::div[@data-testid='room-and-bed']")
  end

  def flight_location_flight_date
    @container_element.find_element(:xpath, "//div[@data-testid='flight-details-panel']/descendant::span[@data-testid='flight-date']")
  end

  def flight_elapsed_time
    @container_element.find_element(:xpath, "//div[@data-testid='flight-details-panel']/descendant::div[@data-testid='flight-elapsed-time']")
  end

  def flight_status
    @container_element.find_element(:xpath, "//div[@data-testid='flight-details-panel']/descendant::div[@data-testid='flight-status']")
  end

  def flight_loader
    @container_element.find_element(:xpath, "//div[@data-testid='flight-details-panel']/descendant::div[@data-testid='flight-loader']")
  end

  def start_button
    @container_element.find_element(:xpath, "//div[@data-testid='flight-details-panel']/descendant::button[@data-testid='start']")
  end

  def tab_history
    @container_element.find_element(:xpath, "//div[@data-testid='flight-details-panel']/descendant::button[@data-testid='tab-history']")
  end

  def tab_audit
    @container_element.find_element(:xpath, "//div[@data-testid='flight-details-panel']/descendant::button[@data-testid='tab-audit']")
  end

  def tab_monitor
    @container_element.find_element(:xpath, "//div[@data-testid='flight-details-panel']/descendant::button[@data-testid='tab-monitor']")
  end

  def tab_content_history
    @container_element.find_element(:xpath, "//div[@data-testid='flight-details-panel']/descendant::div[@data-testid='tab-content-history']")
  end

  def tab_content_audit
    @container_element.find_element(:xpath, "//div[@data-testid='flight-details-panel']/descendant::div[@data-testid='tab-content-audit']")
  end

  def tab_content_monitor
    @container_element.find_element(:xpath, "//div[@data-testid='flight-details-panel']/descendant::div[@data-testid='tab-content-monitor']")
  end

  def flight_events
    @container_element.find_element(:xpath, "//div[@data-testid='flight-details-panel']/descendant::div[@data-testid='flight-events']")
  end

  def date_in_flight_event
    @container_element.find_element(:xpath, "//div[@data-testid='flight-details-panel']/descendant::div[@data-testid='date']")
  end

  def time_in_flight_event
    @container_element.find_element(:xpath, "//div[@data-testid='flight-details-panel']/descendant::div[@data-testid='time']")
  end

  def type_in_flight_event
    @container_element.find_element(:xpath, "//div[@data-testid='flight-details-panel']/descendant::div[@data-testid='type']")
  end

  def data_in_flight_event
    @container_element.find_element(:xpath, "//div[@data-testid='flight-details-panel']/descendant::div[@data-testid='data']")
  end

end
