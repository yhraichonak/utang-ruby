@automated @el @critical @atc_api
@EPIC:API @FEATURE:InitialSuspend
@clear_atc_flights @TMS:584241
Feature: api_tc21b_escalationsWithLateAcceptResponse

  Scenario: flight with three destination levels, a non zero delay on accept timeout, and zero accept responses per level
    Given User executes test from "[props.CONFIGS_TC21B_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    When Alert "TC21b_Alarm" initiated on PM with 240 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    When API: Wait for 10 seconds until the flight has event with attributes
    """
    { "eventType":"FlightEscalated", "message":"EscalationLevel:1; Reason:InitialSuspenseTimeout"}
    """
    When API: Check for flight "escalationLevel" to be "2" for 50 seconds
    And API: Verify the flight has event with attributes '{ "eventType":"FlightEscalated", "message":"EscalationLevel:2; Reason:EscalationTimeout"}'
    When User manually triggers an Accept response to be sent back to the Flight Manager for this flight
    When API: Check for flight "escalationLevel" to be "3" for 110 seconds
    And API: Verify the flight has event with attributes '{ "eventType":"FlightEscalated", "message":"EscalationLevel:3; Reason:EscalationTimeout"}'
    And API: Verify the flight has event with attributes '{ "eventType":"ExtendEscalation"}'
    And API: Verify the difference between event "EscalationLevel:1" and event "EscalationLevel:2" is 50 seconds within 3 seconds range
