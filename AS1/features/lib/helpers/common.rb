require 'allure-cucumber'
require 'inifile'
require 'pp'
$testdata = IniFile.load('AS1/testdata.ini')
module Common

  def get_amp_url_by(site)
    case site
    when '34'; return AUTHENTICATED_AMP34_URL
    when '35'; return AUTHENTICATED_AMP35_URL
    when 'automation'; return AUTHENTICATED_AMPAUTOMATION_URL
    else
      raise Exception.new "No AMP site associated with parameter [%s]" % site
    end
  end

  AllureCucumber.configure do |c|
    c.clean_results_directory  = false
    c.results_directory = "/docs/allure"
  end

  def is_element_present(selenium,how, what)
    initial_timeout=selenium.manage.timeouts.implicit_wait
    selenium.manage.timeouts.implicit_wait = 0
    result = selenium.find_elements(how, what).size() > 0
    if result
      result = selenium.find_element(how, what).displayed?
    end
    selenium.manage.timeouts.implicit_wait =initial_timeout
    return result
  end
  def find_element_no_wait(selenium,how, what)
    result=nil
    initial_timeout=selenium.manage.timeouts.implicit_wait
    selenium.manage.timeouts.implicit_wait = 0
    if !selenium.find_elements(how, what).empty?
      result = selenium.find_element(how, what)
    end
    selenium.manage.timeouts.implicit_wait =initial_timeout
    return result
  end
  def find_element_no_wait(selenium,container,how, what)
    result=nil
    initial_timeout=selenium.manage.timeouts.implicit_wait
    selenium.manage.timeouts.implicit_wait = 0
    if !container.find_elements(how, what).empty?
      result = container.find_element(how, what)
    end
    selenium.manage.timeouts.implicit_wait =initial_timeout
    return result
  end
  def click_if_element_present(selenium,how, what)
    if (is_element_present(selenium,how,what))
      selenium.find_element(how,what).click()
    end
  end
end
