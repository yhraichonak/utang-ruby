@regression @automated @core @cardio @cardio-ecg_screen
Feature: ECG Screen - 500 SPS min resolution
  The web application will dynamically resize until a minimum resolution of 1280x720

TestRail Id: C264438
Jira Issues: AS1-419, AS1-1128, AS1-2931

 @TMS:264438
Scenario: ECG Screen - 500 SPS min resolution
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  Then I should see the patient list screen
  When I click "MOST RECENT" on the List
  Then I should see the patient list screen
  When I click on "test, 500sps" in patient list
  Then I should see the patient summary screen
  When I click on the ECG tile
  Then I should see the ecg list on ECG screen
  And I should see the ecg list close automatically
  And I should see patient info in ecg screen header
  When I click on row "1" on ecg list
  Then I should see the patient ECG screen
  When I see the browser resolution to "800" width by "600" height
  When I click the expand icon menu button
  Then I should see the expanded navigation links
  When I click the expand icon menu button
  Then I should not see the expanded navigation links
  When I click on the info icon on the ecg toolbar
  Then the ecg detailed info drawer displays
  When I click on the info icon on the ecg toolbar
  Then I should see the 15 waveforms rhythm strips I II III aVR aVL aVF V1 V2 V3 V4 V5 V6 V3R V4R V7 waveforms display
  And I should see the lead legend displaying "0.1mV/.04sec" on first ecg three sec lead
  And I should see the lead legend displaying "0.1mV/.04sec" on first ecg rhythm strip lead

  When I click on expand statement indicator in ECG header
  Then I should see the expanded ECG Details in ECG header
  When I click on expand statement indicator in ECG header
  Then I should see the 15 waveforms rhythm strips I II III aVR aVL aVF V1 V2 V3 V4 V5 V6 V3R V4R V7 waveforms display

  When I click on 3 sec Lead "I"
  Then I should see the Lead "I" zoom lead window

  When I click on expand statement indicator in ECG header
  Then I should see the expanded ECG Details in ECG header

  When I click on the info icon on the ecg toolbar
  Then the ecg detailed info drawer displays
