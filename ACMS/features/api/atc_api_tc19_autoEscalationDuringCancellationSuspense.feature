@automated @el @critical @atc_api
@EPIC:API @FEATURE:EscalationResponse
@clear_atc_flights @TMS:584257
Feature: api_tc19_autoEscalationDuringCancellationSuspense

  Scenario: flight with an auto escalate recipient and with a non-zero cancellation suspense value
    Given User executes test from "[props.CONFIGS_TC19_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    When Alert "TC19_Alarm" initiated on PM with 20 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    When API: Wait until the flight is escalated to level 1
    And API: Wait until the flight is in cancellation suspense state for 20 seconds
    When API: Wait until the flight is escalated to level 2
    And API: Wait until the flight status is Complete by Flight Manager for 65 seconds
    And API: Verify the difference between event "NewFlightCreated" and event "FlightComplete" is 80 seconds within 3 seconds range
    And API: Verify the difference between event "FlightCompletionSuspenseStart" and event "FlightCompletionSuspenseEnd" is 60 seconds
    And API: Verify the difference between event "FlightCompletionSuspenseStart" and event "EscalationLevel:2" is 4 seconds within 1 seconds range
