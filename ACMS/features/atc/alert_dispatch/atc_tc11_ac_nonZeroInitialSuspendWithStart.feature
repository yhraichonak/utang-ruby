@atc @automated @el @critical @atc_ad @flight_path
@EPIC:AirCommand @FEATURE:InitialSuspend
@clear_atc_flights @TMS:584200
Feature: airDispatch_tc11_nonZeroInitialSuspendWithStart
  As an Air Traffic Controller user
  I want to generate a flight with a non-zero initial suspend value where the "Start" button is clicked before the Initial Suspend timeout is reached
  So that I can verify that an alarm that is "Started" while in the Initial Suspend state will escalate to Escalation Level 1

  XXXX-###

  Test Notes: See https://utang.atlassian.net/wiki/spaces/ACMS/pages/3304816692/Setting+up+a+Flight+Plan+and+Generating+an+Alarm+Manually for location of
  flight plan configuration and instructions on how to execute configuration setup/alarm generation

  TestRail Id: C584200

  Jira Stories:

  Jira Bugs/Defects:

  Background:
    Given User executes test from "[props.CONFIGS_TC11_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    And AC: User is logged in with default filter applied

  Scenario: flight with a non-zero initial suspend value where the "Start" button is clicked before the Initial Suspend timeout is reached
    When Alert "TC11_Alarm" initiated on PM with 60 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    Then AC: User verifies the generated alert is present in Alarm Queue panel
    Then AC: Flight alert status section is blue and has no-icon icon with label Suspended
    When AC: User clicks start button on alarm
    And AC: User clicks start button in pop up modal
    Then AC: User should see the generated alert present in Alerts panel in Active subsection
    And AC: Flight alert status section is blue and has empty-circle icon with label Waiting
    When AC: User opens the generated alert details in Alerts panel
    And AC: User opens History tab of the alert details panel
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*NewFlightCreated*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightInitialSuspenseStart. *Initial Suspense started.*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated. To Level:1, Reason: ManualEscalation.*"
