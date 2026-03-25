@atc @automated @el @critical @atc_at @flight_path
@EPIC:FlightTracker @FEATURE:AutoCancel
@clear_atc_flights @TMS:584208
Feature: alertTracker_tc05_nonZeroAutoCancel
  As an Air Traffic Controller user
  I want to generate a flight with one destination level and a non zero auto cancel timeout
  So that I can verify that an inflight alarm is cancelled after the auto cancel duration passes

  XXXX-###

  Test Notes: See https://utang.atlassian.net/wiki/spaces/ACMS/pages/3304816692/Setting+up+a+Flight+Plan+and+Generating+an+Alarm+Manually for location of
  flight plan configuration and instructions on how to execute configuration setup/alarm generation

  TestRail Id: C584208

  Jira Stories:

  Jira Bugs/Defects:

  Background:
    Given User executes test from "[props.CONFIGS_TC05_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    And FT: User is logged in with default filter applied

  Scenario: flight with one destination level and a non zero auto cancel timeout
    When Alert "TC05_Alarm" initiated on PM with 60 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    And FT: User waits unit the generated alert is present in alerts table with attributes "{ "Alarm Label":"TC05_Alarm", "End Time":"", "Delivered":"true", "Accepted":"false"}"
    When API: Wait until the flight status is Complete by Flight Manager for 20 seconds
    And FT: User sees the "Total Time" on the flight entry stop at "0:20" within 3 second range
    When FT: User opens the generated alert details
    And FT: User opens History tab of the alert details panel
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*NewFlightCreated*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated. To Level:1, Reason: InitialSuspenseTimeout.*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightComplete.*Reason:AutoCancelTime expired.*"
    And Time difference between ".*[props.ACMS_TIMESTAMP_REGEXP].*NewFlightCreated*" and ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightComplete.*Reason:AutoCancelTime expired.*" is 20 seconds
