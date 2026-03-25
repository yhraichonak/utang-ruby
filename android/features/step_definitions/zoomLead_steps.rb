Before do
  @ZoomLead_screen = ZoomLead_screen.new selenium, appium
  @ECG_View_screen = ECG_View_screen.new selenium, appium
end

Then(/^I should see the Lead "(.*?)" zoom lead window$/) do |lead|

  begin
    retries ||= 0
    while @ZoomLead_screen.threeSecondLead_element.displayed? == false
      sleep(3)
    end
  rescue
    puts "error: did not find the 3 second element......."
    retry if (retries +=1 ) <3
  end

  three_second_lead = @ZoomLead_screen.threeSecondLead_element.text
  ten_second_lead = @ZoomLead_screen.tenSecondLead_element.text

  if(three_second_lead == lead.downcase)
  expect(three_second_lead).to eq lead.downcase
  expect(ten_second_lead).to eq lead.downcase
  elsif(three_second_lead == lead)
  expect(three_second_lead).to eq lead
  expect(ten_second_lead).to eq lead
  elsif(three_second_lead == lead.upcase)
  expect(three_second_lead).to eq lead.upcase
  expect(ten_second_lead).to eq lead.upcase
  end
end

Then(/^I should see the 10 Second Lead "(.*?)" zoom lead window$/) do |lead|
  expect(@ZoomLead_screen.threeSecondLead_element.text).to eq lead
  expect(@ZoomLead_screen.tenSecondLead_element.text).to eq lead
end

Then(/^I should see the following info in patient banner on Zoom Lead screen$/) do |table|
  data = table.rows_hash
  patientDetails = @ZoomLead_screen.getPatientInfoFromHeader
  patientDetails["name"].should eq data["name"]
  patientDetails["gender"].should match data["gender"]
  patientDetails["age"].should match data["age"]
  patientDetails["site"].should match data["site"]
  patientDetails["mrn"].should match data["mrn"]
end

When(/^I click on the chevron on zoom lead screen$/) do
  @ZoomLead_screen.chevron.click
end

Then(/^I should see detail patient info on zoom lead screen$/) do
  #@eyes.check_window("ECG Zoom Screen - Detail")
end

When(/^I click the back button on zoom lead window$/) do
  begin
    while @ZoomLead_screen.ecg_scrubber_object.displayed? == true
      @ZoomLead_screen.back_button.click
      sleep(1)
    end
  rescue

  end

  sleep 3

  begin
    while @ECG_View_screen.ecgList_listView.exists == true
      puts @ECG_View_screen.ecgList_listView.exists
      @ZoomLead_screen.back_button.click
      sleep(1)
    end
  rescue

  end
end

When(/^I swipe the scrubber to the "(.*?)" on zoom lead screen$/) do |direction|
  if @DeviceSystemVersion.to_i > 10
    if direction == "right"
      @selenium.action
               .move_to_location(150, 2050)  # Start point
               .click_and_hold
               .move_to_location(900, 2050)   # End point
               .release
               .perform
      # Appium::TouchAction.new.swipe(:start_x => 150, :start_y => 2050, :end_x => 900, :end_y => 2050, :duration => 1000).perform
    elsif direction == "left"
      @selenium.action
               .move_to_location(900, 2050)  # Start point
               .click_and_hold
               .move_to_location(150, 2050)   # End point
               .release
               .perform
      # Appium::TouchAction.new.swipe(:start_x => 900, :start_y => 2050, :end_x => 150, :end_y => 2050, :duration => 1000).perform
    end
  else
    if direction == "right"
      @selenium.action
               .move_to_location(150, 1500)  # Start point
               .click_and_hold
               .move_to_location(900, 1500)   # End point
               .release
               .perform
      # Appium::TouchAction.new.swipe(:start_x => 150, :start_y => 1500, :end_x => 900, :end_y => 1500, :duration => 1000).perform
    elsif direction == "left"
      @selenium.action
               .move_to_location(900, 1500)  # Start point
               .click_and_hold
               .move_to_location(150, 1500)   # End point
               .release
               .perform
      # Appium::TouchAction.new.swipe(:start_x => 900, :start_y => 1500, :end_x => 150, :end_y => 1500, :duration => 1000).perform
    end
  end
  sleep(1)
end

When(/^I pinch zoom OLD "(.*?)" on zoom lead screen$/) do |action|
  if action == "in"
    selenium.execute_script 'mobile: pinchClose', :element => @ZoomLead_screen.threeSecondLeadGrid_element.ref
  elsif action == "out"
    selenium.execute_script 'mobile: pinchOpen', :element => @ZoomLead_screen.threeSecondLeadGrid_element.ref
  end
end

When(/^I longclick on row (\d+) on ecg list$/) do |row|
  wait_for(10){ @ECG_View_screen.ecgList_listView.exists == true }
  sleep 2
  e = @selenium.find_element(:id, "android:id/list")
  elements = e.find_elements(:id, "#{APP_PACKAGE}:id/tv_cardio_diagnosis")
  which = row.to_i - 1
  element =  elements[which]

  @selenium.action
           .click_and_hold(element)
           .perform
