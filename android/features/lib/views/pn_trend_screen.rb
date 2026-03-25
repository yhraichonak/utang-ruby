Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class PM_Trend_screen
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end

  def trend_graph
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/trend_graph")
  end

  def discrete_container
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/discrete_container")
  end

  def hr_discrete_info
    parent = @selenium.find_element(:id, "#{APP_PACKAGE}:id/discrete_container")
    title = parent.find_element(:id, "#{APP_PACKAGE}:id/title").text
    value = parent.find_element(:id, "#{APP_PACKAGE}:id/valueLeft").text
    timestamp = parent.find_element(:id, "#{APP_PACKAGE}:id/timestamp").text

    return {
      "title" => title,
      "value" => value,
      "timestamp" => timestamp
    }
  end

  def pvc_discrete_info
    parent = @selenium.find_element(:id, "#{APP_PACKAGE}:id/discrete_box_container")
    title = parent.find_element(:id, "#{APP_PACKAGE}:id/title")
    value = parent.find_element(:id, "#{APP_PACKAGE}:id/valueLeft")
    timestamp = parent.find_element(:id, "#{APP_PACKAGE}:id/timestamp")

    return {
      "title" => title,
      "value" => value,
      "timestamp" => timestamp
    }
  end

  def nbp_discrete_info
    parent = @selenium.find_element(:id, "#{APP_PACKAGE}:id/discrete_container")
    title = parent.find_element(:id, "#{APP_PACKAGE}:id/title")
    nbp_left = parent.find_element(:id, "#{APP_PACKAGE}:id/valueLeft")
    nbp_separator = parent.find_element(:id, "#{APP_PACKAGE}:id/valueSeparator")
    nbp_right = parent.find_element(:id, "#{APP_PACKAGE}:id/valueRight")

    timestamp = parent.find_element(:id, "#{APP_PACKAGE}:id/timestamp")

    return {
      "title" => title,
      "nbp_left" => nbp_left,
      "nbp_separator" => nbp_separator,
      "nbp_right" => nbp_right,
      "timestamp" => timestamp
    }
  end

  def ar1_discrete_info
    parent = @selenium.find_element(:id, "#{APP_PACKAGE}:id/discrete_container")
    title = parent.find_element(:id, "#{APP_PACKAGE}:id/title")
    ar1_left = parent.find_element(:id, "#{APP_PACKAGE}:id/valueLeft")
    ar1_separator = parent.find_element(:id, "#{APP_PACKAGE}:id/valueSeparator")
    ar1_right = parent.find_element(:id, "#{APP_PACKAGE}:id/valueRight")

    timestamp = parent.find_element(:id, "#{APP_PACKAGE}:id/timestamp")

    return {
      "title" => title,
      "nbp_left" => ar1_left,
      "nbp_separator" => ar1_separator,
      "nbp_right" => ar1_right,
      "timestamp" => timestamp
    }
  end

  def horizontal_zoom_level
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/horizontal_zoom_level")
  end

  def trend_graoh
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/trend_graph")
  end

  def vertical_zoom_level
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/vertical_zoom_level")
  end

  def timespan
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/timespan")
  end

  def value_labels
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/value_labels")
  end

  def value_labels
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/time_labels")
  end
end