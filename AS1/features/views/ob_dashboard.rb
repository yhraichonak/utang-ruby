# frozen_string_literal: true

Dir["#{File.dirname(__FILE__)}/../*.rb"].sort.each { |file| require file }

class OB_Dashboard
  def initialize(selenium)
    @selenium = selenium
  end

  def ob_waveform_chart
    @selenium.find_element(:class, 'waveform-ob-tile')
  end

  def ob_maternal_vitals
    @selenium.find_element(:class, 'obvitals-ob-tile')
  end

  def ob_cervical_exams
    @selenium.find_element(:class, 'cervicalexams-ob-tile')
  end

  def ob_annotations
    @selenium.find_element(:class, 'annotations-ob-tile')
  end

  def ob_pitocin
    @selenium.find_element(:class, 'pitocin-ob-tile')
  end

  def ob_misc
    @selenium.find_element(:class, 'other-ob-tile')
  end

  def delay_time
    @selenium.find_element(:class, 'delay')
  end

  def time_scale
    @selenium.find_element(:class, 'time-scale')
  end
end
