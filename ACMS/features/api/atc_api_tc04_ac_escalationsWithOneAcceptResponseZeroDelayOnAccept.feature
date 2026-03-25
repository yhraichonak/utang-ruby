@atc_api @automated @el @critical
@EPIC:API @FEATURE:Accept
@clear_atc_flights @TMS:584192
Feature: api_tc04_escalationsWithOneAcceptResponseZeroDelayOnAccept

Scenario: API - flight with three destination levels, a zero delay on accept timeout, and one accept response per level
  Given User executes test from "[props.CONFIGS_TC04_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
  When Alert "TC04_Alarm" initiated on PM with 40 seconds timeout
  And API: Wait until the alert is processed by Flight Manager
  And API: Wait until the flight status is Escalated by Flight Manager
  When API: Wait for 10 seconds until the flight has event with attributes
  """
    { "eventType":"FlightEscalated", "message":"EscalationLevel:1; Reason:InitialSuspenseTimeout"}
    """
  When API: Wait for 11 seconds until the flight has event with attributes
  """
    { "eventType":"FlightEscalated", "message":"EscalationLevel:2; Reason:EscalationTimeout"}
    """
  When API: Wait for 21 seconds until the flight has event with attributes
  """
    { "eventType":"FlightEscalated", "message":"EscalationLevel:3; Reason:EscalationTimeout"}
    """
  When API: Wait until the flight status is Complete by Flight Manager for 130 seconds

  Then API: Verify the flight has 3 events with attributes
  """
            { "eventType":"AcceptReceived","source":"FlightManagerService" , "message":"ResponseBy:autoaccept"}
   """
  And API: Verify the difference between event "EscalationLevel:1" and event "EscalationLevel:2" is 10 seconds within 1 seconds range
  And API: Verify the difference between event "EscalationLevel:2" and event "EscalationLevel:3" is 20 seconds within 1 seconds range
  And API: Verify the difference between event "NewFlightCreated" and event "Cancellation Suspend ended" is 40 seconds within 2 seconds range
  And API: Verify flight entry stopped in 40 seconds within 2 second range
