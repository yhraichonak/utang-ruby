@regression @monitor @automated @core @pm @pm-monitor
Feature: PM - Monitor - Historical Monitor Alarm Display
Historical Monitor
For Historical Monitor only, Alarms will have an Actual Start, Actual End, Padded Start, and Padded End time.

Actual Start: The time that the server begins sending the alarm
Actual End: The time that the alarm ceases to be sent
Padded Start: The time that the server begins sending the alarm, plus "padding" of minimum one second before Actual Start
Padded End: The time that the alarm ceases to be sent, plus "padding" one second after Actual End
Display Rules for Historical Monitor Alarms:
The minimum display for a single alarm (non-overlapping) is three seconds. If an alarm is sent for a single second, the Padded Start will be one second prior and Padded End will be one seconds after, totaling three seconds of continuous display.
Labels will continuously display on the Live Monitor until 1 second after alarm ends to be sent
Labels should not "blink" (e.g. receiving a VTach Label every second for 32 seconds should display a continuous 33 second VTach Label on the live monitor)
Current logic contains a precedence order for display of singular alarms based on start time. See "Overlapping/Multiple Alarms" for display of multiple alarms. The Historical Monitor Alarm Display rules which includes Padded Start and End times will be retained, whether a single or multiple (overlapping) alarms are displayed.

TestRail Id: C264311
Jira Stories: AS1-190, AS1-682, AS1-812, AS1-3005
@critical @TMS:264311
Scenario: PM - Monitor - Historical Monitor Alarm Display
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  Then I should see the patient list screen
  And reset unit filtering
  When I click "Census" on the List
  Then I should see the patient list screen
  When I click on default patient in list
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
  And I should see Event selected from events screen

  When I scroll the monitor waveform to the "right"
  Then monitor waveform moves "back" in time
  And the "Live" button is inactive
  And the Monitor Time Ago displays on monitor

  When I scroll the monitor waveform to the "left"
  Then monitor waveform moves "forward" in time
  And the "Live" button is inactive
  And the Monitor Time Ago displays on monitor
