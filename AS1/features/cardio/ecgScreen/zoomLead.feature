@regression @smoke @automated @core @cardio @cardio-ecg_screen
Feature: ECG Screen - Zoom Lead
  As an AS1 user
  I want view a 12 Lead Wave Form ECG Screen
  So that I can make sure a patient's ECG displays with diagnostic statements

  TestRail Id: C179310

  Jira Issues: AS1-3, AS1-8, AS1-17, AS1-15, AS1-22, AS1-41, AS1-252, AS1-877, MIG-338, AS1-1485, AS1-3502
@critical @TMS:179310
Scenario: ECG Screen - Zoom Lead
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

  When I click on the info icon on the ecg toolbar
  Then the ecg detailed info drawer displays
  When I click on the info icon on the ecg toolbar
  Then I should see the 12 waveforms I II III aVR aVL aVF V1 V2 V3 V4 V5 V6 waveforms display

  When I click on 3 sec Lead "I"
  Then I should see the Lead "I" zoom lead window
  And I should see V.HR and A.HR labels in ECG Details Header are right aligned

  When I click the 12 Lead link
  Then I should see the patient ECG screen
  When I click on 3 sec Lead "II"
  Then I should see the Lead "II" zoom lead window
  And I should see V.HR and A.HR labels in ECG Details Header are right aligned


  When I click the 12 Lead link
  Then I should see the patient ECG screen
  When I click on 3 sec Lead "III"
  Then I should see the Lead "III" zoom lead window
  And I should see V.HR and A.HR labels in ECG Details Header are right aligned


  When I click the 12 Lead link
  Then I should see the patient ECG screen
  When I click on 3 sec Lead "aVR"
  Then I should see the Lead "aVR" zoom lead window
  And I should see V.HR and A.HR labels in ECG Details Header are right aligned


  When I click the 12 Lead link
  Then I should see the patient ECG screen
  When I click on 3 sec Lead "aVL"
  Then I should see the Lead "aVL" zoom lead window
  And I should see V.HR and A.HR labels in ECG Details Header are right aligned


  When I click the 12 Lead link
  Then I should see the patient ECG screen
  When I click on 3 sec Lead "aVF"
  Then I should see the Lead "aVF" zoom lead window
  And I should see V.HR and A.HR labels in ECG Details Header are right aligned


  When I click the 12 Lead link
  Then I should see the patient ECG screen
  When I click on 3 sec Lead "V1"
  Then I should see the Lead "V1" zoom lead window
  And I should see V.HR and A.HR labels in ECG Details Header are right aligned


  When I click the 12 Lead link
  Then I should see the patient ECG screen
  When I click on 3 sec Lead "V2"
  Then I should see the Lead "V2" zoom lead window
  And I should see V.HR and A.HR labels in ECG Details Header are right aligned


  When I click the 12 Lead link
  Then I should see the patient ECG screen
  When I click on 3 sec Lead "V3"
  Then I should see the Lead "V3" zoom lead window
  And I should see V.HR and A.HR labels in ECG Details Header are right aligned


  When I click the 12 Lead link
  Then I should see the patient ECG screen
  When I click on 3 sec Lead "V4"
  Then I should see the Lead "V4" zoom lead window
  And I should see V.HR and A.HR labels in ECG Details Header are right aligned


  When I click the 12 Lead link
  Then I should see the patient ECG screen
  When I click on 3 sec Lead "V5"
  Then I should see the Lead "V5" zoom lead window
  And I should see V.HR and A.HR labels in ECG Details Header are right aligned


  When I click the 12 Lead link
  Then I should see the patient ECG screen
  When I click on 3 sec Lead "V6"
  Then I should see the Lead "V6" zoom lead window
  And I should see V.HR and A.HR labels in ECG Details Header are right aligned


  When I click the waveform toolbar
  And I click the Lead "I" in waveform toolbar
  And I close the waveform toolbar
  Then I should see the Lead "I" zoom lead window
  And I should see V.HR and A.HR labels in ECG Details Header are right aligned


  When I click the waveform toolbar
  And I click the Lead "II" in waveform toolbar
  And I close the waveform toolbar
  Then I should see the Lead "II" zoom lead window
  And I should see V.HR and A.HR labels in ECG Details Header are right aligned


  When I click the waveform toolbar
  And I click the Lead "III" in waveform toolbar
  And I close the waveform toolbar
  Then I should see the Lead "III" zoom lead window
  And I should see V.HR and A.HR labels in ECG Details Header are right aligned


  When I click the waveform toolbar
  And I click the Lead "aVR" in waveform toolbar
  And I close the waveform toolbar
  Then I should see the Lead "aVR" zoom lead window
  And I should see V.HR and A.HR labels in ECG Details Header are right aligned


  When I click the waveform toolbar
  And I click the Lead "aVL" in waveform toolbar
  And I close the waveform toolbar
  Then I should see the Lead "aVL" zoom lead window
  And I should see V.HR and A.HR labels in ECG Details Header are right aligned


  When I click the waveform toolbar
  And I click the Lead "aVF" in waveform toolbar
  And I close the waveform toolbar
  Then I should see the Lead "aVF" zoom lead window
  And I should see V.HR and A.HR labels in ECG Details Header are right aligned


  When I click the waveform toolbar
  And I click the Lead "V1" in waveform toolbar
  And I close the waveform toolbar
  Then I should see the Lead "V1" zoom lead window
  And I should see V.HR and A.HR labels in ECG Details Header are right aligned


  When I click the waveform toolbar
  And I click the Lead "V2" in waveform toolbar
  And I close the waveform toolbar
  Then I should see the Lead "V2" zoom lead window
  And I should see V.HR and A.HR labels in ECG Details Header are right aligned


  When I click the waveform toolbar
  And I click the Lead "V3" in waveform toolbar
  And I close the waveform toolbar
  Then I should see the Lead "V3" zoom lead window
  And I should see V.HR and A.HR labels in ECG Details Header are right aligned


  When I click the waveform toolbar
  And I click the Lead "V4" in waveform toolbar
  And I close the waveform toolbar
  Then I should see the Lead "V4" zoom lead window
  And I should see V.HR and A.HR labels in ECG Details Header are right aligned


  When I click the waveform toolbar
  And I click the Lead "V5" in waveform toolbar
  And I close the waveform toolbar
  Then I should see the Lead "V5" zoom lead window
  And I should see V.HR and A.HR labels in ECG Details Header are right aligned


  When I click the waveform toolbar
  And I click the Lead "V6" in waveform toolbar
  And I close the waveform toolbar
  Then I should see the Lead "V6" zoom lead window
  And I should see V.HR and A.HR labels in ECG Details Header are right aligned


  When I click the 12 Lead link
  Then I should see the patient ECG screen
  And I should see V.HR and A.HR labels in ECG Details Header are right aligned
