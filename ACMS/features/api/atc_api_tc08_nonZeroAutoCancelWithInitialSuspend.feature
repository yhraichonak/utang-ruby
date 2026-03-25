@atc_api @automated @el @critical
@EPIC:API @FEATURE:AutoCancel
@clear_atc_flights @TMS:584196
Feature: atc_api_tc08_nonZeroAutoCancelWithInitialSuspend
Scenario: API - flight with one destination level, a non zero auto cancel timeout, and a non-zero initial suspend timeout that is larger than the auto cancel timeout
  Given User executes test from "[props.CONFIGS_TC08_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
  When Alert "TC08_Alarm" initiated on PM with 60 seconds timeout
  And API: Wait until the alert is processed by Flight Manager
  When API: Wait until the flight status is Complete by Flight Manager for 20 seconds
  Then API: Verify the flight has event with attributes
"""
{ "eventType":"AutoCancelTimeout", "message":"Timeout for Flight auto cancellation expired. Completing Flight."}
"""
  And API: Verify the flight has event "FlightInitialSuspenseStart"
  And API: Verify the flight doesn't have event "FlightInitialSuspenseEnd"
  And API: Verify the difference between event "NewFlightCreated" and event "AutoCancelTimeout" is 10 seconds within 2 seconds range
  And API: Verify the difference between event "NewFlightCreated" and event "FlightComplete" is 10 seconds within 2 seconds range
  And API: Verify flight entry stopped in 10 seconds within 2 second range