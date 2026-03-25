Before do
  @OBMonitor_screen = OBMonitor_screen.new selenium, appium
end

When(/^I click the close button on the ob tile/) do
 
	element = @OBMonitor_screen.x_button
	Common.click_center_of_object(element)
	
  #	x_V = element.location[:x] 
  #  y_V= element.location[:y]
  #  
  #  sizes = element.size  
  #  width = sizes[:width]
  #    
  #  Appium::TouchAction.new.press( x: x_V, y: y_V, count: 10).release.perform

	 #@appiumDriver.action.move_to(button).click.perform	
	 #appiumDriver.action.move_to(button).click.perform
end

Then(/^I should see the patient ob monitor screen$/) do
  @wait.until { @OBMonitor_screen.live_button.displayed? == true }
  expect(@OBMonitor_screen.live_button.value).to eq "1"
end

Then(/^I should verify patient monitor demographics$/) do
  @wait.until { @OBMonitor_screen.getPatientInfoFromHeader.displayed? == true }
  patientInfo = @OBMonitor_screen.getPatientInfoFromHeader
  
  #patientMonitorInfo = @OBMonitor_screen.getPatientInfoLiveMonitor
  #
  #expect(patientInfo[0]).to eql @patientName
  #expect(patientInfo[1]).to include @patientRoomNumber
  #if patientMonitorInfo[0] == '--'
  #  expect(@patientMembraneStatus).to eql ' | '
  #else
  #  expect(@patientMembraneStatus).to include patientMonitorInfo[0]
  #end
  #######  @patientEAG  ####

  expect(patientInfo[0]).to include @TRAINING_PATIENT_NAME
end

Then(/^the monitor is in Live mode$/) do
    # if @OBMonitor_screen.liveMonitorCaret_button.value == nil
    #    @OBMonitor_screen.liveMonitorCaret_button.click
    # end
    # 
    # begin
    # retries ||= 0
    expect(@OBMonitor_screen.live_button.value).to eq "1"
  #  expect(@OBMonitor_screen.monitorTime_staticText.value).to eq "Now"
  # rescue StandardError => e
  #    retry if (retries += 1) < 2
  # end
end

When(/^I click on the "(.*?)" section$/) do |section|
  # begin
  if(section == 'Misc')
	#Appium::TouchAction.new.press(x: 100, y: 300).wait(5000).move_to(x: 100, y: 100).release.perform
	#Appium::TouchAction.new.press(x: 100, y: 300).wait(5000).move_to(x: 100, y: 100).release.perform
	#@seleniumDriver.execute_script 'mobile: scroll', :direction => 'down'
	@seleniumDriver.execute_script 'mobile: scroll', :direction => 'down'
  elsif(section == "ANNOTATIONS")
	#Appium::TouchAction.new.press(x: 100, y: 100).wait(5000).move_to(x: 100, y: 300).release.perform
	#Appium::TouchAction.new.press(x: 100, y: 100).wait(5000).move_to(x: 100, y: 300).release.perform
	@seleniumDriver.execute_script 'mobile: scroll', :direction => 'down'
  end

  element = @OBMonitor_screen.section_tile(section)
  Common.click_center_of_object(element)
  
  
end

Then(/^I click on the maternal vitals tile$/) do
  element = @OBMonitor_screen.mv_tile
  Common.click_center_of_object(element)
end

Then(/^I should see the maternal vitals screen$/) do
  expect(@OBMonitor_screen.mv_tile_exp.text).to eq "Maternal Vitals"
end

Then(/^I click on the annotations tile$/) do
  element = @OBMonitor_screen.annotations_tile
  Common.click_center_of_object(element)
end

Then(/^I should see the annotations screen$/) do
  expect(@OBMonitor_screen.anno_tile_exp.text).to eq "Annotations"
end

Then(/^I click on the cervical exams tile$/) do
  element = @OBMonitor_screen.cervical_exams_tile
  Common.click_center_of_object(element)
end

Then(/^I should see the cervical exams screen$/) do
  expect(@OBMonitor_screen.cervX_tile_exp.text).to eq "Cervical Exams"
end

Then(/^I click on the pitocin tile$/) do
  element = @OBMonitor_screen.pitocin_tile
  Common.click_center_of_object(element)
end

Then(/^I should see the pitocin screen$/) do
  expect(@OBMonitor_screen.pitocin_tile_exp.text).to eq "Pitocin Dosage"
end

Then(/^I click on the misc tile$/) do
  element = @OBMonitor_screen.misc_tile
  Common.click_center_of_object(element)
end

