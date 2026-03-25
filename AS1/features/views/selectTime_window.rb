# frozen_string_literal: true

Dir["#{File.dirname(__FILE__)}/../*.rb"].sort.each { |file| require file }

class SelectTime_Window
  def initialize(selenium)
    @selenium = selenium
  end

  def window_header
    @selenium.find_element(:css, 'div.swal2-header')
  end

  def time_object
    # different types are "hours" "minutes" "seconds"
    window = @selenium.find_element(:class, 'date-time-picker')
    # body = window.find_element(:class, 'rc-time-picker')
    # input = body.find_element(:class, 'rc-time-picker-input')
    window.find_element(:id, 'time')
  end

  def date_picker_select_date
    window = @selenium.find_element(:class, 'date-time-picker')
    # day_selectbox = window.find_element(:class, 'Select')
    # return day_selectbox
    window.find_elements(:css, 'input')
  end

  def select_day_options
    window = @selenium.find_element(:class, 'date-options')
    # menu_list = window.find_element(:class, 'Select__menu-list')
    opts =  window.find_elements(:class, 'option')
    
    #puts "========"
    #puts opts.count
    #puts "========"

    #for i in 0..(opts.count - 1)
    #  puts opts[i].text
    #end
  end

  def select_time_picker_combobox(hour, min, sec)
    combobox = @selenium.find_element(:class, 'rc-time-picker-panel-combobox')
    time = combobox.find_elements(:css, 'div')

    hours = time[0].find_elements(:css, 'li')
    (0..hours.count - 1).each do |h|
      if hours[h].text == hour
        hours[h].click
        break
      end
    end

    minutes = time[1].find_elements(:css, 'li')
    (0..minutes.count - 1).each do |m|
      if minutes[m].text == min
        minutes[m].click
        break
      end
    end

    seconds = time[2].find_elements(:css, 'li')
    (0..seconds.count - 1).each do |s|
      if seconds[s].text == sec
        seconds[s].click
        break
      end
    end
  end

  def time_input
    @selenium.find_element(:class, 'rc-time-picker-panel-input')
  end

  def window_header
    @selenium.find_element(:class, 'swal2-header')
  end

  def ok_button
    @selenium.find_element(:css, 'button.swal2-confirm.swal2-styled')
  end

  def cancel_button
    @selenium.find_element(:css, 'button.swal2-cancel.swal2-styled')
  end
end
