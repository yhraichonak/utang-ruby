@atc_api @automated @el @critical
@EPIC:API @FEATURE:CancelSuspend
@clear_atc_flights @TMS:584230 @skip
Feature: api_tc16_nonZeroInitialSuspendWithAlarmEnd_CancelSuspendTimeoutAfterFlightEscalation

  Scenario: flight with a non-zero initial suspend value and with an alarm duration that is less than the initial suspend value
    Given User executes test from "[props.CONFIGS_TC12_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    When Alert "TC12_Alarm" initiated on PM with 20 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    When API: Wait until the flight is in cancellation suspense state for 25 seconds
    And API: Wait until the flight status is Escalated by Flight Manager for 30 seconds
    And API: Wait until the flight isn't in cancellation suspense state for 20 seconds
    And API: Wait until the flight status is Complete by Flight Manager for 40 seconds
    Then API: Verify the flight has event "NewFlightCreated"
    Then API: Verify the flight has event "Initial Suspense started"
    Then API: Verify the flight has event "Alarm End message received"
    Then API: Verify the flight has event "Starting Completion Suspend."
    And API: Verify the difference between event "NewFlightCreated" and event "EscalationLevel:1" is 30 seconds
    Then API: Verify the flight has event "FlightCompletionSuspenseEnd"
    Then API: Verify the flight has event "FlightComplete"
    And API: Verify the difference between event "FlightCompletionSuspenseStart" and event "FlightComplete" is 20 seconds
