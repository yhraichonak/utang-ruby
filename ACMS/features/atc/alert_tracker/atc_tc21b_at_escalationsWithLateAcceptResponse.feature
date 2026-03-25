@atc @automated @el @critical @atc_at @flight_path
@EPIC:FlightTracker @FEATURE:InitialSuspend
@clear_atc_flights @TMS:584242
Feature: at_tc21b_escalationsWithLateAcceptResponse
  As an utang Alarm Management user
  I want to generate a flight that receives an accept response from a previous escalation level
  So that I can verify that the flight still processes the accept response for the current escalation level

  XXXX-1440
  When a late escalation response is received by the flight from a previous escalation level , it should be ignored.

  TESTING NOTES:
  - See https://utang.atlassian.net/wiki/spaces/ACMS/pages/3304816692/Setting+up+a+Flight+Plan+and+Generating+an+Alarm+Manually for location of
  flight plan configuration and instructions on how to execute configuration setup/alarm generation
  See https://utang.atlassian.net/wiki/spaces/ACMS/pages/3387162914/Triggering+Responses+For+Manual+Dispatches for location of instructions on triggering manual
  dispatch replies

  TestRail Id: C584242

  Jira Stories: XXXX-1440

  Jira Bugs/Defects: XXXX-1361

  Background:
    Given User executes test from "[props.CONFIGS_TC21B_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    And FT: User is logged in with default filter applied

  Scenario:  flight with three destination levels, a non zero delay on accept timeout, and zero accept responses per level
    When Alert "TC21b_Alarm" initiated on PM with 240 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    And FT: User waits unit the generated alert is present in alerts table with attributes "{ "Alarm Label":"TC21b_Alarm", "End Time":"", "Delivered":"true", "Accepted":"false"}"
    And FT: The "Total Time" field should be populated with an incrementing time elapsed label
    When API: Check for flight "escalationLevel" to be "2" for 50 seconds
    When User manually triggers an Accept response to be sent back to the Flight Manager for this flight
    When API: Check for flight "escalationLevel" to be "3" for 110 seconds
    When FT: User opens the generated alert details
    And FT: User opens History tab of the alert details panel
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightEscalated *Flight Escalated. To Level:1, Reason: InitialSuspenseTimeout.*"
    And Time difference between ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated. To Level:1, Reason: InitialSuspenseTimeout.*" and ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated. To Level:2. *Reason: EscalationTimeout.*" is 50 seconds
    Then FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*AcceptReceived.*Accept Received. From:manual.*"
    Then FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*ExtendEscalation.*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated. To Level:3. *Reason: EscalationTimeout.*"
