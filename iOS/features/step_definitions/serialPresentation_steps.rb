Before do
  @SerialPresentation_screen = SerialPresentation_screen.new selenium, appium
end

When(/^I click the close button on the Serial Presentation screen$/) do
	element = @SerialPresentation_screen.close_button
	Common.click_center_of_object(element)
end

Then(/^I should see the serial presentation screen$/) do
  @SerialPresentation_screen.mainThreeSecondLead_element("I").nil?.should be false
  #@SerialPresentation_screen.mainThreeSecondLead_element("II").exists.should be true
  #@SerialPresentation_screen.mainThreeSecondLead_element("III").exists.should be true
  #@SerialPresentation_screen.mainThreeSecondLead_element("aVR").exists.should be true
  #@SerialPresentation_screen.mainThreeSecondLead_element("aVL").exists.should be true
  #@SerialPresentation_screen.mainThreeSecondLead_element("aVF").exists.should be true
  #@SerialPresentation_screen.mainThreeSecondLead_element("V1").exists.should be true
  #@SerialPresentation_screen.mainThreeSecondLead_element("V2").exists.should be true
  #@SerialPresentation_screen.mainThreeSecondLead_element("V3").exists.should be true
  #@SerialPresentation_screen.mainThreeSecondLead_element("V4").exists.should be true
  #@SerialPresentation_screen.mainThreeSecondLead_element("V5").exists.should be true
  #@SerialPresentation_screen.mainThreeSecondLead_element("V6").exists.should be true
  #
  @SerialPresentation_screen.comparisonThreeSecondLead_element("I").nil?.should be false
  #@SerialPresentation_screen.comparisonThreeSecondLead_element("II").exists.should be true
  #@SerialPresentation_screen.comparisonThreeSecondLead_element("III").exists.should be true
  #@SerialPresentation_screen.comparisonThreeSecondLead_element("aVR").exists.should be true
  #@SerialPresentation_screen.comparisonThreeSecondLead_element("aVL").exists.should be true
  #@SerialPresentation_screen.comparisonThreeSecondLead_element("aVF").exists.should be true
  #@SerialPresentation_screen.comparisonThreeSecondLead_element("V1").exists.should be true
  #@SerialPresentation_screen.comparisonThreeSecondLead_element("V2").exists.should be true
  #@SerialPresentation_screen.comparisonThreeSecondLead_element("V3").exists.should be true
  #@SerialPresentation_screen.comparisonThreeSecondLead_element("V4").exists.should be true
  #@SerialPresentation_screen.comparisonThreeSecondLead_element("V5").exists.should be true
  #@SerialPresentation_screen.comparisonThreeSecondLead_element("V6").exists.should be true
end

Then(/^I should see the following info in patient banner on Serial Presentation screen$/) do |table|
  expectedData = table.rows_hash
  patientBanner = @SerialPresentation_screen.getPatientInfoFromHeader

  processed_patient=process_param(expectedData["name"])
  processed_gender=process_param(expectedData["gender"])
  processed_age=process_param(expectedData["age"])

  expect(patientBanner[0]).to include processed_patient
  expect(patientBanner[2]).to include processed_gender
  expect(patientBanner[2]).to include processed_age
end

