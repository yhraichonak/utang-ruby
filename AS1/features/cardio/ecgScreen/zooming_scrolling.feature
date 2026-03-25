@regression @automated @core @cardio @cardio-ecg_screen
Feature: ECG Screen - Zooming/Scrolling
  As an AS1 user
  I want view a 12 Lead Wave Form ECG Screen 
  So that I can make sure a patient's ECG displays with diagnostic statements
  
  TestRail Id: C179309
  Jira Issues: AS1-5, AS1-36, AS1-39, AS1-253, AS1-1234
@critical @TMS:179309
Scenario: ECG Screen - Zooming/Scrolling
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  Then I should see the patient list screen
  When I click "MOST RECENT" on the List
  Then I should see the patient list screen
  When I click on "[props.DP_FULL_NAME]" in patient list
  Then I should see the patient summary screen
  
  When I click on the ECG tile
  Then I should see the ecg list on ECG screen
  
  When I click on row "1" on ecg list
  Then I should see the patient ECG screen
  
  When I click on the info icon on the ecg toolbar
  Then the ecg detailed info drawer displays
  
  When I click on the info icon on the ecg toolbar
  Then I should see the 12 waveforms I II III aVR aVL aVF V1 V2 V3 V4 V5 V6 waveforms display
  
  
  When I scroll the ecg scrubber to the "right"
  Then I should see the 12 waveforms I II III aVR aVL aVF V1 V2 V3 V4 V5 V6 waveforms display
 
  When I scroll the ecg scrubber to the "right"
  Then I should see the 12 waveforms I II III aVR aVL aVF V1 V2 V3 V4 V5 V6 waveforms display
 
  When I scroll the ecg scrubber to the "right"
  Then I should see the 12 waveforms I II III aVR aVL aVF V1 V2 V3 V4 V5 V6 waveforms display
  
  When I scroll the ecg scrubber to the "left"
  Then I should see the 12 waveforms I II III aVR aVL aVF V1 V2 V3 V4 V5 V6 waveforms display
  
  When I scroll the ecg scrubber to the "left"
  Then I should see the 12 waveforms I II III aVR aVL aVF V1 V2 V3 V4 V5 V6 waveforms display
  
  When I scroll the ecg scrubber to the "left"
  Then I should see the 12 waveforms I II III aVR aVL aVF V1 V2 V3 V4 V5 V6 waveforms display
    
  
  When I zoom the ecg zoom lead "out" by offset "250"
  Then I should see the 12 waveforms I II III aVR aVL aVF V1 V2 V3 V4 V5 V6 waveforms display
  
  When I zoom the ecg zoom lead "in" by offset "250"
  Then I should see the 12 waveforms I II III aVR aVL aVF V1 V2 V3 V4 V5 V6 waveforms display
  
  
  When I click on 3 sec Lead "I"
  Then I should see the Lead "I" zoom lead window
  
  When I scroll the ecg scrubber to the "right"
  Then I should see the Lead "I" zoom lead window
  
  When I scroll the ecg scrubber to the "right"
  Then I should see the Lead "I" zoom lead window
  
  When I scroll the ecg scrubber to the "right"
  Then I should see the Lead "I" zoom lead window
  
  When I scroll the ecg scrubber to the "left"
  Then I should see the Lead "I" zoom lead window
  
  When I scroll the ecg scrubber to the "left"
  Then I should see the Lead "I" zoom lead window
  
  When I scroll the ecg scrubber to the "left"
  Then I should see the Lead "I" zoom lead window
  
  
  When I scroll the ecg zoom lead "right"
  Then I should see the Lead "I" zoom lead window
  
  When I scroll the ecg zoom lead "right"
  Then I should see the Lead "I" zoom lead window
 
  
  When I scroll the ecg zoom lead "left"
  Then I should see the Lead "I" zoom lead window
 
  When I scroll the ecg zoom lead "left"
  Then I should see the Lead "I" zoom lead window
  
  
  When I scroll the ecg zoom lead "up"
  Then I should see the Lead "I" zoom lead window
  
  When I scroll the ecg zoom lead "up"
  Then I should see the Lead "I" zoom lead window
  
  When I scroll the ecg zoom lead "down"
  Then I should see the Lead "I" zoom lead window
 
  When I scroll the ecg zoom lead "down"
  Then I should see the Lead "I" zoom lead window
  
  
  When I zoom the ecg zoom lead "out" by offset "250"
  Then I should see the Lead "I" zoom lead window

  When I zoom the ecg zoom lead "in" by offset "250"
  Then I should see the Lead "I" zoom lead window
