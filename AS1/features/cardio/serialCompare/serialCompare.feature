@regression @smoke @automated @core@cardio @cardio-serial_compare
Feature: Serial Compare Screen
  As an AS1 user
  I want view a Serial Presentation Screen
  So that I can display a patient's ECGs side by side
  
TestRail Id: C179314
Jira Issues: AS1-4, AS1-17, AS1-9, AS1-12, AS1-14, AS1-254, AS1-606, AS1-876, AS1-1532, AS1-1486, AS1-1560, AS1-2753, AS1-2612, AS1-2613, AS1-3004
@critical @TMS:179314
Scenario: Serial Compare Screen
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  Then I should see the patient list screen
  When I click "MOST RECENT" on the List
  Then I should see the patient list screen
  When I click on "Nesbitt, Esron" in patient list
  Then I should see the patient summary screen
  When I click on the ECG tile
  Then I should see the ecg list on ECG screen
  And I should see the ecg list close automatically
  When I click on row "1" on ecg list
  Then I should see the patient ECG screen
  And I should see the compare link enabled
  When I click the Compare link
  Then I should see the second ecg list on the ECG screen
  When I click on row "2" on the second ecg list
  Then I should see the Serial Compare screen
  And I should see patient info in ecg screen header
  And I should see the edit button disabled
  Then I should see the 12 waveforms I II III aVR aVL aVF V1 V2 V3 V4 V5 V6 waveforms display
  And I should see the lead legend displaying "0.1mV/.04sec" on first ecg three sec lead
  And I should see the lead legend displaying "0.1mV/.04sec" on first ecg rhythm strip lead
  Then I should see the serial compare 12 waveforms I II III aVR aVL aVF V1 V2 V3 V4 V5 V6 waveforms display
  And I should see the lead legend displaying "0.1mV/.04sec" on first ecg three sec lead in serial compare ecg
  And I should see the lead legend displaying "0.1mV/.04sec" on first ecg rhythm strip lead in serial compare ecg
  When I click on the info icon on the ecg toolbar
  Then the ecg detailed info drawer displays
  When I click on the info icon on the ecg toolbar for serial compare ecg
  Then the ecg detailed info drawer displays for serial compare ecg
  And I should see V.HR and A.HR labels in ECG Details Header are right aligned
  
  When I click on the ecg list button on the ecg toolbar
  Then I should see the ecg list on ECG screen
  And I should see row "1" selected on ecg list
  When I click on the ecg list button on second ecg
  Then I should see the second ecg list on the ECG screen
  And I should see row "2" selected on ecg list on second ecg
  
  When I click on row "2" on ecg list
  When I click on row "1" on the second ecg list
  Then I should see the Serial Compare screen
  And I should see patient info in ecg screen header
  And I should see the edit button disabled
  Then I should see the 12 waveforms I II III aVR aVL aVF V1 V2 V3 V4 V5 V6 waveforms display
  And I should see the lead legend displaying "0.1mV/.04sec" on first ecg three sec lead
  And I should see the lead legend displaying "0.1mV/.04sec" on first ecg rhythm strip lead
  Then I should see the serial compare 12 waveforms I II III aVR aVL aVF V1 V2 V3 V4 V5 V6 waveforms display
  And I should see the lead legend displaying "0.1mV/.04sec" on first ecg three sec lead in serial compare ecg
  And I should see the lead legend displaying "0.1mV/.04sec" on first ecg rhythm strip lead in serial compare ecg
  When I click on the info icon on the ecg toolbar
  Then the ecg detailed info drawer displays
  When I click on the info icon on the ecg toolbar for serial compare ecg
  Then the ecg detailed info drawer displays for serial compare ecg
  And I should see V.HR and A.HR labels in ECG Details Header are right aligned
  And I should see V.HR and A.HR labels in ECG Details Header are right aligned on serial compare ecg
  
  When I click on the ecg list button on the ecg toolbar
  Then I should see the ecg list on ECG screen
  And I should see row "2" selected on ecg list
  When I click on the ecg list button on second ecg
  Then I should see the second ecg list on the ECG screen
  And I should see row "1" selected on ecg list on second ecg
  
  When I click on row "1" on ecg list
  When I click on row "1" on the second ecg list
  Then I should see the Serial Compare screen
  And I should see patient info in ecg screen header
  And I should see the edit button disabled
  Then I should see the 12 waveforms I II III aVR aVL aVF V1 V2 V3 V4 V5 V6 waveforms display
  And I should see the lead legend displaying "0.1mV/.04sec" on first ecg three sec lead
  And I should see the lead legend displaying "0.1mV/.04sec" on first ecg rhythm strip lead
  Then I should see the serial compare 12 waveforms I II III aVR aVL aVF V1 V2 V3 V4 V5 V6 waveforms display
  And I should see the lead legend displaying "0.1mV/.04sec" on first ecg three sec lead in serial compare ecg
  And I should see the lead legend displaying "0.1mV/.04sec" on first ecg rhythm strip lead in serial compare ecg
  When I click on the info icon on the ecg toolbar
  Then the ecg detailed info drawer displays
  When I click on the info icon on the ecg toolbar for serial compare ecg
  Then the ecg detailed info drawer displays for serial compare ecg
  And I should see V.HR and A.HR labels in ECG Details Header are right aligned
  And I should see V.HR and A.HR labels in ECG Details Header are right aligned on serial compare ecg
  
  When I click on the ecg list button on the ecg toolbar
  Then I should see the ecg list on ECG screen
  And I should see row "1" selected on ecg list
  When I click on the ecg list button on second ecg
  Then I should see the second ecg list on the ECG screen
  And I should see row "1" selected on ecg list on second ecg
  
  When I click on row "2" on ecg list
  When I click on row "2" on the second ecg list
  Then I should see the Serial Compare screen
  And I should see patient info in ecg screen header
  And I should see the edit button disabled
  Then I should see the 12 waveforms I II III aVR aVL aVF V1 V2 V3 V4 V5 V6 waveforms display
  And I should see the lead legend displaying "0.1mV/.04sec" on first ecg three sec lead
  And I should see the lead legend displaying "0.1mV/.04sec" on first ecg rhythm strip lead
  Then I should see the serial compare 12 waveforms I II III aVR aVL aVF V1 V2 V3 V4 V5 V6 waveforms display
  And I should see the lead legend displaying "0.1mV/.04sec" on first ecg three sec lead in serial compare ecg
  And I should see the lead legend displaying "0.1mV/.04sec" on first ecg rhythm strip lead in serial compare ecg
  When I click on the info icon on the ecg toolbar
  Then the ecg detailed info drawer displays
  When I click on the info icon on the ecg toolbar for serial compare ecg
  Then the ecg detailed info drawer displays for serial compare ecg
  And I should see V.HR and A.HR labels in ECG Details Header are right aligned
  And I should see V.HR and A.HR labels in ECG Details Header are right aligned on serial compare ecg
  
  When I click on the ecg list button on the ecg toolbar
  Then I should see the ecg list on ECG screen
  And I should see row "2" selected on ecg list
  When I click on the ecg list button on second ecg
  Then I should see the second ecg list on the ECG screen
  And I should see row "2" selected on ecg list on second ecg

  When I click on the ecg list button on the ecg toolbar
  And I click on the ecg list button on second ecg
  And I click on expand statement indicator in ECG header
  Then I should see the expanded ECG Details in ECG header
  
  