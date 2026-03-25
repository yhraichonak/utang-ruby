@atc @automated @el @critical @atc_at
@EPIC:FlightTracker @FEATURE:FlightDetails
@clear_atc_flights
@TMS:586317
Feature: alertTracker_alert_details_history_display
  As an Alert Tracker User
  I want to view the History tab on the patient details monitor
  So that I can verify its display

  TestRail Id: C586317

  XXXX-2022
  - In Alert Tracker, remove "History" tab from Expanded window and change "Audit" tab to "History" tab.

  Jira Stories: XXXX-2022

  Jira Bugs/Defects:


  Scenario: Alert Tracker - Patient Details Panel - History Tab Display
    Given User executes test from "[props.CONFIGS_TC05_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    And FT: User is logged in with default filter applied
    When Alert "TC05_Alarm" initiated on PM with 60 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    When API: Wait until the flight status is Complete by Flight Manager for 30 seconds
    When FT: User opens the generated alert details
    And FT: User opens History tab of the alert details panel
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*NewFlightCreated*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated. To Level:1, Reason: InitialSuspenseTimeout.*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightComplete.*Reason:AutoCancelTime expired.*"
    And Time difference between ".*[props.ACMS_TIMESTAMP_REGEXP].*NewFlightCreated*" and ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightComplete.*Reason:AutoCancelTime expired.*" is 20 seconds