Then(/^I should see the patient ECG displaying first on the screen \(green\)$/) do |table|
  leadData = table.rows_hash
  @SerialPresentation_screen.mainThreeSecondLead_element("I").leadData.gsub(/\s+/, "").should eql leadData["lead_I"]
  @SerialPresentation_screen.mainThreeSecondLead_element("II").leadData.gsub(/\s+/, "").should eql leadData["lead_II"]
  @SerialPresentation_screen.mainThreeSecondLead_element("III").leadData.gsub(/\s+/, "").should eql leadData["lead_III"]
  @SerialPresentation_screen.mainThreeSecondLead_element("aVR").leadData.gsub(/\s+/, "").should eql leadData["lead_aVR"]
  @SerialPresentation_screen.mainThreeSecondLead_element("aVL").leadData.gsub(/\s+/, "").should eql leadData["lead_aVL"]
  @SerialPresentation_screen.mainThreeSecondLead_element("aVF").leadData.gsub(/\s+/, "").should eql leadData["lead_aVF"]
  @SerialPresentation_screen.mainThreeSecondLead_element("V1").leadData.gsub(/\s+/, "").should eql leadData["lead_V1"]
  @SerialPresentation_screen.mainThreeSecondLead_element("V2").leadData.gsub(/\s+/, "").should eql leadData["lead_V2"]
  @SerialPresentation_screen.mainThreeSecondLead_element("V3").leadData.gsub(/\s+/, "").should eql leadData["lead_V3"]
  @SerialPresentation_screen.mainThreeSecondLead_element("V4").leadData.gsub(/\s+/, "").should eql leadData["lead_V4"]
  @SerialPresentation_screen.mainThreeSecondLead_element("V5").leadData.gsub(/\s+/, "").should eql leadData["lead_V5"]
  @SerialPresentation_screen.mainThreeSecondLead_element("V6").leadData.gsub(/\s+/, "").should eql leadData["lead_V6"]
end

Then(/^I should see detail patient info for 1st ECG$/) do |table|
  expectedData = table.rows_hash
  patientDetail = @SerialPresentation_screen.getDetailPatientInfoFromMainEcg
  patientDetail["mainStatement"].should eql expectedData["mainStatement"]
  patientDetail["acquistionDate"].should eql expectedData["acq_date"]
  patientDetail["gender"].should eql expectedData["sex"]
  patientDetail["DOB"].should eql expectedData["dob"]
  patientDetail["age"].should eql expectedData["age"]
  patientDetail["race"].should eql expectedData["race"]
  patientDetail["VHR"].should eql expectedData["vhr"]
  patientDetail["PR"].should eql expectedData["pr"]
  patientDetail["QRS"].should eql expectedData["qrs"]
  patientDetail["PRT"].should include expectedData["prt"]
  patientDetail["AHR"].should eql expectedData["ahr"]
  patientDetail["QT"].should eql expectedData["qt"]
  patientDetail["QTC"].should eql expectedData["qtc"]
  patientDetail["diagnosisStatements"].should include expectedData["diag_state1"]
  patientDetail["diagnosisStatements"].should include expectedData["diag_state2"]
  patientDetail["diagnosisStatements"].should include expectedData["diag_state3"]
end

Then(/^I should see the patient ECG displaying second on the screen \(blue\)$/) do |table|
  leadData = table.rows_hash
  @SerialPresentation_screen.comparisonThreeSecondLead_element("I").leadData.gsub(/\s+/, "").should eql leadData["lead_I"]
  @SerialPresentation_screen.comparisonThreeSecondLead_element("II").leadData.gsub(/\s+/, "").should eql leadData["lead_II"]
  @SerialPresentation_screen.comparisonThreeSecondLead_element("III").leadData.gsub(/\s+/, "").should eql leadData["lead_III"]
  @SerialPresentation_screen.comparisonThreeSecondLead_element("aVR").leadData.gsub(/\s+/, "").should eql leadData["lead_aVR"]
  @SerialPresentation_screen.comparisonThreeSecondLead_element("aVL").leadData.gsub(/\s+/, "").should eql leadData["lead_aVL"]
  @SerialPresentation_screen.comparisonThreeSecondLead_element("aVF").leadData.gsub(/\s+/, "").should eql leadData["lead_aVF"]
  @SerialPresentation_screen.comparisonThreeSecondLead_element("V1").leadData.gsub(/\s+/, "").should eql leadData["lead_V1"]
  @SerialPresentation_screen.comparisonThreeSecondLead_element("V2").leadData.gsub(/\s+/, "").should eql leadData["lead_V2"]
  @SerialPresentation_screen.comparisonThreeSecondLead_element("V3").leadData.gsub(/\s+/, "").should eql leadData["lead_V3"]
  @SerialPresentation_screen.comparisonThreeSecondLead_element("V4").leadData.gsub(/\s+/, "").should eql leadData["lead_V4"]
  @SerialPresentation_screen.comparisonThreeSecondLead_element("V5").leadData.gsub(/\s+/, "").should eql leadData["lead_V5"]
  @SerialPresentation_screen.comparisonThreeSecondLead_element("V6").leadData.gsub(/\s+/, "").should eql leadData["lead_V6"]
