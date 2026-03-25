Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

module PyBridge
  @relative_path = File.dirname(__FILE__)
  @cmd_as_one_prefs = "adb -s '#{$UDID}' shell run-as com.utang.one.qa cat shared_prefs/com.utang.one.qa_preferences.xml"
  @cmd_activities = "adb -s '#{$UDID}' shell dumpsys activity activities | grep mFocusedWindow"
  @cmd_windows = "adb -s '#{$UDID}' shell dumpsys activity recents | grep 'Recent #0'"
  @cmd_device_api = "adb -s '#{$UDID}' shell getprop ro.build.version.sdk"

  def self.package_shell(arg)
    Open3.popen3('python package_shell.py %s' % arg)
    return self.read_result_and_return
  end

  def self.pkg_shell_reg_code
    cmd_out = `#{@cmd_as_one_prefs} | grep REGISTRATION`
    if cmd_out != ""
      return cmd_out.split('">')[1].split("</s")[0]
    end
  end

  def self.read_result_and_return
    sleep(0.5)
    file = File.open('%s/python_lib/result.txt' % @relative_path)
    result = file.read
    file.close
    return result
  end

  def self.get_reg_code_from_pkg_shell
    result = self.pkg_shell_reg_code
    # result = self.package_shell('reg_code')
    if result == ""
      return false
    end
    return result
  end

  def self.get_last_login_user_for(site)
    case site.to_str
    when "34"; site_id = "1763"
    when "35"; site_id = "4186"
    when "M9"; site_id = "4103"
    when "MNX"; site_id = "4104"
    when "MPM"; site_id = "4121"
    when "NK"; site_id = "4645"
    when 'auto'; site_id = '4751'
    else; site_id = nil
    end
    find_string = "SiteLoginActivity_%s_" % site_id
    file_read = `#{@cmd_as_one_prefs} | grep "#{find_string}"`
    file_read = file_read.split('">')[1].split("</s")[0] if file_read != ""
    return file_read
  end

  def self.is_app_foregrounded(package="#{APP_PACKAGE}")
    # Returns true or false, if a match with the package string provided as argument
    # Note: Android 8-10 require a different command to capture foregrounded app string than 11+
    #       We use API levels as they are more easily handled as integers

    device_api = `#{@cmd_device_api}`.to_i
    # puts "\nDevice API level: %s" % device_api
    cmd_output = ""
    iteration = 0
    params = []

    until cmd_output != "" || iteration == 10
      cmd_output = `#{@cmd_activities}`.to_s if device_api >= 30 # Android 11 & higher
      params = ['/', ' u0 '] if device_api >= 30 # Android 11 & higher
      cmd_output = `#{@cmd_windows}`.to_s if device_api <= 29 # Android 10 & lower
      params = [' U=', ' A='] if device_api <= 29 # Android 10 & lower
      iteration += 1
    end

    # puts "Iterations: #{iteration}"
    result = cmd_output.split(params[0])[0].split(params[1])[1] if cmd_output != ""

    # puts "Command output: #{cmd_output}"
    # puts "Current package with activity/window in focus: '#{result}'"

    if package == result
      # puts "Package: '#{package}' is in FOREGROUND [API:%s|i:#{iteration}]" % device_api
      return true
    else
      # puts "Package: '#{package}' is in BACKGROUND [API:%s|i:#{iteration}]" % device_api
      return false
    end
  end

end
