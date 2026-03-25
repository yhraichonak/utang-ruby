@regression @nodeSim @automated @core @pm @pm-snippets @pm-snippets-tools
Feature: PM - Monitor Tool - Caliper Control

Caliper Control

The Caliper Control is contained within the Monitor Tool of the Patient Monitoring Module and will have all functionality of the Monitor Tool. The Caliper control will be invoked through a button which appears to the right of the Measure button in the control space on the Monitor Tool. Selecting the button will either invoke or turn off the Calipers, depending on its current state.

Turning Calipers ON (i.e. Selecting the button from an OFF state) will invoke the Calipers and will display:
Two Calipers on Zoom view and rhythm strip
Caliper legend
The Caliper Button with visual ON styling(like Measure button)
Include left-aligned heart rate, displayed as :
HR:XX where XX = Heart Rate provided by the source system, central to the time in the calipers.
Turning Calipers OFF (i.e. Selecting the button from an ON state) will turn the Calipers off and will not display:
Calipers
Caliper legend
The Caliper Button with visual ON styling(like Measure button)
WILL Include left-aligned heart rate, displayed as :
HR:XX where XX = Heart Rate provided by the source system, central to the time in the viewport.
The Calipers will not retain placement after being turned OFF by selecting the Caliper control (e.g. Turning Calipers ON, adjusting Calipers, then turning OFF, turning back on will "reset" the calipers to default placement)

Note Measure and Caliper controls will be reset only if the user selects the Active control again, turning it "off" and resetting. Switching controls will retain any user-edited location(s) of calipers or measurements.
The Caliper Control and Measure Control cannot be enabled at the same time.

If the Measure Control is active (in an ON state) and the user selects the Caliper Control , the Caliper Control will be active and the Measure Control will be inactive (but not reset).
If the Caliper Control is active and the user selects the Measure Control , the Measure Control will become active and the Calipers will become inactive (but not reset).
Caliper Legend
When active (ON) the Caliper Control will display a legend, within the caliper overlay (between first and second caliper)

The Caliper Legend which will display the measurement between the Calipers in seconds, to the hundredth of a second. (e.g. 0.90s)
The Caliper Legend will also display the beats per minute (bpm) which is 60/number of seconds measured in the primary Calipers (e.g. 66bpm)
Due to space between calipers, time and BPM may not fit on the same line. If wrapping is necessary, ensure that all digits of time value remain as one unit, and all digits of BPM remain as one unit.
Example Legend Display
0.90s (66bpm)

TestRail Id: C264275
Jira Stories: AS1-137, AS1-138, AS1-585, AS1-590, AS1-1352, AS1-3023, AS1-3026, AS1-3126
@critical @TMS:264275
Scenario: PM - Monitor Tool - Caliper Control
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  Then I should see the patient list screen
  When I click "Census" on the List
  Then I should see the patient list screen
  When I click on default patient in list without redirect
  Then I should see the Live Monitor screen
  When I click the "Tools" button in sub navigation menu
  Then I should see the Snippet Tool screen
  And I should see the Measure button "inactive"
  And I should see the HR legend in waveform chart
  When I click on Caliper button
  Then I should see the Caliper button "active"
  And I should see the HR legend in waveform chart
  And I should see calculating distances for the calipers
  When I drag the whole caliper to the center
  Then the caliper displays in the center of waveform  
  When I drag the "left" caliper to the "left"
  Then I should see the caliper distance "increase"
  When I drag the "left" caliper to the "right"
  Then I should see the caliper distance "decrease"  
  When I drag the "right" caliper to the "left"
  Then I should see the caliper distance "decrease"
  When I drag the "right" caliper to the "right"
  Then I should see the caliper distance "increase"
  When I click on Caliper button
  Then I should see the Caliper button "inactive"
  When I click on Caliper button
  Then I should see the Caliper button "active"
  And I should see calipers reset original distance
  