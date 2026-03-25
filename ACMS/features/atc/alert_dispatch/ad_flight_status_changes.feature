@atc @automated @critical @atc_ad
@atc_smoke @EPIC:AirCommand @FEATURE:FlightStatus
@TMS:586338 @clear_atc_flights
Feature: ad_flight_status_changes
  As an Alert Dispatch user
  I want to see the flight status change
  So that I can verify flight status change correctly

  XXXX-1048
  The following flight statuses shall exist:
  Status Queue/In Flight/Completed Color
  - Suspended Queue alarm active time box should be utang Blue
  - Ended Queue alarm time box should be gray
  - Waiting In Flight (top) alarm active time box should be Blue, symbol: Open Circle
  - Accepted In Flight (top) alarm active time box should be Green, symbol: Closed Circle
  - Undeliverable In Flight (top) alarm active time box should be Red, Symbol: Open Circle with Diagonal line
  - Completed Completed (bottom) alarm time box should be gray

  TESTING NOTES:
  - How-To create an alert flight - https://utang.atlassian.net/wiki/spaces/ACMS/pages/3304816692/Setting+up+a+Flight+Plan+and+Generating+an+Alarm+Manually
  - Setting up various Flight statuses - https://utang.atlassian.net/wiki/spaces/ACMS/pages/3568041992/Setting+up+various+Flight+statuses

  TestRail Id: C586338

  Jira Stories: XXXX-1048

  Jira Bugs/Defects:

  Scenario: Alarm Queue panel with Suspended status
    Given User executes test from "[props.CONFIGS_TC11_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    And AC: User is logged in with default filter applied
    When Alert "TC11_Alarm" initiated on PM with 60 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    Then AC: User verifies the generated alert is present in Alarm Queue panel
    Then AC: Flight alert status section is blue and has no-icon icon with label Suspended
    And AC: Flight alert "Escalation in" value counting down from "00:30" seconds

  Scenario: Alarm Queue panel with Ended status
    Given User executes test from "[props.CONFIGS_TC08_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    And AC: User is logged in with default filter applied
    When Alert "TC08_Alarm" initiated on PM with 60 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    When API: Wait until the flight status is Complete by Flight Manager for 30 seconds
    Then AC: User verifies the generated alert is present in Alarm Queue panel
    And AC: Flight alert status section is grey and has no-icon icon with label Ended

  Scenario: Alerts panel with Waiting status
    Given User executes test from "[props.CONFIGS_TC03_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    And AC: User is logged in with default filter applied
    When Alert "TC03_Alarm" initiated on PM with 25 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    Then AC: User verifies the generated alert is present in Alerts panel
    And AC: Flight alert status section is blue and has empty-circle icon with label Waiting
    And AC: Flight alert "Escalation in" value counting down from "00:10" seconds


  Scenario: Alerts panel with Accepted status
      Given User executes test from "[props.CONFIGS_TC04_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
      And AC: User is logged in with default filter applied
      When Alert "TC04_Alarm" initiated on PM with 25 seconds timeout
      And API: Wait until the alert is processed by Flight Manager
      And AC: Flight alert status section is green and has filled-circle icon with label Accepted

  Scenario: Alerts panel with Undeliverable status
    Given User executes test from "[props.CONFIGS_TC01C_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    And AC: User is logged in with default filter applied
    When Alert "TC01c_Alarm" initiated on PM with 25 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    And AC: Flight alert status section is red and has barred-circle icon with label Undeliverable


  Scenario: Alerts panel with Completed status
    Given User executes test from "[props.CONFIGS_TC03_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    And AC: User is logged in with default filter applied
    When Alert "TC03_Alarm" initiated on PM with 15 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    When API: Wait until the flight status is Complete by Flight Manager for 30 seconds
    Then AC: User should see the generated alert present in Alerts panel in Completed subsection
    And AC: Flight alert status section is grey and has no-icon icon with label Completed