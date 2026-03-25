@regression @automated @core@cardio @cardio-patient_summary
Feature: Patient Summary - ECG tile
  Tile Layout
  Header:

  Tile Header= "ECGs"
  Content:
  Show the Count of total ECGs for that patient in the tile's main content (not in header for this iteration)
  Interaction
  Tapping on the tile opens the ECG Details for the selected Patient
  
TestRail Id: C179326
Jira Issues: AS1-302, AS1-30, AS1-1114
 @critical @TMS:179326
Scenario:  Patient Summary - ECG tile
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  Then I should see the patient list screen
  When I click "MOST RECENT" on the List
  Then I should see the patient list screen
  When I click on "Nesbitt, Esron" in patient list
  Then I should see the patient summary screen
  And I should see the same ECG count from patient list on ECG tile
  When I click on the ECG tile
  Then I should see the ecg list on ECG screen