end

Then(/^I should see detail patient info for 2nd ECG$/) do |table|
  expectedData = table.rows_hash
  patientDetail = @SerialPresentation_screen.getDetailPatientInfoFromComparisonEcg
  patientDetail["mainStatement"].should eql expectedData["mainStatement"]
  patientDetail["acquistionDate"].should eql expectedData["acq_date"]
  patientDetail["gender"].should eql expectedData["sex"]
  patientDetail["DOB"].should eql expectedData["dob"]
  patientDetail["age"].should eql expectedData["age"]
  patientDetail["race"].should eql expectedData["race"]
  patientDetail["VHR"].should eql expectedData["vhr"]
  patientDetail["PR"].should eql expectedData["pr"]
  patientDetail["QRS"].should eql expectedData["qrs"]
  patientDetail["PRT"].should include expectedData["prt"]
  patientDetail["AHR"].should eql expectedData["ahr"]
  patientDetail["QT"].should eql expectedData["qt"]
  patientDetail["QTC"].should eql expectedData["qtc"]
  patientDetail["diagnosisStatements"].should include expectedData["diag_state1"]
  patientDetail["diagnosisStatements"].should include expectedData["diag_state2"]
  patientDetail["diagnosisStatements"].should include expectedData["diag_state3"]
end

Then(/^I should see the Serial Presentation Leads with appropiate zoom scale of "(.*?)"$/) do |threeSecLeadsZoom|
  @SerialPresentation_screen.mainThreeSecondLead_element("I").zoomScale.should >= threeSecLeadsZoom
  @SerialPresentation_screen.mainThreeSecondLead_element("II").zoomScale.should >= threeSecLeadsZoom
  @SerialPresentation_screen.mainThreeSecondLead_element("III").zoomScale.should >= threeSecLeadsZoom
  @SerialPresentation_screen.mainThreeSecondLead_element("aVR").zoomScale.should >= threeSecLeadsZoom
  @SerialPresentation_screen.mainThreeSecondLead_element("aVL").zoomScale.should >= threeSecLeadsZoom
  @SerialPresentation_screen.mainThreeSecondLead_element("aVF").zoomScale.should >= threeSecLeadsZoom
  @SerialPresentation_screen.mainThreeSecondLead_element("V1").zoomScale.should >= threeSecLeadsZoom
  @SerialPresentation_screen.mainThreeSecondLead_element("V2").zoomScale.should >= threeSecLeadsZoom
  @SerialPresentation_screen.mainThreeSecondLead_element("V3").zoomScale.should >= threeSecLeadsZoom
  @SerialPresentation_screen.mainThreeSecondLead_element("V4").zoomScale.should >= threeSecLeadsZoom
  @SerialPresentation_screen.mainThreeSecondLead_element("V5").zoomScale.should >= threeSecLeadsZoom
  @SerialPresentation_screen.mainThreeSecondLead_element("V6").zoomScale.should >= threeSecLeadsZoom
  
  @SerialPresentation_screen.comparisonThreeSecondLead_element("I").zoomScale.should >= threeSecLeadsZoom
  @SerialPresentation_screen.comparisonThreeSecondLead_element("II").zoomScale.should >= threeSecLeadsZoom
  @SerialPresentation_screen.comparisonThreeSecondLead_element("III").zoomScale.should >= threeSecLeadsZoom
  @SerialPresentation_screen.comparisonThreeSecondLead_element("aVR").zoomScale.should >= threeSecLeadsZoom
  @SerialPresentation_screen.comparisonThreeSecondLead_element("aVL").zoomScale.should >= threeSecLeadsZoom
  @SerialPresentation_screen.comparisonThreeSecondLead_element("aVF").zoomScale.should >= threeSecLeadsZoom
  @SerialPresentation_screen.comparisonThreeSecondLead_element("V1").zoomScale.should >= threeSecLeadsZoom
  @SerialPresentation_screen.comparisonThreeSecondLead_element("V2").zoomScale.should >= threeSecLeadsZoom
  @SerialPresentation_screen.comparisonThreeSecondLead_element("V3").zoomScale.should >= threeSecLeadsZoom
  @SerialPresentation_screen.comparisonThreeSecondLead_element("V4").zoomScale.should >= threeSecLeadsZoom
  @SerialPresentation_screen.comparisonThreeSecondLead_element("V5").zoomScale.should >= threeSecLeadsZoom
  @SerialPresentation_screen.comparisonThreeSecondLead_element("V6").zoomScale.should >= threeSecLeadsZoom
