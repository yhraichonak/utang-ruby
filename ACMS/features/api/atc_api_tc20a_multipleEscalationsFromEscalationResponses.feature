@automated @el @critical @atc_api
@EPIC:API @FEATURE:Escalation
@clear_atc_flights @TMS:584235
Feature: api_tc20a_multipleEscalationsFromEscalationResponses

  Scenario: flight with three destination levels and escalations for each level that come from escalate responses received from recipients
    Given User executes test from "[props.CONFIGS_TC20A_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    When Alert "TC20a_Alarm" initiated on PM with 60 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    And API: Verify the flight attribute "status" has value "InitialSuspense"
    And API: Wait until the flight status is Escalated by Flight Manager for 10 seconds
    And API: Wait until the flight is escalated to level 2
    And API: Wait until the flight is escalated to level 3
    And API: Wait until the flight status is Complete by Flight Manager for 60 seconds
    And API: Verify the difference between event "NewFlightCreated" and event "FlightCompletionSuspenseEnd" is 60 seconds within 4 seconds range
    Then API: Verify the flight has event with attributes '{ "eventType":"FlightEscalated", "message":"EscalationLevel:1; Reason:InitialSuspenseTimeout"}'
    And API: Verify the flight has event with attributes '{ "eventType":"FlightEscalated", "message": "EscalationLevel:2; Reason:EscalationResponse"}'
    Then API: Verify the flight has at least 2 events with attributes
    """
      { "eventType":"FlightEscalated", "message":"EscalationLevel:3; Reason:EscalationResponse"}
    """
