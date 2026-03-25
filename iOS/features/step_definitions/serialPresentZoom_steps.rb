Before do
  @SerialPresentZoom_screen = SerialPresentZoom_screen.new selenium, appium
end

Then(/^I should see the Lead "(.*?)" zoom lead window for both ECGs$/) do |lead|
  @wait.until { @SerialPresentZoom_screen.nav_bar.displayed? == true }
  expect(@SerialPresentZoom_screen.ecg_one_close_button.displayed?).to be_truthy
  expect(@SerialPresentZoom_screen.ecg_two_close_button.displayed?).to be_truthy
end

Then(/^I should see the following info in patient banner on Serial Presentation Zoom screen$/) do |table|
  expectedData = table.rows_hash
  patientBanner = @SerialPresentZoom_screen.getPatientInfoFromHeader
  patientBanner[0].should eql expectedData["name"]
  patientBanner[1].should match expectedData["gender"]
  patientBanner[1].should match expectedData["age"]
  patientBanner[2].should match expectedData["site"]
  patientBanner[2].should match expectedData["mrn"]
end

Then(/^I should see the selected zoom lead datapoints displaying on Serial Presentation Zoom screen$/) do |table|
  leadData = table.rows_hash
  @SerialPresentZoom_screen.mainThreeSecondLead_element.leadData.gsub(/\s+/, "").should eql leadData["main_lead"]
  @SerialPresentZoom_screen.comparisonThreeSecondLead_element.leadData.gsub(/\s+/, "").should eql leadData["comparison_lead"]
  
  @SerialPresentZoom_screen.mainTenSecondLead_element.leadData.gsub(/\s+/, "").should eql leadData["main_lead"]
  @SerialPresentZoom_screen.comparisonTenSecondLead_element.leadData.gsub(/\s+/, "").should eql leadData["comparison_lead"]
end

When(/^I click the Close button on Serial Presentation Zoom window$/) do
  element = @SerialPresentZoom_screen.close_button
  Common.click_center_of_object(element)
  #threeLead = @SerialPresentZoom_screen.mainThreeSecondLead_element.location
  #selenium.execute_script 'mobile: doubleTap', :x => threeLead[:x]+50, :y => threeLead[:y]+50
end

When(/^I click on the patient caret button on Serial Presentation Zoom screen$/) do
  element = @SerialPresentZoom_screen.caret1_button
  Common.click_center_of_object(element)
end

Then(/^I should see detail patient info on Serial Presentation Zoom screen for ECG lead "(.*?)"$/) do |lead|
  #@$eyes.check_window("Serial Presentation Zoomed Detail for Lead #{lead}")
end

Then(/^I should see detail patient info on Serial Presentation Zoom screen for comparison ECG$/) do |table|
  expectedData = table.rows_hash
  patientDetail = @SerialPresentZoom_screen.getDetailPatientInfoFromComparisonEcg
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