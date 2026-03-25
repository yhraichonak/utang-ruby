@atc @automated @critical @atc_ad
@atc_smoke @EPIC:AirCommand @FEATURE:AlertsCounter
@TMS:586360 @clear_atc_flights
Feature: ad_alerts_counter
  As an Alert Dispatch User
  I want to view results coming into the Alerts list
  So that I can confirm the counter accurately counts the incoming alerts

  XXXX-1079
  Alarm/Alert Queue Counter #Alarm tested in C586362
  - Both the Alarm and Alert queue columns will include a counter in the top right corner.
  - This will show a count of active alarms/Alerts only for their respective queues.
  - This count will NOT include ended or completed flights.
  - Border will flash for any update
  - Count will only flash when the number changes

  XXXX-1956
  In Alert Dispatch, under the Alerts Column, change "In Flight" to "Active". Attached is a screen shot for reference.

  XXXX-2143
  - Remove blue blinking borders around columns.

  TESTING NOTES:
  - How-To create an alert flight - https://utang.atlassian.net/wiki/spaces/ACMS/pages/3304816692/Setting+up+a+Flight+Plan+and+Generating+an+Alarm+Manually

  TestRail Id: C586360

  Jira Stories: XXXX-1079, XXXX-1956, XXXX-2143

  Jira Bugs/Defects:

  Scenario: Alerts count increases when a new alert comes in
    Given User executes test from "[props.CONFIGS_TC05_MULTI_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    When AC: User is logged in with default filter applied
    And AC: User verifies that Alarms counter on Alerts panel has value 0
    When Alert "TC05_01_Alarm" initiated on PM with 60 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    And API: Wait until the flight status is Escalated by Flight Manager
    And AC: User wait until "TC05_01_Alarm" alert appears in Alerts panel in Active subsection
    Then AC: User verifies that Alarms counter on Alerts panel has value 1
    When Alert "TC05_02_Alarm" initiated on PM with 60 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    And API: Wait until the flight status is Escalated by Flight Manager
    Then AC: User verifies that Alarms counter on Alerts panel has value 2
    And AC: User wait until "TC05_02_Alarm" alert appears in Alerts panel in Active subsection

  Scenario: Alerts count decreases when an alarm has completed
    Given User executes test from "[props.CONFIGS_TC05_MULTI_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    And AC: User is logged in with default filter applied
    When Alert "TC05_02_Alarm" initiated on PM with 60 seconds timeout
    When Alert "TC05_Medium_Alarm_Short" initiated on PM with 10 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    And API: Wait until the flight status is Escalated by Flight Manager
    And AC: User wait until "TC05_Medium_Alarm_Short" alert appears in Alerts panel in Active subsection
    Then AC: User verifies that Alarms counter on Alerts panel has value 2
    When API: Wait until the flight status is Complete by Flight Manager for 30 seconds
    And wait for 1 seconds
    Then AC: User verifies that Alarms counter on Alerts panel has value 1

  Scenario: Alerts count does not changed when an alarm is updated
    Given User executes test from "[props.CONFIGS_TC04_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    And AC: User is logged in with default filter applied
    When Alert "TC04_Alarm" initiated on PM with 60 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    And API: Wait until the flight status is Escalated by Flight Manager
    And AC: User wait until "TC04_Alarm" alert appears in Alerts panel in Active subsection
    Then AC: User verifies that Alarms counter on Alerts panel has value 1
    When API: Wait until the flight is escalated to level 2
    Then AC: User verifies that Alarms counter on Alerts panel has value 1