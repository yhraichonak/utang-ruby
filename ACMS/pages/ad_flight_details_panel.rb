
Dir["#{File.dirname(__FILE__)}/../*.rb"].sort.each { |file| require file }

require "#{File.dirname(__FILE__)}/flight_details_panel.rb"

class AlertDispatch_FlightDetailsPanel < FlightDetailsPanel
  def get_flight_info
    @container_element.find_element(:css,"div[data-testid='flight-info-panel']")
  end

end
