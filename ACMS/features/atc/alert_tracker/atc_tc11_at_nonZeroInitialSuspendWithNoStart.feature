@atc @automated @el @critical @atc_at @flight_path
@EPIC:FlightTracker @FEATURE:InitialSuspend
@clear_atc_flights @TMS:584213
Feature: alertTracker_tc11_nonZeroInitialSuspendWithNoStart
  As an Air Traffic Controller user
  I want to generate a flight with a non-zero initial suspend value where the "Start" button is not pressed
  So that I can verify that an alarm that is not started will hit the Initial Suspend timeout and auto escalate to Escalation Level 1

  XXXX-###

  Test Notes: See https://utang.atlassian.net/wiki/spaces/ACMS/pages/3304816692/Setting+up+a+Flight+Plan+and+Generating+an+Alarm+Manually for location of
  flight plan configuration and instructions on how to execute configuration setup/alarm generation

  TestRail Id: C584213

  Jira Stories:

  Jira Bugs/Defects:

  Background:
    Given User executes test from "[props.CONFIGS_TC11_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    And FT: User is logged in with default filter applied

  Scenario: flight with a non-zero initial suspend value where the "Start" button is not pressed
    When Alert "TC11_Alarm" initiated on PM with 60 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    And FT: User waits unit the generated alert is present in alerts table with attributes "{ "Alarm Label":"TC11_Alarm", "End Time":"", "Delivered":"false", "Accepted":"false"}"
    And FT: The "Total Time" field should be populated with an incrementing time elapsed label
    When API: Wait until the flight status is Escalated by Flight Manager for 35 seconds
    And FT: User waits unit the generated alert is present in alerts table with attributes "{ "Alarm Label":"TC11_Alarm", "End Time":"", "Delivered":"true", "Accepted":"false"}"
    And API: Wait until the flight status is Complete by Flight Manager for 90 seconds
    And FT: User sees the "Total Time" on the flight entry stop at "1:30" within 3 second range
    When FT: User opens the generated alert details
    And FT: User opens History tab of the alert details panel
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*NewFlightCreated*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightInitialSuspenseStart *Initial Suspense started.*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated. To Level:1. *Reason: InitialSuspenseTimeout.*"
    And Time difference between ".*[props.ACMS_TIMESTAMP_REGEXP].*NewFlightCreated*" and ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated. To Level:1, Reason: InitialSuspenseTimeout.*" is 30 seconds
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*AlarmEndReceived *Alarm End message received.*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightComplete.*"