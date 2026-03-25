@automated @core @pm @pm-snippets @pm-snippets-document_edit
Feature: PM - Snippet Document Edit - Boundary Indicators
  As an utangONE user
  I want to move the boundary indicators off the edge of the screen with Measure ON and Measure OFF
  So that I can expand my snippet beyond the amount of time automatically selected when Measure is ON
  And still be able to change the time selected, up to the edge of the screen when Measure is OFF

Header
  Updates to Boundary Indicator interactions have made it necessary to ensure that the user can easily create a longer snippet for the length of time desired
  Currently, when dragging a boundary indicator to the left or to the right, when the user reaches the edge of the viewable screen, the boundary indicator cannot go further.
  As a user, I expect that when dragging a boundary indicator past the viewable screen area, that the boundary indicator would continue to drag while the waveform scrolls with this drag.
  **This function will only be available when measure = ON


TestRail Id: C581755

Jira Epic: AS1-2506

Jira Stories: AS1-3889

Jira Bugs/Defects: AS1-5863

@critical @TMS:581755
Scenario: PM - Snippet Document Edit - Boundary Indicators
  Given I login to a testSite with "utang" and "XXXXX"
  Then I should see the patient list screen
  When I click "Census" on the List
  Then I should see the patient list screen
  When I click on "[props.DP_FULL_NAME]" in patient list
  Then I should see the patient summary screen
  When I click on the Monitor tile
  Then I should see the Live Monitor screen
  When I click the "Tools" button in sub navigation menu
  Then I should see the Snippet Tool screen
  When I click the Create Snippet button
  Then I should see the Snippet Document Edit View
  And I should see the measurement values "HR" from monitor tool
  When I enter "90" in "HR" measurement value
  Then I should see the measurement values entered
  When I click the Cancel button on Snippet Document Edit View
  Then I should see Snippet Not Saved window
  When I click the Ok button in Snippet Not Saved window
  Then I should see the Snippet Tool screen
  When I scroll the "left" boundary indicator to the "left"
  Then the "left" boundary indicator moves to the "left"
  And the "left" boundary indicator can only be dragged to the edge of the screen
  And the "right" boundary indicator does not move
  When I scroll the "right" boundary indicator to the "right"
  Then the "right" boundary indicator moves to the "right"
  And the "right" boundary indicator can only be dragged to the edge of the screen
  And the "left" boundary indicator does not move
  When I click on Measure button
  Then I should see calculating distances of PR, QRS, and QT values
  When I scroll the "right" boundary indicator to the far "right"
  Then the "right" boundary window should continue to scroll with the waveform expanding as well
  Then the "left" boundary indicator does not move
  When I scroll the "right" boundary indicator to the far "left"
  Then the rhythm strip should be back to center
  When I scroll the "left" boundary indicator to the far "left"
  Then the "left" boundary window should continue to scroll with the waveform expanding as well
  Then the "right" boundary indicator does not move
  When I scroll the "left" boundary indicator to the far "right"
  Then the rhythm strip should be back to center
  When I click on Measure button
  And I scroll the "left" boundary indicator to the "left"
  Then the "left" boundary indicator moves to the "left"
  And the "left" boundary indicator can only be dragged to the edge of the screen
  And the "right" boundary indicator does not move
  And I scroll the "right" boundary indicator to the "right"
  Then the "right" boundary indicator moves to the "right"
  And the "right" boundary indicator can only be dragged to the edge of the screen
  And the "left" boundary indicator does not move
