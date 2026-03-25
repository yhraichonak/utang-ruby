Dir[File.dirname(__FILE__) + '/../*.rb'].each {|file| require file }

module DeviceExtensions

  private def adb_call(command)
    return `adb -s '#{$UDID}' #{command}`
  end

  private def shell_call(command)
    return `adb -s '#{$UDID}' shell #{command}`
  end

  private def get_window_size
    return shell_call('wm size').split('size: ')[1].split('x')
  end

  def display_power_cycle(off_duration=0.5)
    # This is a workaround hack for when activities have display issues.
    # Quickly restarts activity to fix certain 'issues'.
    toggle_display_state(set_state='off', off_wait=off_duration)
    toggle_display_state(set_state='on')
  end

  def get_display_state
    result = shell_call('dumpsys power | grep "Display Power"')
    if result.include?('ON')
      return 'on'
    else
      return 'off'
    end
  end

  def get_screen_orientation
    # Gets the device screen orientation between modes: [0,1,2,3]
    # 0 -> portrait-normal
    # 1 -> landscape-left
    # 2 -> portrait-upside-down
    # 3 -> landscape-right
    return shell_call("dumpsys input | grep 'SurfaceOrientation' | awk '{ print $2 }'")
  end

  def take_screenshot(name)
    @selenium.screenshot "#{$SCREENSHOT_HOME}/#{name}_#{Common.cur_time}.png"
  end

  def toggle_display_state(set_state='on', off_wait=1.6)
    if set_state == 'on'
      shell_call('input keyevent 82') # Turn on display
    else
      shell_call('input keyevent 223') # Turn off display (Soft sleep for wakelock 276)
      sleep(off_wait) # Off_wait of 0.6 = 1s (0.6 + 0.4 call delay)
    end
  end

  def toggle_app_switch(action='on')
    if action == 'on'
      shell_call('input keyevent KEYCODE_APP_SWITCH')
    elsif action == 'off'
      display_size = get_window_size
      x_center = (display_size[0].to_i).div(2)
      y_center = (display_size[1].to_i).div(2)
      shell_call("input tap #{x_center} #{y_center}")
    end
  end
  # module_function :toggle_app_switch

  def toggle_notification_bar(action='on')
    if action == 'on'
      return shell_call('cmd statusbar expand-notifications')
    else
      return shell_call('cmd statusbar collapse')
    end
  end
  # module_function :toggle_notification_bar

  def set_screen_orientation(mode=0, system_pause=1.75)
    # Sets the device screen orientation between modes: [0,1,2,3]
    # 0 -> portrait-normal
    # 1 -> landscape-left
    # 2 -> portrait-upside-down
    # 3 -> landscape-right
    shell_call('settings put system user_rotation %s' % mode)
    sleep(system_pause)

  end
  # module_function :set_screen_orientation

  def back_button_tap
    #Taps device Back button once
    shell_call('input keyevent 4')
  end
  # module_function :back_button_tap

  def home_button_tap
    #Taps device Home button once
    shell_call('input keyevent 3')
  end
  # module_function :home_button_tap

  def key_event(key)
    shell_call('input keyevent %s' % key)
  end

  def keycode_hash(char)
    keycodes = { 'A' => '29', 'B' => '30', 'C' => '31', 'D' => '32', 'E' => '33', 'F' => '34', 'G' => '35', 'H' => '36', 'I' => '37',
                 'J' => '38', 'K' => '39', 'L' => '40', 'M' => '41', 'N' => '42', 'O' => '43', 'P' => '44', 'Q' => '45', 'R' => '46',
                 'S' => '47', 'T' => '48', 'U' => '49', 'V' => '50', 'W' => '51', 'X' => '52', 'Y' => '53', 'Z' => '54', '0' => '7',
                 '1' => '8', '2' => '9', '3' => '10', '4' => '11', '5' => '12', '6' => '13', '7' => '14', '8' => '15', '9' => '116',
                 ' ' => '62' }

    return keycodes[char]
  end

  def string_to_key_conversion(string)
    string = string.upcase
    (0..(string.size - 1)).each do |i|
      key_event(keycode_hash(string[i]))
    end
  end

  def force_stop
    return 'adb shell am force-stop com.utang.one.qa'
  end

  def uninstall_app
    return 'adb uninstall com.utang.one.qa'
  end

  def install_app
    return "adb install #{APP_PATH}"
  end

  def launch_app
    return 'adb shell am start -n com.utang.one.qa/com.utang.one.qa.ui.user.WelcomeActivity'
  end
end
