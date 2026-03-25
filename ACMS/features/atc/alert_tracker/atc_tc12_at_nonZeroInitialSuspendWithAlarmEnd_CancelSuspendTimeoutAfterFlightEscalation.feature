@atc @automated @el @critical @atc_at @flight_path
@EPIC:FlightTracker @FEATURE:InitialSuspend
@clear_atc_flights @TMS:584231
Feature: airDispatch_tc12_nonZeroInitialSuspendWithAlarmEnd_CancelSuspendTimeoutAfterFlightEscalation
  As an Air Traffic Controller user
  I want to generate a flight with whose alarm ends in the Initial Suspense state but hit a flight escalation while the non-zero cancellation suspense is still active
  So that I can verify an alarm that ends while in the initial suspend state and hits the Initial Suspense timeout with an active CancellationSuspense timeout will complete properly when the CancellationSuspense timeout is reached
  XXXX-###

  Test Notes: See https://utang.atlassian.net/wiki/spaces/ACMS/pages/3304816692/Setting+up+a+Flight+Plan+and+Generating+an+Alarm+Manually for location of
  flight plan configuration and instructions on how to execute configuration setup/alarm generation

  TestRail Id: C584231

  Jira Stories:

  Jira Bugs/Defects:

  Background:
    Given User executes test from "[props.CONFIGS_TC12_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    And FT: User is logged in with default filter applied

  Scenario: flight with a non-zero initial suspend value and with an alarm duration that is less than the initial suspend value
    When Alert "TC12_Alarm" initiated on PM with 20 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    And FT: User waits unit the generated alert is present in alerts table with attributes "{ "Alarm Label":"TC12_Alarm", "End Time":"", "Delivered":"false", "Accepted":"false"}"
    And FT: The "Total Time" field should be populated with an incrementing time elapsed label
    And API: Wait until the flight status is Complete by Flight Manager for 40 seconds
    And FT: User sees the "Total Time" on the flight entry stop at "0:40" within 3 second range
    When FT: User opens the generated alert details
    And FT: User opens History tab of the alert details panel
    Then FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*NewFlightCreated*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightInitialSuspenseStart. *Initial Suspense started.*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*AlarmEndReceived. *Alarm End message received.*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightCompletionSuspenseStart. *Starting Completion Suspend.*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightCompletionSuspenseEnd.*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightComplete.*"
    And Time difference between ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightCompletionSuspenseStart. *Starting Completion Suspend.*" and ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightComplete.*" is 20 seconds