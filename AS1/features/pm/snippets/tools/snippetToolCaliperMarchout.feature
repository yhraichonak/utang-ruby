@regression @nodeSim @automated @core @pm @pm-snippets @pm-snippets-tools
Feature: PM - Monitor Tool - Caliper Control Marchout

Marchout Caliper Control

The Marchout Calipers can only be accessed when Caliper Control is in an ON state by selecting a checkbox or toggle next to the Caliper control titled "Marchout"

Turning Calipers OFF when Marchout is invoked (i.e. Selecting the button from an ON state) will turn the Calipers off and will not display:
Calipers
Caliper legend
Marchout Calipers
The Caliper Button with visual ON styling(like Measure button)
The user can also turn Marchout OFF by deselecting the checkbox/toggle when Marchout is in an ON state which will provide the user with only the Calipers (no Marchout)
The Marchout calipers contain all aspects of the Caliper Control, and: 
When invoked, the Primary Caliper distance will determine the distance of the Secondary Calipers (or Marchout), in seconds (e.g. if the Primary Calipers are a distance of .30s apart, the Marchout Calipers will also be .30s apart each).

The Marchout Calipers will be visually distinguishable from(thinner, dimmer, color, etc)

the Primary Calipers
background
gridlines
waveform
The Marchout Calipers should repeat across the visual space of the Tool View, to the left and right of the Primary Calipers on both the Zoom view and Rhythm Strip

Note: When Snippets ON, the Marchout Calipers will need to span the distance of the selected Snippet length, which may not be visible on screen.

TestRail Id: C264276
Jira Stories: AS1-288, AS1-289, AS1-1407
@critical @TMS:264276
Scenario: PM - Monitor Tool - Caliper Control Marchout
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
	Then I should see the patient list screen
  When I click "Census" on the List
  Then I should see the patient list screen
  When I click on default patient in list
  Then I should see the patient summary screen
  When I click on the Monitor tile
  Then I should see the Live Monitor screen
  When I click the "Tools" button in sub navigation menu
  Then I should see the Snippet Tool screen
  And I should see the Measure button "inactive"
  And I should see the HR legend in waveform chart
  When I click on Caliper button
  Then I should see the Caliper button "active"
  And I should see the HR legend in waveform chart
  And I should see calculating distances for the calipers
  When I click the Marchout switch to "On"
  Then the Caliper Marchout lines appear in zoom view and rhythm strip
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
  When I click on Caliper button
  Then I should see the Caliper button "inactive"
  And the Marchout switch should be "disabled"
  When I click on Caliper button
  Then I should see the Caliper button "active"
  And the Caliper Marchout lines appear in zoom view and rhythm strip
  And the Marchout switch should be "enabled"
  When I click the Marchout switch to "Off"
  Then the Caliper Marchout lines should not appear in zoom view and rhythm strip
  
  When I click the Marchout switch to "On"
  And I click on Measure button
  Then the Caliper Marchout lines should not appear in zoom view and rhythm strip
  And I should see the Measure button "active"
  And the Marchout switch should be "disabled"
  
  When I click the Create Snippet button
  Then I should see the Snippet Document Edit View
  When I click the Cancel button on Snippet Document Edit View
  Then I should see Snippet Not Saved window
  When I click the Ok button in Snippet Not Saved window
  Then I should see the Snippet Tool screen
  
  And I should see the Measure button "active"
  And the Marchout switch should be "disabled"
  When I click on Caliper button
  Then I should see the Caliper button "active"
  And the Caliper Marchout lines should not appear in zoom view and rhythm strip

  
  
  
  
  
  