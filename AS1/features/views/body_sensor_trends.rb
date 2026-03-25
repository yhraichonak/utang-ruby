# frozen_string_literal: true

Dir["#{File.dirname(__FILE__)}/../*.rb"].sort.each { |file| require file }

class BodySensor_Trends
  def initialize(selenium)
    @selenium = selenium
    
  end

  def trendsScreen
    @selenium.find_element(:class, 'BodySensorSPV__Wrapper-sc-vbhoeo-0')
  end

  def currentReadings_table
    @selenium.find_element(:class, 'CurrentReadings__CurrentReadingsWrapper-sc-1rn5fpb-4')
  end

  def eventsTimeline_table
    @selenium.find_element(:class, 'TrendsTab__EventSummaryWrapper-sc-13d4czm-5')
  end

  def respirationRate_chart
    @selenium.find_element(:class, 'TrendsTab__ChartWrapper-sc-13d4czm-3')
  end
  
  def heart_rate_event
    @selenium.find_elements(:class, 'icon-heart-rate')
  end

  def grid_view_link
    @subheader_nav = @selenium.find_element(:class, 'SubHeader__Wrapper-sc-1ohxd3k-0')
    @subheader_nav.find_element(:xpath, "//*[contains(text(), 'Grid View')]")
  end

  def month_view_link
    @subheader_nav = @selenium.find_element(:class, 'SubHeader__Wrapper-sc-1ohxd3k-0')
    @subheader_nav.find_elements(:xpath, "//*[contains(text(), 'Month')]")
  end

  def week_view_link
    @subheader_nav = @selenium.find_element(:class, 'SubHeader__Wrapper-sc-1ohxd3k-0')
    @subheader_nav.find_elements(:xpath, "//*[contains(text(), 'Week')]")
  end

  def day_view_link
    @subheader_nav = @selenium.find_element(:class, 'SubHeader__Wrapper-sc-1ohxd3k-0')
    @subheader_nav.find_elements(:xpath, "//*[contains(text(), 'Day')]")
  end
end
