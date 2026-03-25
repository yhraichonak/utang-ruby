@atc @automated @critical @atc_ad
@atc_smoke @EPIC:AirCommand @FEATURE:AlarmsCounter
@TMS:586362 @clear_atc_flights
Feature: ad_alarm_queue_counter
  As an Alert Dispatch User
  I want to view results coming into the Alarm Queues list
  So that I can confirm the counter accurately counts the incoming alarm

  XXXX-1079
  Alarm/Alert Queue Counter #Alert tested in C586360
  - Both the Alarm and Alert queue columns will include a counter in the top right corner.
  - This will show a count of active alarms/Alerts only for their respective queues.
  - This count will NOT include ended or completed flights.
  - Border will flash for any update
  - Count will only flash when the number changes

  XXXX-1553
  - As a user I shall see the Alarm Queue update as new flights are received.

  XXXX-2143
  - Remove blue blinking borders around columns.

  TESTING NOTES:
  - How-To create an alert flight - https://utang.atlassian.net/wiki/spaces/ACMS/pages/3304816692/Setting+up+a+Flight+Plan+and+Generating+an+Alarm+Manually

  TestRail Id: C586362

  Jira Stories: XXXX-1079, XXXX-1553, XXXX-2143

  Jira Bugs/Defects:


  Scenario: Alarm Queues count increases when a new alarm comes in
    Given User executes test from "[props.CONFIGS_TC09_MULTI_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    When AC: User is logged in with default filter applied
    When Alert "TC09_01_Alarm" initiated on PM with 60 seconds timeout
    And AC: User verifies that Alarms counter on Alarm Queue panel has value 0
    And API: Wait until the alert is processed by Flight Manager
    Then AC: User verifies that Alarms counter on Alarm Queue panel has value 1
    When Alert "TC09_02_Alarm" initiated on PM with 60 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    Then AC: User verifies that Alarms counter on Alarm Queue panel has value 2


  Scenario: Alarm Queues count decreases when a flight starts
    Given User executes test from "[props.CONFIGS_TC05_MULTI_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    When AC: User is logged in with default filter applied
    When Alert "TC05_01_Alarm_Suspend" initiated on PM with 60 seconds timeout
    When Alert "TC05_02_Alarm_Suspend" initiated on PM with 60 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    Then AC: User verifies that Alarms counter on Alarm Queue panel has value 2
    And API: Wait until the flight status is Escalated by Flight Manager
    Then AC: User verifies that Alarms counter on Alarm Queue panel has value 1


  Scenario: Alarm Queues count decreases when an alarm ends
    Given User executes test from "[props.CONFIGS_TC09_MULTI_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    When AC: User is logged in with default filter applied
    When Alert "TC09_01_Alarm" initiated on PM with 60 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    Then AC: User verifies that Alarms counter on Alarm Queue panel has value 1
    When Alert "TC09_04_Alarm_Ended" initiated on PM with 5 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    Then AC: User verifies that Alarms counter on Alarm Queue panel has value 2
    When API: Wait until the flight status is Complete by Flight Manager for 20 seconds
    Then AC: User verifies that Alarms counter on Alarm Queue panel has value 1

