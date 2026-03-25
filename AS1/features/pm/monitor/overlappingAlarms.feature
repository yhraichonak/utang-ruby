@regression @monitor @automated @core @pm @pm-monitor
Feature: PM - Monitor - Overlapping/Multiple Alarms
Overlapping/Multiple Alarms
The alarm(s) that are sent for the right-aligned viewed time (plus padded start/end times) shall display as a horizontal list, where the highest severity alarms display on the left (first) and lowest severity alarms display on the right (last). Any alarms with equal severity will display in the order in which the server sends them.
Note: If severity "None" displays, it will be considered the lowest level of alarm instead of "low"

TBD max # of alarms
Scenario (4 alarms) where padding = 2 seconds
Severity	Start Time	End Time	Padded Start	Padded End
Medium	9:00:02	9:03:00	9:00:00	9:03:02
High A	9:01:02	9:05:00	9:01:00	9:05:02
High B	9:02:02	9:04:00	9:02:00	9:04:02
Low	9:03:02	9:06:00	9:03:00	9:06:02
Historical Monitor Display:
when right aligned monitor time is:

9:00:30, Medium displays.
9:01:30, High A and Medium display (left to right)
9:02:30 High A, High B, and Medium display (left to right)
9:03:30 High A, High B, and Low display (left to right)
9:04:30 Low displays
Live Monitor Display:
Scenario is same as above - the only exception being that live monitor has no "padded" start time, so the initial display of the alarms will come as soon as received by the server. (Actual Start time).

TestRail Id: C264312
Jira Stories: AS1-191, AS1-682
  @TMS:264312
Scenario: PM - Monitor - Overlapping/Multiple Alarms
  Given I login to a testSite with "utang" and "XXXXX"
  Then I should see the patient list screen
  When I click "Census" on the List
  Then I should see the patient list screen
  When I click on "da Vinci, Leonardo" in patient list
  Then I should see the patient summary screen
  When I click on the Monitor tile
  Then I should see the Live Monitor screen
  When I click the "Events" button in sub navigation menu
  Then I should see the Events screen
  When I click Expand link under "Last Hour" section
  And I should see the discrete data for events for "Last Hour" section
  When I click on the first Event in event section
  Then I should see the Live Monitor screen
  And the "Live" button is inactive
  And the Monitor Time should match the Event time selected

  When I scroll the monitor waveform to the "right"
  Then monitor waveform moves "back" in time
  And I should see overlapping Events priority in order from left to right
  When I scroll the monitor waveform to the "right"
  Then monitor waveform moves "back" in time
  And I should see overlapping Events priority in order from left to right
  When I scroll the monitor waveform to the "right"
  Then monitor waveform moves "back" in time
  And I should see overlapping Events priority in order from left to right
  When I scroll the monitor waveform to the "right"
  Then monitor waveform moves "back" in time
  And I should see overlapping Events priority in order from left to right

  When I click the "Events" button in sub navigation menu
  Then I should see the Events screen
