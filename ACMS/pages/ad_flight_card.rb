Dir["#{File.dirname(__FILE__)}/../*.rb"].sort.each { |file| require file }

class AlertDispatch_FlightCard
  def initialize(selenium)
    @selenium = selenium
  end

  def flight_alarm_icon(flight_id)
    get_flight_card(flight_id).find_element(:xpath,"./descendant::div[@data-testid='flight-alarm-icon-section']/descendant::img[@data-testid='alarm-severity-icon']")
  end

  def alarm_name_label(flight_id)
    get_flight_card(flight_id).find_element(:xpath, "./descendant::div[@data-testid='flight-alarm-label-section']/descendant::div[@data-testid='alarm-label']/div")
  end

  def date_of_birth(flight_id)
    get_flight_card(flight_id).find_element(:xpath, "descendant::div[@data-testid='flight-patient']/descendant::div[@data-testid='date-of-birth']")
  end

  def mrn(flight_id)
    get_flight_card(flight_id).find_element(:xpath, "descendant::div[@data-testid='flight-patient']/descendant::div[@data-testid='mrn']")
  end

  def facility(flight_id)
    get_flight_card(flight_id).find_element(:xpath, "descendant::div[@data-testid='flight-location-section']/descendant::div[@data-testid='facility']")
  end

  def unit(flight_id)
    get_flight_card(flight_id).find_element(:xpath, "descendant::div[@data-testid='flight-location-section']/descendant::div[@data-testid='unit']")
  end

  def room_and_bed(flight_id)
    get_flight_card(flight_id).find_element(:xpath, "descendant::div[@data-testid='flight-location-section']/descendant::div[@data-testid='room-and-bed']")
  end

  def flight_start_time(flight_id)
    get_flight_card(flight_id).find_element(:css, "*[data-testid='flight-date']")
  end

  def flight_elapsed_time(flight_id)
    get_flight_card(flight_id).find_element(:css, "div[data-testid='elapsed-time']")
   end

  def get_flight_card(flight_id)
    @selenium.find_element(:css, "div[data-flight-id='#{flight_id}']")
  end

  def get_flight_card_elipsis_menu(flight_id)
    @selenium.find_element(:css, "div[data-flight-id='#{flight_id}'] div[data-testid='ellipsis-menu-button']")
  end
  def get_flight_card_delay_icon(flight_id)
    get_flight_card(flight_id).find_element(:css,'svg.tabler-icon-clock')
  end

  def flight_card_status(flight_id)
    flight_card = get_flight_card(flight_id)
    flight_card.find_element(:css, "div[data-testid='flight-status']")
  end

  def flight_status_color(flight_id)
    flight_card = get_flight_card(flight_id)
    element = flight_card.find_element(:css, "div[data-testid='flight-status-section-content']")
    element.find_element(:xpath, './..')
  end

  def flight_status_content(flight_id)
    flight_card = get_flight_card(flight_id)
    flight_card.find_element(:css, "div[data-testid='flight-status-section-content']")
  end

  def get_timer(flight_id,time_elapsed)
    flight_card = get_flight_card(flight_id)
    if time_elapsed == true
      flight_card.find_element(:css, "div[data-testid='elapsed-time']")
    else
      flight_card.find_element(:css, "div[data-testid='escalates-in']")
    end
  end
  def get_timer_value(flight_id,time_elapsed)
    get_timer(flight_id,time_elapsed).find_element(:css, "div[data-testid='animated-timer']")
  end
  def flight_status_icon(flight_id, icon)
    selector = icon === 'no-icon' ? "div[data-testid='#{icon}']" : "svg[data-testid='#{icon}'],svg.#{icon}"
    flight_card = get_flight_card(flight_id)
    flight_card.find_element(:css, "div[data-testid='flight-alert-status-icons'] #{selector}")
  end

  def flight_time_elapsed(flight_id)
    flight_card = get_flight_card(flight_id)
    flight_card.find_element(:css, "div[data-testid='elapsed-time']")
  end

  def alarm_start_button(flight_id)
    flight_card = get_flight_card(flight_id)
    flight_card.find_element(:css, "button[data-testid='start']")
  end

  def elipses_menu(flight_id)
    get_flight_card_elipsis_menu(flight_id)
  end
end