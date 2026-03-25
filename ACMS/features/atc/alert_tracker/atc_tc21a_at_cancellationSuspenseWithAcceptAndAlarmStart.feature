@atc @automated @el @critical @atc_at @flight_path
@EPIC:FlightTracker @FEATURE:CancellationSuspend
@clear_atc_flights @TMS:584329
Feature: alertTracker_tc21a_cancellationSuspenseWithAcceptAndAlarmStart
  As an Air Traffic Controller user
  I want to generate a flight that receives an accept response during a cancellation suspense and then exit cancellation suspense due to an alarm start
  So that I can verify that the delay on accept logic as it applies to escalation levels still works while in cancellation suspense

  XXXX-###

  Test Notes: See https://utang.atlassian.net/wiki/spaces/ACMS/pages/3304816692/Setting+up+a+Flight+Plan+and+Generating+an+Alarm+Manually for location of
  flight plan configuration and instructions on how to execute configuration setup/alarm generation

  TestRail Id: C584329

  Jira Stories:

  Jira Bugs/Defects:

  Background:
    Given User executes test from "[props.CONFIGS_TC21A_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    And FT: User is logged in with default filter applied

  Scenario: flight that receives an accept response during a cancellation suspense and then exit cancellation suspense due to an alarm start
    When Alert "TC21a_Alarm" initiated on PM with 20 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    And FT: User waits unit the generated alert is present in alerts table with attributes "{ "Alarm Label":"TC21a_Alarm", "End Time":"", "Delivered":"true", "Accepted":"false"}"
    And FT: The "Total Time" field should be populated with an incrementing time elapsed label
    When API: Wait until the flight is in cancellation suspense state for 25 seconds
    When User manually triggers an Accept response to be sent back to the Flight Manager for this flight
    And FT: User waits unit the generated alert is present in alerts table with attributes "{ "Alarm Label":"TC21a_Alarm", "End Time":"", "Delivered":"true", "Accepted":"true"}"
    When Alert "TC21a_Alarm" initiated on PM with 60 seconds timeout
    And API: Wait until the flight status is Complete by Flight Manager for 300 seconds
    And FT: User sees the "Total Time" on the flight entry stop at "2:50" within 10 second range
    When FT: User opens the generated alert details
    And FT: User opens History tab of the alert details panel
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated. To Level:1. *Reason: InitialSuspenseTimeout.*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*DispatchSent. *Alert Sent. Address:manual*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightCompletionSuspenseStart. *Starting Completion Suspend.*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*DispatchReply. *ResponseBy:manual, Choice:Accept*"
    Then FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*AcceptReceived.*Accept Received.*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*AlarmStartReceived.*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightCompletionSuspenseExit.*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated. To Level:2. *Reason: EscalationTimeout.*"
    And Time difference between ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated. To Level:1, Reason: InitialSuspenseTimeout.*" and ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated. To Level:2. *Reason: EscalationTimeout.*" is 70 seconds
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightCompletionSuspenseStart. *Starting Completion Suspend.*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightCompletionSuspenseEnd.*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightComplete.*"
