@regression @automated @core @nodeSim  @pm @pm-snippets @pm-snippets-tools
Feature: PM - Snippet Tool Rhythm Strip Scroll
Boundary Indicators Interaction
The boundary indicators should be draggable (lengthen or shorten the total snippet length) on
both the zoom view and rhythm strip in order to encompass the appropriate amount of waveform necessary.
Boundary indicators should be draggable when measurements are "ON" or "OFF" however, it is possible
when measurements OFF that the indicators are not visible and therefore not draggable (depending on
length of snippet set). Both left and right boundary indicators should be draggable in either direction,
but not allowed to overlap one another.

When boundary indicators are dragged, indicating that the snippet will now be a custom size, that
length (in seconds) should dynamically display in the Snippet Length picker display area, rounding
to a tenth of a second.

*Note: max to be set if necessary due to technical limit

TestRail Id: C264451
Jira Stories: AS1-155, AS1-3637
@critical @TMS:264451
Scenario: PM - Snippet Tool Rhythm Strip Scroll
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  Then I should see the patient list screen
  When I click "Census" on the List
  Then I should see the patient list screen
  When I click on default patient in list without redirect
  Then I should see the Live Monitor screen
  When I click the "Tools" button in sub navigation menu
  Then I should see the Snippet Tool screen
  And I see the Snippet Rhythm Strip timestamp "%H:%M:%S" format
  
  When I scroll the "left" boundary indicator to the "left"
  Then the Rhythm strip boundary indicator "increases" in size
  When I scroll the "left" boundary indicator to the "right"
  Then the Rhythm strip boundary indicator "decreases" in size
  When I scroll the "right" boundary indicator to the "right"
  Then the Rhythm strip boundary indicator "increases" in size
  When I scroll the "right" boundary indicator to the "left"
  Then the Rhythm strip boundary indicator "decreases" in size

  When I scroll the rhythm strip to the "right"
  Then the rhythm strip should scroll to the "right"
  And the boundary indicators should remain in place
  When I scroll the rhythm strip to the "left"
  Then the rhythm strip should scroll to the "left"
  And the boundary indicators should remain in place
  
  When I click on Measure button
  Then I should see the Measure button "active"
  And I should see the HR legend in waveform chart
  And I should see calculating distances of PR, QRS, and QT values
  And I should see the Measure controls for P, Q/R, S, T

  When I scroll the "left" boundary indicator to the "left"
  Then the Rhythm strip boundary indicator "increases" in size
  When I scroll the "left" boundary indicator to the "right"
  Then the Rhythm strip boundary indicator "decreases" in size
  When I scroll the "right" boundary indicator to the "right"
  Then the Rhythm strip boundary indicator "increases" in size
  When I scroll the "right" boundary indicator to the "left"
  Then the Rhythm strip boundary indicator "decreases" in size

  When I scroll the rhythm strip to the "right"
  Then the rhythm strip should scroll to the "right"
  And the boundary indicators should move with measure controls
  When I scroll the rhythm strip to the "left"
  Then the rhythm strip should scroll to the "left"
  And the boundary indicators should move with measure controls