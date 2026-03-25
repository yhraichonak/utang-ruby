# frozen_string_literal: true

Dir["#{File.dirname(__FILE__)}/../*.rb"].sort.each { |file| require file }

class PM_Monitor_Screen
  def initialize(selenium)
    @selenium = selenium
  end

  def patient_info_object
    p_header = @selenium.find_element(:class, 'patient-header')
    p_info = p_header.find_element(:class, 'patient-info')
    name = p_info.find_element(:class, 'name').text
    age_sex = p_info.find_element(:class, 'age').text
    
    mrn_location = p_info.find_element(:class, 'info').text

    {
      'name' => name,
      'age_sex' => age_sex,
      'mrn_location' => mrn_location
    }
  end

  def patientMonitor_toolbar
    @selenium.find_element(:css, 'nav.main-nav')
  end

  def patientMonitor_body
    #@selenium.find_element(:css, 'div.monitor-charts')
    @selenium.find_element(:class, 'monitor-body')
  end

  def pm_sub_nav_bar
    monitor = @selenium.find_element(:css, 'div.monitor.widget')
    monitor.find_element(:css, 'nav.sub-nav')
  end

  def navigation_link(name)
    monitor = @selenium.find_element(:css, 'div.monitor.widget')
    sub_navbar = monitor.find_element(:css, 'nav.sub-nav')
    span_objs = sub_navbar.find_elements(:css, 'span')

    (0..(span_objs.count - 1)).each do |x|
      links = span_objs[x].find_elements(:css, 'a')

      (0..(links.count - 1)).each do |i|
        # puts links[i].text
        return links[i] if links[i].text == name
      end
    end
  end

  def monitor_heart_rate_value 
    discrete_column = @selenium.find_element(:class, 'discrete-column')
    hr_discrete=discrete_column.find_element(:css, '.hr-beat-min,.hr-b-min,.hr-bpm,hr-min')
    hr_discrete.find_element(:class, 'value')
  end

  def discrete(name)
    discretes = @selenium.find_elements(:class, 'chiclet')
    (0..(discretes.count - 1)).each do |i|
      next unless discretes[i].text.include? name

      status = if discretes[i].attribute('className').include? 'active'
                 true
               else
                 false
               end
      return {
        'discrete_obj' => discretes[i],
        'status' => status
      }
    end
  end

  def totalTrendsGraphs
    trendsView = @selenium.find_element(:class, 'trend-charts')
    charts = trendsView.find_elements(:class, 'chart')
    (0..(charts.count - 1)).each do |i|
      puts charts[i].find_element(:class, 'chart-title').text
    end
    charts.count
  end

  def chart(name)
    trendsView = @selenium.find_element(:class, 'trend-charts')
    charts = trendsView.find_elements(:class, 'chart')
    (0..(charts.count - 1)).each do |i|
      title = charts[i].find_element(:class, 'chart-title')
      return charts[i] if title.text == name
    end
  end

  def monitor_time
    monitor_body = @selenium.find_element(:class, 'monitor-body')
    begin
      charts = monitor_body.find_element(:class, 'charts')
      monitor_charts = charts.find_element(:class, 'monitor-charts')
      chart_timestamp = monitor_charts.find_element(:class, 'chart-end-time')
    rescue
      chart_header = monitor_body.find_element(:class, 'chart-header')
      chart_timestamp = chart_header.find_element(:class, 'timestamp')
    end
    puts "++++"
    puts chart_timestamp.text
    puts "++++"
    return chart_timestamp
  end

  def monitor_time_ago
    @selenium.find_element(:class, 'latency')
  end

  def live_button
    sub_nav_menu = @selenium.find_element(:class, 'sub-nav')
    spans = sub_nav_menu.find_elements(:css, 'span')

    (0..(spans.count - 1)).each do |i|
      buttons = spans[i].find_elements(:css, 'a')

      (0..(buttons.count - 1)).each do |x|
        next unless buttons[x].text == 'Live'

        status = buttons[x].attribute('className').include? "active"
        return {
          'live_button_obj' => buttons[x],
          'status' => status
        }
      end
    end
  end

  def monitor_zoom
    monitor = @selenium.find_element(:class, 'monitor-charts')
    zoom = monitor.find_element(:class, 'zoom-control')
    zoom.find_element(:css, 'input')
  end

  def monitor_lead(name = "")
    leads = @selenium.find_elements(:class, 'monitor-chart')
    (0..(leads.count - 1)).each do |i|
      label = leads[i].find_element(:class, 'label')
      status = leads[i].attribute('className').include?('disabled') 
      if !name == ""
        next unless label.text == name
      end
     
      status = status == false
      # puts label.text
      # puts status
      return {
        'lead_obj' => label,
        'status' => status
      }
    end
  end

  def monitor_lead_by_order(order_number)
    monitor_body = @selenium.find_element(:class, 'monitor-body')
    charts = monitor_body.find_element(:class, 'charts')
    monitor_charts = charts.find_element(:class, 'monitor-charts')
    monitor_cs = monitor_charts.find_elements(:class, 'monitor-chart')

    label = monitor_cs[order_number.to_i - 1].find_element(:class, 'label')
    
    status_value = monitor_cs[order_number.to_i - 1].attribute('className')
    
    puts "----------"
    puts status_value
    puts "----------"

    status = nil

    if status_value.include?('disabled')
      status = "off"
    else
      status = "on"
    end

    #leads = @selenium.find_elements(:class, 'monitor-chart')
    #label = leads[order_number.to_i - 1].find_element(:class, 'label')
    #status = leads[order_number.to_i - 1].attribute('className').include?('disabled')

    #status = status == false
    #puts label.text
    #puts status

    {
      'lead_obj' => label,
      'status' => status
    }
  end

  def monitor_events_by_name(name)
    event = @selenium.find_element(:class, 'monitor-events')
    events = event.find_elements(:class, 'event')
    event_type = nil

    (0..(events.count - 1)).each do |i|
      summary = events[i].find_element(:class, 'summary')
      message = summary.find_element(:class, 'message')

      next unless message.text == name

      if events[i].attribute('className').include?('high')
        event_type = 'high'
      elsif events[i].attribute('className').include?('medium')
        event_type = 'medium'
      elsif events[i].attribute('className').include?('low')
        event_type = 'low'
      end
      return {
        'event_obj' => events[i],
        'event_type' => event_type,
        'event_message' => message
      }
    end
  end

  def monitor_events
    event = @selenium.find_element(:class, 'monitor-events')
    events = event.find_elements(:class, 'event')
    event_type = []
    message = nil
    summary = nil

    (0..(events.count - 1)).each do |i|
      summary = events[i].find_element(:class, 'summary')
      message = summary.find_element(:class, 'message')

      if events[i].attribute('className').include?('high')
        event_type[i] = 'high'
      elsif events[i].attribute('className').include?('medium')
        event_type[i] = 'medium'
      elsif events[i].attribute('className').include?('low')
        event_type[i] = 'low'
      end
    end

    {
      'event_obj' => events,
      'event_type' => event_type,
      'event_message' => message
    }
  end

  def trends_close_button(which)
    close_buttons = @selenium.find_elements(:css, 'svg.icon.icon-x')
    close_buttons[which]
  end
end
