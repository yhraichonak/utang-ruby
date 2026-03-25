# frozen_string_literal: true

# This will be for the "Events" option that has been selected when on a patient

Dir["#{File.dirname(__FILE__)}/../*.rb"].sort.each { |file| require file }

class PatientEvents_Screen
  def initialize(selenium)
    @selenium = selenium
  end

  def events_header_objects
    monitor_events = @selenium.find_element(:class, 'monitor-events')
    segment = monitor_events.find_element(:class, 'segments')
    segments = segment.find_elements(:class, 'segment')

    last_hour_title = segments[0].find_element(:class, 'header')
    last_hour_expand_link = segments[0].find_element(:class, 'expand-toggle')

    one_to_six_title = segments[1].find_element(:class, 'header')
    one_to_six_link = segments[1].find_element(:class, 'expand-toggle')

    more_than_six_title = segments[2].find_element(:class, 'header')
    more_than_six_link = segments[2].find_element(:class, 'expand-toggle')
    
    return {
      'last_hour_title' => last_hour_title,
      'last_hour_expand_link' => last_hour_expand_link,
      'one_to_six_title' => one_to_six_title,
      'one_to_six_link' => one_to_six_link,
      'more_than_six_title' => more_than_six_title,
      'more_than_six_link' => more_than_six_link
    }
  end

  def last_hour_event_count
    monitor_events = @selenium.find_element(:class, 'monitor-events')
    segment = monitor_events.find_element(:class, 'segments')
    segments = segment.find_elements(:class, 'segment')
    event_parent = segments[0].find_element(:class, 'events')

    count = 0
    begin
      events = event_parent.find_elements(:class, 'event')
      count = events.count
    rescue
    end

    return count
  end

  def one_to_six_event_count
    monitor_events = @selenium.find_element(:class, 'monitor-events')
    segment = monitor_events.find_element(:class, 'segments')
    segments = segment.find_elements(:class, 'segment')
    event_parent = segments[1].find_element(:class, 'events')

    count = 0
    begin
      events = event_parent.find_elements(:class, 'event')
      count = events.count
    rescue
    end
    return count
  end

  def more_than_six_event_count
    monitor_events = @selenium.find_element(:class, 'monitor-events')
    segment = monitor_events.find_element(:class, 'segments')
    segments = segment.find_elements(:class, 'segment')
    event_parent = segments[2].find_element(:class, 'events')

    count = 0
    begin
      events = event_parent.find_elements(:class, 'event')
      count = events.count
    rescue
    end
    return count
  end

  def last_hour_event_object
    monitor_events = @selenium.find_element(:class, 'monitor-events')
    segment = monitor_events.find_element(:class, 'segments')
    segments = segment.find_elements(:class, 'segment')
    event_parent = segments[0].find_element(:class, 'events')

    events = event_parent.find_elements(:class, 'event')
    puts "the last hour event count = #{events.count}"

    events_info = Array.new(events.count){Array.new(9)}

    for i in 0..(events.count - 1)
      event_message = events[i].find_element(:class, 'message')
      event_time = events[i].find_element(:class, 'time')

      discretes = events[i].find_elements(:class, 'discrete')

      hr_discrete_title = discretes[0].find_element(:class, 'title')
      hr_discrete_value = discretes[0].find_element(:class, 'value')

      pvc_discrete_title = discretes[1].find_element(:class, 'title')
      pvc_discrete_value = discretes[1].find_element(:class, 'value')

      events_info[i] = [event_message, event_time, hr_discrete_title, hr_discrete_value, pvc_discrete_title, pvc_discrete_value]
    end
    e = events.take(5)
    e_info = events_info.take(5)
    return {
      'events_info' => e_info,
      'events' => e
    }
  end

  def one_to_six_hours_event_object
    monitor_events = @selenium.find_element(:class, 'monitor-events')
    segment = monitor_events.find_element(:class, 'segments')
    segments = segment.find_elements(:class, 'segment')
    event_parent = segments[1].find_element(:class, 'events')

    events = event_parent.find_elements(:class, 'event')
    events_info = Array.new(events.count){Array.new(9)}

    for i in 0..(events.count - 1)
      event_message = events[i].find_element(:class, 'message')
      event_time = events[i].find_element(:class, 'time')

      discretes = events[i].find_elements(:class, 'discrete')

      hr_discrete_title = discretes[0].find_element(:class, 'title')
      hr_discrete_value = discretes[0].find_element(:class, 'value')

      pvc_discrete_title = discretes[1].find_element(:class, 'title')
      pvc_discrete_value = discretes[1].find_element(:class, 'value')

      events_info[i] = [event_message, event_time, hr_discrete_title, hr_discrete_value, pvc_discrete_title, pvc_discrete_value]
    end
    e = events.take(5)
    e_info = events_info.take(5)
    return {
      'events_info' => e_info,
      'events' => e
    }
  end

  def more_than_six_hours_events_object
    monitor_events = @selenium.find_element(:class, 'monitor-events')
    segment = monitor_events.find_element(:class, 'segments')
    segments = segment.find_elements(:class, 'segment')
    event_parent = segments[2].find_element(:class, 'events')

    events = event_parent.find_elements(:class, 'event')
    events_info = Array.new(events.count){Array.new(9)}

    for i in 0..(20)
      event_message = events[i].find_element(:class, 'message')
      event_time = events[i].find_element(:class, 'time')

      discretes = events[i].find_elements(:class, 'discrete')

      hr_discrete_title = discretes[0].find_element(:class, 'title')
      hr_discrete_value = discretes[0].find_element(:class, 'value')

      pvc_discrete_title = discretes[1].find_element(:class, 'title')
      pvc_discrete_value = discretes[1].find_element(:class, 'value')

      events_info[i] = [event_message, event_time, hr_discrete_title, hr_discrete_value, pvc_discrete_title, pvc_discrete_value]
    end

    e = events.take(5)
    e_info = events_info.take(5)
    return {
      'events_info' => e_info,
      'events' => e
    }
  end

  def alarms_object(which_segment)
    segment_parent = @selenium.find_element(:class, 'segments')
    segment_children = segment_parent.find_elements(:class, 'segment')
    events_parent = segment_children[which_segment.to_i].find_element(:class, 'events')
    events = events_parent.find_elements(:class, 'event')

    for i in 0..(events.count - 1)
      
    end
  end

  def more_than_six_date
    monitor_events = @selenium.find_element(:class, 'monitor-events')
    segment = monitor_events.find_element(:class, 'segments')
    segments = segment.find_elements(:class, 'segment')
    event_parent = segments[2].find_element(:class, 'events')
    date_header = event_parent.find_element(:class, 'date-header')
    return date_header
  end

  def patientEvents_view
    @selenium.find_element(:css, '.monitor-events')
  end

  def event_section(name)
    sections = @selenium.find_elements(:css, '.segment')
    (0..(sections.count - 1)).each do |i|
      header = sections[i].find_element(:css, '.header')
      return sections[i] if header.text.include? name
    end
  end

  def event_count
    events = @selenium.find_elements(:css, '.event')
    events.count
  end

  def firstEvent
    events = @selenium.find_elements(:css, '.event')
    priority = if events[0].attribute('className').include? 'medium'
                 'medium'
               elsif events[0].attribute('className').include? 'low'
                 'low'
               elsif events[0].attribute('className').include? 'high'
                 'high'
               elsif events[0].attribute('className').include? 'critical'
                 'critical'
               else
                 'unknown'
               end

    summary = events[0].find_element(:css, '.summary')
    # discrete_data = events[0].find_element(:class, 'discrete_data')
    # discretes = discrete_data.find_elements(:class, 'discretes')
    # title = []
    # value = []
    # for y in 0..(discretes.count - 1)
    #  title << discretes[y].find_element(:class, 'title').text
    #  value << discretes[y].find_element(:class, 'value').text
    # end

    message = summary.find_element(:css, '.message')
    time = summary.find_element(:css, '.time')
    {
      'event_obj' => events[0],
      'event_name' => message,
      'priority' => priority,
      'time' => time
    }
  end

  def patientEvent(section, name)
    sections = @selenium.find_elements(:css, '.segment')

    section_name = nil
    priority = nil
    time = nil

    (0..(sections.count - 1)).each do |i|
      header = sections[i].find_element(:css, '.header')
      next unless header.text.include? section

      section_name = section

      events = @selenium.find_elements(:css, '.event')
      (0..(events.count - 1)).each do |x|
        priority = if events[x].attribute('className').include? 'medium'
                     'medium'
                   elsif events[x].attribute('className').include? 'low'
                     'low'
                   elsif events[x].attribute('className').include? 'high'
                     'high'
                   elsif events[x].attribute('className').include? 'critical'
                     'critical'
                   else
                     'unknown'
                   end

        summary = events[x].find_element(:css, '.summary')
        # discrete_data = events[x].find_element(:class, 'discrete_data')
        # discretes = discrete_data.find_elements(:class, 'discretes')
        # title = []
        # value = []
        # for y in 0..(discretes.count - 1)
        #  title << discretes[y].find_element(:class, 'title').text
        #  value << discretes[y].find_element(:class, 'value').text
        # end

        message = summary.find_element(:class, 'message')
        time = summary.find_element(:class, 'time')
        if message.text.include? name
          return {
            'event_obj' => events[x],
            'section_name' => section_name,
            'event_name' => message.text,
            'priority' => priority,
            'time' => time.text
            # "discrete_titles" => title,
            # "discrete_values" => value
          }
        end
      end
    end
  end

  def expand_collapse_link(section)
    sections = @selenium.find_elements(:class, 'segment')
    (0..(sections.count - 1)).each do |i|
      header = sections[i].find_element(:class, 'header')
      next unless header.text.include? section

      link = header.find_element(:class, 'expand-toggle')
      expanded = false
      expanded = true if link.attribute('className').include? 'expanded'
      return {
        'link_obj' => link,
        'expanded' => expanded
      }
    end
  end
end
