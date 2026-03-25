require 'open3'
require 'pp'
require 'inifile'
require 'allure-cucumber'
module Common
  $testdata = IniFile.load('android/testdata.ini')
  # def archive_removal(days_over=7)
  #   archive_cleanup = `find "#{$ARCHIVE_DIR}" -type f -mtime +#{days_over.to_s} -name '*' -print0 | xargs -r0 rm --`
  #   puts "Removing archives more than #{days_over.to_s} days old... #{archive_cleanup}"
  # end

  # def archive_session_folders(source, target)
  #   # For archiving previous sessions
  #   Dir.chdir("#{source}") {
  #     filenames = Dir.entries(".")
  #     filenames.each { |fn|
  #       if fn.size == 8 && fn != '_archive'
  #         if fn != $DATE
  #           origin = "#{source}/%s" % fn
  #           destination = "#{target}/%s" % fn
  #           FileUtils.mv("#{origin}", "#{destination}")
  #         end
  #       end
  #     }
  #   }
  # end

  # def build_config_info
  #   puts "APPIUM::Driver Info"
  #   puts "Server Version: %s" % $driver.appium_server_status['build']['version']
  #   puts "appium_wait_interval= %s" % $driver.appium_wait_interval
  #   puts "appium_wait_timeout= %s" % $driver.appium_wait_timeout
  #   puts "automation_name= %s" % $driver.automation_name
  #   puts "core.custom_url= %s" % $driver.core.custom_url
  #   puts "driver.bridge.session_id= %s" % $driver.driver.bridge.session_id
  #   puts "$SCREENSHOT_HOME= %s" % $SCREENSHOT_HOME
  #   puts "$STACK_TRACE_DIR= %s" % $STACK_TRACE_DIR
  #   puts "$PROGRAM_NAME= %s" % $PROGRAM_NAME
  #   puts "$RUNTIME= %s" % $RUNTIME
  #   puts "$PROCESS_ID= %s" % $PROCESS_ID
  #   puts "$DEVICE_BUILD_VERSION= %s" % $DEVICE_BUILD_VERSION
  # end

  def convert_ci_site(string)
    case string
    when '34'; return '34 QA Cardio PM'
    when '35'; return 'QA Cardio PM 35'
    when '39'; return '39 QA GE WEB - CSG 231'
    when '45'; return 'Site 45 - HCA NewDev'
    when '1588'; return 'Carle Vent Dev'
    when '1544'; return 'Carle EMR Test'
    when '85'; return 'Training Site'
    when '1547'; return 'Palomar utang ONE OB'
    when '4170'; return 'Node Simulator'
    when 'MPM'; return 'Mindray PM'
    when 'NK'; return 'Nihon Khoden'
    when 'M9'; return 'Muse9'
    when 'MNX'; return 'MuseNX'
    when 'Auto'; return 'Automation Site'
    when 'qaauto'; return 'astqaautoenv1-01'
    else raise Exception.new "No matching case found for CI_SITE: '%s'" % string
    end
  end

  def compare_element_size_attr(element1, element2, check='both')
    # Pass in two elements along with argument 'check' that allows you to evaluate size attributes
    # Returns true if the attributes are the same and false if the attributes differ

    if check == 'both'
      return true if element1[0] == element2[0] && element1[1] == element2[1]
    elsif check == 'width'
      return true if element1[0] == element2[0]
    elsif check == 'height'
      return true if element1[1] == element2[1]
    else raise ArgumentError.new "String for check did not match either width, height, or both"
    end
    return false
  end

  def cur_time(format='default')
    if format == 'default'
      time = Time.now
      time = time.strftime("%m%d%Y%H%M%S")
      return time.to_s
    elsif format == 'date'
      time = Time.now
      time = time.strftime("%Y%m%d")
      return time.to_s
    elsif format == 'time'
      time = Time.now
      time = time.strftime("%H%M%S")
      return time.to_s
    end
  end

  def click_center_of_object(element)
    location = element.location
    aa = location[:x]
    bb = location[:y]

    xx = element.size[:width] / 2
    yy = element.size[:height] / 2

    x = aa+xx
    y = bb+yy

    puts "TouchAction(press): x=#{x}, y=#{y}  [element_loc_x=#{aa}, element_loc_y=#{bb}]"
    Appium::TouchAction.new.press(:x => x, :y => y).wait(500).release.perform
  end

  def double_tap(element)
    # The only way to get a fast double tap is this method
    # Must pass in an Element.new()
    element.click
    element.click
  end

  def first_run_check
    if $first_run
      return true
    end
    return $first_run
  end

  def set_first_run_false   # alpha sort exception
    $first_run = false
  end

  def get_current_utc_timestamp
    return Time.now.to_s
  end

  def random_time
    time = Time.now
    time = time.strftime("%m%d%Y%H%M%S")
    return time.to_s
  end

  # def record_result(path, data)
  #   if File.exist?("#{path}")
  #     read_data = File.read("#{path}")
  #     write_data = read_data.to_i + data.to_i
  #   else
  #     write_data = data
  #   end
  #   File.open("#{path}","w") { |f| f.write(write_data) }
  #   puts "[JBMR] file=#{path.split('/')[-1]} [read_data=#{read_data.to_s}] [write_data=#{write_data.to_s}]"
  # end

  def save_to_file(path, data, style=:line_by_line)
    # Save to file using style [:line_by_line, :dump, :append_by_line, :append_dump]
    #
    # :line_by_line = reads all strings in data, and writes them out newline separated
    # :dump = reads data as single line and writes to file
    # :append = adds data to existing file as single newline
    # puts "[File] Writing data to file: %s" % path

    if style == :line_by_line # strings line by line
      File.open("#{path}", 'w+') do |f|
        data.each { |element| f.puts(element) }
      end

    elsif style == :dump  # single line or data stream
      File.open("#{path}", 'w+').puts(data)

    elsif style == :append_by_line # add data to an existing file
      File.write("#{path}", data, mode: "a") do |f|
        data.each { |element| f.puts(element) }
      end

    end
  end

  def sitename_flag_config_check(sitename)
    #TODO: Delete useless method
    # err_msg = "The (Given) sitename='#{sitename}' does not match the cucumber flag SITE_NAME_CI='#{SITE_NAME_CI}'. \nFix run configuration!"
    # flunk err_msg if $CI_SITE != sitename
  end

  def swipe_screen(selenium, startX, startY, endX, endY, duration = 0.5)
    selenium.execute_script 'mobile: swipe', :startX => startX, :startY => startY, :endX => endX, :endY => endY, :duration => duration
  end

  def self.swipe_window(driver, x_pct_start=0.5, x_pct_end=0.5, y_pct_start=0.75, y_pct_end=0.25, dur_ms=1750)
    # This is a dynamic window swipe function. It swipes window by percent, adjusting for each device's dimensions.
    win_x_wid = $WINDOW_SIZE[0]
    win_y_len = $WINDOW_SIZE[1]

    x_start = (win_x_wid * x_pct_start).to_i
    x_end = (win_x_wid * x_pct_end).to_i
    y_start = (win_y_len * y_pct_start).to_i
    y_end = (win_y_len * y_pct_end).to_i

    # Appium::TouchAction
    #   .new
    #   .swipe(:start_x => x_start, :start_y => y_start, :end_x =>x_end, :end_y =>y_end, :duration => dur_ms)
    #   .perform

    action_builder = driver.action
    touch = action_builder.add_pointer_input(:touch, 'finger')
    touch.create_pointer_move(duration: 0, x: x_start, y: y_start)
    touch.create_pointer_down(:left)
    touch.create_pointer_move(duration: dur_ms/1000, x: x_end, y: y_end)
    touch.create_pause(1)
    touch.create_pointer_up(:left)
    action_builder.perform
  end

  def try_without_fail(name)
    begin
      yield
    rescue
      puts "[RESCUE] Method %s was rescued." % name
    end
  end

  def validate_dir(path)
    require 'fileutils'
    unless File.directory?("#{path}")
      FileUtils.mkdir_p("#{path}")
      # system('mkdir -p %s' & dirname)
    end
  end

  def validate_file(path, data=nil)
    require 'fileutils'
    if File.exist?("#{path}")
      FileUtils.remove_file("#{path}", force=true)
      FileUtils.touch("#{path}")
    end

    unless data == nil
      f = File.open("#{path}", "w+")
      f.write(data)
      f.close
    end
  end

  def wait_for_element(selenium, loc_type, locator)
    #wait for object to be displayed
    timeout_secs = 2
    exists = false
    for wait in 1..(timeout_secs*2) do
      begin
        id = selenium.find_element(loc_type, locator)
        if id
          exists = true
          break
        else
          #sleep(0.5)
        end
      rescue => e
        #sleep(0.5)
      end
    end
    return { "id" => id, "exists" => exists }
  end

  def wait_for_loading_prompt
    #check/wait for 'Loading...' prompt
    sleep(1)
    @wait.until { @selenium.find_element(:class_name, "#{APP_PACKAGE}:id/progress").displayed? == false }
  end
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

