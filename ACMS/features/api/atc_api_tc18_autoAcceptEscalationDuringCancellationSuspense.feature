@automated @el @critical @atc_api
@EPIC:AirCommand @FEATURE:EscalationResponse
@clear_atc_flights @TMS:584256
Feature: api_tc18_autoAcceptEscalationDuringCancellationSuspense

  Scenario: flight with an auto accept recipient and with a non-zero cancellation suspense value
    Given User executes test from "[props.CONFIGS_TC18_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    When Alert "TC18_Alarm" initiated on PM with 30 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    And API: Verify the flight attribute "status" has value "InitialSuspense"
    When API: Wait until the flight is escalated to level 1
    And API: Wait until the flight is in cancellation suspense state for 30 seconds
    And API: Verify the flight has event with attributes '{ "eventType":"ExtendEscalation"}'
    And API: Wait until the flight status is Complete by Flight Manager for 45 seconds
    And API: Verify the difference between event "FlightInitialSuspenseStart" and event "FlightInitialSuspenseEnd" is 15 seconds
    And API: Verify the difference between event "FlightCompletionSuspenseStart" and event "FlightCompletionSuspenseEnd" is 40 seconds
    And API: Verify the flight has event with attributes '{"message":"EscalationLevel:1; Reason:InitialSuspenseTimeout"}'
    And API: Verify the flight has event with attributes '{"message":"EscalationLevel:2; Reason:EscalationTimeout"}'
    And API: Verify the difference between event "NewFlightCreated" and event "FlightCompletionSuspenseEnd" is 70 seconds within 3 seconds range
