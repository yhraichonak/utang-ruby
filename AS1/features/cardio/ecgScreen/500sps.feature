@regression @smoke @automated @core @cardio @cardio-ecg_screen
Feature: ECG Screen - 500 SPS
  As an AS1 user
  I want view a 12 Lead Screen 
  So that I can make sure a patient's ECG displays with diagnostic statements
  
TestRail Id: C179305
Jira Issues: AS1-2, AS1-54, AS1-6, AS1-13, AS1-33, AS1-56, AS1-7, AS1-296, AS1-11, AS1-600, AS1-603, AS1-880, AS1-1484, AS1-2612, AS1-2613, AS1-2999
 @critical @TMS:179305
Scenario: ECG Screen - 500 SPS
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  Then I should see the patient list screen
  When I click "MOST RECENT" on the List
  Then I should see the patient list screen
  When I click on "test, 500sps" in patient list
  Then I should see the patient summary screen
  When I click on the ECG tile
  Then I should see the ecg list on ECG screen
  And I should see patient info in ecg screen header
  When I click on row "1" on ecg list
  Then I should see the patient ECG screen
  When I click on the info icon on the ecg toolbar
  Then the ecg detailed info drawer displays
  When I click on the info icon on the ecg toolbar
  Then I should see the 12 waveforms rhythm strips I II III aVR aVL aVF V1 V2 V3 V4 V5 V6 V3R V4R V7 waveforms display
  And I should see the lead legend displaying "0.1mV/.04sec" on first ecg three sec lead
  And I should see the lead legend displaying "0.1mV/.04sec" on first ecg rhythm strip lead
  And I should see V.HR and A.HR labels in ECG Details Header are right aligned
  
  When I click on expand statement indicator in ECG header
  Then I should see the expanded ECG Details in ECG header
  When I click on expand statement indicator in ECG header
  Then I should see the 12 waveforms rhythm strips I II III aVR aVL aVF V1 V2 V3 V4 V5 V6 V3R V4R V7 waveforms display
  
  When I click on 3 sec Lead "I"
  Then I should see the Lead "I" zoom lead window
  And I should see V.HR and A.HR labels in ECG Details Header are right aligned
  
  When I click on expand statement indicator in ECG header
  Then I should see the expanded ECG Details in ECG header
  
  When I click on the info icon on the ecg toolbar
  Then the ecg detailed info drawer displays
