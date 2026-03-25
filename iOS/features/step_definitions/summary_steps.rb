Before do
  @Summary_screen = Summary_screen.new selenium, appium
  @Demographics_window = Demographics_window.new selenium, appium
end

When(/^I click the close button on the patient summary screen$/) do
	element = @Summary_screen.x_button
	Common.click_center_of_object(element)
end

When(/^I click the back button on the patient summary screen$/) do
	element = @Summary_screen.back_button
	Common.click_center_of_object(element)
end

When(/^I click the close button on the emr expanded tile$/) do
	element = @Summary_screen.expanded_tile_close_button
	Common.click_center_of_object(element)
end

When(/^I click the close button on the doc expanded tile$/) do
	element = @Summary_screen.doc_expanded_tile_close_button
	Common.click_center_of_object(element)
end

When(/^I click the close button on the vent expanded tile$/) do
	element = @Summary_screen.vent_expanded_tile_close_button
	Common.click_center_of_object(element)
end

When(/^I click the close button on the non shareable tile$/) do
	element = @Summary_screen.close_button
	Common.click_center_of_object(element)
end

When(/^I click the back button on the expanded tile$/) do

	value = @Summary_screen.expanded_tile_close_solo_button.text

	if @appVersion == "1.5.2100" || @appVersion == "1.5.2300"
		if(value == "common close")
			element = @Summary_screen.expanded_tile_close_solo_button
			Common.click_center_of_object(element)
		elsif(value == "Share")
			element = @Summary_screen.expanded_tile_close_button
			Common.click_center_of_object(element)
		end
	elsif @appVersion == "1.6"
		if(value == "Back")
			element = @Summary_screen.expanded_tile_close_solo_button
			Common.click_center_of_object(element)
		else
		   element = @Summary_screen.expanded_tile_back_button
		   Common.click_center_of_object(element)
		end
	end
end

Then(/^I should see the patient summary screen$/) do
  @wait.until {@Summary_screen.summary_collection_view.displayed? == true }
  #expect(@Summary_screen.summary_header.exists).to be_truthy
  #expect(@Summary_screen.demographicsTile_button.exists).to be_truthy
  @appiumDriver.swipe(:direction => "up")
  expect(@Summary_screen.summary_collection_view.visible?).to be_truthy
end

When(/^I click on the ECG tile$/) do
  element = @Summary_screen.ecgTile_button
  Common.click_center_of_object(element)
end

When(/^I click on the training patient Monitor tile$/) do
	element = @Summary_screen.monitor_tile_training
	Common.click_center_of_object(element)
end

When(/^I click on the Monitor tile$/) do
@Summary_screen.monitorTile_button.click
end

When(/^I click on the general info tile$/) do
  element = @Summary_screen.demographicsTile_button
  Common.click_center_of_object(element)
end

Then(/^I should see the following info in patient banner on Summary screen$/) do |table|
  expectedData = table.rows_hash
  patientBanner = @Summary_screen.getPatientInfoFromHeader
  patientBanner[0].should eql expectedData["name"]
  patientBanner[1].should match expectedData["gender"]
  patientBanner[1].should match expectedData["age"]
  patientBanner[2].should match expectedData["site"]
  patientBanner[2].should match expectedData["mrn"]
end

Then(/^I should see the following info in patient banner on PM Summary screen$/) do |table|
  expectedData = table.rows_hash
  patientBanner = @Summary_screen.getPatientInfoFromHeader
  patientBanner[0].should eql expectedData["name"]
  patientBanner[1].should match expectedData["gender"]
  patientBanner[1].should match expectedData["age"]
  patientBanner[2].should include expectedData["site"]
  patientBanner[2].should match expectedData["mrn"]
  patientBanner[2].should match expectedData["unit"]
  patientBanner[2].should match expectedData["bed"]
end

Then(/^I should see the following demographic tile/) do |table|
  expectedData = table.rows_hash
  patientInfo = @Summary_screen.getPatientInfoFromDemographicTile
  patientInfo["pid"].should include expectedData["PID"]
  patientInfo["sex"].should include expectedData["Sex"]
  patientInfo["race"].should include expectedData["Race"]
  patientInfo["dob"].should include expectedData["DOB"]
  patientInfo["age"].should include expectedData["Age"]
