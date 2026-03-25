@automated @el @critical @atc_api
@EPIC:API @FEATURE:CancellationSuspend
@clear_atc_flights @TMS:584328
Feature: api_tc21a_cancellationSuspenseWithAcceptAndAlarmStart

  Scenario: flight that receives an accept response during a cancellation suspense and then exit cancellation suspense due to an alarm start
    Given User executes test from "[props.CONFIGS_TC21A_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    When Alert "TC21a_Alarm" initiated on PM with 20 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    When API: Wait until the flight is in cancellation suspense state for 25 seconds
    When User manually triggers an Accept response to be sent back to the Flight Manager for this flight
    When Alert "TC21a_Alarm" initiated on PM with 60 seconds timeout
#    And API: Wait until the flight status is Complete by Flight Manager for 300 seconds
#     TODO: get rid of wait until flight is finished workaround
    When API: Wait for 300 seconds until the flight has event with attributes
    """
    { "eventType":"FlightCompletionSuspenseEnd"}
    """
    Then API: Verify the flight has event with attributes '{ "eventType":"FlightEscalated", "message":"EscalationLevel:1; Reason:InitialSuspenseTimeout"}'
    And API: Verify the flight has event with attributes '{ "eventType":"FlightCompletionSuspenseStart", "message":"Starting Completion Suspend."}'
    And API: Verify the flight has event with attributes '{ "eventType":"AcceptReceived", "message":"ResponseBy:manual"}'
    Then API: Verify the flight has 2 events with attributes
   """
    { "eventType":"AlarmEndReceived"}
   """
    And API: Verify the flight has event with attributes '{ "eventType":"AlarmStartReceived"}'
    Then API: Verify the flight has event with attributes '{ "eventType":"FlightEscalated", "message":"EscalationLevel:2; Reason:EscalationTimeout"}'
    And API: Verify the difference between event "EscalationLevel:1" and event "EscalationLevel:2" is 70 seconds
