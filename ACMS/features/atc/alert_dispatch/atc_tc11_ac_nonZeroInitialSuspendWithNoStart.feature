@atc @automated @el @critical @atc_ad @flight_path
@EPIC:AirCommand @FEATURE:InitialSuspend
@clear_atc_flights @TMS:584199
Feature: airDispatch_tc11_nonZeroInitialSuspendWithNoStart
  As an Air Traffic Controller user
  I want to generate a flight with a non-zero initial suspend value where the "Start" button is not pressed
  So that I can verify that an alarm that is not started will hit the Initial Suspend timeout and auto escalate to Escalation Level 1

  XXXX-###

  Test Notes: See https://utang.atlassian.net/wiki/spaces/ACMS/pages/3304816692/Setting+up+a+Flight+Plan+and+Generating+an+Alarm+Manually for location of
  flight plan configuration and instructions on how to execute configuration setup/alarm generation

  TestRail Id: C584199

  Jira Stories:

  Jira Bugs/Defects:

  Background:
    Given User executes test from "[props.CONFIGS_TC11_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    And AC: User is logged in with default filter applied
  
  Scenario: flight with a non-zero initial suspend value where the "Start" button is not pressed
    When Alert "TC11_Alarm" initiated on PM with 60 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    Then AC: User verifies the generated alert is present in Alarm Queue panel
    Then AC: Flight alert status section is blue and has no-icon icon with label Suspended

    When AC: User opens the generated alert details in Alarm Queue panel
    And AC: User opens History tab of the alert details panel
    Then AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*NewFlightCreated*"
    And API: Wait until the flight status is Escalated by Flight Manager for 30 seconds
    Then AC: User should see the generated alert present in Alerts panel in Active subsection
    And AC: Flight alert status section is blue and has empty-circle icon with label Waiting
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated. To Level:1, Reason: InitialSuspenseTimeout.*"
    And Time difference between ".*[props.ACMS_TIMESTAMP_REGEXP].*NewFlightCreated*" and ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated. To Level:1, Reason: InitialSuspenseTimeout.*" is 30 seconds
