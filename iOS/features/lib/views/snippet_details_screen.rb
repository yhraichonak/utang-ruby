Dir[File.dirname(__FILE__) + "/../*.rb"].each {|file| require file }

class Snippets_details_screen
  def initialize(selenium, appium)
    @selenium = selenium
    @appium = appium
  end

  def done_keyboard_button
    Appium_lib.predicate(@appium, "XCUIElementTypeButton", "Done")
  end

  def nav_bar
    #Appium_lib.predicate(@appium, "XCUIElementTypeNavigationBar", "One_Enterprise.SnippetsDetailsView")
    nav = @selenium.find_element(:class, 'XCUIElementTypeNavigationBar')
    return nav
  end

  def cancel_button
    $GLOBAL_APPIUM.find_element(:accessibility_id,'Cancel')
  end

  def preview_button
    $GLOBAL_APPIUM.find_element(:accessibility_id,'Preview')
  end

  def save_button
    $GLOBAL_APPIUM.find_element(:accessibility_id,'Save')
  end

  def get_txts_ipad124
    txts = @selenium.find_elements(:class, 'XCUIElementTypeStaticText')

    #puts txts.count
    #for i in 0..(txts.count - 1)
    #	if(txts[i].nil?)
    #	else
    #		puts "txt #{i} = #{txts[i].text}"
    #	end
    #end

    #for i in 0..(txts.count - 1)
    #  puts "#{i} = #{txts[i].text}"
    #end

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

    return{
      "name" => txts[0].text,
      "pid" => pid,
      "loc" => loc,
      "hm" => hm,
      "site" => site,
      "gender" => gender,
      "years" => years,
      "ecg_dropdown" => txts[6].text
    }
  end

  def get_txts_ipad133
    txts = @selenium.find_elements(:class, 'XCUIElementTypeStaticText')


    #for i in 0..(txts.count - 1)
    #  puts "#{i} = #{txts[i].text}"
    #end

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

    return{
      "name" => txts[0].text,
      "pid" => pid,
      "loc" => loc,
      "hm" => hm,
      "site" => site,
      "gender" => gender,
      "years" => years,
      "ecg_dropdown" => txts[3].text
    }
  end

  def get_txts_iphone124
    txts = @selenium.find_elements(:class, 'XCUIElementTypeStaticText')

    if $debug_flag == "debug"
        for i in 0..(txts.count - 1)
          puts "#{i} = #{txts[i].text}"
        end
    end

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

    return{
      "name" => txts[0].text,
      "pid" => pid,
      "loc" => loc,
      "hm" => hm,
      "site" => site,
      "gender" => gender,
      "years" => years,
      "ecg_dropdown" => txts[4].text
    }
  end

  def get_txts_iphone133
    txts = @selenium.find_elements(:class, 'XCUIElementTypeStaticText')

    if $debug_flag == "views" || $debug_flag == "debug"
      for i in 0..(txts.count - 1)
        puts "#{i} = #{txts[i].text}"
      end
    end

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

    return{
      "name" => txts[0].text,
      "pid" => pid,
      "loc" => loc,
      "hm" => hm,
      "site" => site,
      "gender" => gender,
      "years" => years,
      "ecg_dropdown" => txts[3].text
    }
  end

  def get_txts_ipad_old
    txts = @selenium.find_elements(:class, 'XCUIElementTypeStaticText')
    #puts txts.count
    #for i in 0..(txts.count - 1)
    #	if(txts[i].nil?)
    #	else
    #		puts "#{i} = #{txts[i].text}"
    #	end
    #end

    one = txts[1].text
    dots = (0 ... one.length).find_all { |i| one[i,1] == "•" }
    pid = one.slice(0..(dots[0]).to_i - 2)
    loc = one[(dots[0].to_i + 2)..(dots[1].to_i - 2)]
    hm = one[(dots[1].to_i + 2)..(dots[2].to_i - 2)]
    site = one[(dots[2].to_i + 2)..one.length]

    two = txts[2].text
    dots = (0 ... two.length).find_all { |i| two[i,1] == "•" }
    gender = two.slice(0.to_i + 2..(dots[1]).to_i - 2)
    years = two[(dots[1].to_i + 2)..two.length]

    return{
      "name" => txts[0].text,
      "pid" => pid,
      "loc" => loc,
      "hm" => hm,
      "site" => site,
      "gender" => gender,
      "years" => years,
      "ecg_dropdown" => txts[6].text
    }
  end

  def get_txtfields
    puts "in the get txtfields"
    txts = @selenium.find_elements(:class, 'XCUIElementTypeTextField')
    puts txts.count
    for i in 0..(txts.count - 1)
    	if(txts[i].nil?)
    	else
    		#puts "textfield #{i} = #{txts[i].text}"
    	end
    end

    return{
    "hr_value" => txts[0].text,
    "pr_value" => txts[1].text,
    "qrs_value" => txts[2].text,
    "qt_value" => txts[3].text,
    "qtc_value" => txts[4].text
    }
  end

  def get_txts_old
    txts = @selenium.find_elements(:class, 'XCUIElementTypeStaticText')

    #puts txts.count
    #for i in 0..(txts.count - 1)
    #  if(txts[i].nil?)
    #  else
    #    puts "#{i} = #{txts[i].text}"
    #  end
    #end

    one = txts[1].text
    dots = (0 ... one.length).find_all { |i| one[i,1] == "•" }
    pid = one.slice(0..(dots[0]).to_i - 2)
    loc = one[(dots[0].to_i + 2)..(dots[1].to_i - 2)]
    hm = one[(dots[1].to_i + 2)..(dots[2].to_i - 2)]
    site = one[(dots[2].to_i + 2)..one.length]

    two = txts[2].text
    dots = (0 ... two.length).find_all { |i| two[i,1] == "•" }
    gender = two.slice(0.to_i + 2..(dots[1]).to_i - 2)
    years = two[(dots[1].to_i + 2)..two.length]

    return{
      "name" => txts[0].text,
      "pid" => pid,
      "loc" => loc,
      "hm" => hm,
      "site" => site,
      "gender" => gender,
      "years" => years,
      "ecg_dropdown" => txts[3].text
    }
  end
end
