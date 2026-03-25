@atc @automated @el @critical @atc_at @flight_path
@EPIC:FlightTracker @FEATURE:AutoCancel
@clear_atc_flights @TMS:584211
Feature: alertTracker_tc08_nonZeroAutoCancelWithInitialSuspend
  As an Air Traffic Controller user
  I want to generate a flight with one destination level, a non zero auto cancel timeout, and a non-zero initial suspend timeout that is larger than the auto cancel timeout
  So that I can verify that the flight will still be cancelled when the auto cancel timeout passes even though the flight is in the initial suspend state

  XXXX-###

  Test Notes: See https://utang.atlassian.net/wiki/spaces/ACMS/pages/3304816692/Setting+up+a+Flight+Plan+and+Generating+an+Alarm+Manually for location of
  flight plan configuration and instructions on how to execute configuration setup/alarm generation

  TestRail Id: C584211

  Jira Stories:

  Jira Bugs/Defects:

  Background:
    Given User executes test from "[props.CONFIGS_TC08_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    And FT: User is logged in with default filter applied

  Scenario: flight with one destination level, a non zero auto cancel timeout, and a non-zero initial suspend timeout that is larger than the auto cancel timeout
    When Alert "TC08_Alarm" initiated on PM with 60 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    And FT: User waits unit the generated alert is present in alerts table with attributes "{ "Alarm Label":"TC08_Alarm", "End Time":"", "Delivered":"false", "Accepted":"false"}"
    When API: Wait until the flight status is Complete by Flight Manager for 10 seconds
    And FT: User sees the "Total Time" on the flight entry stop at "0:10" within 3 second range
    When FT: User opens the generated alert details
    And FT: User opens History tab of the alert details panel
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*NewFlightCreated*"
    And FT: User waits until alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightInitialSuspenseStart. Initial Suspense started.*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*AutoCancelTimeout.*"
    And Time difference between ".*[props.ACMS_TIMESTAMP_REGEXP].*NewFlightCreated*" and ".*[props.ACMS_TIMESTAMP_REGEXP].*AutoCancelTimeout.*" is 10 seconds
    And FT: User waits until alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightComplete. Reason: AutoCancelTime expired.*"
    And Time difference between ".*[props.ACMS_TIMESTAMP_REGEXP].*NewFlightCreated*" and ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightComplete.*Reason:AutoCancelTime expired.*" is 10 seconds


