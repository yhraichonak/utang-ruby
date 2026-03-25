Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class SerialPresentation_screen
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end

  def back_button
    e = @selenium.find_element(:id, "#{APP_PACKAGE}:id/action_bar")
    buttons = e.find_elements(:class, 'android.widget.ImageButton')

    (0..(buttons.count - 1)).each do |i|
      if(buttons[i].tag_name == "Navigate up")
        return buttons[i]
      end
    end
  end

  def more_options_button
    e = @selenium.find_element(:id, "#{APP_PACKAGE}:id/action_bar")
    buttons = e.find_elements(:class, 'android.widget.ImageView')

    (0..(buttons.count - 1)).each do |i|
      if(buttons[i].tag_name == "More options")
        return buttons[i]
      end
    end
  end

  def patient_name
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_name")
  end

  def patient_gender
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_gender")
  end

  def patient_mrn
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_mrn")
  end

  def patient_location
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_location")
  end

  def site
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_site")
  end

  def top_ecg_grid(which)
    e = @selenium.find_element(:id, "#{APP_PACKAGE}:id/cardio_ecg_grid1")
    ecg = e.find_element(:id, "#{APP_PACKAGE}:id/#{which}")
    return ecg
  end

  def top_ecg_grid_element(which)
    return Element.new(@selenium,:id, "#{APP_PACKAGE}:id/#{which}")
  end

  def top_ecg_label(which)
    e = @selenium.find_element(:id, "#{APP_PACKAGE}:id/cardio_ecg_grid1")
    ecg_labels = e.find_elements(:id, "#{APP_PACKAGE}:id/tv_label")

    (0..(ecg_labels.count - 1)).each do |i|
      if ecg_labels[i].text == which
        return ecg_labels[i]
      end
    end
  end

  def top_ecg_legend
    ecg_legend = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/tv_legend")
    puts ecg_legend.count

    puts ecg_legend[0].text
    puts ecg_legend[1].text

    return ecg_legend[0]
  end

  def bottom_ecg_grid(which)
    e = @selenium.find_element(:id, "#{APP_PACKAGE}:id/cardio_ecg_viewgroup_grid2")
    ecg_grid = e.find_element(:id, "#{APP_PACKAGE}:id/#{which}")
    return ecg_grid
  end

  def bottom_ecg_label(which)
    e = @selenium.find_element(:id, "#{APP_PACKAGE}:id/cardio_ecg_viewgroup_grid2")
    ecg_labels = e.find_elements(:id, "#{APP_PACKAGE}:id/tv_label")

    (0..(ecg_labels.count - 1)).each do |i|
      if(ecg_labels[i].text == which)
        return ecg_labels[i]
      end
    end
  end

  def bottom_ecg_legend
    ecg_legend = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/tv_legemd")
    return ecg_legend[1]
  end

  def top_ecg_analysis
    e = @selenium.find_element(:id, "#{APP_PACKAGE}:id/cardio_patient_banner1")
    analysis = e.find_element(:id, "#{APP_PACKAGE}:id/tv_cardio_analysis")
    return analysis
  end

  def top_ecg_date_info
    e = @selenium.find_element(:id, "#{APP_PACKAGE}:id/cardio_patient_banner1")
    dt = e.find_element(:id, "#{APP_PACKAGE}:id/tv_cardio_datetime")
    return dt
  end

  def top_ecg_carrot
    e = @selenium.find_element(:id, "#{APP_PACKAGE}:id/cardio_patient_banner1")
    dt = e.find_element(:id, "#{APP_PACKAGE}:id/tb_cardio_drawer_indicator")
    return dt
  end

  def bottom_ecg_analysis
    e = @selenium.find_element(:id, "#{APP_PACKAGE}:id/cardio_patient_banner2")
    analysis = e.find_element(:id, "#{APP_PACKAGE}:id/tv_cardio_analysis")
    return analysis
  end

  def bottom_ecg_date_info
    e = @selenium.find_element(:id, "#{APP_PACKAGE}:id/cardio_patient_banner2")
    dt = e.find_element(:id, "#{APP_PACKAGE}:id/tv_cardio_datetime")
    return dt
  end

  def bottom_ecg_carrot
    e = @selenium.find_element(:id, "#{APP_PACKAGE}:id/cardio_patient_banner2")
    dt = e.find_element(:id, "#{APP_PACKAGE}:id/tb_cardio_drawer_indicator")
    return dt
  end

  def getPatientInfoFromHeader
    patientName = Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_name").text
    patientSex = Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_gender").text
    patientAge = Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_age").text
    patientSite = Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_site").text
    patientMrn = Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_mrn").text
    return {"name" => patientName, "gender" => patientSex, "age" => patientAge, "site" => patientSite, "mrn" => patientMrn}
  end

  def home_button
    Element.new(@selenium, :id, 'android:id/home')
  end

  def mainThreeSecondLeadGrid_element
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/cardio_ecg_viewgroup_grid1")
  end

  def compThreeSecondLeadGrid_element
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/cardio_ecg_viewgroup_grid2")
  end

  def mainThreeSecondLead_element(lead)
    case lead
    when "I"
      Element.new(@selenium, :id, "#{APP_PACKAGE}:id/I")
    when "II"
      Element.new(@selenium, :id, "#{APP_PACKAGE}:id/II")
    when "III"
      Element.new(@selenium, :id, "#{APP_PACKAGE}:id/III")
    when "aVR"
      Element.new(@selenium, :id, "#{APP_PACKAGE}:id/avr")
    when "aVL"
      Element.new(@selenium, :id, "#{APP_PACKAGE}:id/avl")
    when "aVF"
      Element.new(@selenium, :id, "#{APP_PACKAGE}:id/avf")
    when "V1"
      Element.new(@selenium, :id, "#{APP_PACKAGE}:id/v1")
    when "V2"
      Element.new(@selenium, :id, "#{APP_PACKAGE}:id/v2")
    when "V3"
      Element.new(@selenium, :id, "#{APP_PACKAGE}:id/v3")
    when "V4"
      Element.new(@selenium, :id, "#{APP_PACKAGE}:id/v4")
    when "V5"
      Element.new(@selenium, :id, "#{APP_PACKAGE}:id/v5")
    when "V6"
      Element.new(@selenium, :id, "#{APP_PACKAGE}:id/v6")
    end
  end

  def compThreeSecondLead_element(lead)
    case lead
    when "I"
      Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[2]/android.widget.LinearLayout[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[1]/android.widget.FrameLayout[1]/android.widget.TextView[1]')
    when "II"
      Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[2]/android.widget.LinearLayout[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[1]/android.widget.FrameLayout[2]/android.widget.TextView[1]')
    when "III"
      Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[2]/android.widget.LinearLayout[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[1]/android.widget.FrameLayout[3]/android.widget.TextView[1]')
    when "aVR"
      Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[2]/android.widget.LinearLayout[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[2]/android.widget.FrameLayout[1]/android.widget.TextView[1]')
    when "aVL"
      Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[2]/android.widget.LinearLayout[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[2]/android.widget.FrameLayout[2]/android.widget.TextView[1]')
    when "aVF"
      Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[2]/android.widget.LinearLayout[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[2]/android.widget.FrameLayout[3]/android.widget.TextView[1]') #
    when "V1"
      Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[2]/android.widget.LinearLayout[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[3]/android.widget.FrameLayout[1]/android.widget.TextView[1]')
    when "V2"
      Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[2]/android.widget.LinearLayout[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[3]/android.widget.FrameLayout[2]/android.widget.TextView[1]')
    when "V3"
      Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[2]/android.widget.LinearLayout[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[3]/android.widget.FrameLayout[3]/android.widget.TextView[1]')
    when "V4"
      Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[2]/android.widget.LinearLayout[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[4]/android.widget.FrameLayout[1]/android.widget.TextView[1]')
    when "V5"
      Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[2]/android.widget.LinearLayout[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[4]/android.widget.FrameLayout[2]/android.widget.TextView[1]')
    when "V6"
      Element.new(@selenium, :xpath, '//android.view.View[1]/android.widget.FrameLayout[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[2]/android.widget.LinearLayout[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[4]/android.widget.FrameLayout[3]/android.widget.TextView[1]')
    end
  end

  def getPatientEcgDetails(ecgNumber)
    ecg_diagnosis = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/tv_cardio_analysis")
    ecg_diagnosis = ecg_diagnosis.at(ecgNumber-1)

    ecg_time = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/tv_cardio_datetime")
    ecg_time = ecg_time.at(ecgNumber-1)

    sex = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/cardio_details_sex")
    sex = sex.at(ecgNumber-1)

    vhr = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/cardio_details_vhr")
    vhr = vhr.at(ecgNumber-1)

    ahr = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/cardio_details_ahr")
    ahr = ahr.at(ecgNumber-1)

    dob = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/cardio_details_dob")
    dob = dob.at(ecgNumber-1)

    pr = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/cardio_details_pr")
    pr = pr.at(ecgNumber-1)

    qt = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/cardio_details_qt")
    qt = qt.at(ecgNumber-1)

    age = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/cardio_details_age")
    age = age.at(ecgNumber-1)

    qrs = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/cardio_details_qrs")
    qrs = qrs.at(ecgNumber-1)

    qtc = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/cardio_details_qtc")
    qtc = qtc.at(ecgNumber-1)

    prt = @selenium.find_elements(:id, "#{APP_PACKAGE}:id/cardio_details_prt")
    prt = prt.at(ecgNumber-1)

    return {
      "diagnosis" => ecg_diagnosis.text,
      "time" => ecg_time.text,
      "sex" => sex.text,
      "vhr" => vhr.text,
      "ahr" => ahr.text,
      "dob" => dob.text,
      "pr" => pr.text,
      "qt" => qt.text,
      "age" => age.text,
      "qrs" => qrs.text,
      "qtc" => qtc.text,
      "prt" => prt.text
    }
  end

  def cardio_note
    Element.new(@selenium, :id, "#{APP_PACKAGE}:id/tv_cardio_serial_unrelated")
  end

  def ecg_details_chevron(which)
    parent = @selenium.find_element(:id, "#{APP_PACKAGE}:id/cardio_patient_banner#{which.to_i}")
    children = parent.find_elements(:class, 'android.widget.TextView')
    label_array = []

    (0..(children.count - 1)).each do |i|
      case children[i].text
      when "Sex:"
        sex_label = children[i].text
        label_array.append(sex_label)
      when "DOB:"
        dob_label = children[i].text
        label_array.append(dob_label)
      when "Age:"
        age_label = children[i].text
        label_array.append(age_label)
      when "Race:"
        race_label = children[i].text
        label_array.append(race_label)
      when "V.HR:"
        vhr_label = children[i].text
        label_array.append(vhr_label)
      when "A.HR:"
        ahr_label = children[i].text
        label_array.append(ahr_label)
      when "PR:"
        pr_label = children[i].text
        label_array.append(pr_label)
      when "QT:"
        qt_label = children[i].text
        label_array.append(qt_label)
      when "QRS:"
        qrs_label = children[i].text
        label_array.append(qrs_label)
      when "QTc:"
        qtc_label = children[i].text
        label_array.append(qtc_label)
      when "PRT(°):"
        prt_label = children[i].text
        label_array.append(prt_label)
      end
    end

    ecg_diagnosis = parent.find_element(:id, "#{APP_PACKAGE}:id/tv_cardio_analysis")

    ecg_time = parent.find_element(:id, "#{APP_PACKAGE}:id/tv_cardio_datetime")

    sex = parent.find_element(:id, "#{APP_PACKAGE}:id/cardio_details_sex")

    race = parent.find_element(:id, "#{APP_PACKAGE}:id/cardio_details_race")

    vhr = parent.find_element(:id, "#{APP_PACKAGE}:id/cardio_details_vhr")

    ahr = parent.find_element(:id, "#{APP_PACKAGE}:id/cardio_details_ahr")

    dob = parent.find_element(:id, "#{APP_PACKAGE}:id/cardio_details_dob")

    pr = parent.find_element(:id, "#{APP_PACKAGE}:id/cardio_details_pr")

    qt = parent.find_element(:id, "#{APP_PACKAGE}:id/cardio_details_qt")

    age = parent.find_element(:id, "#{APP_PACKAGE}:id/cardio_details_age")

    qrs = parent.find_element(:id, "#{APP_PACKAGE}:id/cardio_details_qrs")

    qtc = parent.find_element(:id, "#{APP_PACKAGE}:id/cardio_details_qtc")

    prt = parent.find_element(:id, "#{APP_PACKAGE}:id/cardio_details_prt")

    return{
      "diagnosis" => ecg_diagnosis.text,
      "time" => ecg_time.text,
      "sex_label" => label_array[0],
      "sex" => sex.text,
      "race_label" => label_array[3],
      "race" => race.text,
      "vhr_label" => label_array[4],
      "vhr" => vhr.text,
      "ahr_label" => label_array[5],
      "ahr" => ahr.text,
      "dob_label" => label_array[1],
      "dob" => dob.text,
      "pr_label" => label_array[6],
      "pr" => pr.text,
      "qt_label" => label_array[7],
      "qt" => qt.text,
      "age_label" => label_array[2],
      "age" => age.text,
      "qrs_label" => label_array[8],
      "qrs" => qrs.text,
      "qtc_label" => label_array[9],
      "qtc" => qtc.text,
      "prt_label" => label_array[10],
      "prt" => prt.text
    }
  end
end