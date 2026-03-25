@regression @ecgCalipers @automated @core @cardio @cardio-ecg_screen @cardio-ecg_screen-calipers
Feature: ECG Time Caliper Interactions - 12 Lead View to Single Lead View (zooming and scrolling)
Scrolling - All tools
The waveform can be adjusted/scrolled while calipers are ON - however the Caliper will maintain relative to location placed on waveform ("sticky") and move with the waveform scrolling. 

**This means that the user can scroll a waveform so that the caliper and grab handles are out of view on the lead box, if they choose to scroll the waveform instead of caliper drag targets. 

Marchout
When Marchout Calipers are ON, Both Primary Calipers and Marchout Calipers should be "sticky" to placement when scrolling The Marchout Calipers should continue to be visible as the user scrolls.

Zooming - All Tools
 All Calipers (including Marchout) should be "sticky" to placement when zooming (e.g. zooming does not change the mathematical distance, only visual distance).

  
TestRail Id: C328781
Jira Issues: AS1-1480, AS1-1559, AS1-1636
 @critical @TMS:328781
Scenario: ECG Time Caliper Interactions - 12 Lead View to Single Lead View (zooming and scrolling)
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  Then I should see the patient list screen
  When I click "MOST RECENT" on the List
  Then I should see the patient list screen
  When I click on "Nesbitt, Esron" in patient list
  Then I should see the patient summary screen
  When I click on the ECG tile
  Then I should see the ecg list on ECG screen
  And I should see patient info in ecg screen header
  When I click on row "1" on ecg list
  Then I should see the patient ECG screen
  When I click on the info icon on the ecg toolbar
  Then the ecg detailed info drawer displays
  When I click on the info icon on the ecg toolbar
  Then I should see the 12 waveforms I II III aVR aVL aVF V1 V2 V3 V4 V5 V6 waveforms display
  And I should see the lead legend displaying "0.1mV/.04sec" on first ecg three sec lead
  And I should see the lead legend displaying "0.1mV/.04sec" on first ecg rhythm strip lead
  And I should see V.HR and A.HR labels in ECG Details Header are right aligned
  Then I should see the ECG Time Caliper button "inactive"
  And I should see the ECG Voltage Caliper button "disabled"
  And I should see ECG Toolbar Tools separater
  
  When I click on ECG Time Caliper button
  Then I should see the ECG Time Caliper button "active"
  And I should see calculating distances for the ecg time calipers
  
  When I drag the whole ecg time caliper to the "right"
  Then the ecg time caliper moves to the "right" of waveform  
  When I drag the whole ecg time caliper to the "left"
  Then the ecg time caliper moves to the "left" of waveform
  When I drag the whole ecg time caliper to the "up"
  Then the ecg time caliper moves to the "up" of waveform
  When I drag the whole ecg time caliper to the "down"
  Then the ecg time caliper moves to the "down" of waveform
  
  When I drag the "left" ecg time caliper to the "left"
  Then I should see the ecg time caliper distance "increase"
  
  When I drag the "left" ecg time caliper to the "right"
  Then I should see the ecg time caliper distance "decrease"
  
  When I drag the "right" ecg time caliper to the "left"
  Then I should see the ecg time caliper distance "decrease"
  
  When I drag the "right" ecg time caliper to the "right"
  Then I should see the ecg time caliper distance "increase"

  When I click the Single Lead link
  Then I should see the Lead "I" zoom lead window
  And I should see V.HR and A.HR labels in ECG Details Header are right aligned
  And I should see the ECG Time Caliper button "active"
  And I should see calculating distances for the ecg time calipers
  
  When I drag the whole ecg time caliper to the "right"  
  Then I should see the ecg time caliper distance "not changed"
  And the ecg time caliper moves to the "right" of waveform
  When I drag the whole ecg time caliper to the "left"  
  Then I should see the ecg time caliper distance "not changed"
  And the ecg time caliper moves to the "left" of waveform
  When I drag the whole ecg time caliper to the "up"
  Then I should see the ecg time caliper distance "not changed"
  And the ecg time caliper moves to the "up" of waveform  
  When I drag the whole ecg time caliper to the "down"
  Then I should see the ecg time caliper distance "not changed"
  And the ecg time caliper moves to the "down" of waveform  
  
  When I drag the "left" ecg time caliper to the "left"
  Then I should see the ecg time caliper distance "increase"
  When I drag the "left" ecg time caliper to the "left"
  Then I should see the ecg time caliper distance "increase"
  
  When I drag the "left" ecg time caliper to the "right"
  Then I should see the ecg time caliper distance "decrease"
  When I drag the "left" ecg time caliper to the "right"
  Then I should see the ecg time caliper distance "decrease"
  
  When I drag the "right" ecg time caliper to the "left"
  Then I should see the ecg time caliper distance "decrease"
  When I drag the "right" ecg time caliper to the "left"
  Then I should see the ecg time caliper distance "decrease"
  
  When I drag the "right" ecg time caliper to the "right"
  Then I should see the ecg time caliper distance "increase"
   When I drag the "right" ecg time caliper to the "right"
  Then I should see the ecg time caliper distance "increase"
  
  When I click the waveform toolbar
  And I click the Lead "II" in waveform toolbar
  And I close the waveform toolbar
  Then I should see the Lead "II" zoom lead window
  And I should see V.HR and A.HR labels in ECG Details Header are right aligned
  And I should see the ECG Time Caliper button "active"
  And I should see calculating distances for the ecg time calipers
  
  When I click the waveform toolbar
  And I click the Lead "III" in waveform toolbar
  And I close the waveform toolbar
  Then I should see the Lead "III" zoom lead window
  And I should see V.HR and A.HR labels in ECG Details Header are right aligned
  And I should see the ECG Time Caliper button "active"
  And I should see calculating distances for the ecg time calipers
  
  When I click the waveform toolbar
  And I click the Lead "aVR" in waveform toolbar
  And I close the waveform toolbar
  Then I should see the Lead "aVR" zoom lead window
  And I should see V.HR and A.HR labels in ECG Details Header are right aligned
  And I should see the ECG Time Caliper button "active"
  And I should see calculating distances for the ecg time calipers
  
  When I click the waveform toolbar
  And I click the Lead "aVL" in waveform toolbar
  And I close the waveform toolbar
  Then I should see the Lead "aVL" zoom lead window
  And I should see V.HR and A.HR labels in ECG Details Header are right aligned
  And I should see the ECG Time Caliper button "active"
  And I should see calculating distances for the ecg time calipers
  
  When I click the waveform toolbar
  And I click the Lead "aVF" in waveform toolbar
  And I close the waveform toolbar
  Then I should see the Lead "aVF" zoom lead window
  And I should see V.HR and A.HR labels in ECG Details Header are right aligned
  And I should see the ECG Time Caliper button "active"
  And I should see calculating distances for the ecg time calipers
  
  When I click the waveform toolbar
  And I click the Lead "V1" in waveform toolbar
  And I close the waveform toolbar
  Then I should see the Lead "V1" zoom lead window
  And I should see V.HR and A.HR labels in ECG Details Header are right aligned
  And I should see the ECG Time Caliper button "active"
  And I should see calculating distances for the ecg time calipers
  
  When I click the waveform toolbar
  And I click the Lead "V2" in waveform toolbar
  And I close the waveform toolbar
  Then I should see the Lead "V2" zoom lead window
  And I should see V.HR and A.HR labels in ECG Details Header are right aligned
  And I should see the ECG Time Caliper button "active"
  And I should see calculating distances for the ecg time calipers
  
  When I click the waveform toolbar
  And I click the Lead "V3" in waveform toolbar
  And I close the waveform toolbar
  Then I should see the Lead "V3" zoom lead window
  And I should see V.HR and A.HR labels in ECG Details Header are right aligned
  And I should see the ECG Time Caliper button "active"
  And I should see calculating distances for the ecg time calipers
  
  When I click the waveform toolbar
  And I click the Lead "V4" in waveform toolbar
  And I close the waveform toolbar
  Then I should see the Lead "V4" zoom lead window
  And I should see V.HR and A.HR labels in ECG Details Header are right aligned
  And I should see the ECG Time Caliper button "active"
  And I should see calculating distances for the ecg time calipers
  
  When I click the waveform toolbar
  And I click the Lead "V5" in waveform toolbar
  And I close the waveform toolbar
  Then I should see the Lead "V5" zoom lead window
  And I should see V.HR and A.HR labels in ECG Details Header are right aligned
  And I should see the ECG Time Caliper button "active"
  And I should see calculating distances for the ecg time calipers
  
  When I click the waveform toolbar
  And I click the Lead "V6" in waveform toolbar
  And I close the waveform toolbar
  Then I should see the Lead "V6" zoom lead window
  And I should see V.HR and A.HR labels in ECG Details Header are right aligned
  And I should see the ECG Time Caliper button "active"
  And I should see calculating distances for the ecg time calipers

  When I zoom the ecg zoom lead "in" by offset "100"
  And I should see the ECG Time Caliper button "active"
  And I should see calculating distances for the ecg time calipers
  
  When I zoom the ecg zoom lead "out" by offset "50"
  And I should see the ECG Time Caliper button "active"
  And I should see calculating distances for the ecg time calipers
  
  When I click the 12 Lead link
  Then I should see the patient ECG screen
  Then I should see the ECG Time Caliper button "active"
  And I should see calculating distances for the ecg time calipers

  

  
  