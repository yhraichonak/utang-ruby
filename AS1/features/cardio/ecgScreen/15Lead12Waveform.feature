@regression @pending @automated @core @cardio @cardio-ecg_screen
Feature: ECG Screen - (15 Lead - 12 Waveform)
  As an AS1 user
  I want view a 15 Lead Wave Form ECG Screen 
  So that I can make sure a patient's ECG displays with diagnostic statements
  
TestRail Id: C316541
Jira Issues: 
@critical @TMS:316541
Scenario: ECG Screen (15 Lead - 12 Waveform)
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
  When I click on row "1" on ecg list
  Then I should see the patient ECG screen
  When I click on the info icon on the ecg toolbar
  Then the ecg detailed info drawer displays
  When I click on the info icon on the ecg toolbar
  Then I should see the 12 waveforms rhythm strips I II III aVR aVL aVF V1 V2 V3 V4 V5 V6 V3R V4R V7 waveforms display
  
  When I click the waveform toolbar
  And I click the Lead "I" in waveform toolbar
  And I close the waveform toolbar
  Then I should see the Lead "I" zoom lead window
  
  When I click the waveform toolbar
  And I click the Lead "II" in waveform toolbar
  And I close the waveform toolbar
  
  When I click the waveform toolbar
  And I click the Lead "III" in waveform toolbar
  And I close the waveform toolbar
  Then I should see the Lead "III" zoom lead window
  
  When I click the waveform toolbar
  And I click the Lead "aVR" in waveform toolbar
  And I close the waveform toolbar
  Then I should see the Lead "aVR" zoom lead window
  
  When I click the waveform toolbar
  And I click the Lead "aVL" in waveform toolbar
  And I close the waveform toolbar
  Then I should see the Lead "aVL" zoom lead window
  
  When I click the waveform toolbar
  And I click the Lead "aVF" in waveform toolbar
  And I close the waveform toolbar
  Then I should see the Lead "aVF" zoom lead window
  
  When I click the waveform toolbar
  And I click the Lead "V1" in waveform toolbar
  And I close the waveform toolbar
  Then I should see the Lead "V1" zoom lead window
  
  When I click the waveform toolbar
  And I click the Lead "V2" in waveform toolbar
  And I close the waveform toolbar
  Then I should see the Lead "V2" zoom lead window
  
  When I click the waveform toolbar
  And I click the Lead "V3" in waveform toolbar
  And I close the waveform toolbar
  Then I should see the Lead "V3" zoom lead window
  
  When I click the waveform toolbar
  And I click the Lead "V4" in waveform toolbar
  And I close the waveform toolbar
  Then I should see the Lead "V4" zoom lead window
  
  When I click the waveform toolbar
  And I click the Lead "V5" in waveform toolbar
  And I close the waveform toolbar
  Then I should see the Lead "V5" zoom lead window
  
  When I click the waveform toolbar
  And I click the Lead "V6" in waveform toolbar
  And I close the waveform toolbar
  Then I should see the Lead "V6" zoom lead window
  
  When I click the waveform toolbar
  And I click the Lead "V3R" in waveform toolbar
  And I close the waveform toolbar
  Then I should see the Lead "V3R" zoom lead window
  
  When I click the waveform toolbar
  And I click the Lead "V4R" in waveform toolbar
  And I close the waveform toolbar
  Then I should see the Lead "V4R" zoom lead window
  
  When I click the waveform toolbar
  And I click the Lead "V7" in waveform toolbar
  And I close the waveform toolbar
  Then I should see the Lead "V7" zoom lead window
  
  When I click the 12 Lead link
  Then I should see the patient ECG screen
	