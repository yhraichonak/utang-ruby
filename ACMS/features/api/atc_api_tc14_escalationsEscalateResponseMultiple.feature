@atc_api @automated @el @critical
@EPIC:API @FEATURE:EscalationResponse
@clear_atc_flights @TMS:584245
Feature: api_tc14_escalationsEscalateResponseMultiple

  Scenario: flight with multiple recipients set to autoaccept notification, only first escalation accept is represented
    Given User executes test from "[props.CONFIGS_TC14_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    When Alert "TC14_Alarm" initiated on PM with 30 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    And API: Wait until the flight is escalated to level 0
    When API: User manually starts the flight
    And API: Wait until the flight is escalated to level 1
    And API: Wait until the flight is escalated to level 2
    And API: Wait until the flight status is Complete by Flight Manager for 30 seconds
    Then API: Verify the flight has event with attributes '{ "eventType":"NewFlightCreated"}'
    And API: Verify the flight has event with attributes '{ "eventType":"FlightInitialSuspenseStart"}'
    And API: Verify the flight has event with attributes '{ "eventType":"EscalateReceived"}'
    And API: Verify the flight has event with attributes '{ "eventType":"FlightEscalated", "message": "EscalationLevel:2; Reason:EscalationResponse"}'
    And API: Verify the flight doesn't have event with attributes '{ "eventType":"FlightEscalated", "message": "EscalationLevel:3; Reason:EscalationResponse"}'
    And API: Verify the flight has event with attributes '{ "eventType":"FlightComplete"}'
