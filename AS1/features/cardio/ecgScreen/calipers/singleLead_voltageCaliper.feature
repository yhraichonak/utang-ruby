@regression @ecgCalipers @automated @core @cardio @cardio-ecg_screen @cardio-ecg_screen-calipers
Feature: ECG Voltage Caliper Interactions - Single Lead View
ECG Voltage Caliper - Single Lead View
The ECG Voltage Caliper is contained within the ECG Single Lead. The Voltage caliper will be invoked through a button on the Vertical Toolbar (only in single lead mode).  Selecting the button will either invoke or turn off the Voltage Caliper, depending on its current state.

Voltage Caliper ON - Single Lead View
Turning Voltage caliper ON will invoke the Voltage Caliper and will display:

Two horizontal calipers on lead box with grab handles, default placement of .4s above baseline (two major grid boxes) and on baseline.
A third "paired" grab handle
Voltage caliper legend
Voltage caliper button with visual ON styling
Active Voltage Caliper Display - Single Lead View
When Voltage caliper is initialized ON, the caliper will display in an active state/coloration on the viewed Lead  box Rhythm Strip (same "active" coloration as 12 lead view).  The Caliper grab handles and legend display are interactive ONLY in the active lead box (not rhythm strip).  The "Active" lead will persist through changing between 12 lead and single lead view(s).

Voltage Caliper OFF - Single lead View
Turning Voltage Calipers OFF (i.e. Selecting the button from an ON state) will turn the Calipers off and will not display:

Two horizontal calipers on lead box with grab handles, default placement of .4s above baseline (two major grid boxes) and on baseline.
Paired grab handle
Time caliper legend
Time caliper button with visual ON styling
The Calipers will not retain placement after being turned OFF by selecting the Caliper control (e.g. Turning - Calipers ON, adjusting Calipers, then turning OFF, turning back on will "reset" the calipers to default placement)
Voltage Caliper Legend
When active (ON) the Voltage Caliper will display a legend, within the active lead box, between paired calipers 

The Voltage Caliper Legend  will display the measurement between the Voltage Calipers in mv, to the hundredth of a mv. (e.g.  0.90mv)
The Voltage Caliper Legend will be the drag target for the calipers as a pair. 


TestRail Id: C328768
Jira Issues: AS1-1490, AS1-1491
 @critical @TMS:328768
Scenario: ECG Voltage Caliper Interactions - Single Lead View
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
  
  When I click on 3 sec Lead "I"
  Then I should see the Lead "I" zoom lead window
  And I should see V.HR and A.HR labels in ECG Details Header are right aligned
  Then I should see the ECG Time Caliper button "inactive"
  And I should see the ECG Voltage Caliper button "inactive"
  And I should see ECG Toolbar Tools separater
  
  When I click on ECG Voltage Caliper button
  Then I should see the ECG Voltage Caliper button "active"
  And I should see calculating distances for the ecg voltage calipers
  
  When I drag the whole ecg voltage caliper to the "right"  
  Then I should see the ecg voltage caliper distance "not changed"
  And the ecg voltage caliper moves to the "right" of waveform
  When I drag the whole ecg voltage caliper to the "left"  
  Then I should see the ecg voltage caliper distance "not changed"
  And the ecg voltage caliper moves to the "left" of waveform
  When I drag the whole ecg voltage caliper to the "up"
  Then I should see the ecg voltage caliper distance "not changed"
  And the ecg voltage caliper moves to the "up" of waveform  
  When I drag the whole ecg voltage caliper to the "down"
  Then I should see the ecg voltage caliper distance "not changed"
  And the ecg voltage caliper moves to the "down" of waveform  
  
  When I drag the "top" ecg voltage caliper "up" on the screen
  Then I should see the ecg voltage caliper distance "increase"
  When I drag the "top" ecg voltage caliper "up" on the screen
  Then I should see the ecg voltage caliper distance "increase"
  
  When I drag the "top" ecg voltage caliper "down" on the screen
  Then I should see the ecg voltage caliper distance "decrease"
  When I drag the "top" ecg voltage caliper "down" on the screen
  Then I should see the ecg voltage caliper distance "decrease"
  
  When I drag the "bottom" ecg voltage caliper "up" on the screen
  Then I should see the ecg voltage caliper distance "decrease"
  When I drag the "bottom" ecg voltage caliper "up" on the screen
  Then I should see the ecg voltage caliper distance "decrease"
  
  When I drag the "bottom" ecg voltage caliper "down" on the screen
  Then I should see the ecg voltage caliper distance "increase"
  When I drag the "bottom" ecg voltage caliper "down" on the screen
  Then I should see the ecg voltage caliper distance "increase"
  
  When I click on ECG Voltage Caliper button
  Then I should see the ECG Voltage Caliper button "inactive"
  
  When I click on ECG Voltage Caliper button
  Then I should see the ECG Voltage Caliper button "active"
  And I should see calculating distances for the ecg voltage calipers

  
  