require 'allure-cucumber'
require 'inifile'
module Common
  $testdata = IniFile.load('iOS/testdata.ini')
  def cur_time
    time = Time.now
    time = time.strftime("%m%d%Y%H%M%S")
    return time.to_s
  end

  def server_status
    status = `curl http://0.0.0.0:4723/wd/hub/status`
    return status
  end

  def click_center_of_object(e)
    element = e
    location = element.location
		aa = location[:x]
		bb = location[:y]

		xx = element.size[:width] / 2
		yy = element.size[:height] / 2

    $GLOBAL_APPIUM.action.move_to_location( aa + xx, bb + yy ).click.perform
  end

  def do_swipe(startX=600,startY=550,endX=600,endY=200)
    $GLOBAL_APPIUM.action.move_to_location(startX, startY).pointer_down(:left).move_to_location(endX, endY).release.perform
  end

  def do_small_swipe(startX=600,startY=550,endX=600,endY=500)
    $GLOBAL_APPIUM.action.move_to_location(startX, startY).pointer_down(:left).move_to_location(endX, endY).release.perform
  end

  def double_tap(element)
    $GLOBAL_APPIUM.execute_script 'mobile: doubleTap', :x => element.rect['x'] + element.rect['width']/2, :y => element.rect['y'] + element.rect['height']/2
  end


  def wait_for_element(selenium, loc_type, locator)
    wait_for_element_with_timeout(selenium, loc_type, locator, 1)
  end

  def wait_for_element_with_timeout(selenium, loc_type, locator, timeout_secs)
    exists = false
    for wait in 1..(timeout_secs) do
      begin
        id = selenium.find_element(loc_type, locator)
        if id
          exists = true
          break
        else
          puts "attempt #{wait} to wait for element"
        end
      rescue => e
        sleep(1)
      end
    end
    return { "id" => id, "exists" => exists }
  end

  #def wait_for_loading_prompt(selenium)

  #  @driver.execute_script 'mobile: waitForPageLoad'
  #end
  def resetSession
    @appiumDriver.driver_quit
    @appiumDriver.start_driver
  end

  def wait_for_loading_prompt(selenium)
    #check/wait for 'Loading...' prompt
    timeout_secs = 15

    for wait in 1..(timeout_secs*2) do
      begin
		  e = Appium_lib.first_element_by_class('XCUIElementTypeActivityIndicator')
		  puts e.text
        if selenium.find_element(:class_name, 'XCUIElementTypeActivityIndicator').displayed?
          #puts '(wait...)'

        else
          #puts 'break'
          break
        end
      rescue => e

        #puts 'error-break'
        break
      end
    end
    #puts 'done'
  end


  def print_elementTree(selenium)
    puts @driver.execute_script("UIATarget.localTarget().logElementTree();")
  end
  AllureCucumber.configure do |config|
    config.clean_results_directory  = false
    config.results_directory = '/docs/allure'
    config.logging_level = Logger::INFO
    config.logger = Logger.new($stdout, Logger::DEBUG)
    config.environment = 'environment'

    # these are used for creating links to bugs or test cases where {} is replaced with keys of relevant items
    config.link_tms_pattern = 'http://qa-app-01/testrail/index.php?/cases/view/{}'
    config.link_issue_pattern = 'https://utang.atlassian.net/browse/{}'

    # additional metadata
    # environment.properties
    config.environment_properties = {
      custom_attribute: 'foo'
    }
    # categories.json
    # config.categories = File.new("my_custom_categories.json")
  end

end
