@atc @automated @el @critical @atc_at @flight_path
@EPIC:FlightTracker @FEATURE:CancellationSuspend
@clear_atc_flights @TMS:584237
Feature: alertTracker_tc20b_escalationDuringCancellationSuspense
  As an Air Traffic Controller user
  I want to generate a flight that gets escalated after the alarm for the flight has ended and the flight's CancellationSuspense timeout is activated
  So that I can verify that an alarm can change escalation levels successfully with an activated CancellationSuspense timeout

  XXXX-###

  Test Notes: See https://utang.atlassian.net/wiki/spaces/ACMS/pages/3304816692/Setting+up+a+Flight+Plan+and+Generating+an+Alarm+Manually for location of
  flight plan configuration and instructions on how to execute configuration setup/alarm generation

  TestRail Id: C584237

  Jira Stories:

  Jira Bugs/Defects:

  Background:
    Given User executes test from "[props.CONFIGS_TC20B_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    And FT: User is logged in with default filter applied

  Scenario: flight with a non-zero initial suspend value and with an alarm duration that is less than the initial suspend value
    When Alert "TC20b_Alarm" initiated on PM with 30 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    And FT: User waits unit the generated alert is present in alerts table with attributes "{ "Alarm Label":"TC20b_Alarm", "End Time":"", "Delivered":"false", "Accepted":"false"}"
    And API: Wait until the flight status is Escalated by Flight Manager for 15 seconds
    And FT: User waits unit the generated alert is present in alerts table with attributes "{ "Alarm Label":"TC20b_Alarm", "End Time":"", "Delivered":"true", "Accepted":"false"}"
    And FT: The "Total Time" field should be populated with an incrementing time elapsed label
    And API: Wait until the flight status is Complete by Flight Manager for 60 seconds
    And FT: User sees the "Total Time" on the flight entry stop at "1:00" within 3 second range
    When FT: User opens the generated alert details
    And FT: User opens History tab of the alert details panel
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*NewFlightCreated*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightInitialSuspenseStart. *Initial Suspense started.*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated. To Level:1. *Reason: InitialSuspenseTimeout.*"
    And Time difference between ".*[props.ACMS_TIMESTAMP_REGEXP].*NewFlightCreated*" and ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated. To Level:1, Reason: InitialSuspenseTimeout.*" is 15 seconds
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*AlarmEndReceived. *Alarm End message received.*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightCompletionSuspenseStart. *Starting Completion Suspend.*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated. To Level:2. *Reason: EscalationTimeout.*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightCompletionSuspenseEnd.*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightComplete.*"
