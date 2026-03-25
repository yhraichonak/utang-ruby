@regression @ecgCalipers @automated @core @cardio @cardio-ecg_screen @cardio-ecg_screen-calipers
Feature: ECG Time Caliper Interactions - 12 Lead View

ECG Time Caliper Interactions - 12 Lead View
There are three "handles" for dragging the calipers on the ECG Time Caliper.  One handle on each vertical measurement indicator, used for adjusting each caliper individually, and a third handle located between the pair of calipers, used for dragging the calipers as a pair.  

Drag handles (both)

Are Tap targets for dragging
Dragging a Time caliper handle individually or as a pair, past the viewable screen space (to the left or to the right) should scroll the waveform with the drag
User interaction(dragging) of Time Caliper tool handles are actionable only on the active lead box (not rhythm strip). However, all dragging performed in active lead box is visible in other lead boxes and all rhythm strips.
Time caliper handles only:

Draggable vertically (handles only)
Dragging a handle vertically does not adjust the horizontal placement of Time calipers
Dragging a handle vertically also drags the vertical location of the other time caliper handle
Draggable horizontally (handles with indicators)
Dragging a handle horizontally adjusts the handle and indicator horizontally.
Dragging a handle horizontally adjusts the Time Caliper legend accordingly
If the Calipers are overlapped (the rightmost caliper is dragged backward in time, past the leftmost indicator) the legend should still display a positive value.
Dragging a handle horizontally adjusts the Marchout distance in lead boxes and rhythm strips accordingly 
Paired caliper handle only: (see note regarding handle vs legend)

Draggable vertically (handle with indicator)
Dragging the handle vertically adjusts the indicator vertically
Draggable horizontally (handle only)
Dragging the handle horizontally does not adjust the vertical placement of the paired indicator
Dragging the handle horizontally moves the calipers as a pair, maintaining relative distance. 
  
TestRail Id: C328764
Jira Issues: AS1-1482, AS1-1499, AS1-1542, AS1-1543, AS1-1539, AS1-1558
 @critical @TMS:328764
Scenario: ECG Time Caliper Interactions - 12 Lead View
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
  
  When I click on ECG Time Caliper button
  Then I should see the ECG Time Caliper button "inactive"

  
  