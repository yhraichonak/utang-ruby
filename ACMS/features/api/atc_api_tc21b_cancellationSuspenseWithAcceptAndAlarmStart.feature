@automated @el @critical @atc_api
@EPIC:API @FEATURE:CancellationSuspend
@clear_atc_flights @TMS:584324 @issue
Feature: api_tc21b_cancellationSuspenseWithAcceptAndAlarmStart

  Scenario: api_tc21b_cancellationSuspenseWithAcceptAndAlarmStart
    Given User executes test from "[props.CONFIGS_TC21B_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    When Alert "TC21b_Alarm" initiated on PM with 20 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
#    And API: Wait until the flight is in cancellation suspense state for 20 seconds
    And User manually triggers an Accept response to be sent back to the Flight Manager for this flight
    And API: Wait until the flight is escalated to level 1
    And Alert "TC21b_Alarm" initiated on PM with 60 seconds timeout
    And API: Check for flight "escalationLevel" to be "2" for 70 seconds
    And API: Wait until the flight status is Complete by Flight Manager for 300 seconds
    Then API: Verify the flight has event with attributes '{ "eventType":"FlightEscalated", "message":"EscalationLevel:1; Reason:InitialSuspenseTimeout"}'
    And API: Verify the flight has event with attributes '{ "eventType":"FlightCompletionSuspenseStart", "message":"Starting Completion Suspend."}'
    And API: Verify the flight has event with attributes '{ "eventType":"AcceptReceived", "message":"ResponseBy:manual"}'
    And API: Verify the flight has event with attributes '{ "eventType":"PrimaryAlarmReplaced"}'

