@atc @automated @el @critical @atc_at @flight_path
@EPIC:FlightTracker @FEATURE:InitialSuspend
@clear_atc_flights @TMS:584265
Feature: alertTracker_tc11_alarmEndAndStartDuringEscalation
  As an Air Traffic Controller user
  I want to generate a flight with a non-zero initial suspend value and with an alarm duration that is less than the initial suspend value
  So that I can verify an alarm that ends while in the initial suspend state will go into the completion suspense state and then complete state right away

  XXXX-###

  Test Notes: See https://utang.atlassian.net/wiki/spaces/ACMS/pages/3304816692/Setting+up+a+Flight+Plan+and+Generating+an+Alarm+Manually for location of
  flight plan configuration and instructions on how to execute configuration setup/alarm generation

  TestRail Id: C584265

  Jira Stories:

  Jira Bugs/Defects:

  Background:
    Given User executes test from "[props.ACMS_DEFAULT_CONFIG]" file in ATC Integration Test Console
    And FT: User is logged in with default filter applied
  @prioritized
  Scenario: flight with a non-zero initial suspend value and with an alarm duration that is less than the initial suspend value
    When Alert "TC11_Alarm" initiated on PM with 40 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    And FT: User waits unit the generated alert is present in alerts table with attributes "{ "Alarm Label":"TC11_Alarm", "End Time":"", "Delivered":"false", "Accepted":"false"}"
    When API: Wait until the flight status is Escalated by Flight Manager for 35 seconds
    And FT: User waits unit the generated alert is present in alerts table with attributes "{ "Alarm Label":"TC11_Alarm", "End Time":"", "Delivered":"true", "Accepted":"false"}"
    When API: Force stop alert generation script
    When API: Wait until the flight is in cancellation suspense state for 30 seconds
    And wait for 1 seconds
    When Alert "TC11_Alarm" initiated on PM with 40 seconds timeout
    And API: Wait until the flight status is Complete by Flight Manager for 120 seconds
    When FT: User opens the generated alert details
    And FT: User opens History tab of the alert details panel
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*NewFlightCreated*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightInitialSuspenseStart *Initial Suspense started.*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated. To Level:1. *Reason: InitialSuspenseTimeout.*"
    And Time difference between ".*[props.ACMS_TIMESTAMP_REGEXP].*NewFlightCreated*" and ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated. To Level:1, Reason: InitialSuspenseTimeout.*" is 30 seconds
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*AlarmEndReceived *Alarm End message received.*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightCompletionSuspenseStart. *Starting Completion Suspend.*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightCompletionSuspenseExit.*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated. To Level:2. *Reason: EscalationTimeout.*"
    And Time difference between ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated. To Level:1, Reason: InitialSuspenseTimeout.*" and ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated. To Level:2, Reason: EscalationTimeout.*" is 60 seconds
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightCompletionSuspenseEnd.*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightComplete.*"