@atc_api @automated @el @critical
@EPIC:API @FEATURE:Accept
@clear_atc_flights @TMS:584190 @issue
Feature: api_tc02_escalationsWithMultipleAcceptResponses

  Scenario: API - flight with three destination levels, a non zero delay on accept timeout, and multiple accept responses per level
    Given User executes test from "[props.CONFIGS_TC02_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    When Alert "TC02_Alarm" initiated on PM with 130 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    When API: Wait for 50 seconds until the flight has event with attributes
  """
  { "eventType":"FlightEscalated", "message":"EscalationLevel:1; Reason:InitialSuspenseTimeout"}
  """
  When API: Wait for 50 seconds until the flight has event with attributes
  """
  { "eventType":"FlightEscalated", "message":"EscalationLevel:2; Reason:EscalationTimeout"}
  """
  When API: Wait for 50 seconds until the flight has event with attributes
  """
  { "eventType":"FlightEscalated", "message":"EscalationLevel:3; Reason:EscalationTimeout"}
  """
  When API: Wait until the flight status is Complete by Flight Manager for 130 seconds
  Then API: Verify the flight has 6 events with attributes
   """
      { "eventType":"AcceptReceived","source":"FlightManagerService" , "message":"ResponseBy:autoaccept"}
  """
  And API: Verify the difference between event "EscalationLevel:1" and event "EscalationLevel:2" is 50 seconds
  And API: Verify the difference between event "EscalationLevel:2" and event "EscalationLevel:3" is 50 seconds
  And API: Verify the difference between event "NewFlightCreated" and event "Cancellation Suspend ended" is 130 seconds within 2 seconds range
