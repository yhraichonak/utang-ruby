@atc @automated @el @critical @atc_at @flight_path
@EPIC:FlightTracker @FEATURE:CancellationSuspend
@clear_atc_flights @TMS:584267
Feature: alertTracker_tc22_alarmEndAndStartDuringInitialSuspenseAndEscalation
  As an Air Traffic Controller user
  I want to generate a flight with whose alarm ends and starts again in the Initial Suspense state
  So that I can verify that a flight will still properly exit the Initial Suspense state after the Cancellation Suspense is activated and deactivated
  XXXX-###

  Test Notes: See https://utang.atlassian.net/wiki/spaces/ACMS/pages/3304816692/Setting+up+a+Flight+Plan+and+Generating+an+Alarm+Manually for location of
  flight plan configuration and instructions on how to execute configuration setup/alarm generation

  TestRail Id: C584267

  Jira Stories:

  Jira Bugs/Defects:

  Background:
    Given User executes test from "[props.ACMS_DEFAULT_CONFIG]" file in ATC Integration Test Console
    And FT: User is logged in with default filter applied

  Scenario: flight in which the alarm ends in the Initial Suspense state and starts again in the Escalated state
    When Alert "TC22_Alarm" initiated on PM with 20 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    And FT: User waits unit the generated alert is present in alerts table with attributes "{ "Alarm Label":"TC22_Alarm", "End Time":"", "Delivered":"false", "Accepted":"false"}"
    And FT: The "Total Time" field should be populated with an incrementing time elapsed label
    When API: Wait until the flight is in cancellation suspense state for 30 seconds
    When Alert "TC22_Alarm" initiated on PM with 10 seconds timeout
    And API: Wait until the flight status is Escalated by Flight Manager
    And FT: User waits unit the generated alert is present in alerts table with attributes "{ "Alarm Label":"TC22_Alarm", "End Time":"", "Delivered":"true", "Accepted":"false"}"
    And API: Wait until the flight status is Complete by Flight Manager for 30 seconds
    And FT: User sees the "Total Time" on the flight entry stop at "00:45" within 3 second range
    When FT: User opens the generated alert details
    And FT: User opens History tab of the alert details panel
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*NewFlightCreated*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightInitialSuspenseStart. *Initial Suspense started.*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*AlarmEndReceived. *Alarm End message received.*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightCompletionSuspenseStart. *Starting Completion Suspend.*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated. To Level:1. *Reason: InitialSuspenseTimeout.*"
    And Time difference between ".*[props.ACMS_TIMESTAMP_REGEXP].*NewFlightCreated*" and ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated. To Level:1, Reason: InitialSuspenseTimeout.*" is 30 seconds
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightCompletionSuspenseExit.*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightComplete.*"
