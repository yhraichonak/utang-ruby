@atc_api @automated @el @critical
@EPIC:API @FEATURE:ManualEscalation
@clear_atc_flights @TMS:584246
Feature: api_tc15_manualEscalations

  Scenario: API - flight with manual escalations from level 1 to level 2
    Given User executes test from "[props.CONFIGS_TC15_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    When Alert "TC15_Alarm" initiated on PM with 30 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    And API: Wait until the flight is escalated to level 0
    When API: User manually starts the flight
    And API: Wait until the flight is escalated to level 1
    And API: User manually escalates the flight from level 1
    And API: Wait until the flight status is Complete by Flight Manager for 30 seconds
    Then API: Verify the flight has event with attributes '{ "eventType":"FlightEscalated", "message":"EscalationLevel:1; Reason:ManualEscalation"}'
    And API: Verify the flight has event with attributes '{ "eventType":"FlightEscalated", "message":"EscalationLevel:2; Reason:ManualEscalation"}'
    And API: Verify flight entry stopped in 30 seconds within 3 second range
