@regression @nodeSim @automated @core @pm @pm-snippets @pm-snippets-tools
Feature: PM - Monitor Tool - Caliper Zooming and Scrolling

Calipers 
Scrolling
The waveform can be adjusted/scrolled while calipers are ON - however the Caliper will maintain relative to location placed on waveform ("sticky") and move with the waveform scrolling.

The paired calipers can also be dragged to a new location as a pair by grabbing the legend. In the event this dragging brings the user to the edge of the viewed waveform, the waveform should auto-scroll to the left or right (depending on which way the user is dragging the paired calipers)

Zooming
Calipers should be "sticky" to placement when zooming (e.g. zooming does not change the mathematical distance, only visual distance).

TestRail Id: C264282
Jira Stories: AS1-215, AS1-1415, AS1-1960
@critical @TMS:264282
Scenario: PM - Monitor Tool - Caliper Zooming and Scrolling
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
  
#  And the snippet tool zoom value is set at "5.1"
  When I zoom "in" on snippet tool screen
  Then the snippet tool zoom value is set at "10"
  When I zoom "out" on snippet tool screen
  Then the snippet tool zoom value is set at "1"
  
  When I scroll the snippet waveform to the "left"
  Then snippet waveform moves "forward" in time
  
  When I scroll the snippet waveform to the "right"
  Then snippet waveform moves "back" in time
  