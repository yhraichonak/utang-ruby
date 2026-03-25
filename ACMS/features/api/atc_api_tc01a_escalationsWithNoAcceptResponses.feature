@atc_api @automated @el @critical
@EPIC:API @FEATURE:Escalate
@clear_atc_flights @TMS:584188
Feature: api_tc01a_escalationsWithNoAcceptResponses

  Scenario: API - flight with three destination levels, a non zero delay on accept timeout, and zero accept responses per level
    Given User executes test from "[props.CONFIGS_TC01A_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    When Alert "TC01a_Alarm" initiated on PM with 100 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    When API: Wait for 45 seconds until the flight has event with attributes
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
   When API: Wait until the flight status is Complete by Flight Manager for 100 seconds
   Then API: Verify the flight has event with attributes
   """
      { "eventType":"FlightComplete", "message":"Reason:Cancellation Suspend ended"}
  """
    And API: Verify the difference between event "EscalationLevel:1" and event "EscalationLevel:2" is 45 seconds within 1 seconds range
    And API: Verify the difference between event "EscalationLevel:2" and event "EscalationLevel:3" is 45 seconds within 1 seconds range
    And API: Verify the difference between event "NewFlightCreated" and event "Cancellation Suspend ended" is 100 seconds within 4 seconds range
    And API: Verify flight entry stopped in 100 seconds within 4 second range

