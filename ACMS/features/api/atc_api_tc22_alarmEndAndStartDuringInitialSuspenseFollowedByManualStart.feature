@automated @el @critical @atc_api
@EPIC:API @FEATURE:CancellationSuspend
@clear_atc_flights @TMS:584264
Feature: api_tc22_alarmEndAndStartDuringInitialSuspenseFollowedByManualStart

  Scenario: flight with whose alarm ends and starts again in the Initial Suspense state
    Given User executes test from "[props.CONFIGS_TC22_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    When Alert "TC22_Alarm" initiated on PM with 20 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    When API: Wait until the flight is in cancellation suspense state for 25 seconds
    And Alert "TC22_Alarm" initiated on PM with 20 seconds timeout
    When API: User manually starts the flight
    When API: Wait until the flight is escalated to level 1
    And API: Wait until the flight status is Complete by Flight Manager for 150 seconds
  # TODO: get rid of wait until flight is finished workaround
   Then API: Verify the flight has event "Alarm End message received"
   Then API: Verify the flight has event "FlightCompletionSuspenseStart"
   Then API: Verify the flight has event "FlightCompletionSuspenseExit"
   And API: Verify the flight has event with attributes '{ "eventType":"FlightEscalated", "message":"EscalationLevel:1; Reason:ManualEscalation"}'
   Then API: Verify the flight has event "FlightComplete"
