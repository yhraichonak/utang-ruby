@regression @automated @core @pm @pm-snippets @pm-snippets-tools
Feature: PM - Monitor Tool - Hortizonal Fling
Description

The user can "fling" the Monitor Tool forward or backward in time (similar to how a touch-screen would "swipe" scroll).
When performing this action, the fling motion should result in *only * scrolling horizontally (adjusting the time
index of the monitor - not the vertical placement of the waveforms/lead labels.)

Note: Most likely requires implementation of 2 discrete actions when scrolling: horizontal OR vertical.
As per Neil - >45 degrees down then vertical scroll, > 45 degrees horizontal is left to right scroll. 


TestRail Id: C328793
Jira Stories: AS1-1665
@critical @TMS:328793
Scenario: PM - Monitor Tool - Horizontal Fling
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

  When I fling the snippet waveform to the "right"
  Then snippet waveform moves "back" in time
  And I should notice little to no vertical movement on fling action

  When I fling the snippet waveform to the "left"
  Then snippet waveform moves "forward" in time
  And I should notice little to no vertical movement on fling action