end

Then(/^I should see the following PM demographic tile/) do |table|
  expectedData = table.rows_hash
  patientInfo = @Summary_screen.getPatientInfoFromPMDemographicTile
  patientInfo["name"].should include expectedData["Name"]
  patientInfo["mrn"].should include expectedData["MRN"]
  #patientInfo["dob"].should include expectedData["DOB"]
  patientInfo["gender"].should include expectedData["Gender"]
  patientInfo["age"].should include expectedData["Age"]
end

Then(/^I should see the following EMR demographic tile/) do |table|
  expectedData = table.rows_hash
  patientInfo = @Summary_screen.getPatientInfoFromEMRDemographicTile
  patientInfo["weight"].should include expectedData["Weight"]
  patientInfo["admit_date"].should include expectedData["Admit Date"]
  patientInfo["primary_md"].should include expectedData["Primary MD"]
  patientInfo["code_status"].should include expectedData["Code Status"]
  patientInfo["location"].should include expectedData["Location"]
  patientInfo["admit_dx"].should include expectedData["Admit DX"]
end

Then(/^I should see the patient with (\d+) ECGs$/) do |numbOfECGs|
  @Summary_screen.getPatientECGCountFromEcgTile.should eql numbOfECGs
end

When(/^I click on the < button on the general info window$/) do

  #if $device_version == "14.0" || $device_version == "14.1" || $device_version == "14.3"
  #  element = @Demographics_window.back_button
  #  #Common.click_center_of_object(element)
  #  element.click
  #else
  #  element = @Demographics_window.close_button
  #  Common.click_center_of_object(element)
  #end

  if $device_version == "13.7"
    element = @Demographics_window.close_button
    Common.click_center_of_object(element)
  else
    element = @Demographics_window.back_button
    if element ==  nil
      sleep 7
      element = @Demographics_window.back_button
    end
    #Common.click_center_of_object(element)
    element.click
  end
end

Then(/^I should see the general info window$/) do
  sleep(2)
  #@$eyes.check_window("Patient Demographics window")
end

Then(/^I should see the EMR demographics info window$/) do |table|
  expectedData = table.rows_hash
  patientInfo = @Demographics_window.getPatientInfoFromEMRDemographicWindow
  patientInfo["weight"].should include expectedData["Weight"]
  patientInfo["admit_date"].should include expectedData["Admit Date"]
  patientInfo["primary_md"].should include expectedData["Primary MD"]
  patientInfo["code_status"].should include expectedData["Code Status"]
  patientInfo["location"].should include expectedData["Location"]
  patientInfo["admit_dx"].should include expectedData["Admit DX"]
  patientInfo["isolation_status"].should include expectedData["Isolation Status"]
  patientInfo["fin"].should include expectedData["FIN"]
  patientInfo["dob"].should include expectedData["DOB"]
  patientInfo["religion"].should include expectedData["Religion"]
  patientInfo["language"].should include expectedData["Language"]
  patientInfo["primary_contact"].should include expectedData["Primary Contact"]
  patientInfo["secondary_contact"].should include expectedData["Secondary Contact"]
end

When(/^I click the General Info tile$/) do
  element = @Summary_screen.generalInfo_tile
  Common.click_center_of_object(element)
end

Then(/^I should see the General Info expanded screen$/) do

  expect(@Summary_screen.generalInfo_expanded_tile.exists).to eq true
end

When(/^I swipe the horizontal scroll view "(.*?)"$/) do |direction|

  #element = @selenium.find_element(:xpath, '//XCUIElementTypeStaticText[@name="GENERAL INFO"]')

  # 		element = Element.new(@selenium, :xpath, '//XCUIElementTypeStaticText[@name="GENERAL INFO"]')
  #
  #		x = element.location[:x]
  #		puts x
  #		y = element.location[:y]
  #		puts y
  #
  #		xx = element.size[:width] / 2
  #		puts xx
  #		yy = element.size[:height] / 2
  #		puts yy

  #puts selenium.page_source
  if direction == "right"
    #Appium::TouchAction.new.press(x: 350, y: 178).wait(1).move_to(x: -250, y: 0).release.perform
    @appiumDriver.swipe(:start_x => 350, :start_y => 178, :offset_x => - 250, :offset_y => 0)
  else
    @appiumDriver.swipe(:start_x => 50, :start_y => 200, :offset_x => 350, :offset_y => 0)
    #Appium::TouchAction.new.press(x: 50, y: 200).wait(1).move_to(x: 350, y: 0).release.perform
  end
