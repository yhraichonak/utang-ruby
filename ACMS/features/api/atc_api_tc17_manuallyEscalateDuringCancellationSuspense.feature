@automated @el @critical @atc_api
@EPIC:API @FEATURE:EscalationResponse
@clear_atc_flights  @TMS:584255
Feature: api_tc17_manuallyEscalateDuringCancellationSuspense

  Scenario: flight with a manual escalation of alarm and with a non-zero cancellation suspense value
    Given User executes test from "[props.CONFIGS_TC17_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    When Alert "TC17_Alarm" initiated on PM with 30 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    And API: Verify the flight attribute "status" has value "InitialSuspense"
    When API: Wait until the flight is escalated to level 1
    And API: Wait until the flight is in cancellation suspense state for 30 seconds
    And API: User manually escalates the flight from level 1
    And API: Wait until the flight status is Complete by Flight Manager for 30 seconds
    And API: Verify the flight has event with attributes '{ "eventType":"FlightEscalated", "message":"EscalationLevel:2; Reason:ManualEscalation"}'
    And API: Verify the difference between event "NewFlightCreated" and event "FlightCompletionSuspenseEnd" is 60 seconds within 3 seconds range

