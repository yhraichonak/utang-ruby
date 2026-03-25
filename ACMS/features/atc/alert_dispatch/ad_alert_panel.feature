@atc @automated @critical @atc_ad
@atc_smoke @EPIC:AirCommand @FEATURE:AlertDetails
@TMS:586468 @clear_atc_flights
Feature: ad_alert_panel
  As an Alert Dispatch User
  I want Alerts panel to display flights
  So that I can view flights that are in flight or completed

  XXXX-1531
  - A user shall not see a new flight displayed in Alerts.
  - A user shall only see started flight displayed in alerts - in flight section
  - A user shall only see a completed flight displayed in alerts - completed section
  - A user shall be able to scroll up/down to see all alerts.

  XXXX-1956
  In Alert Dispatch, under the Alerts Column, change "In Flight" to "Active". Attached is a screen shot for reference.

  TESTING NOTES:
  - How-To create an alert flight - https://utang.atlassian.net/wiki/spaces/ACMS/pages/3304816692/Setting+up+a+Flight+Plan+and+Generating+an+Alarm+Manually

  TestRail Id: C586468

  Jira Stories: XXXX-1531, XXXX-1956

  Jira Bugs/Defects:

  Scenario: The Alerts panel should only display flights that are Active or completed
    Given User executes test from "[props.CONFIGS_TC05_MULTI_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
     And AC: User is logged in with default filter applied
    When Alert "TC05_02_Alarm" initiated on PM with 60 seconds timeout
    When Alert "TC05_Medium_Alarm_Short" initiated on PM with 10 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    When API: Wait until the flight status is Complete by Flight Manager for 30 seconds
    And wait for 1 seconds
    And AC: User should see "TC05_Medium_Alarm_Short" alert present in Alerts panel in Completed subsection
    And AC: User should see "TC05_02_Alarm" alert present in Alerts panel in Active subsection
    And AC: User opens the "TC05_02_Alarm" alert details in Alerts panel
    Then AC: User verifies that the alert details panel is opened
    Then AC: User verifies that the alert details has matching text
  """
 (?m).*TC05_02_Alarm.*
  """
    And AC: User opens History tab of the alert details panel
    And AC: User verifies that the alert details panel has event matching ".*FlightEscalated.*"
    And AC: User opens the "TC05_Medium_Alarm_Short" alert details in Alerts panel
    Then AC: User verifies that the alert details panel is opened
    Then AC: User verifies that the alert details has matching text
  """
 (?m).*TC05_Medium_Alarm_Short.*
  """
    And AC: User opens History tab of the alert details panel
    And AC: User verifies that the alert details panel has event matching ".*FlightComplete.*"
