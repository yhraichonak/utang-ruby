@atc_api @automated @el @critical
@EPIC:API @FEATURE:AutoCancel
@clear_atc_flights @TMS:584194
Feature: atc_api_tc06_nonZeroAutoCancelWithDelayOnAccept
Scenario: API - flight with one destination level, a non zero auto cancel timeout, and a non zero delay on accept timeout
  Given User executes test from "[props.CONFIGS_TC06_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
  When Alert "TC06_Alarm" initiated on PM with 60 seconds timeout
  And API: Wait until the alert is processed by Flight Manager
  And API: Wait until the flight status is Escalated by Flight Manager
  When API: Wait for 10 seconds until the flight has event with attributes
  """
    { "eventType":"FlightEscalated", "message":"EscalationLevel:1; Reason:InitialSuspenseTimeout"}
    """
  When API: Wait until the flight status is Complete by Flight Manager for 30 seconds
  Then API: Verify the flight has event with attributes
  """
    { "eventType":"AcceptReceived","source":"FlightManagerService" , "message":"ResponseBy:autoaccept"}
   """
  And API: Verify the flight has event with attributes
  """
    { "eventType":"AutoCancelTimeout", "message":"Timeout for Flight auto cancellation expired. Completing Flight."}
   """
  And API: Verify the difference between event "NewFlightCreated" and event "AutoCancelTimeout" is 20 seconds within 2 seconds range
  And API: Verify the difference between event "NewFlightCreated" and event "FlightComplete" is 20 seconds within 2 seconds range
  And API: Verify flight entry stopped in 20 seconds within 2 second range