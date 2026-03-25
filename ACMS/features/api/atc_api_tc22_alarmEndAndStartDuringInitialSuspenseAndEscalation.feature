@automated @el @critical @atc_api
@EPIC:API @FEATURE:CancellationSuspend
@clear_atc_flights @TMS:584263
Feature: api_tc22_alarmEndAndStartDuringInitialSuspenseAndEscalation

  Scenario: flight whose alarm ends in the Initial Suspense state and starts again while in Escalated state
    Given User executes test from "[props.CONFIGS_TC22_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    When Alert "TC22_Alarm" initiated on PM with 20 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    When API: Wait until the flight is in cancellation suspense state for 30 seconds
     When API: Wait for 20 seconds until the flight has event with attributes
  """
  { "eventType":"AlarmEndReceived"}
  """
    When Alert "TC22_Alarm" initiated on PM with 20 seconds timeout
     When API: Wait for 30 seconds until the flight the flight has 2 events with attributes
    """
      { "eventType":"AlarmEndReceived"}
    """
    And API: Wait until the flight status is Complete by Flight Manager for 300 seconds
    Then API: Verify the flight has event "Alarm End message received"
    Then API: Verify the flight has event "FlightCompletionSuspenseStart"
    And API: Verify the flight has event with attributes '{"message":"EscalationLevel:1; Reason:InitialSuspenseTimeout"}'
    And API: Verify the difference between event "NewFlightCreated" and event "EscalationLevel:1" is 30 seconds within 1 seconds range
    Then API: Verify the flight has event "FlightCompletionSuspenseExit"
    Then API: Verify the flight has event "FlightComplete"