end

When(/^I NOT pinch zoom "(.*?)" on zoom lead screen$/) do |action|
  element = @selenium.find_element(:id, "#{APP_PACKAGE}:id/cardio_ecg_grid")
  puts "just got the elment"
  #children = element.find_elements(:class, 'android.widget.TextView')
  #puts children.count
  element.click
  puts "just clicked the grid"

  if action == "in"
    #@appiumDriver.pinch(75)

    puts "in the zoom in"

    newone = Appium::MultiTouch

    newone.pinch(element.location[:x], element.location[:y])

    #@appiumDriver.pinch(element, 75)
    #Appium::MultiTouch.new.pinch(element, 75)
    puts "tried to zoom in"
  else
    #@appiumDriver.pinch(25)

    puts "in the out"

    newone = Appium::MultiTouch
    newone.pinch(element.location[:x], element.location[:y])
    #newone.pinch(element)

    #@appiumDriver.pinch(element, 25)
    #Appium::MultiTouch.new.pinch(element, 25)
    puts "tried to zoom out"
  end
end
When(/^I pinchEEEE zoom "(.*?)" on zoom lead screen$/) do |action|
  element = @selenium.find_element(:id, "#{APP_PACKAGE}:id/cardio_ecg_grid")
  #element.click
  #@appiumDriver.zoom
  zoom(element)
end

When(/^I pinch zoom "(.*?)" on zoom lead screen$/) do |action|
  if action == "in"
  		element = @selenium.find_element(:id, "#{APP_PACKAGE}:id/cardio_ecg_grid")

      center_x = element.size[:width] / 2
      center_y = element.size[:height] / 2

      # Create action builders
      action_builder = @selenium.action

      # First touch action
      touch1 = action_builder.add_pointer_input(:touch, 'finger1')
      touch1.create_pointer_move(duration: 0, x: center_x, y: center_y)
      touch1.create_pointer_down(:left)
      touch1.create_pointer_move(duration: 1, x: center_x - 200, y: center_y - 200)
      touch1.create_pause(1)
      touch1.create_pointer_up(:left)

      # Second touch action
      touch2 = action_builder.add_pointer_input(:touch, 'finger2')
      touch2.create_pointer_move(duration: 0, x: center_x + 200, y: center_y + 200)
      touch2.create_pointer_down(:left)
      touch2.create_pointer_move(duration: 1, x: center_x + 300, y: center_y + 300)
      touch2.create_pause(1)
      touch2.create_pointer_up(:left)

      # Perform the actions
      action_builder.perform

      # Perform the actions
      action_builder.perform

  	elsif action == "out"

  		element = @selenium.find_element(:id, "#{APP_PACKAGE}:id/cardio_ecg_grid")

      center_x = element.size[:width] / 2
      center_y = element.size[:height] / 2

      # Create action builders
      action_builder = @selenium.action

      # First touch action
      touch1 = action_builder.add_pointer_input(:touch, 'finger1')
      touch1.create_pointer_move(duration: 0, x: center_x - 200, y: center_y - 200)
      touch1.create_pointer_down(:left)
      touch1.create_pointer_move(duration: 1, x: center_x, y: center_y)
      touch1.create_pause(1)
      touch1.create_pointer_up(:left)

      # Second touch action
      touch2 = action_builder.add_pointer_input(:touch, 'finger2')
      touch2.create_pointer_move(duration: 0, x: center_x + 300, y: center_y + 300)
      touch2.create_pointer_down(:left)
      touch2.create_pointer_move(duration: 1, x: center_x - 200, y: center_y - 200)
      touch2.create_pause(1)
      touch2.create_pointer_up(:left)

      # Perform the actions
      action_builder.perform
  	end
end

