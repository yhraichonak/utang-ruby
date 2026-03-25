@atc @automated @el @critical @atc_at @flight_path
@EPIC:FlightTracker @FEATURE:CancelSuspend
@clear_atc_flights @TMS:584206
Feature: alertTracker_tc03_nonZeroCancelSuspend
  As an Air Traffic Controller user
  I want to generate a flight with destination level and a non zero cancel suspend timeout
  So that I can verify that the flight goes into the cancel suspend state after the alarm ends and that the flight moves into 'completed' state immediately after the cancel suspend timeout ends

  XXXX-###

  Test Notes: See https://utang.atlassian.net/wiki/spaces/ACMS/pages/3304816692/Setting+up+a+Flight+Plan+and+Generating+an+Alarm+Manually for location of
  flight plan configuration and instructions on how to execute configuration setup/alarm generation

  TestRail Id: C584206

  Jira Stories:

  Jira Bugs/Defects:

  Background:
    Given User executes test from "[props.CONFIGS_TC03_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    And FT: User is logged in with default filter applied

  Scenario: flight with destination level and a non zero cancel suspend timeout
    When Alert "TC03_Alarm" initiated on PM with 25 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    And FT: User waits unit the generated alert is present in alerts table with attributes "{ "Alarm Label":"TC03_Alarm", "End Time":"", "Delivered":"true", "Accepted":"false"}"
    And FT: The "Total Time" field should be populated with an incrementing time elapsed label
    When API: Wait until the flight status is Complete by Flight Manager for 30 seconds
    And FT: User sees the "Total Time" on the flight entry stop at "0:30" within 3 second range
    When FT: User opens the generated alert details
    And FT: User opens History tab of the alert details panel
    Then FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated. To Level:1, Reason: InitialSuspenseTimeout.*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*AlarmEndReceived.*Alarm End message received.*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightCompletionSuspenseStart.*Starting Completion Suspend.*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightCompletionSuspenseEnd.*Event: Cancellation Suspend period ended.*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightComplete.*Reason.Cancellation Suspend ended.*"
    And Time difference between ".*[props.ACMS_TIMESTAMP_REGEXP].*AlarmEndReceived.*Alarm End message received.*" and ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightComplete.*Reason.Cancellation Suspend ended.*" is 5 seconds
    And Time difference between ".*[props.ACMS_TIMESTAMP_REGEXP].*NewFlightCreated*" and ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightComplete.*Reason.Cancellation Suspend ended.*" is 30 seconds


  Scenario: Sending two flights with destination levels and a non zero cancel suspend timeout to verify they complete within the same fight plan
    When Alert "TC03_Alarm" initiated on PM with 25 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    And FT: User waits unit the generated alert is present in alerts table with attributes "{ "Alarm Label":"TC03_Alarm", "End Time":"", "Delivered":"true", "Accepted":"false"}"
    When API: Wait until the flight is in cancellation suspense state for 25 seconds
    When Alert "TC03_Alarm" initiated on PM with 20 seconds timeout
    When API: Wait until the flight status is Complete by Flight Manager for 40 seconds
    When FT: User opens the generated alert details
    And FT: User opens History tab of the alert details panel
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*AlarmEndReceived.*Alarm End message received.*"
    And FT: User verifies that the alert details panel has 2 events matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightCompletionSuspenseStart.*Starting Completion Suspend.*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*PrimaryAlarmReplaced.*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightComplete.*"