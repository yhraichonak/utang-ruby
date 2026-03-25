Before do
  @ZoomLead_screen = ZoomLead_screen.new selenium, appium
end

Then(/^I should see the Lead "(.*?)" zoom lead window$/) do |lead|
  #@$eyes.check_window("Zoomed Lead Screen - Lead #{lead}")
end

When(/^I click the X button on zoom lead window$/) do

  @wait.until { @ZoomLead_screen.close_button.displayed? }
	Common.click_center_of_object(@ZoomLead_screen.close_button)
end

Then(/^I should see the following info in patient banner on Zoom Lead screen$/) do |table|
  expectedData = table.rows_hash
  patientBanner = @ZoomLead_screen.getPatientInfoFromHeader
  patientBanner[0].should eql expectedData["name"]
  patientBanner[1].should match expectedData["gender"]
  patientBanner[1].should match expectedData["age"]
  patientBanner[2].should match expectedData["site"]
  patientBanner[2].should match expectedData["mrn"]
end

Then(/^I should see the selected zoom lead datapoints displaying$/) do |table|
  leadData = table.rows_hash
  @ZoomLead_screen.threeSecondLead_element.leadData.gsub(/\s+/, "").should eql leadData["lead"]
  @ZoomLead_screen.tenSecondLead_element.leadData.gsub(/\s+/, "").should eql leadData["lead"]
end

When(/^I click on the patient caret button on zoom lead screen$/) do
  element = @ZoomLead_screen.caret_button
  Common.click_center_of_object(element)
end

Then(/^I should see detail patient info on Lead "(.*?)" zoom lead screen$/) do |lead|
  #@$eyes.check_window("Zoomed Lead Detail Screen - Lead #{lead}")
end


