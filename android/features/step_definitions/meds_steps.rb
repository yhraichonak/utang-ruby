Before do
  @Active_Meds_screen =  Active_Meds_screen.new selenium, appium
end

Then(/^I should see the Active Meds screen with the "(.*?)" drug displaying$/) do |drug_name|
  sleep(4)
  @Active_Meds_screen.med_one_name(drug_name).text.should eql drug_name
end

Then(/^I should see the "(.*?)" drug details$/) do |drug_name|
  sleep(3)
  data = table.rows_hash
  
  @Active_Meds_screen.drug_details_data(drug_name)
  
   patientDetails =  @Active_Meds_screen.drug_details_data(drug_name)
  
  #patientDetails["med_name"].should include data["med_name"]
  #patientDetails["details_label"].should include data["details_label"]
  #patientDetails["ordered_item_label"].should include data["ordered_item_label"]
  #patientDetails["oredered_item"].should include data["oredered_item"]
  #patientDetails["details_label"].should include data["details_label"]
  #patientDetails["details_text"].should include data["details_text"]
  #patientDetails["comments_label"].should include data["comments_label"]
  #patientDetails["comments_text"].should include data["comments_text"]  
  
end

Then(/^I should see the drug details screen$/) do
  @Active_Meds_screen.drug_detail_header.exists.should be true
end

And(/^verify the active med for "(.*?)"$/) do |patient_name|
  sleep(1)
  if (patient_name == "CINDY SMITH")
    @Active_Meds_screen.med_one_name("acetaminophen").text.should eql "acetaminophen" 
  end
  sleep(1)
end

And(/^the Active Meds screen displays$/) do
    @Active_Meds_screen.med_one_name("acetaminophen").text.should eql "acetaminophen" 
end

When(/^I click on the "(.*?)" drug$/) do |drug_name|
  sleep(2)
  @Active_Meds_screen.med_one_name(drug_name).click
  sleep(2)
end


When(/^I enter "(.*?)" in the medication search field$/) do |medication, search_field|
  #Common.wait_for_loading_prompt(selenium)
  @Search_screen.medication_search(search_field, medication)
end
