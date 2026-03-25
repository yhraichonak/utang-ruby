@automated @el @critical @atc_api
@EPIC:API @FEATURE:CancellationSuspend
@clear_atc_flights @TMS:584262
Feature: api_tc22_alarmEndAndStartDuringInitialSuspense

  Scenario: flight with whose alarm ends and starts again in the Initial Suspense state
    Given User executes test from "[props.CONFIGS_TC22_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    When Alert "TC22_Alarm" initiated on PM with 20 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    And API: Verify the flight attribute "status" has value "InitialSuspense"
    When API: Wait until the flight is in cancellation suspense state for 30 seconds
    When Alert "TC22_Alarm" initiated on PM with 20 seconds timeout
#    And API: Wait until the flight status is Escalated by Flight Manager
#    And API: Wait until the flight status is Complete by Flight Manager for 150 seconds
#    TODO: get rid of wait until flight is finished workaround
    When API: Wait for 300 seconds until the flight has event with attributes
    """
    { "eventType":"FlightCompletionSuspenseEnd"}
    """
    Then API: Verify the flight has event "Alarm End message received"
    Then API: Verify the flight has event "FlightCompletionSuspenseStart"
    Then API: Verify the flight has event "FlightCompletionSuspenseExit"
    And API: Verify the difference between event "NewFlightCreated" and event "EscalationLevel:1" is 30 seconds within 1 seconds range
    Then API: Verify the flight has event "FlightCompletionSuspenseEnd"
#    Then API: Verify the flight has event "FlightComplete"