end

When(/^I click the Allergies tile$/) do
  # @appiumDriver.swipe(start_x: 50, start_y: 200, offset_x: 350, offset_y: 0)

  #Appium::TouchAction.new.swipe(start_x: 375, start_y: 100, end_x: 0, end_y:100, duration: 100).perform


  #Appium::TouchAction.new.swipe(start_x: 200, start_y: 300, end_x: 300, end_y:300, duration: 100).perform




  if direction == "right"
    do_swipe(1000,600,200,600)
    # Appium::TouchAction.new.swipe(:start_x => 1000, :start_y => 600, :end_x => 200, :end_y => 600, :duration => 1000).perform
  elsif direction == "left"
    do_swipe(200,600,100,600)
    # Appium::TouchAction.new.swipe(:start_x => 200, :start_y => 600, :end_x => 1000, :end_y => 600, :duration => 1000).perform
  end


  #Appium::TouchAction.new.swipe(start_x: 1000, start_y: 100, end_x: 200, end_y: 100, duration: 1000).perform
  # Appium::TouchAction.new.swipe(:start_x => 200, :start_y => 100, :end_x => 1000, :end_y => 100, :duration => 1000).perform
  do_swipe(200,100,1000,100)

  element = @Summary_screen.allergies_tile
  Common.click_center_of_object(element)
end

Then(/^I should see the Allergies expanded screen$/) do

  expect(@Summary_screen.allergies_expanded_tile.exists).to eq true
end

When(/^I click the Care Team tile$/) do
  element = @Summary_screen.careTeam_tile
  Common.click_center_of_object(element)
end

Then(/^I should see the Care Team expanded screen$/) do

  expect(@Summary_screen.careTeam_expanded_tile.exists).to eq true
end

When(/^I click the Dx Problems tile$/) do
  element = @Summary_screen.dxProblems_tile
  Common.click_center_of_object(element)
end

Then(/^I should see the Dx Problems expanded screen$/) do
  expect(@Summary_screen.dxProblems_expanded_tile.exists).to eq true
end

When(/^I click the Vitals tile$/) do
  element = @Summary_screen.vitals_tile
  Common.click_center_of_object(element)
end

Then(/^I should see the Vitals expanded screen$/) do
  expect(@Summary_screen.vitals_expanded_tile.attribute("visible")).to eq "true"
end

When(/^I click the Venttilator tile$/) do
  selenium.execute_script 'mobile: scroll', :direction => 'down'
  element = @Summary_screen.ventilator_tile
  Common.click_center_of_object(element)
end

Then(/^I should see the Venttilator expanded screen$/) do
  expect(@Summary_screen.ventilator_expanded_tile.attribute("visible")).to eq "true"
end

When(/^I click the Active Meds tile$/) do
  element = @Summary_screen.activeMeds_tile
  Common.click_center_of_object(element)
end

Then(/^I should see the Active Meds expanded screen$/) do
  expect(@Summary_screen.activeMeds_expanded_tile.attribute("visible")).to eq "true"
end

When(/^I click the Labs tile$/) do
  element = @Summary_screen.labs_tile
  Common.click_center_of_object(element)
end

Then(/^I should see the Labs expanded screen$/) do
  expect(@Summary_screen.labs_expanded_tile.displayed?).to eq true
end

When(/^I click the Documents tile$/) do
  element = @Summary_screen.documents_tile
  Common.click_center_of_object(element)
end

When(/^I click the Docs button$/) do
  element = @Summary_screen.docs_button
  Common.click_center_of_object(element)
  #xx = element.size[:width] / 2
  #yy = element.size[:height] / 2
  #Appium::TouchAction.new.tap( x: xx , y: yy).release.perform
end

