@atc @automated @el @critical @atc_at @flight_path
@EPIC:FlightTracker @FEATURE:InitialSuspend
@clear_atc_flights @TMS:584325
Feature: at_tc21b_escalationsWithLateEscalateResponse
  As an utang Alarm Management user
  I want to generate a flight that receives an escalate response from a previous escalation level
  So that I can verify that the flight does NOT react to this response for the current escalation level

  XXXX-1441
  When a late escalation response is received by the flight from a previous escalation level , it should be ignored.

  TESTING NOTES:
  - See https://utang.atlassian.net/wiki/spaces/ACMS/pages/3304816692/Setting+up+a+Flight+Plan+and+Generating+an+Alarm+Manually for location of
  flight plan configuration and instructions on how to execute configuration setup/alarm generation
  See https://utang.atlassian.net/wiki/spaces/ACMS/pages/3387162914/Triggering+Responses+For+Manual+Dispatches for location of instructions on triggering manual
  dispatch replies

  TestRail Id: C584325

  Jira Stories: XXXX-1441

  Jira Bugs/Defects:

  Background:
    Given User executes test from "[props.CONFIGS_TC21B_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    And FT: User is logged in with default filter applied

  Scenario: flight with three destination levels, a non zero delay on accept timeout, and zero accept responses per level
    When Alert "TC21b_Alarm" initiated on PM with 140 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    And FT: User waits unit the generated alert is present in alerts table with attributes "{ "Alarm Label":"TC21b_Alarm", "End Time":"", "Delivered":"true", "Accepted":"false"}"
    And FT: The "Total Time" field should be populated with an incrementing time elapsed label
    When API: Check for flight "escalationLevel" to be "2" for 50 seconds
    When User manually triggers an Escalate response to be sent back to the Flight Manager for this flight
    When FT: User opens the generated alert details
    And AC: User opens History tab of the alert details panel
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightEscalated *Flight Escalated. To Level:1, Reason: InitialSuspenseTimeout.*"
    And Time difference between ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated. To Level:1, Reason: InitialSuspenseTimeout.*" and ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated. To Level:2. *Reason: EscalationTimeout.*" is 50 seconds
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*DispatchReply. *ResponseBy:manual, Choice:Escalate*"
    Then AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*EscalateReceived.*Escalate Received. From:manual.*"
    And AC: User verifies that the alert details panel doesn't have event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated. To Level:3. *Reason: EscalationResponse*"
