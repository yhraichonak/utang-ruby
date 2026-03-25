Dir[File.dirname(__FILE__) + '/../*.rb'].each {|file| require file }

class PM_Monitor_screen
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end

  def reload_button
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/menu_reload")
  end

  def live_monitor_button
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/live_button")
  end

  def choose_time_cancel
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/button2")
  end

  def pm_wave_form
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/pm_waveform")
  end

  def events_list
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/events_list")
  end

  def events_discretes
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/discretes")
  end

  def pm_wave_wrapper
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/pm_wavewrapper")
  end

  def navbar_events_button
    return @selenium.find_element(:accessibility_id, 'EVENTS')
  end

  def navbar_events_element
    return Element.new(@selenium, :accessibility_id, 'EVENTS')
  end

  def navbar_ecgs_button
    return @selenium.find_element(:accessibility_id, 'ECGs')
  end

  def navbar_ecgs_element
    return Element.new(@selenium, :accessibility_id, 'ECGs')
  end

  def navbar_tools_button
    return @selenium.find_element(:accessibility_id, 'TOOLS')
  end

  def navbar_tools_element
    return Element.new(@selenium, :accessibility_id, 'TOOLS')
  end

  def navbar_home_button
    return @selenium.find_element(:accessibility_id, 'HOME')
  end

  def navbar_home_element
    return Element.new(@selenium, :accessibility_id, 'HOME')
  end

  def navbar_share_button
    return @selenium.find_element(:accessibility_id, 'SHARE')
  end

  def navbar_share_element
    return Element.new(@selenium, :accessibility_id, 'SHARE')
  end

  def navbar_monitor_button
    return @selenium.find_element(:accessibility_id, 'MONITOR')
  end

  def navbar_monitor_element
    return Element.new(@selenium, :accessibility_id, 'MONITOR')
  end

  def control_live_button
    return @selenium.find_element(:accessibility_id, 'Live')
  end

  def control_live_element
    return Element.new(@selenium, :accessibility_id, 'Live')
  end

  def lead_checkbox(lead_name)
    elements = @selenium.find_elements(:class, 'android.widget.CheckBox')

    (1..elements.count).each { |i|
      if elements[i].text == lead_name
        return elements[i]
      end
    }
  end

  def time_index
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/pm_timeindex")
  end

  def time_ago
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/pm_timeago")
  end

  def print_relative_layout_views
    elements = @selenium.find_elements(:class, 'android.widget.RelativeLayout')
    elements.each { |b| puts 'relative layout views = ' + b.text }
  end

  def share_button
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/menu_share")
  end

  def first_three_discretes
    discretes_object = @selenium.find_element(:id, "#{APP_PACKAGE}:id/pm_vertical_discretes")
    linears = discretes_object.find_elements(:class, 'android.widget.LinearLayout')

    hr_title = linears[0].find_element(:id, "#{APP_PACKAGE}:id/title")
    hr_value = linears[0].find_element(:id, "#{APP_PACKAGE}:id/valueLeft")

    pvc_title = linears[3].find_element(:id, "#{APP_PACKAGE}:id/title")
    pvc_value = linears[3].find_element(:id, "#{APP_PACKAGE}:id/valueLeft")

    nbp_title = linears[6].find_element(:id, "#{APP_PACKAGE}:id/title")
    nbp_left = linears[6].find_element(:id, "#{APP_PACKAGE}:id/valueLeft")
    nbp_sep = linears[6].find_element(:id, "#{APP_PACKAGE}:id/valueSeparator")
    nbp_right = linears[6].find_element(:id, "#{APP_PACKAGE}:id/valueRight")
    nbp_average = linears[6].find_element(:id, "#{APP_PACKAGE}:id/average")
    nbp_timestamp = linears[6].find_element(:id, "#{APP_PACKAGE}:id/timestamp")

    ar1_title = linears[9].find_element(:id, "#{APP_PACKAGE}:id/title")
    ar1_left = linears[9].find_element(:id, "#{APP_PACKAGE}:id/valueLeft")
    ar1_sep = linears[9].find_element(:id, "#{APP_PACKAGE}:id/valueSeparator")
    ar1_right = linears[9].find_element(:id, "#{APP_PACKAGE}:id/valueRight")
    ar1_average = linears[9].find_element(:id, "#{APP_PACKAGE}:id/average")
    ar1_timestamp = linears[9].find_element(:id, "#{APP_PACKAGE}:id/timestamp")

    return {
      'hr_title' => hr_title.text,
      'hr_value' => hr_value.text,
      'pvc_title' => pvc_title.text,
      'pvc_value' => pvc_value.text,
      'nbp_title' => nbp_title.text,
      'nbp_left' => nbp_left.text,
      'nbp_sep' => nbp_sep.text,
      'nbp_right' => nbp_right.text,
      'nbp_average' => nbp_average.text,
      'nbp_timestamp' => nbp_timestamp.text,
      'ar1_title' => ar1_title.text,
      'ar1_left' => ar1_left.text,
      'ar1_sep' => ar1_sep.text,
      'ar1_right' => ar1_right.text,
      'ar1_average' => ar1_average.text,
      'ar1_timestamp' => ar1_timestamp.text
    }
  end

  def hr_discrete
    # discrete_value = 'HR'
    # discretes_object = @selenium.find_element(:id, "#{APP_PACKAGE}:id/pm_vertical_discretes")
    # linears = discretes_object.find_elements(:class, 'android.widget.LinearLayout')
    # object = nil
    # titleText = nil
    # found = false
    #
    # (0..(linears.count - 1)).each do |i|
    #   txts = linears[i].find_elements(:class,'android.widget.TextView')
    #   (0..(txts.count - 1)).each do |x|
    #     titleText = txts[x].text
    #     if(titleText ==	discrete_value)
    #       object = linears[i]
    #       found = true
    #       break
    #     end
    #   end
    #   if found == true
    #     break
    #   end
    # end
    #
    # value = object.find_element(:id,"#{APP_PACKAGE}:id/valueLeft").text
    #
    # return {
    #   'title' => titleText,
    #   'value' => value,
    #   'object' => object
    # }
    discrete_title = 'HR'
    containers = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/discrete_box_container")
    titles = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/title")

    titles.each_with_index do |title, index|
      title = title.text
      if title.include? discrete_title
        discrete_cell = containers[index]
        value = discrete_cell.find_element(:id, "#{APP_PACKAGE}:id/valueLeft").text

        return {
          'title' => title,
          'value' => value,
          'object' => discrete_cell
        }
      end
    end

    raise Exception.new 'ERROR: No matching discrete title.'
  end


  def training_hr_discrete
    discretes_object = @selenium.find_element(:id, "#{APP_PACKAGE}:id/pm_vertical_discretes")
    linears = discretes_object.find_elements(:class, 'android.widget.LinearLayout')
    lin_obj_needed = nil

    (0..(linears.count - 1)).each do |i|
      txts = linears[i].find_elements(:class, 'android.widget.TextView')
      (0..(txts.count - 1)).each do |x|
        if txts[x].attribute('text') == 'HR Bpm'
          lin_obj_needed = linears[i]
          break
        end
      end
    end

    hr_object = lin_obj_needed
    hr_title = lin_obj_needed.find_element(:id, "#{APP_PACKAGE}:id/title")
    hr_value = lin_obj_needed.find_element(:id, "#{APP_PACKAGE}:id/valueLeft")

    return {
      'hr_title' => hr_title,
      'hr_value' => hr_value,
      'hr_object' => hr_object
    }
  end

  def pvc_discrete
    discrete_title = 'PVC'
    containers = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/discrete_box_container")
    titles = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/title")

    titles.each do |title|
      title = title.text
      if title.include? discrete_title
        discrete_cell = containers[containers.length - 1]
        value = discrete_cell.find_element(:id, "#{APP_PACKAGE}:id/valueLeft").text

        return {
          'title' => title,
          'value' => value,
          'object' => discrete_cell
        }
      end
    end

    raise Exception.new 'ERROR: No matching discrete title.'
  end

  def nbp_discrete
    discretes_object = @selenium.find_element(:id, "#{APP_PACKAGE}:id/pm_vertical_discretes")
    linears = discretes_object.find_elements(:class, 'android.widget.LinearLayout')
    lin_obj_needed = nil

    (0..(linears.count - 1)).each do |i|
      txts = linears[i].find_elements(:class, 'android.widget.TextView')
      (0..(txts.count - 1)).each do |x|
        if txts[x].text == 'NBP mm[Hg]'
          lin_obj_needed = linears[i]
          break
        end
      end
    end

    nbp_object = lin_obj_needed
    nbp_title = lin_obj_needed.find_element(:id, "#{APP_PACKAGE}:id/title")
    nbp_left = lin_obj_needed.find_element(:id, "#{APP_PACKAGE}:id/valueLeft")
    nbp_separator = lin_obj_needed.find_element(:id, "#{APP_PACKAGE}:id/valueSeparator")
    nbp_right = lin_obj_needed.find_element(:id, "#{APP_PACKAGE}:id/valueRight")

    return {
      'nbp_title' => nbp_title,
      'nbp_left' => nbp_left,
      'nbp_separator' => nbp_separator,
      'nbp_right' => nbp_right,
      'nbp_object' => nbp_object
    }
  end

  def ar1_discrete
    discretes_object = @selenium.find_element(:id, "#{APP_PACKAGE}:id/pm_vertical_discretes")
    linears = discretes_object.find_elements(:class, 'android.widget.LinearLayout')
    lin_obj_needed = nil

    (0..(linears.count - 1)).each do |i|
      txts = linears[i].find_elements(:class, 'android.widget.TextView')
      (0..(txts.count - 1)).each do |x|
        if txts[x].text == 'AR1 mm[Hg]'
          lin_obj_needed = linears[i]
          break
        end
      end
    end

    ar1_object = lin_obj_needed
    ar1_title = lin_obj_needed.find_element(:id, "#{APP_PACKAGE}:id/title")
    ar1_left = lin_obj_needed.find_element(:id, "#{APP_PACKAGE}:id/valueLeft")
    ar1_separator = lin_obj_needed.find_element(:id, "#{APP_PACKAGE}:id/valueSeparator")
    ar1_right = lin_obj_needed.find_element(:id, "#{APP_PACKAGE}:id/valueRight")

    return {
      'ar1_title' => ar1_title,
      'ar1_left' => ar1_left,
      'ar1_separator' => ar1_separator,
      'ar1_right' => ar1_right,
      'ar1_object' => ar1_object
    }
  end

  def hr_discrete_object
    vertical_discretes = @selenium.find_element(:id, "#{APP_PACKAGE}:id/pm_vertical_discretes")
    linear_layouts = vertical_discretes.find_elements(:class, 'android.widget.LinearLayout')

    discrete = nil
    title = nil
    value = nil

    (0..(linear_layouts.count - 1)).each do |i|
      txts = linear_layouts[i].find_elements(:class, 'android.widget.TextView')
      (0..(txts.count - 1)).each do |x|

        #puts "#{txts[x].text} .. #{txts[x].text.include? "HR"} .. #{txts[x].text ==  "HR {beat}/min"}"

        if txts[x].text.include? 'HR' #"HR {beat}/min"
          discrete = linear_layouts[i]
          title =  txts[x].text
          value = txts[x + 1].text
          #title = linear_layouts[i].find_element(:id, "#{APP_PACKAGE}:id/title").text
          #value = linear_layouts[i].find_element(:id, "#{APP_PACKAGE}:id/valueLeft").text
          #puts title
          #puts value
          break
        end
      end
    end

    return {
      'discrete' => discrete,
      'title' => title,
      'discrete_value' => value
    }
  end

  def pvc_discrete_object
    vertical_discretes = @selenium.find_element(:id, "#{APP_PACKAGE}:id/pm_vertical_discretes")
    linear_layouts = vertical_discretes.find_elements(:class, 'android.widget.LinearLayout')

    discrete = nil
    title = nil
    value = nil

    (0..(linear_layouts.count - 1)).each do |i|
      txts = linear_layouts[i].find_elements(:class, 'android.widget.TextView')
      (0..(txts.count - 1)).each do |x|
        if txts[x].text.include? 'PVC' #PVC {beat}/min
          discrete = linear_layouts[i]
          title = linear_layouts[i].find_element(:id, "#{APP_PACKAGE}:id/title").text
          value = linear_layouts[i].find_element(:id, "#{APP_PACKAGE}:id/valueLeft").text
        end
      end
    end

    return {
      'discrete' => discrete,
      'title' => title,
      'discrete_value' => value
    }
  end

  def nbp_discrete_object
    vertical_discretes = @selenium.find_element(:id, "#{APP_PACKAGE}:id/pm_vertical_discretes")
    linear_layouts = vertical_discretes.find_elements(:class, 'android.widget.LinearLayout')

    discrete = nil
    title = nil
    value = nil
    average = nil
    timestamp = nil

    (0..(linear_layouts.count - 1)).each do |i|
      txts = linear_layouts[i].find_elements(:class, 'android.widget.TextView')
      (0..(txts.count - 1)).each do |x|
        if txts[x].text.include? 'NBP' #NBP mm[Hg]
          discrete = linear_layouts[i]
          title = linear_layouts[i].find_element(:id, "#{APP_PACKAGE}:id/title")
          left  = linear_layouts[i].find_element(:id, "#{APP_PACKAGE}:id/valueLeft").text
          separator = linear_layouts[i].find_element(:id, "#{APP_PACKAGE}:id/valueSeparator").text
          right = linear_layouts[i].find_element(:id, "#{APP_PACKAGE}:id/valueRight").text
          value = "#{left}#{separator}#{right}"
          average = linear_layouts[i].find_element(:id, "#{APP_PACKAGE}:id/average").text
          timestamp = linear_layouts[i].find_element(:id, "#{APP_PACKAGE}:id/timestamp").text
        end
      end
    end

    return {
      'discrete' => discrete,
      'title' => title,
      'discrete_value' => value,
      'average' => average,
      'timestamp' => timestamp
    }
  end

  def ar_discrete_object
    vertical_discretes = @selenium.find_element(:id, "#{APP_PACKAGE}:id/pm_vertical_discretes")
    linear_layouts = vertical_discretes.find_elements(:class, 'android.widget.LinearLayout')

    discrete = nil
    title = nil
    value = nil
    average = nil

    (0..(linear_layouts.count - 1)).each do |i|
      txts = linear_layouts[i].find_elements(:class, 'android.widget.TextView')
      (0..(txts.count - 1)).each do |x|
        if txts[x].text.include? 'AR1' #AR1 mm[Hg]
          discrete = linear_layouts[i]
          title = linear_layouts[i].find_element(:id, "#{APP_PACKAGE}:id/title")
          left  = linear_layouts[i].find_element(:id, "#{APP_PACKAGE}:id/valueLeft").text
          separator = linear_layouts[i].find_element(:id, "#{APP_PACKAGE}:id/valueSeparator").text
          right = linear_layouts[i].find_element(:id, "#{APP_PACKAGE}:id/valueRight").text
          value = "#{left}#{separator}#{right}"
          average = linear_layouts[i].find_element(:id, "#{APP_PACKAGE}:id/average").text

        end
      end
    end

    return {
      'discrete' => discrete,
      'title' => title,
      'discrete_value' => value,
      'average' => average
    }
  end

  def st_discrete_object
    vertical_discretes = @selenium.find_element(:id, "#{APP_PACKAGE}:id/pm_vertical_discretes")
    linear_layouts = vertical_discretes.find_elements(:class, 'android.widget.LinearLayout')

    discrete = nil
    title = nil
    value = nil
    average = nil

    (0..(linear_layouts.count - 1)).each do |i|
      txts = linear_layouts[i].find_elements(:class, 'android.widget.TextView')
      (0..(txts.count - 1)).each do |x|
        if txts[x].text == 'ST mm'
          discrete = linear_layouts[i]
        end
      end
    end

    ######################
    screen_size = @selenium.manage.window.size
    puts screen_size[:width]
    puts screen_size[:height]
    dis_size = discrete.location
    puts dis_size[:x]
    puts dis_size[:y]

    grid = discrete.find_element(:class, 'android.widget.GridLayout')
    grid_txts = grid.find_elements(:class, 'android.widget.TextView')
    puts grid_txts.count

    return {
      'discrete' => discrete,
      'title' => title,
      'discrete_value' => value,
      'average' => average
    }
  end

  def count_values
    parent = @selenium.find_element(:xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[1]/android.widget.ScrollView[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[5]/android.widget.GridLayout[1]')
    children =  parent.find_elements
    counter = 0
    while counter < children.count
      counter +=1
    end
  end

  def events_discrete
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/discretes")
  end

  def patient_name
    patient_name = @selenium.find_element(:id, "#{APP_PACKAGE}:id/tv_name")
    # patient_name = action_bar.find_element(:id, "#{APP_PACKAGE}:id/tv_name")
    return patient_name
  end

end