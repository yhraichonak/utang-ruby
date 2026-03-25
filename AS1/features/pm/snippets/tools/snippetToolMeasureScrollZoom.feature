@regression @nodeSim @automated @core @pm @pm-snippets @pm-snippets-tools
Feature: PM - Monitor Tool - Measure Tool Zooming and Scrolling

Measure control
Scrolling

The PQRST drag handles may be dragged and adjusted on the waveform, but when the user scrolls the waveform, the
labels and their associated location indicators will maintain relative position on the waveform.

Zooming

When the user zooms the waveform, the drag handles should maintain current vertical position on screen space (not waveform).
(i.e. If the label is located directly in the middle of the screen, zooming in or out does NOT change this position).
Location indicators should "stick" to their placed location on the waveform as the user zooms in or out

TestRail Id: C264277
Jira Stories: AS1-214, AS1-173, AS1-1960
@critical @TMS:264277
Scenario: PM - Monitor Tool - Measure Tool Zooming and Scrolling
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
  When I click on Measure button
  Then I should see the Measure button "active"
  And I should see the HR legend in waveform chart
  And I should see calculating distances of PR, QRS, and QT values
  And I should see calculating distances of QTc value 
  And I should see the Measure controls for P, Q/R, S, T
#  And the snippet tool zoom value is set at "5"
  When I zoom "in" on snippet tool screen
  Then the snippet tool zoom value is set at "10"
  When I zoom "out" on snippet tool screen
  Then the snippet tool zoom value is set at "1"
  
  When I scroll the snippet waveform to the "left"
  Then snippet waveform moves "forward" in time
  
  When I scroll the snippet waveform to the "right"
  Then snippet waveform moves "back" in time
  