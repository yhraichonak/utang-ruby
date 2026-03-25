Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class Snippets_screen
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end

  def nav_bar
    nav = @selenium.find_element(:class, "XCUIElementTypeNavigationBar")
    return nav
  end

  def patient_name
	  txts = nav_bar.find_elements(:class, 'XCUIElementTypeStaticText')
	  name = txts[0].text
	  return name
  end

  def patient_info
    txts = nav_bar.find_elements(:class, 'XCUIElementTypeStaticText')

    #for i in 0..(txts.count - 1)
    #  if(txts[i].nil?)
    #  else
    #    puts "txt #{i} = #{txts[i].text}"
    #  end
    #end

    name = txts[0].text
    one = txts[1].text
    dots = (0 ... one.length).find_all { |i| one[i,1] == "•" }
    pid = one.slice(0..(dots[0]).to_i - 1)
    loc = one[(dots[0].to_i + 1)..(dots[1].to_i - 1)]
    hm = one[(dots[1].to_i + 1)..(dots[2].to_i - 1)]
    site = one[(dots[2].to_i + 1)..one.length]

    two = txts[2].text
    dots = (0 ... two.length).find_all { |i| two[i,1] == "•" }
    gender = two.slice(0.to_i + 2..(dots[1]).to_i - 2)
    years = two[(dots[1].to_i + 2)..two.length]

    return {
      "name" => name,
      "pid" => pid,
      "loc" => loc,
      "hm" => hm,
      "site" => site,
      "gender" => gender,
      "years" => years
    }
  end

  def get_txts_ipad124
    txts = @selenium.find_elements(:class, 'XCUIElementTypeStaticText')

    #for i in 0..(txts.count - 1)
    #  puts "#{i} = #{txts[i].text}"
    #end

    return{
      "ecg_dropdown" => txts[6].text,
      "time_one" => txts[3].text,
      "time_two" => txts[4].text,
      "ecg_one" => txts[8].text,
      "ecg_two" => txts[9].text,
      "date" => txts[10].text,
      "time" => txts[11].text,

      "hr_label" => txts[12].text,
      "hr_value" => txts[13].text,
      "pr_label" => txts[14].text,
      "pr_value" => txts[15].text,
      "qrs_label" => txts[16].text,
      "qrs_value" => txts[17].text,
      "qt_label" => txts[18].text,
      "qt_value" => txts[19].text,
      "qtc_label" => txts[20].text,
      "qtc_value" => txts[21].text
    }
  end

  def get_txts_ipad133
    txts = @selenium.find_elements(:class, 'XCUIElementTypeStaticText')

    #for i in 0..(txts.count - 1)
    #  puts "#{i} = #{txts[i].text}"
    #end

    return{
      "ecg_dropdown" => txts[3].text,
      "time_one" => txts[4].text,
      "time_two" => txts[4].text,
      "ecg_one" => txts[8].text,
      "ecg_two" => txts[9].text,
      "date" => txts[10].text,
      "time" => txts[11].text,

      "hr_label" => txts[12].text,
      "hr_value" => txts[13].text,
      "pr_label" => txts[14].text,
      "pr_value" => txts[15].text,
      "qrs_label" => txts[16].text,
      "qrs_value" => txts[17].text,
      "qt_label" => txts[18].text,
      "qt_value" => txts[19].text,
      "qtc_label" => txts[20].text,
      "qtc_value" => txts[21].text
    }
  end

  def get_txts_iphone124
    txts = @selenium.find_elements(:class, 'XCUIElementTypeStaticText')
    if $debug_flag == "debug"
        for i in 0..(txts.count - 1)
          puts "#{i} = #{txts[i].text}"
        end
    end
    return{
      "ecg_dropdown" => txts[4].text,
      "time_one" => txts[5].text,
      "time_two" => txts[5].text,
      "ecg_one" => txts[6].text,
      "ecg_two" => txts[7].text,
      "date" => txts[8].text,
      "time" => txts[9].text,

      "hr_label" => txts[10].text,
      "hr_value" => txts[11].text,
      "pr_label" => txts[12].text,
      "pr_value" => txts[13].text,
      "qrs_label" => txts[14].text,
      "qrs_value" => txts[15].text,
      "qt_label" => txts[16].text,
      "qt_value" => txts[17].text,
      "qtc_label" => txts[18].text,
      "qtc_value" => txts[19].text
    }
  end

  def get_txts_iphone133
    txts = @selenium.find_elements(:class, 'XCUIElementTypeStaticText')

    #for i in 0..(txts.count - 1)
    # puts "#{i} = #{txts[i].text}"
    #end

    return{
      "ecg_dropdown" => txts[3].text,
      "time_one" => txts[4].text,
      "time_two" => txts[4].text,
      "ecg_one" => txts[8].text,
      "ecg_two" => txts[9].text,
      "date" => txts[10].text,
      "time" => txts[11].text,

      "hr_label" => txts[12].text,
      "hr_value" => txts[13].text,
      "pr_label" => txts[14].text,
      "pr_value" => txts[15].text,
      "qrs_label" => txts[16].text,
      "qrs_value" => txts[17].text,
      "qt_label" => txts[18].text,
      "qt_value" => txts[19].text,
      "qtc_label" => txts[20].text,
      "qtc_value" => txts[21].text
    }
  end

  def get_txts_i7_plus
    txts = @selenium.find_elements(:class, 'XCUIElementTypeStaticText')

    #for i in 0..(txts.count - 1)
    #  puts "#{i} = #{txts[i].text}"
    #end

    return{
      "ecg_dropdown" => txts[3].text,
      "time_one" => txts[4].text,
      "time_two" => txts[4].text,
      "ecg_one" => txts[5].text,
      "ecg_two" => txts[6].text,
      "date" => txts[7].text,
      "time" => txts[8].text,

      "hr_label" => txts[9].text,
      "hr_value" => txts[10].text,
      "pr_label" => txts[11].text,
      "pr_value" => txts[12].text,
      "qrs_label" => txts[13].text,
      "qrs_value" => txts[14].text,
      "qt_label" => txts[15].text,
      "qt_value" => txts[16].text,
      "qtc_label" => txts[17].text,
      "qtc_value" => txts[18].text
    }
  end

  def get_txts_ipad
    txts = @selenium.find_elements(:class, 'XCUIElementTypeStaticText')

    #for i in 0..(txts.count - 1)
    #  puts "#{i} = #{txts[i].text}"
    #end

    return{
      "ecg_dropdown" => txts[6].text,
      "time_one" => txts[7].text,
      "time_two" => txts[7].text,
      "ecg_one" => txts[8].text,
      "ecg_two" => txts[9].text,
      "date" => txts[10].text,
      "time" => txts[11].text,

      "hr_label" => txts[12].text,
      "hr_value" => txts[13].text,
      "pr_label" => txts[14].text,
      "pr_value" => txts[15].text,
      "qrs_label" => txts[16].text,
      "qrs_value" => txts[17].text,
      "qt_label" => txts[18].text,
      "qt_value" => txts[19].text,
      "qtc_label" => txts[20].text,
      "qtc_value" => txts[21].text
    }
  end

  def get_txts_i8
    txts = @selenium.find_elements(:class, 'XCUIElementTypeStaticText')

    #for i in 0..(txts.count - 1)
    #  puts "#{i} = #{txts[i].text}"
    #end

    return{
      "ecg_dropdown" => txts[3].text,
      "time_one" => txts[4].text,
      "time_two" => txts[4].text,
      "ecg_one" => txts[5].text,
      "ecg_two" => txts[6].text,
      "date" => txts[7].text,
      "time" => txts[8].text,

      "hr_label" => txts[9].text,
      "hr_value" => txts[10].text,
      "pr_label" => txts[11].text,
      "pr_value" => txts[12].text,
      "qrs_label" => txts[13].text,
      "qrs_value" => txts[14].text,
      "qt_label" => txts[15].text,
      "qt_value" => txts[16].text,
      "qtc_label" => txts[17].text,
      "qtc_value" => txts[18].text
    }
  end

  def measure_button
     Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Measure")
  end

  def create_snippet_button
    #Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Create Snippet")
    buttons = @selenium.find_elements(:class, 'XCUIElementTypeButton')
    btn = nil
    found = false
    for i in 0..(buttons.count - 1)
      if buttons[i].text == "Create Snippet"
        btn = buttons[i]
        break
      end
      if found == true
        break
      end
    end
    return btn
  end

  def get_target_objects

    return{
      "target_p" =>  @selenium.find_element(:accessibility_id, 'SnippetTarget-P.png'),
      "target_qr" =>  @selenium.find_element(:accessibility_id, 'SnippetTarget-QR.png'),
      "target_s" =>  @selenium.find_element(:accessibility_id, 'SnippetTarget-S.png'),
      "target_t" =>  @selenium.find_element(:accessibility_id, 'SnippetTarget-T.png'),
    }
  end

  def p_wave_target
    #puts "in the p wave target"
    @appium.find_element(:accessibility_id,'SnippetTarget-P.png')
    # Appium_lib.predicate(@appium, "XCUIElementTypeImage", "SnippetTarget-P.png")
    # @selenium.find_element(:xpath, '//XCUIElementTypeImage[@name="SnippetTarget-P.png"]')
  end

  def qr_wave_target
    #Appium_lib.predicate(@appium, "XCUIElementTypeImage", "SnippetTarget-QR.png")
    buttons = @selenium.find_elements(:class, 'XCUIElementTypeImage')
    btn = nil
    found = false
    for i in 0..(buttons.count - 1)
      puts "#{i} = #{buttons[i].name}"
      if buttons[i].name == "SnippetTarget-QR.png"
        btn = buttons[i]
        break
      end
      if found == true
        break
      end
    end
    return btn
  end

  def s_wave_target
    #Appium_lib.predicate(@appium, "XCUIElementTypeImage", "SnippetTarget-S.png")
    buttons = @selenium.find_elements(:class, 'XCUIElementTypeImage')
    btn = nil
    found = false
    for i in 0..(buttons.count - 1)
      puts "#{i} = #{buttons[i].name}"
      if buttons[i].name == "SnippetTarget-S.png"
        btn = buttons[i]
        break
      end
      if found == true
        break
      end
    end
    return btn
  end

  def t_wave_target
    #Appium_lib.predicate(@appium, "XCUIElementTypeImage", "SnippetTarget-T.png")
    buttons = @selenium.find_elements(:class, 'XCUIElementTypeImage')
    btn = nil
    found = false
    for i in 0..(buttons.count - 1)
      puts "#{i} = #{buttons[i].name}"
      if buttons[i].name == "SnippetTarget-T.png"
        btn = buttons[i]
        break
      end
      if found == true
        break
      end
    end
    return btn
  end
end
