@atc @automated @el @critical @atc_at @flight_path
@EPIC:FlightTracker @FEATURE:Accept
@clear_atc_flights
@TMS:584204
Feature: alertTracker_tc01b_escalationsWithOneAcceptResponse
  As an Air Traffic Controller user
  I want to generate a flight with three destination levels, a non zero delay on accept value, and one accept response per level
  So that I can verify that the accept response appropriately adds a delay to the escalation timeout for each escalation

  XXXX-###

  Test Notes: See https://utang.atlassian.net/wiki/spaces/ACMS/pages/3304816692/Setting+up+a+Flight+Plan+and+Generating+an+Alarm+Manually for location of
  flight plan configuration and instructions on how to execute configuration setup/alarm generation

  TestRail Id: C584204

  Jira Stories:

  Jira Bugs/Defects:

  Preconditions
  Background:
    Given User executes test from "[props.CONFIGS_TC01B_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    And FT: User is logged in with default filter applied

  Scenario: flight with three destination levels, a non zero delay on accept timeout, and one accept responses per level
    When Alert "TC01b_Alarm" initiated on PM with 130 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    And FT: User waits unit the generated alert is present in alerts table with attributes "{ "Alarm Label":"TC01b_Alarm", "End Time":"", "Delivered":"true"}"
    And FT: The "Total Time" field should be populated with an incrementing time elapsed label
    And FT: User waits unit the generated alert is present in alerts table with attributes "{"Accepted":"true"}"
    When API: Wait until the flight status is Complete by Flight Manager for 135 seconds
    And FT: User sees the "Total Time" on the flight entry stop at "2:10" within 3 second range
    When FT: User opens the generated alert details
    And FT: User opens History tab of the alert details panel
    Then FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated. To Level:1, Reason: InitialSuspenseTimeout.*"
    Then FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated. To Level:2, Reason: EscalationTimeout.*"
    And Time difference between ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated. To Level:1, Reason: InitialSuspenseTimeout.*" and ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated. To Level:2, Reason: EscalationTimeout.*" is 55 seconds
    Then FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated. To Level:3, Reason: EscalationTimeout.*"
    And Time difference between ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated. To Level:2, Reason: EscalationTimeout.*" and ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated. To Level:3, Reason: EscalationTimeout.*" is 55 seconds
    Then FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightComplete.*Reason.Cancellation Suspend ended.*"
    And Time difference between ".*[props.ACMS_TIMESTAMP_REGEXP].*NewFlightCreated*" and ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightComplete.*Reason.Cancellation Suspend ended.*" is 130 seconds
