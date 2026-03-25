@atc @automated @el @critical @atc_ad @flight_path
@EPIC:AirCommand @FEATURE:AutoCancel
@clear_atc_flights @TMS:584194
Feature: airDispatch_tc06_nonZeroAutoCancelWithDelayOnAccept
  As an Air Traffic Controller user
  I want to generate a flight with one destination level, a non zero auto cancel timeout, and a non zero delay on accept timeout
  So that I can verify that an accept response for an inflight alarm does not affect the timing of the flight being cancelled because of the set auto cancel timeout

  XXXX-###

  Test Notes: See https://utang.atlassian.net/wiki/spaces/ACMS/pages/3304816692/Setting+up+a+Flight+Plan+and+Generating+an+Alarm+Manually for location of
  flight plan configuration and instructions on how to execute configuration setup/alarm generation

  TestRail Id: C584194

  Jira Stories:

  Jira Bugs/Defects:

  Background:
    Given User executes test from "[props.CONFIGS_TC06_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    And AC: User is logged in with default filter applied

  Scenario: flight with one destination level, a non zero auto cancel timeout, and a non zero delay on accept timeout
    When Alert "TC06_Alarm" initiated on PM with 60 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    And API: Wait until the flight status is Escalated by Flight Manager
    And AC: User verifies the generated alert is present in Alerts panel with attributes
      """
      { "assigned-to":"destination:[props.DESTINATIONS_DESTINATION1_SINGLEREC]", "escalates-to": "destination:none"}
      """
    And AC: Flight alert status section is green and has filled-circle icon with label Accepted
    When API: Wait until the flight status is Complete by Flight Manager for 30 seconds
    Then AC: User should see the generated alert present in Alerts panel in Completed subsection
    And AC: Flight alert status section is grey and has no-icon icon with label Completed
    And AC: User sees the elapsed flight time on the flight entry stop at "0:20" within 3 second range
    When AC: User opens the generated alert details in Alerts panel
    And AC: User opens History tab of the alert details panel
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*NewFlightCreated*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated. To Level:1, Reason: InitialSuspenseTimeout.*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightComplete.*Reason:AutoCancelTime expired.*"
    And Time difference between ".*[props.ACMS_TIMESTAMP_REGEXP].*NewFlightCreated*" and ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightComplete.*Reason:AutoCancelTime expired.*" is 20 seconds