end

When(/^I swipe the 1st ECG leads to the "(.*?)"$/) do |direction|
  objectCoord1 = @SerialPresentation_screen.mainThreeSecondLead_element("V4").location
  objectCoord2 = @SerialPresentation_screen.mainThreeSecondLead_element("III").location
  
  if desired_capabilities['deviceName'].include? 'iPad'
    if direction == "right"
      selenium.execute_script("target.dragInsideWithOptions({startOffset:{x:0.85, y:0.25}, endOffset:{x:0.25, y:0.25}, duration:0.5});")
    else
      selenium.execute_script("target.dragInsideWithOptions({startOffset:{x:0.25, y:0.25}, endOffset:{x:0.85, y:0.25}, duration:0.5});")
    end
  else
    if direction == "right"
      #selenium.execute_script("target.dragInsideWithOptions({startOffset:{x:0.85, y:0.25}, endOffset:{x:0.25, y:0.25}, duration:0.5});")
      selenium.execute_script('mobile: flick', :touchCount => 1, :startX => objectCoord1[:x], :startY => objectCoord1[:y], :endX => objectCoord2[:x], :endY =>objectCoord2[:y])
    else
      #selenium.execute_script("target.dragInsideWithOptions({startOffset:{x:0.25, y:0.25}, endOffset:{x:0.85, y:0.25}, duration:0.5});")
      selenium.execute_script('mobile: flick', :touchCount => 1, :startX => objectCoord2[:x], :startY => objectCoord2[:y], :endX => objectCoord1[:x], :endY => objectCoord1[:y])
    end
  end

end

When(/^I pinch zoom out on Serial Presentation screen$/) do
  objectCoord = @SerialPresentation_screen.mainThreeSecondLead_element("I").rect
  selenium.execute_script('mobile: pinchClose', :startX => objectCoord[:x], :startY => objectCoord[:y], :endX => objectCoord[:x]+25, :endY => objectCoord[:y]+25, :duration => 3)
end

When(/^I pinch zoom in on Serial Presentation screen$/) do
  objectCoord = @SerialPresentation_screen.mainThreeSecondLead_element("I").rect
  selenium.execute_script('mobile: pinchOpen', :startX => objectCoord[:x], :startY => objectCoord[:y], :endX => objectCoord[:x]+25, :endY => objectCoord[:y]+25, :duration => 3)
end

When(/^I double click on main 3 sec Lead "(.*?)"$/) do |lead|
  #@SerialPresentation_screen.mainThreeSecondLead_element(lead).double_tap
  threeLead = @SerialPresentation_screen.mainThreeSecondLead_element(lead).location
  selenium.execute_script 'mobile: doubleTap', :x => threeLead[:x]+50, :y => threeLead[:y]+50
end

When(/^I double click on comparison 3 sec Lead "(.*?)"$/) do |lead|
  #@SerialPresentation_screen.comparisonThreeSecondLead_element(lead).double_tap
  threeLead = @SerialPresentation_screen.comparisonThreeSecondLead_element(lead).location
  selenium.execute_script 'mobile: doubleTap', :x => threeLead[:x]+50, :y => threeLead[:y]+50
end
