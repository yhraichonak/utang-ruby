@regression @automated @core@cardio @cardio-serial_compare
Feature: Serial Compare Screen - Single Lead Zoom
  As an AS1 user
  I want view a Serial Presentation Screen
  So that I can display a patient's ECGs side by side
  
TestRail Id: C179329
Jira Issues: AS1-10, AS1-12, AS1-40, AS1-1113, MIG-228, MIG-337, AS1-1529, AS1-1529, AS1-1500
@critical @TMS:179329
Scenario: Serial Compare Screen - Single Lead Zoom
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  Then I should see the patient list screen
  When I click "MOST RECENT" on the List
  Then I should see the patient list screen
  When I click on "Nesbitt, Esron" in patient list
  Then I should see the patient summary screen
  When I click on the ECG tile
  Then I should see the ecg list on ECG screen
  When I click on row "1" on ecg list
  Then I should see the patient ECG screen
  When I click the Compare link
  Then I should see the second ecg list on the ECG screen
  When I click on row "2" on the second ecg list
  Then I should see the Serial Compare screen
  And I should see patient info in ecg screen header
  
  When I click on the info icon on the ecg toolbar
	Then the ecg detailed info drawer displays
  And I click on the info icon on the ecg toolbar
  
  When I click on the info icon on the ecg toolbar on second ecg
	Then the ecg detailed info drawer displays on second ecg
  And I click on the info icon on the ecg toolbar on second ecg
  
  When I click on 3 sec Lead "I"
  Then I should see the Lead "I" zoom lead window
  Then I should see the serial compare Lead "I" zoom lead window
  
  When I click the 12 Lead link
	Then I should see the patient ECG screen
	When I click on 3 sec Lead "II"
  Then I should see the Lead "II" zoom lead window
  Then I should see the serial compare Lead "II" zoom lead window
	
	When I click the 12 Lead link
	Then I should see the patient ECG screen
	When I click on 3 sec Lead "III"
  Then I should see the Lead "III" zoom lead window
  Then I should see the serial compare Lead "III" zoom lead window
	
	When I click the 12 Lead link
	Then I should see the patient ECG screen
	When I click on 3 sec Lead "aVR"
  Then I should see the Lead "aVR" zoom lead window
  Then I should see the serial compare Lead "aVR" zoom lead window

	When I click the 12 Lead link
	Then I should see the patient ECG screen
	When I click on 3 sec Lead "aVL"
  Then I should see the Lead "aVL" zoom lead window
  Then I should see the serial compare Lead "aVL" zoom lead window
	
	When I click the 12 Lead link
	Then I should see the patient ECG screen
	When I click on 3 sec Lead "aVF"
  Then I should see the Lead "aVF" zoom lead window
  Then I should see the serial compare Lead "aVF" zoom lead window
	
	When I click the 12 Lead link
	Then I should see the patient ECG screen
	When I click on 3 sec Lead "V1"
  Then I should see the Lead "V1" zoom lead window
  Then I should see the serial compare Lead "V1" zoom lead window
	
  When I click the 12 Lead link
	Then I should see the patient ECG screen
	When I click on 3 sec Lead "V2"
  Then I should see the Lead "V2" zoom lead window
  Then I should see the serial compare Lead "V2" zoom lead window
	
	When I click the 12 Lead link
	Then I should see the patient ECG screen
	When I click on 3 sec Lead "V3"
  Then I should see the Lead "V3" zoom lead window
  Then I should see the serial compare Lead "V3" zoom lead window
	
	When I click the 12 Lead link
	Then I should see the patient ECG screen
	When I click on 3 sec Lead "V4"
  Then I should see the Lead "V4" zoom lead window
  Then I should see the serial compare Lead "V4" zoom lead window
	
	When I click the 12 Lead link
	Then I should see the patient ECG screen
	When I click on 3 sec Lead "V5"
  Then I should see the Lead "V5" zoom lead window
  Then I should see the serial compare Lead "V5" zoom lead window
	
	When I click the 12 Lead link
	Then I should see the patient ECG screen
	When I click on 3 sec Lead "V6"
  Then I should see the Lead "V6" zoom lead window
  Then I should see the serial compare Lead "V6" zoom lead window
  
  When I click the waveform toolbar
	And I click the Lead "I" in waveform toolbar
  And I close the waveform toolbar
  Then I should see the Lead "I" zoom lead window
  Then I should see the serial compare Lead "I" zoom lead window
  
  When I click the waveform toolbar
	And I click the Lead "II" in waveform toolbar
  And I close the waveform toolbar
  Then I should see the Lead "II" zoom lead window
  Then I should see the serial compare Lead "II" zoom lead window
  
  When I click the waveform toolbar
	And I click the Lead "III" in waveform toolbar
  And I close the waveform toolbar
  Then I should see the Lead "III" zoom lead window
  Then I should see the serial compare Lead "III" zoom lead window
  
  When I click the waveform toolbar
	And I click the Lead "aVR" in waveform toolbar
  And I close the waveform toolbar
  Then I should see the Lead "aVR" zoom lead window
  Then I should see the serial compare Lead "aVR" zoom lead window
  
  When I click the waveform toolbar
	And I click the Lead "aVL" in waveform toolbar
  And I close the waveform toolbar
  Then I should see the Lead "aVL" zoom lead window
  Then I should see the serial compare Lead "aVL" zoom lead window
  
  When I click the waveform toolbar
	And I click the Lead "aVF" in waveform toolbar
  And I close the waveform toolbar
  Then I should see the Lead "aVF" zoom lead window
  Then I should see the serial compare Lead "aVF" zoom lead window
  
  When I click the waveform toolbar
	And I click the Lead "V1" in waveform toolbar
  And I close the waveform toolbar
  Then I should see the Lead "V1" zoom lead window
  Then I should see the serial compare Lead "V1" zoom lead window
  
  When I click the waveform toolbar
	And I click the Lead "V2" in waveform toolbar
  And I close the waveform toolbar
  Then I should see the Lead "V2" zoom lead window
  Then I should see the serial compare Lead "V2" zoom lead window
  
  When I click the waveform toolbar
	And I click the Lead "V3" in waveform toolbar
  And I close the waveform toolbar
  Then I should see the Lead "V3" zoom lead window
  Then I should see the serial compare Lead "V3" zoom lead window
  
  When I click the waveform toolbar
	And I click the Lead "V4" in waveform toolbar
  And I close the waveform toolbar
  Then I should see the Lead "V4" zoom lead window
  Then I should see the serial compare Lead "V4" zoom lead window
  
  When I click the waveform toolbar
	And I click the Lead "V5" in waveform toolbar
  And I close the waveform toolbar
  Then I should see the Lead "V5" zoom lead window
  Then I should see the serial compare Lead "V5" zoom lead window
  
  When I click the waveform toolbar
	And I click the Lead "V6" in waveform toolbar
  And I close the waveform toolbar
  Then I should see the Lead "V6" zoom lead window
  Then I should see the serial compare Lead "V6" zoom lead window
  
  When I click the 12 Lead link
	Then I should see the patient ECG screen
  When I click on second ecg 3 sec Lead "I"
  Then I should see the Lead "I" zoom lead window
  Then I should see the serial compare Lead "I" zoom lead window
  
  When I click the 12 Lead link
	Then I should see the patient ECG screen
  When I click on second ecg 3 sec Lead "II"
  Then I should see the Lead "II" zoom lead window
  Then I should see the serial compare Lead "II" zoom lead window
  
  When I click the 12 Lead link
	Then I should see the patient ECG screen
  When I click on second ecg 3 sec Lead "III"
  Then I should see the Lead "III" zoom lead window
  Then I should see the serial compare Lead "III" zoom lead window
  
  When I click the 12 Lead link
	Then I should see the patient ECG screen
  When I click on second ecg 3 sec Lead "aVR"
  Then I should see the Lead "aVR" zoom lead window
  Then I should see the serial compare Lead "aVR" zoom lead window
  
  When I click the 12 Lead link
	Then I should see the patient ECG screen
  When I click on second ecg 3 sec Lead "aVL"
  Then I should see the Lead "aVL" zoom lead window
  Then I should see the serial compare Lead "aVL" zoom lead window
  
  When I click the 12 Lead link
	Then I should see the patient ECG screen
  When I click on second ecg 3 sec Lead "aVF"
  Then I should see the Lead "aVF" zoom lead window
  Then I should see the serial compare Lead "aVF" zoom lead window
  
  When I click the 12 Lead link
	Then I should see the patient ECG screen
  When I click on second ecg 3 sec Lead "V1"
  Then I should see the Lead "V1" zoom lead window
  Then I should see the serial compare Lead "V1" zoom lead window
  
  When I click the 12 Lead link
	Then I should see the patient ECG screen
  When I click on second ecg 3 sec Lead "V2"
  Then I should see the Lead "V2" zoom lead window
  Then I should see the serial compare Lead "V2" zoom lead window
  
  When I click the 12 Lead link
	Then I should see the patient ECG screen
  When I click on second ecg 3 sec Lead "V3"
  Then I should see the Lead "V3" zoom lead window
  Then I should see the serial compare Lead "V3" zoom lead window
  
  When I click the 12 Lead link
	Then I should see the patient ECG screen
  When I click on second ecg 3 sec Lead "V4"
  Then I should see the Lead "V4" zoom lead window
  Then I should see the serial compare Lead "V4" zoom lead window
  
  When I click the 12 Lead link
	Then I should see the patient ECG screen
  When I click on second ecg 3 sec Lead "V5"
  Then I should see the Lead "V5" zoom lead window
  Then I should see the serial compare Lead "V5" zoom lead window
  
  When I click the 12 Lead link
	Then I should see the patient ECG screen
  When I click on second ecg 3 sec Lead "V6"
  Then I should see the Lead "V6" zoom lead window
  Then I should see the serial compare Lead "V6" zoom lead window
  
  When I click the waveform toolbar on second ecg
	And I click the Lead "I" in waveform toolbar on second ecg
  And I close the waveform toolbar on second ecg
  Then I should see the Lead "I" zoom lead window
  Then I should see the serial compare Lead "I" zoom lead window
  
  When I click the waveform toolbar on second ecg
	And I click the Lead "II" in waveform toolbar on second ecg
  And I close the waveform toolbar on second ecg
  Then I should see the Lead "II" zoom lead window
  Then I should see the serial compare Lead "II" zoom lead window
  
  When I click the waveform toolbar on second ecg
	And I click the Lead "III" in waveform toolbar on second ecg
  And I close the waveform toolbar on second ecg
  Then I should see the Lead "III" zoom lead window
  Then I should see the serial compare Lead "III" zoom lead window
  
  When I click the waveform toolbar on second ecg
	And I click the Lead "aVR" in waveform toolbar on second ecg
  And I close the waveform toolbar on second ecg
  Then I should see the Lead "aVR" zoom lead window
  Then I should see the serial compare Lead "aVR" zoom lead window
  
  When I click the waveform toolbar on second ecg
	And I click the Lead "aVL" in waveform toolbar on second ecg
  And I close the waveform toolbar on second ecg
  Then I should see the Lead "aVL" zoom lead window
  Then I should see the serial compare Lead "aVL" zoom lead window
  
  When I click the waveform toolbar on second ecg
	And I click the Lead "aVF" in waveform toolbar on second ecg
  And I close the waveform toolbar on second ecg
  Then I should see the Lead "aVF" zoom lead window
  Then I should see the serial compare Lead "aVF" zoom lead window
  
  When I click the waveform toolbar on second ecg
	And I click the Lead "V1" in waveform toolbar on second ecg
  And I close the waveform toolbar on second ecg
  Then I should see the Lead "V1" zoom lead window
  Then I should see the serial compare Lead "V1" zoom lead window
  
  When I click the waveform toolbar on second ecg
	And I click the Lead "V2" in waveform toolbar on second ecg
  And I close the waveform toolbar on second ecg
  Then I should see the Lead "V2" zoom lead window
  Then I should see the serial compare Lead "V2" zoom lead window
  
  When I click the waveform toolbar on second ecg
	And I click the Lead "V3" in waveform toolbar on second ecg
  And I close the waveform toolbar on second ecg
  Then I should see the Lead "V3" zoom lead window
  Then I should see the serial compare Lead "V3" zoom lead window
  
  When I click the waveform toolbar on second ecg
	And I click the Lead "V4" in waveform toolbar on second ecg
  And I close the waveform toolbar on second ecg
  Then I should see the Lead "V4" zoom lead window
  Then I should see the serial compare Lead "V4" zoom lead window
  
  When I click the waveform toolbar on second ecg
	And I click the Lead "V5" in waveform toolbar on second ecg
  And I close the waveform toolbar on second ecg
  Then I should see the Lead "V5" zoom lead window
  Then I should see the serial compare Lead "V5" zoom lead window
  
  When I click the waveform toolbar on second ecg
	And I click the Lead "V6" in waveform toolbar on second ecg
  And I close the waveform toolbar on second ecg
  Then I should see the Lead "V6" zoom lead window
  Then I should see the serial compare Lead "V6" zoom lead window
