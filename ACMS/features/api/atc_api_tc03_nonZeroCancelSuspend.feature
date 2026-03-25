@atc_api @automated @el @critical
@EPIC:API @FEATURE:CancelSuspend
@clear_atc_flights @TMS:584191
Feature: api_tc03_nonZeroCancelSuspend

  Scenario: API - flight with destination level and a non zero cancel suspend timeout
    Given User executes test from "[props.CONFIGS_TC03_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    When Alert "TC03_Alarm" initiated on PM with 25 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    When API: Wait until the flight status is Complete by Flight Manager for 35 seconds
    Then API: Verify the flight has event with attributes '{ "eventType":"FlightEscalated", "message":"EscalationLevel:1; Reason:InitialSuspenseTimeout"}'
    Then API: Verify the flight has event with attributes '{ "eventType":"AlarmEndReceived", "message":"Alarm End message received."}'
    Then API: Verify the flight has event with attributes '{ "eventType":"FlightCompletionSuspenseStart", "message":"Starting Completion Suspend"}'
    Then API: Verify the flight has event with attributes '{ "eventType":"FlightCompletionSuspenseEnd", "message":"Event: Cancellation Suspend period ended"}'
    Then API: Verify the flight has event with attributes '{ "eventType":"FlightComplete", "message":"Reason:Cancellation Suspend ended"}'
    And API: Verify the difference between event "Alarm End message received" and event "FlightComplete.*Reason.Cancellation Suspend ended" is 5 seconds
    And API: Verify flight entry stopped in 30 seconds within 2 second range

