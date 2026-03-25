@regression @monitor @nodeSim @automated @core @pm @pm-monitor
Feature: Monitor - Horizontal Scroll Fling
Description

The user can "fling" the Patient Monitor forward or backward in time (similar to how a touch-screen would "swipe" scroll).
When performing this action, the fling motion should result in *only * scrolling horizontally (adjusting the time index
of the monitor - not the vertical placement of the waveforms/lead labels.)

Note: Most likely requires implementation of 2 discrete actions when scrolling: horizontal OR vertical.
As per Neil - >45 degrees down then vertical scroll, > 45 degrees horizontal is left to right scroll.

TestRail Id: C328792
Jira Issues: AS1-1664, AS1-2985, AS1-4225, AS1-4501, AS1-5681
 @critical @TMS:328792
Scenario: Monitor - Horizontal Scroll Fling
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  Then I should see the patient list screen
  When I click "Census" on the List
  Then I should see the patient list screen
  When I click on default patient in list
  Then I should see the patient summary screen
  When I click on the Monitor tile
  Then I should see the Live Monitor screen
  When I fling the monitor waveform to the "right"
  Then monitor waveform moves "back" in time
  And I should notice little to no vertical movement on fling action
  #And I should see the historical waveforms are maintained
  #(AS1-5681)
  And the "Live" button is inactive
  And the Monitor Time Ago displays on monitor
  And I should see discrete values updating as the data changes
  When I fling the monitor waveform to the "left"
  Then monitor waveform moves "forward" in time
  And I should notice little to no vertical movement on fling action
  #And I should see the historical waveforms are maintained
  #(AS1-5681)
  And the "Live" button is inactive
  And the Monitor Time Ago displays on monitor
  And I should see discrete values updating as the data changes

  When I scroll the monitor waveform to the "up"
  Then monitor waveform moves "no change" in time
  And the "Live" button is inactive
  And the Monitor Time Ago displays on monitor
  When I scroll the monitor waveform to the "down"
  Then monitor waveform moves "no change" in time
  And the "Live" button is inactive
  And the Monitor Time Ago displays on monitor
  When I click the "Live" button in sub navigation menu
  And the "Live" button is active
