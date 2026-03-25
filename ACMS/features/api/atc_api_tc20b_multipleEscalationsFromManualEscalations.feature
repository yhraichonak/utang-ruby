@automated @el @critical @atc_api
@EPIC:API @FEATURE:CancellationSuspend
@clear_atc_flights @TMS:584236
Feature: api_tc20b_multipleEscalationsFromManualEscalations

  Scenario: flight with three destination levels, a non zero delay on accept timeout, and zero accept responses per level
   Given User executes test from "[props.CONFIGS_TC20B_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
   When Alert "TC20b_Alarm" initiated on PM with 60 seconds timeout
   And API: Wait until the alert is processed by Flight Manager
   And API: Wait until the flight status is Escalated by Flight Manager for 15 seconds
   And API: User manually escalates the flight from level 1
   And API: Wait until the flight is escalated to level 2
   And API: Verify the flight has event with attributes '{ "eventType":"FlightEscalated", "message":"EscalationLevel:2; Reason:ManualEscalation"}'
   And API: User manually escalates the flight from level 2
   And API: Wait until the flight is escalated to level 3
   And API: Verify the flight has event with attributes '{ "eventType":"FlightEscalated", "message":"EscalationLevel:3; Reason:ManualEscalation"}'
   And API: User manually escalates the flight from level 3
   And API: Verify the flight has event with attributes '{ "eventType":"FlightEscalated", "message":"EscalationLevel:3; Reason:ManualEscalation"}'
   And API: Wait until the flight status is Complete by Flight Manager for 90 seconds
   And API: Verify the difference between event "NewFlightCreated" and event "FlightComplete" is 90 seconds within 3 seconds range
   Then API: Verify the flight has event with attributes '{ "eventType":"FlightEscalated", "message":"EscalationLevel:1; Reason:InitialSuspenseTimeout"}'
   Then API: Verify the flight has 3 events with attributes
    """
      { "eventType":"ManualEscalateReceived"}
    """
