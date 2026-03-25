@automated @el @critical @atc_api
@EPIC:API @FEATURE:InitialSuspend
@clear_atc_flights @TMS:584324
Feature: api_tc21b_escalationsWithLateEscalateResponse

  Scenario: flight with three destination levels, a non zero delay on accept timeout, and zero accept responses per level
    Given User executes test from "[props.CONFIGS_TC21B_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    When Alert "TC21b_Alarm" initiated on PM with 140 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    When API: Wait until the flight is escalated to level 1
    And API: Verify the flight has event with attributes '{"message":"EscalationLevel:1; Reason:InitialSuspenseTimeout"}'
    When API: Check for flight "escalationLevel" to be "2" for 50 seconds
    And API: Verify the flight has event with attributes '{"message":"EscalationLevel:2; Reason:EscalationTimeout"}'
    And API: Verify the difference between event "EscalationLevel:1" and event "EscalationLevel:2" is 50 seconds
    When User manually triggers an Escalate response to be sent back to the Flight Manager for this flight
    When API: Wait for 10 seconds until the flight has event with attributes
   """
    { "eventType":"EscalateReceived", "message":"ResponseBy:manual"}
    """
    Then API: Verify the flight has event with attributes '{ "eventType":"DispatchReply", "message":"ResponseBy:manual, Choice:Escalate"}'
    And API: Verify the flight doesn't have event with attributes '{ "message":"EscalationLevel:3; Reason:ManualEscalation"}'