Then(/^I should see the Misc screen$/) do
    expect(@OBMonitor_screen.misc_tile_exp.text).to include ("MISC")
  #elsif expect(@OBMonitor_screen.misc_tile_exp.text).to include ("Gravida")
  #elsif expect(@OBMonitor_screen.misc_tile_exp.text).to include ("Physician")  
  #end
end

When(/^I click close on the screen$/) do
  @wait.until { @OBMonitor_screen.sectionClose_button.displayed? == true }
  
  el = @OBMonitor_screen.sectionClose_button
    pos =  el.location
    size =  el.size
    
    center_x = pos[:x] + size[:width] / 2
    center_y = pos[:y] + size[:height] / 2
    Appium::TouchAction.new.press(:x => center_x, :y => center_y).wait(1000).release.perform
    Appium::TouchAction.new.press(:x => center_x, :y => center_y).wait(1000).release.perform
end

When(/^I close the live monitor tile$/) do
  element = @OBMonitor_screen.liveMonitorCaret_button
  Common.click_center_of_object(element)
end

When(/^I swipe "(.*?)" on the ob waveform$/) do |direction|
  @seleniumDriver.execute_script 'mobile: scroll', :direction => "#{direction}"
end

Then(/^I should see historical data for the ob waveform \(not Live mode\)$/) do
  #puts @OBMonitor_screen.live_button.value
  expect(@OBMonitor_screen.live_button.value).to be_nil
  expect(@OBMonitor_screen.monitorTime_staticText.value).to include "ago"
end

When(/^I pinch zoom out on ob monitor/) do
  @seleniumDriver.execute_script 'mobile: pinch', :scale => 0.5, :velocity => -1, :element => @OBMonitor_screen.liveMonitor_collectionView
  
  begin
    retries ||= 0
    v = @OBMonitor_screen.monitorZoom_staticText.value
    expect(v).to include "min"
    expect(v).to include "%"
  rescue StandardError => e
      retry if (retries += 1) < 2
  end
end

When(/^I pinch zoom in on ob monitor/) do
  @seleniumDriver.execute_script 'mobile: pinch', :scale => 1.5, :velocity => 1, :element => @OBMonitor_screen.liveMonitor_collectionView
  
  begin
    retries ||= 0
     v = @OBMonitor_screen.monitorZoom_staticText.value
       expect(v).to include "min"
    expect(v).to include "%"
  rescue StandardError => e
      retry if (retries += 1) < 2
  end
end

When(/^I click the Live monitor button$/) do
  element = @OBMonitor_screen.live_button
  Common.click_center_of_object(element)
end

When(/^I click the monitor caret$/) do
  element = @OBMonitor_screen.monitor_caret
  Common.click_center_of_object(element)
end

When(/^the fetal strip displays$/) do
  @wait.until { @OBMonitor_screen.fetal_strip.displayed? == true }
  
  obj = @OBMonitor_screen.fetal_strip
  
  if
    expect(obj.text).should be
  elsif
    expect(obj.text).should include "ago"
  elsif
    expect(obj.text).should include "Now"
  end
end

When(/^the OB census displays$/) do
  @wait.until { @OBMonitor_screen.ob_census.displayed? == true }
	title = @OBMonitor_screen.ob_census.text

	
	if (title == "Training Hospital: OB > Census" || title == "OB > Census")
		expect(title).to include "OB > Census"
	else
		steps %{
			When I click options button on top left of screen
			Then I should see the ListOfList window
			When I click OB CENSUS in List of List window
		}
		expect(@OBMonitor_screen.ob_census.text).to include "OB > Census"
	end
end

When(/^the fetal strip does not display$/) do
  @wait.until { @OBMonitor_screen.caretDN_button.displayed? == true }
  expect(@OBMonitor_screen.caretDN_button).should be
end

When(/^I refresh the census$/) do
  #Appium::TouchAction.new.press(x: 300, y: 200).move_to(x: 300, y: 1600).release.perform
 
end

Then(/^the OB Search screen displays$/) do
    expect(@OBMonitor_screen.ob_search).should be
end

Then(/^the OB Search screen displays in landscape$/) do
    expect(@OBMonitor_screen.ob_search_landscape).should be
end

Then(/^I leave the app idle for 3 minutes$/) do
    sleep(150)
end

Then(/^I leave the app idle for 15 minutes$/) do
	   #@appiumDriver.timeout('pageLoad', 1000)
    sleep(900)
    
  #@appiumDriver.timeout('pageLoad', )
end

Then(/^I view the screen$/) do
    
end

Then(/^the search results reflect the criteria$/) do
  expect@PatientList_screen.patient_cell.text.should include ("a")
end