@automated @el @critical @atc_api
@EPIC:API @FEATURE:CancellationSuspend
@clear_atc_flights @TMS:584234
Feature: api_tc20b_escalationDuringCancellationSuspense

  Scenario: flight with a non-zero initial suspend value and with an alarm duration that is less than the initial suspend value
    Given User executes test from "[props.CONFIGS_TC20B_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    When Alert "TC20b_Alarm" initiated on PM with 30 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    And API: Verify the flight attribute "status" has value "InitialSuspense"
    And API: Wait until the flight status is Escalated by Flight Manager for 15 seconds
    When API: Wait until the flight is in cancellation suspense state for 40 seconds
    When API: Wait until the flight is escalated to level 2
    And API: Wait until the flight isn't in cancellation suspense state for 30 seconds
    And API: Wait until the flight status is Complete by Flight Manager for 60 seconds
    And API: Verify the difference between event "NewFlightCreated" and event "EscalationLevel:1" is 15 seconds within 1 seconds range
    And API: Verify the difference between event "NewFlightCreated" and event "FlightComplete" is 60 seconds within 3 seconds range
    Then API: Verify the flight has event with attributes '{ "eventType":"AlarmEndReceived", "message":"Alarm End message received."}'
    Then API: Verify the flight has event with attributes '{ "eventType":"FlightCompletionSuspenseStart", "message":"Starting Completion Suspend"}'
    And API: Verify the flight has event with attributes '{"message":"EscalationLevel:2; Reason:EscalationTimeout"}'
