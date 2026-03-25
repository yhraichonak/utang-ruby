Dir[File.dirname(__FILE__) + '/../*.rb'].each {|file| require file }

class ECG_View_screen
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end

  def close_menu_button
    return @selenium.find_element(:accessibility_id, 'Close')
  end

  def ecg_patient_banner
    return Element.new(@selenium, :id, "#{APP_PACKAGE}:id/cardio_patient_banner")
  end

  def ecg_slider_container
    return @selenium.find_element(:id, "#{APP_PACKAGE}:id/master_container")
  end

  def ecg_slider_container_element
    return Element.new(@selenium, :id, "#{APP_PACKAGE}:id/master_container")
  end

  def ecg_miview_button
    return @selenium.find_element(:accessibility_id, 'MIView')
  end

  def ecg_miview_element
    return Element.new(@selenium, :accessibility_id, 'MIView')
  end

  def ecg_details_button
    return @selenium.find_element(:id, "#{APP_PACKAGE}:id/menu_cardio_show_ecgdetails")
  end

  def ecg_details_element
    return Element.new(@selenium, :id, "#{APP_PACKAGE}:id/menu_cardio_show_ecgdetails")
  end

  def print_relative_view
    elements = @selenium.find_elements(:class, 'android.widget.RelativeLayout')
    elements.each { |b| puts 'relative layout android.view.Views = ' + b.attribute('android.widget.TextView') }
  end

  def print_text
    elements = @selenium.find_elements(:class, 'android.widget.TextView')
    elements.each { |b| puts 'android.widget.TextView android.view.Views = ' + b.attribute('android.widget.TextView') }
  end

  def threeSecondLeadGrid_element
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/cardio_ecg_grid")
  end

  def tvCardioDatetime_element
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_cardio_datetime")
  end

  def tenSecondLeadGrid_element
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/cardio_ecg_stack")
  end

  def TTthreeSecondLead_element(lead)
    element_name = "#{APP_PACKAGE}:id/#{lead}"
    e = Element.new(@selenium, :id, element_name)
    return e
  end

  def threeSecondLead_element(lead)
    parent = @selenium.find_element(:id, "#{APP_PACKAGE}:id/cardio_ecg_grid")
    # el = Element.new(@selenium, :class, 'AppCompatImageButton').attribute('contentDescription')

    if(lead == 'I')
      lead = lead
    elsif(lead == 'II')
      lead = lead
    elsif(lead == 'III')
      lead = lead
    else
      lead = lead.downcase
    end

    element_name = "#{APP_PACKAGE}:id/#{lead}"
    child = parent.find_element(:id, element_name)
    return child
  end

  def tenSecondLead_element(lead)
    sleep(1)
    lead = lead.downcase
    tryCount = 0
    row = 1
    found = false
    element = nil

    while !found && (tryCount < 7)
      begin
        catch :leave_loop do
          e = @selenium.find_element(:id, "#{APP_PACKAGE}:id/cardio_ecg_stack")
          elements = e.find_elements(:id, "#{APP_PACKAGE}:id/tv_label")
          (0..(elements.count)).each do |i|
            # puts elements[i].text
            if elements[i].text.downcase == lead
              element = elements[i]
              found = true
              throw :leave_loop if found
            end
          end
        end
        return element if found
      rescue NoMethodError || NoSuchElementError # Rescuing method to swipe down when array tries to access element that's not one the screen yet
        e = @selenium.find_element(:id, "#{APP_PACKAGE}:id/cardio_ecg_stack")
        elements = e.find_elements(:id, "#{APP_PACKAGE}:id/tv_label")
        action_builder = @selenium.action
        touch = action_builder.add_pointer_input(:touch, 'finger')
        touch.create_pointer_move(duration: 0, x: elements[elements.length-2].location[:x], y: elements[elements.length-2].location[:y])
        touch.create_pointer_down(:left)
        touch.create_pointer_move(duration: 1, x: elements[elements.length-2].location[:x], y: elements[elements.length-2].location[:y]-400)
        touch.create_pause(0.1)
        touch.create_pointer_up(:left)
        action_builder.perform
      end

      tryCount += 1
    end
  end

  def getPatientInfoFromHeader
    patientName = Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_name").text
    patientSex = Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_gender").text
    patientAge = Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_age").text
    patientSite = Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_site").text
    patientMrn = Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_mrn").text
    return {'name' => patientName, 'gender' => patientSex, 'age' => patientAge, 'site' => patientSite, 'mrn' => patientMrn}
  end

  def get_ecg_view_group
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/cardio_ecg_main_viewgroup")
  end

  def edit_button
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/menu_cardio_edit")
  end

  def ecg_diagnosis
    Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.view.View[1]/android.widget.FrameLayout[1]/android.widget.ScrollView[1]/android.widget.LinearLayout[1]/android.widget.FrameLayout[1]/android.widget.LinearLayout[1]/android.widget.TextView[1]')
  end

  def ecg_diagnosis_time
    Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.view.View[1]/android.widget.FrameLayout[1]/android.widget.ScrollView[1]/android.widget.LinearLayout[1]/android.widget.FrameLayout[1]/android.widget.LinearLayout[1]/android.widget.TextView[2]')
  end

  def chevron
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tb_cardio_drawer_indicator")
  end

  def ecgList_listView
    Element.new(@selenium, :id, 'android:id/list')
  end

  def ecg_scroll_view
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/cardio_ecg_scroll_view")
  end

  def ecg_list_slide_empty
    Element.new(@selenium, :id, 'android:id/empty')
  end

  def ecg_list_info(ecgRow)

    ecg_list_diagnosis = Element.new(@selenium, :xpath, "//android.view.View[1]/android.widget.FrameLayout[1]/android.view.View[1]/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.widget.ListView[1]/android.widget.LinearLayout[#{ecgRow}]/android.widget.LinearLayout[1]/android.widget.TextView[1]")
    ecg_list_tme = Element.new(@selenium, :xpath, "//android.view.View[1]/android.widget.FrameLayout[1]/android.view.View[1]/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.widget.ListView[1]/android.widget.LinearLayout[#{ecgRow}]/android.widget.LinearLayout[1]/android.widget.TextView[2]")

    return {
      'diagnosis' => ecg_list_diagnosis.text,
      'time' => ecg_list_tme.text
    }
  end

  def ecgs_list
    parent = @selenium.find_element(:id, "#{APP_PACKAGE}:id/action_bar_container")
    burger = parent.find_element(:class, 'android.widget.ImageButton')
    return burger
  end

  def ecg_details
    ecg_diagnosis = Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.view.View[1]/android.widget.FrameLayout[1]/android.widget.ScrollView[1]/android.widget.LinearLayout[1]/android.widget.FrameLayout[1]/android.widget.LinearLayout[1]/android.widget.TextView[1]')
    ecg_time = Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.view.View[1]/android.widget.FrameLayout[1]/android.widget.ScrollView[1]/android.widget.LinearLayout[1]/android.widget.FrameLayout[1]/android.widget.LinearLayout[1]/android.widget.TextView[2]')

    return {
      'diagnosis' => ecg_diagnosis.text,
      'time' => ecg_time.text
    }
  end

  def ecg_details_chevron
    ecg_diagnosis = Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_cardio_analysis")
    ecg_time = Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_cardio_datetime")
    #not sure if race should be included.
    sex_label = Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.view.View[1]/android.widget.FrameLayout[1]/android.widget.ScrollView[1]/android.widget.LinearLayout[1]/android.widget.FrameLayout[1]/android.widget.LinearLayout[1]/android.widget.TableLayout[1]/android.widget.TableRow[1]/android.widget.TextView[1]')
    sex = Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.view.View[1]/android.widget.FrameLayout[1]/android.widget.ScrollView[1]/android.widget.LinearLayout[1]/android.widget.FrameLayout[1]/android.widget.LinearLayout[1]/android.widget.TableLayout[1]/android.widget.TableRow[1]/android.widget.TextView[2]')

    vhr_label = Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.view.View[1]/android.widget.FrameLayout[1]/android.widget.ScrollView[1]/android.widget.LinearLayout[1]/android.widget.FrameLayout[1]/android.widget.LinearLayout[1]/android.widget.TableLayout[1]/android.widget.TableRow[1]/android.widget.TextView[3]')
    vhr = Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.view.View[1]/android.widget.FrameLayout[1]/android.widget.ScrollView[1]/android.widget.LinearLayout[1]/android.widget.FrameLayout[1]/android.widget.LinearLayout[1]/android.widget.TableLayout[1]/android.widget.TableRow[1]/android.widget.TextView[4]')

    ahr_label = Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.view.View[1]/android.widget.FrameLayout[1]/android.widget.ScrollView[1]/android.widget.LinearLayout[1]/android.widget.FrameLayout[1]/android.widget.LinearLayout[1]/android.widget.TableLayout[1]/android.widget.TableRow[1]/android.widget.TextView[5]')
    ahr = Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.view.View[1]/android.widget.FrameLayout[1]/android.widget.ScrollView[1]/android.widget.LinearLayout[1]/android.widget.FrameLayout[1]/android.widget.LinearLayout[1]/android.widget.TableLayout[1]/android.widget.TableRow[1]/android.widget.TextView[6]')

    dob_label = Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.view.View[1]/android.widget.FrameLayout[1]/android.widget.ScrollView[1]/android.widget.LinearLayout[1]/android.widget.FrameLayout[1]/android.widget.LinearLayout[1]/android.widget.TableLayout[1]/android.widget.TableRow[2]/android.widget.TextView[1]')
    dob = Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.view.View[1]/android.widget.FrameLayout[1]/android.widget.ScrollView[1]/android.widget.LinearLayout[1]/android.widget.FrameLayout[1]/android.widget.LinearLayout[1]/android.widget.TableLayout[1]/android.widget.TableRow[2]/android.widget.TextView[2]')

    pr_label = Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.view.View[1]/android.widget.FrameLayout[1]/android.widget.ScrollView[1]/android.widget.LinearLayout[1]/android.widget.FrameLayout[1]/android.widget.LinearLayout[1]/android.widget.TableLayout[1]/android.widget.TableRow[2]/android.widget.TextView[3]')
    pr = Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.view.View[1]/android.widget.FrameLayout[1]/android.widget.ScrollView[1]/android.widget.LinearLayout[1]/android.widget.FrameLayout[1]/android.widget.LinearLayout[1]/android.widget.TableLayout[1]/android.widget.TableRow[2]/android.widget.TextView[4]')

    qt_label = Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.view.View[1]/android.widget.FrameLayout[1]/android.widget.ScrollView[1]/android.widget.LinearLayout[1]/android.widget.FrameLayout[1]/android.widget.LinearLayout[1]/android.widget.TableLayout[1]/android.widget.TableRow[2]/android.widget.TextView[5]')
    qt = Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.view.View[1]/android.widget.FrameLayout[1]/android.widget.ScrollView[1]/android.widget.LinearLayout[1]/android.widget.FrameLayout[1]/android.widget.LinearLayout[1]/android.widget.TableLayout[1]/android.widget.TableRow[2]/android.widget.TextView[6]')

    age_label = Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.view.View[1]/android.widget.FrameLayout[1]/android.widget.ScrollView[1]/android.widget.LinearLayout[1]/android.widget.FrameLayout[1]/android.widget.LinearLayout[1]/android.widget.TableLayout[1]/android.widget.TableRow[3]/android.widget.TextView[1]')
    age = Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.view.View[1]/android.widget.FrameLayout[1]/android.widget.ScrollView[1]/android.widget.LinearLayout[1]/android.widget.FrameLayout[1]/android.widget.LinearLayout[1]/android.widget.TableLayout[1]/android.widget.TableRow[3]/android.widget.TextView[2]')

    qrs_label = Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.view.View[1]/android.widget.FrameLayout[1]/android.widget.ScrollView[1]/android.widget.LinearLayout[1]/android.widget.FrameLayout[1]/android.widget.LinearLayout[1]/android.widget.TableLayout[1]/android.widget.TableRow[3]/android.widget.TextView[3]')
    qrs = Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.view.View[1]/android.widget.FrameLayout[1]/android.widget.ScrollView[1]/android.widget.LinearLayout[1]/android.widget.FrameLayout[1]/android.widget.LinearLayout[1]/android.widget.TableLayout[1]/android.widget.TableRow[3]/android.widget.TextView[4]')

    qtc_label = Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.view.View[1]/android.widget.FrameLayout[1]/android.widget.ScrollView[1]/android.widget.LinearLayout[1]/android.widget.FrameLayout[1]/android.widget.LinearLayout[1]/android.widget.TableLayout[1]/android.widget.TableRow[3]/android.widget.TextView[5]')
    qtc = Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.view.View[1]/android.widget.FrameLayout[1]/android.widget.ScrollView[1]/android.widget.LinearLayout[1]/android.widget.FrameLayout[1]/android.widget.LinearLayout[1]/android.widget.TableLayout[1]/android.widget.TableRow[3]/android.widget.TextView[6]')

    prt_label = Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.view.View[1]/android.widget.FrameLayout[1]/android.widget.ScrollView[1]/android.widget.LinearLayout[1]/android.widget.FrameLayout[1]/android.widget.LinearLayout[1]/android.widget.TableLayout[1]/android.widget.TableRow[4]/android.widget.TextView[2]')
    prt = Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.view.View[1]/android.widget.FrameLayout[1]/android.widget.ScrollView[1]/android.widget.LinearLayout[1]/android.widget.FrameLayout[1]/android.widget.LinearLayout[1]/android.widget.TableLayout[1]/android.widget.TableRow[4]/android.widget.TextView[3]')

    return {
      'diagnosis' => ecg_diagnosis.text,
      'time' => ecg_time.text,
      'sex_label' => sex_label.text,
      'sex' => sex.text,
      'vhr_label' => vhr_label.text,
      'vhr' => vhr.text,
      'ahr_label' => ahr_label.text,
      'ahr' => ahr.text,
      'dob_label' => dob_label.text,
      'dob' => dob.text,
      'pr_label' => pr_label.text,
      'pr' => pr.text,
      'qt_label' => qt_label.text,
      'qt' => qt.text,
      'age_label' => age_label.text,
      'age' => age.text,
      'qrs_label' => qrs_label.text,
      'qrs' => qrs.text,
      'qtc_label' => qtc_label.text,
      'qtc' => qtc.text,
      'prt_label' => prt_label.text,
      'prt' => prt.text
    }
  end

  def ecg_list_object_parent
  Element.new(@selenium, :id, 'android:id/list')
  end

  def ecg_list(ecgRow)
    e = @selenium.find_element(:id, 'android:id/list')
    elements = e.find_elements(:id, "#{APP_PACKAGE}:id/tv_cardio_diagnosis")
    return elements[ecgRow.to_i - 1]
  end

  def ecgs_button
  e = @selenium.find_element(:id, "#{APP_PACKAGE}:id/action_bar")
  elements = e.find_elements(:class, 'android.widget.ImageButton')

  (0..(elements.count)).each do |i|
    if (elements[i].tag_name == 'Navigate up')
      return elements[i]
    end
  end
  end

  def options_button
    Element.new(@selenium, :uiautomator, 'new UiSelector().className("android.widget.ImageView").description("More options")')
  end

  def click_ecg_one
    Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.view.View[1]/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.widget.ListView[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[1]/android.widget.TextView[1]')
  end

  def ecgs_option
    Element.new(@selenium, :xpath, '//android.widget.ListView[1]/android.widget.LinearLayout[1]/android.widget.RelativeLayout[1]/android.widget.TextView[1]')
  end

  def ecg_legend
    Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.view.View[1]/android.widget.FrameLayout[1]/android.widget.ScrollView[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[1]/android.widget.FrameLayout[1]/android.widget.TextView[2]')
  end

  def ecg_patient_details_legend
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/btn_cardio_details_info")
  end

  def display_page_source
    result = JSON.parse @selenium.page_source
    return result
  end

  def tap_off_of_list
    @selenium.execute_script 'mobile: tap', :startX => 0.75, :startY => 0.9
  end

  def ecg_demo_patient_name
    return Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_name")
  end

  def ecg_demo_patient_gender
    return Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_gender_age")
  end

  def ecg_demo_patient_age
    return Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_gender_age")
  end

  def ecg_demo_patient_mrn
    return Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_mrn")
  end

  def ecg_demo_patient_location
    return Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_location")
  end

  def ecg_demo_patient_site
    return Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_site")
  end

end
