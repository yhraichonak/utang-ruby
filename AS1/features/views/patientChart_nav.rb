# frozen_string_literal: true

Dir["#{File.dirname(__FILE__)}/../*.rb"].sort.each { |file| require file }

class PatientChart_Nav
  def initialize(selenium)
    @selenium = selenium
  end

  def overview_tab

    @selenium.find_element(:xpath, "//*[contains(text(), 'Overview')]")
  end

  def labs_tab
    @selenium.find_element(:xpath, "//*[contains(text(), 'Labs')]")
  end

  def activeMeds_tab
    @selenium.find_element(:xpath, "//*[contains(text(), 'Active Meds')]")
  end

  def vitals_tab
    @selenium.find_element(:xpath, "//*[contains(text(), 'Vitals')]")
  end

  def monitor_tab 
    @selenium.find_element(:xpath, "//*[contains(text(), 'Monitor')]")
  end

  def documents_tab 
    @selenium.find_element(:xpath, "//*[contains(text(), 'Documents')]")
  end

  def ecgs_tab
    @selenium.find_element(:xpath, "//*[contains(text(), 'ECGs')]")
  end

  def imaging_tab
    @selenium.find_element(:xpath, "//*[contains(text(), 'Imaging')]")
  end

  def vents_tab
    @selenium.find_element(:xpath, "//*[contains(text(), 'Vents')]")
  end

  def bodySensor_tab
    @selenium.find_element(:xpath, "//*[contains(text(), 'Body Sensor')]")
  end
end