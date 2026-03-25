@atc @automated @critical @atc_ad
@atc_smoke @EPIC:AirCommand @FEATURE:AlarmsQueue
@TMS:586467 @clear_atc_flights
Feature: ad_alarm_queue_panel
  As an Alert Dispatch User
  I want Alarms Queue panel to display flights
  So that I can view flights that have not started or ended

  XXXX-1529
  - A user shall only see a new flight in the alarm queue.
  - A user shall not see a started flight in the alarm queue.
  - A user shall not see a completed flight in the alarm queue.
  - A user shall be able to see the number of alarms in the top right corner of the queue.
  - A user shall be able to scroll to see all alarms in queue.

  NOTE:
  - Only new flights that has triage attribute true will be displayed in alarm queue
  - new Flights that do not have triage true will not be displayed in alarm queue
  - If an alarm ends before it goes to inflight, then it should still stay in the alarm queue but displayed in gray color (still say "suspended"). (default: two hours - configurable)

  XXXX-1875
  Please remove the viewed/unviewed icon in the Alarm Queue chicklet.

  XXXX-2254
  Original Issue reported- If the details panel is open when flights are loaded rapidly (e.g., new flight every 250ms), the web page resizes, unexpectedly and undesirably. See videos below for examples
  - As a user of Alert Dispatch, when flights load into the Alarm column or Alert column at the rate of 1 alarm every 250ms, the Alarm Column and Alert Column shall not resize.
  - As a user of Alert Dispatch, when I have a flight's detail panel open and flights load into the Alarm Queue and/or Alert Queue at a rate of 1 alarm every 250ms, the Alert Column, the Alarm Column, and the Detail panel shall not resize.
  Note: The issue that caused this story to be written was the columns quickly resizing themselves multiple times right after the History tab is opened, rather than one consistent size.

  TESTING NOTES:
  - Other AirCommand related testcases: C590348
  - How-To create an alert flight - https://utang.atlassian.net/wiki/spaces/ACMS/pages/3304816692/Setting+up+a+Flight+Plan+and+Generating+an+Alarm+Manually
  - Freya or Odin should give you a rapid enough rate of 1 alarm every 250ms.

  TestRail Id: C586467

  Jira Stories: XXXX-1529, XXXX-1875, XXXX-2254

  Jira Bugs/Defects:


Scenario: The Alarm Queue panel should only display flights that have not started or ended
  Given User executes test from "[props.CONFIGS_TC09_MULTI_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
  When Alert "TC09_Low_01_Alarm" initiated on PM with 60 seconds timeout
  When Alert "TC09_Low_02_Alarm" initiated on PM with 60 seconds timeout
  When Alert "TC09_Medium_01_Alarm" initiated on PM with 60 seconds timeout
  When Alert "TC09_Medium_02_Alarm" initiated on PM with 60 seconds timeout
  When Alert "TC09_04_Alarm_Ended" initiated on PM with 60 seconds timeout
  When Alert "TC09_05_Alarm_NoTriage" initiated on PM with 60 seconds timeout
  When Alert "TC09_01_Alarm" initiated on PM with 60 seconds timeout
  When Alert "TC09_02_Alarm" initiated on PM with 60 seconds timeout
  And API: Wait until the alert is processed by Flight Manager
  And AC: User is logged in with default filter applied
  And AC: User wait until "TC09_02_Alarm" alert appears in Alarm Queue panel
  Then AC: User verifies that Alarms counter on Alarm Queue panel has value 7

#  Scenario: The Alarm Queue panel shall not resize as flights are loaded rapidly
    #TODO: test is not automatable