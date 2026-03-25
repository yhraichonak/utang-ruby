@atc_api @automated @el @critical
@EPIC:API @FEATURE:InitialSuspend
@clear_atc_flights @TMS:584198
Feature: api_tc11_alarmEndAndStartDuringEscalation

  Scenario: flight with a non-zero initial suspend value and with an alarm duration that is less than the initial suspend value
    Given User executes test from "[props.CONFIGS_TC11_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    When Alert "TC11_Alarm" initiated on PM with 40 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    And API: Wait until the flight status is Escalated by Flight Manager for 35 seconds
    When API: Wait until the flight is in cancellation suspense state for 40 seconds
    When Alert "TC11_Alarm" initiated on PM with 40 seconds timeout
    And API: Wait until the flight isn't in cancellation suspense state for 20 seconds
    When API: Wait for 10 seconds until the flight has event with attributes
  """
 { "eventType":"PrimaryAlarmReplaced"}
  """
    And API: User manually escalates the flight from level 1
    And API: Wait until the flight status is Complete by Flight Manager for 120 seconds
    Then API: Verify the flight has event "NewFlightCreated"
    Then API: Verify the flight has event "FlightInitialSuspenseStart"
    When API: Verify the flight has event with attributes '{ "eventType":"FlightEscalated", "message":"EscalationLevel:1; Reason:InitialSuspenseTimeout"}'
    And API: Verify the difference between event "NewFlightCreated" and event "EscalationLevel:1" is 30 seconds within 1 seconds range
    Then API: Verify the flight has event "AlarmEndReceived"
    Then API: Verify the flight has event "FlightCompletionSuspenseStart"
    Then API: Verify the flight has event "FlightCompletionSuspenseExit"
    And API: Verify the flight has event with attributes '{ "eventType":"FlightEscalated", "message":"EscalationLevel:2; Reason:ManualEscalation"}'
    Then API: Verify the flight has event "FlightCompletionSuspenseEnd"
    Then API: Verify the flight has event "FlightComplete"
