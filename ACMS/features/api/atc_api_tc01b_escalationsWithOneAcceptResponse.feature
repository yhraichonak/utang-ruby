@atc_api @automated @el @critical
@EPIC:API @FEATURE:Escalate
@clear_atc_flights @TMS:584189
Feature: api_tc01b_escalationsWithNoAcceptResponses

  Scenario: API - flight with three destination levels, a non zero delay on accept timeout, and one accept responses per level
    Given User executes test from "[props.CONFIGS_TC01B_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    When Alert "TC01b_Alarm" initiated on PM with 140 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    When API: Wait for 55 seconds until the flight has event with attributes
  """
  { "eventType":"FlightEscalated", "message":"EscalationLevel:1; Reason:InitialSuspenseTimeout"}
  """
    When API: Wait for 55 seconds until the flight has event with attributes
  """
  { "eventType":"FlightEscalated", "message":"EscalationLevel:2; Reason:EscalationTimeout"}
  """
    When API: Wait for 55 seconds until the flight has event with attributes
  """
  { "eventType":"FlightEscalated", "message":"EscalationLevel:3; Reason:EscalationTimeout"}
  """
    When API: Wait until the flight status is Complete by Flight Manager for 140 seconds
    Then API: Verify the flight has event with attributes
   """
      { "eventType":"AcceptReceived", "message":"ResponseBy:autoaccept"}
  """
    And API: Verify the difference between event "EscalationLevel:1" and event "EscalationLevel:2" is 55 seconds within 1 seconds range
    And API: Verify the difference between event "EscalationLevel:2" and event "EscalationLevel:3" is 55 seconds within 1 seconds range
    And API: Verify the difference between event "NewFlightCreated" and event "Cancellation Suspend ended" is 140 seconds within 4 seconds range
    And API: Verify flight entry stopped in 140 seconds within 4 second range
