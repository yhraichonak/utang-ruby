# frozen_string_literal: true

Dir["#{File.dirname(__FILE__)}/../*.rb"].sort.each { |file| require file }

class BodySensor_GridView
  def initialize(selenium)
    @selenium = selenium
  end

  def eventsTimeline_table
    @selenium.find_element(:class, 'GridViewTab__EventTimeWrapper-sc-1gkuzd5-10')
  end

  def respirationRate_chart
    @selenium.find_element(:class, 'GridSPV__Wrapper-sc-13xt8af-0')
  end

  def trends_view
    @selenium.find_element(:xpath, "//*[contains(text(), 'Trends')]")
  end
end
