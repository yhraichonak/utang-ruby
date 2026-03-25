# frozen_string_literal: true

# This is for a shared header bar amongst the site screens

Dir["#{File.dirname(__FILE__)}/../*.rb"].sort.each { |file| require file }

class Summary_Screen
  def initialize(selenium)
    @selenium = selenium
  end

  # should display "utang ONE"
  def main_nav
    @selenium.find_element(:class, 'main-nav')
  end

  def ecg_tile
    tiles = @selenium.find_element(:class, 'tiles')
    tiles.find_element(:class, 'ecgs')
  end

  def ecg_tile_no_results
    tiles = @selenium.find_element(:class, 'tiles')
    tile = tiles.find_element(:class, 'ecgs')
    content = tile.find_element(:class, 'tile-content')

    {
      'results' => content.find_element(:class, 'no-results')
    }
  end

  def general_info_tile
    tiles = @selenium.find_element(:class, 'tiles')
    tiles.find_element(:class, 'demographics')
  end

  def general_info_window
    window = @selenium.find_element(:class, 'tile-content')
    fields = window.find_elements(:class, 'field')

    if fields.length() >= 6
      { 'race' => fields[5].find_element(:class, 'value') }
    end
    {
        'window_obj' => window,
        'patient_name' => fields[0].find_element(:class, 'value'),
        'mrn' => fields[1].find_element(:class, 'value'),
        'dob' => fields[2].find_element(:class, 'value'),
        'gender' => fields[3].find_element(:class, 'value'),
        'age' => fields[4].find_element(:class, 'value')
      }
  end

  def general_info_window_simulator
    window = @selenium.find_element(:class, 'tile-content')
    fields = window.find_elements(:class, 'field')

    {
      'window_obj' => window,
      'weight' => fields[0].find_element(:class, 'value'),
      'admit_date' => fields[1].find_element(:class, 'value'),
      'code_status' => fields[2].find_element(:class, 'value'),
      'location' => fields[3].find_element(:class, 'value'),
      'isolation_status' => fields[4].find_element(:class, 'value'),
      'fin' => fields[5].find_element(:class, 'value'),
      'dob' => fields[6].find_element(:class, 'value'),
      'religion' => fields[7].find_element(:class, 'value'),
      'language' => fields[8].find_element(:class, 'value'),
      'primary_contact' => fields[9].find_element(:class, 'value'),
      'secondary_contact' => fields[10].find_element(:class, 'value'),
      'age' => fields[11].find_element(:class, 'value'),
      'primary_md' => fields[12].find_element(:class, 'value')
    }
  end

  def ok_tile_window_button
    @selenium.find_element(:css, 'button.swal2-confirm.swal2-styled')
  end

  def monitor_tile
    tiles = @selenium.find_element(:class, 'tiles')
    tiles.find_element(:class, 'monitor')
  end

  def monitor_tile_info
    tiles = @selenium.find_element(:class, 'tiles')
    tile = tiles.find_element(:class, 'monitor')
    title = tile.find_element(:class, 'title')
    content = tile.find_element(:class, 'tile-content')

    {
      'title' => title,
      'status' => content.find_element(:class, 'status'),
      'results' => content.find_element(:class, 'no-results')
    }
  end

  def monitor_tile_info_with_events
    tiles = @selenium.find_element(:class, 'tiles')
    tile = tiles.find_element(:class, 'monitor')
    title = tile.find_element(:class, 'title')
    content = tile.find_element(:class, 'tile-content')

    {
      'title' => title,
      'count' => title.find_element(:class, 'count'),
      'status' => content.find_element(:class, 'status'),
      'results' => content.find_elements(:class, 'day-group')
    }
  end

  def events_tile
    tiles = @selenium.find_element(:class, 'tiles')
    tiles.find_element(:class, 'events')
  end

  def ecg_tile_info_object
    tiles = @selenium.find_element(:class, 'tiles')
    ecg_tile = tiles.find_element(:css, 'div.tile.ecgs')
    tile_content = ecg_tile.find_element(:css, 'div.tile-content.ecgs')
    ecg_rows = 	tile_content.find_elements(:class, 'ecg')
    ecg_count = ecg_rows.count

    ecg_diagnosis = []
    ecg_date = []

    if ecg_count.positive?
      (0..ecg_count - 1).each do |i|
        ecg_diagnosis[i] = ecg_rows[i].find_element(:class, 'diagnosis').text
        ecg_date[i] = ecg_rows[i].find_element(:class, 'date').text
      end
    end

    {
      'ecg_count' => ecg_count,
      'ecg_diagnosis' => ecg_diagnosis,
      'ecg_date' => ecg_date
    }
  end

  def ecg_count
    tiles = @selenium.find_element(:class, 'tiles')
    ecg_tile = tiles.find_element(:css, 'div.tile.ecgs')
    title = ecg_tile.find_element(:class, 'title')
    count_header = title.find_element(:class, 'count')
    tile_content = ecg_tile.find_element(:css, 'div.tile-content.ecgs')
    count_tile = tile_content.find_element(:class, 'number')

    {
      'count_header' => count_header.text,
      'count_tile' => count_tile.text
    }
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

  def ventilator_tile
    tiles = @selenium.find_element(:class, 'tiles')
    tiles.find_element(:class, 'ventilator')
  end

  def ventilator_tile_simulator
    tiles = @selenium.find_element(:class, 'tiles')
    tile = tiles.find_element(:class, 'ventilator')
    fields = tile.find_elements(:class, 'field')

    {
      'window_obj' => tile,
      'rr' => fields[0].find_element(:class, 'value'),
      'ex_vt' => fields[1].find_element(:class, 'value'),
      'ex_ve' => fields[2].find_element(:class, 'value'),
      'pip' => fields[3].find_element(:class, 'value'),
      'peep' => fields[4].find_element(:class, 'value'),
      'peep_total' => fields[5].find_element(:class, 'value')
    }
  end

  def documents_tile
    tiles = @selenium.find_element(:class, 'tiles')
    tile = tiles.find_element(:class, 'documents')
    doc_rows = 	tile.find_elements(:class, 'doc')
    totalDocCount = tile.find_element(:class, 'count')
    doc_count = doc_rows.count

    doc_description = []
    doc_date = []

    if doc_count.positive?
      (0..doc_count - 1).each do |i|
        doc_description[i] = doc_rows[i].find_element(:class, 'name').text
        doc_date[i] = doc_rows[i].find_element(:class, 'date').text
      end
    end

    {
      'window_obj' => tile,
      'total_doc_count' => totalDocCount,
      'doc_count' => doc_count,
      'doc_description' => doc_description,
      'doc_date' => doc_date
    }
  end
end