When(/^I pinch NOT REALLY WORKS zoom "(.*?)" on zoom lead screen$/) do |action|
  sleep 1
  if action == "in"

    puts "in the IN section of the zoom"

    element = @selenium.find_element(:id, "#{APP_PACKAGE}:id/cardio_ecg_grid")

    #x = element.location[:x]
    #puts x
    #y = element.location[:y]
    #puts y

    puts "--------------"
    xx = element.size[:width] / 2
    puts "xx = #{xx}"
    yy = element.size[:height] / 2
    puts "yy = #{yy}"

    touch_action1 = Appium::TouchAction.new
    touch_action2 = Appium::TouchAction.new
    m_action = Appium::MultiTouch.new

    touch_action1.long_press(:x => xx - 100, :y => yy - 100).move_to(:x => xx, :y => yy).wait(500).release
    touch_action2.long_press(:x => xx + 200, :y => yy + 200).move_to(:x => xx + 100, :y => yy + 100).wait(500).release

    #touch_action1.press(:x => xx - 200, :y => yy - 200).wait(1000).move_to(:x => xx, :y => yy).release
    #touch_action2.press(:x => xx + 300, :y => yy + 300).wait(1000).move_to(:x => xx + 200, :y => yy + 200).release

    m_action.add(touch_action1)
    m_action.add(touch_action2)
    m_action.perform
  #@appiumDriver.screenshot "#{SCREEN_PATH}/#{$AFFECTED_LEAD}_IN_#{Common.random_time}.png"

  elsif action == "out"
    puts @appiumDriver.device_is_android?
    puts @appiumDriver.current_activity
    #puts @appiumDriver.current_package
    #find_element_with_appium
    #find_elements_with_appium

    element = @selenium.find_element(:id, "#{APP_PACKAGE}:id/cardio_ecg_grid")

    puts element.location[:x]
    puts element.location[:y]
    puts element.size[:width]
    puts element.size[:height]

    center_x = (element.location[:x] + (element.size[:width] / 2))
    center_y = (element.location[:y] + (element.size[:height] / 2))
    puts center_x
    puts center_y

       touch_action1 = Appium::TouchAction.new
    touch_action2 = Appium::TouchAction.new
    m_action = Appium::MultiTouch.new

    #attempt with swipe
    #touch_action1.swipe(:start_x => center_x, :start_y  => center_y, :end_x  => center_x + plus_v, :end_y  => center_y + plus_v, :duration => 400)
    #touch_action2.swipe(:start_x => center_x + accumulator, :start_y  => center_y + accumulator, :end_x  => center_y - minus_v, :end_y  => center_y - minus_v, :duration => 500)

  #touch_action1.swipe start_x: 0.5, start_y: (1.0 - rate) * height, end_x: 0.5, end_y: 0.0, duration: 1_000
  #touch_action1.swipe(:start_x => center_x, :start_y  => center_y, :end_x  => center_x + plus_v, :end_y  => center_y + plus_v, :duration => 400)
  #touch_action2.swipe(:start_x => center_x + accumulator, :start_y  => center_y + accumulator, :end_x  => center_y - minus_v, :end_y  => center_y - minus_v, :duration => 500)

  #attempt with long press
  #touch_action1.long_press(:x => center_x, :y => center_y).move_to(:x => center_x, :y => center_y + 100).wait(500).release
    #touch_action2.long_press(:x => center_x + 10, :y => center_y + 10).move_to(:x => center_x + 10, :y => center_y - 100).wait(500).release

    #attemp with press
    touch_action1.press(:x => center_x, :y => center_y).wait(500).move_to(:x => center_x, :y => center_y + 100).wait(500).release
    touch_action2.press(:x => center_x + 10, :y => center_y + 10).wait(500).move_to(:x => center_x + 10, :y => center_y - 100).wait(500).release

    m_action.add(touch_action1)
    m_action.add(touch_action2)
    m_action.perform
  end
  #elsif action == "out"
  #
  #	e2 = @selenium.find_element(:id, "#{APP_PACKAGE}:id/cardio_ecg_stackcell")
  #	x2 = e2.location[:x]
  #	puts x2
  #	y2 = e2.location[:y]
  #	puts y2
  #
  #	element = @selenium.find_element(:id, "#{APP_PACKAGE}:id/cardio_ecg_grid")
  #
  #	x = element.location[:x]
  #	puts x
  #	y = element.location[:y]
  #	puts y
  #
  #	puts "--------------"
  #	xx = element.size[:width] / 2
  #	puts "xx = #{xx}"
  #	yy = element.size[:height] / 2
  #	puts "yy = #{yy}"
  #
  #	touch_action1 = Appium::TouchAction.new
  #	touch_action2 = Appium::TouchAction.new
  #	m_action = Appium::MultiTouch.new
  #
  #	#touch_action1.long_press(:x => xx, :y => yy).move_to(:x => xx - 100, :y => yy - 100).wait(500).release
  #	#touch_action2.long_press(:x => xx + 200, :y => yy + 200).move_to(:x => xx + 300, :y => yy + 300).wait(500).release
  #	touch_action1.long_press(:x => x + 150, :y => y + 275).move_to(:x => x + 450, :y => y + 275).wait(500).release
  #	touch_action2.long_press(:x => x + 800, :y => y + 275).move_to(:x => x + 500, :y => y + 275).wait(500).release
  #
  #	#touch_action1.press(:x => xx, :y => yy).wait(1000).move_to(:x => xx - 200, :y => yy - 200).release
  #	#touch_action2.press(:x => xx + 300, :y => yy + 300).wait(1000).move_to(:x => xx + 400, :y => yy + 400).release
  #
  #	m_action.add(touch_action1)
  #	m_action.add(touch_action2)
  #	m_action.perform
  #	@appiumDriver.screenshot "#{SCREEN_PATH}/#{$AFFECTED_LEAD}_OUT_#{Common.random_time}.png"
  #
  #	zoom 200
  #end
  sleep 1
  #reposition the screen
  Appium::TouchAction.new.swipe(:start_x => 500, :start_y => 1000, :end_x => 500, :end_y => 800, :duration => 500).perform
  Appium::TouchAction.new.swipe(:start_x => 500, :start_y => 1000, :end_x => 500, :end_y => 500, :duration => 500).perform
  sleep 2
   #@appiumDriver.screenshot "#{SCREEN_PATH}/#{$AFFECTED_LEAD}_CENTERED_#{Common.random_time}.png"
end
