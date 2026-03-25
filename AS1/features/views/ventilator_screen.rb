# frozen_string_literal: true

Dir["#{File.dirname(__FILE__)}/../*.rb"].sort.each { |file| require file }

class Ventilator_Screen
  def initialize(selenium)
    @selenium = selenium
  end

  def ventilator_widget
    @selenium.find_element(:class, 'ventilator')
  end

  def chicklets(name)
    parent = @selenium.find_element(:class, 'chiclets')
    chic = parent.find_element(:class, name)
  end

  def grid_object
    @selenium.find_element(:class, 'grid')
  end

  def events_table
    @selenium.find_element(:class, 'ventilator-events')
  end
end