Then(/^I should see the Documents expanded screen$/) do
  expect(@Summary_screen.documents_expanded_tile.exists).to eq true
  puts "tried to click the docs button"

    #@Summary_screen.docs_button.click
  		element = @Summary_screen.docs_button
  		Common.click_center_of_object(element)

  #			location = element.location
  #			aa = location[:x]
  #			#bb = location[:y]
  #			xx = element.size[:width] / 2
  #			yy = element.size[:height] / 2
  #
  #			Appium::TouchAction.new.press(x: xx + 100, y: yy+ 20).wait(3000).release.perform
  #			#.move_to(x: aa + 20, y: yy + 20)
  #  puts "hopefully i clicked the docs button"
end

When(/^I click the X button on the expanded screen$/) do
  element = @Summary_screen.x_button
  Common.click_center_of_object(element)
end

Then(/^I should see the EMR patient summary$/) do

  expect(@Summary_screen.generalInfo_tile.exists).to eq true
  expect(@Summary_screen.allergies_tile.exists).to eq true
  expect(@Summary_screen.careTeam_tile.exists).to eq true
  expect(@Summary_screen.dxProblems_tile.exists).to eq true
  expect(@Summary_screen.vitals_tile.exists).to eq true
  expect(@Summary_screen.activeMeds_tile.exists).to eq true
  expect(@Summary_screen.labs_tile.exists).to eq true
  expect(@Summary_screen.documents_tile.exists).to eq true
end

When(/^I swipe XXXto the "(.*?)" on the horizontal scroll view$/) do |direction|
    if direction == "right"
      do_swipe(1000,300,500,300)
      # Appium::TouchAction.new.swipe(:start_x => 1000, :start_y => 300, :end_x => 500, :end_y => 300, :duration => 1000).perform
    elsif direction == "left"
      do_swipe(200,300,1000,300)
      # Appium::TouchAction.new.swipe(:start_x => 200, :start_y => 300, :end_x => 1000, :end_y => 300, :duration => 1000).perform
    end
end

When(/^I select the "(.*?)" tile on the training summary screen/) do |which|
	if(ENV['DEVICE'].include? "iPad")

	else
		if (which == "MONITOR")
			@appiumDriver.swipe(:direction => "up")
		elsif (which == "GENERAL INFO")
			@appiumDriver.swipe(:direction => "down")
		elsif (which == "ALLERGIES")
			@appiumDriver.swipe(:direction => "down")

			element = @Summary_screen.first_cell
			Common.click_center_of_object(element)

		#location = element.location
		#aa = location[:x]
		##bb = location[:y]
		#xx = element.size[:width] / 2
		#yy = element.size[:height] / 2
		#
		#Appium::TouchAction.new.press(x: xx + 100, y: yy+ 20).wait(3000).move_to(x: aa + 20, y: yy + 20).release.perform

		elsif (which == "CARE TEAM")
			@appiumDriver.swipe(:direction => "down")
			element = @Summary_screen.first_cell
			Common.click_center_of_object(element)

		#location = element.location
		#aa = location[:x]
		##bb = location[:y]
		#xx = element.size[:width] / 2
		#yy = element.size[:height] / 2
		#
		#Appium::TouchAction.new.press(x: xx + 100, y: yy+ 20).wait(3000).move_to(x: aa + 20, y: yy + 20).release.perform
		elsif (which == "Dx/PROBLEMS")
			@appiumDriver.swipe(:direction => "down")
			element = @Summary_screen.first_cell
			Common.click_center_of_object(element)

		#location = element.location
		#aa = location[:x]
		##bb = location[:y]
		#xx = element.size[:width] / 2
		#yy = element.size[:height] / 2
		#
		#Appium::TouchAction.new.press(x: xx + 100, y: yy+ 20).wait(3000).move_to(x: aa + 20, y: yy + 20).release.perform
		elsif (which == "ECGs")
			@appiumDriver.swipe(:direction => "down")
		elsif (which == "VENTILATOR")
			@appiumDriver.swipe(:direction => "up")
		elsif (which == "DOCUMENTS")
			@appiumDriver.swipe(:direction => "up")
		end
	end
  element = @Summary_screen.summary_tiles_training(which)
  Common.click_center_of_object(element)
end
