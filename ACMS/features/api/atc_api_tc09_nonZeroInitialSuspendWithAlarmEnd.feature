@atc_api @automated @el @critical
@EPIC:API @FEATURE:InitialSuspend
@clear_atc_flights @TMS:584197
Feature: atc_api_tc09_nonZeroInitialSuspendWithAlarmEnd
Scenario: API - flight with a non-zero initial suspend value and with an alarm duration that is less than the initial suspend value
  Given User executes test from "[props.CONFIGS_TC09_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
  When Alert "TC09_Alarm" initiated on PM with 20 seconds timeout
  And API: Wait until the alert is processed by Flight Manager
  When API: Wait until the flight status is Complete by Flight Manager for 50 seconds
  Then API: Verify the flight has event "FlightInitialSuspenseStart"
  And API: Verify the flight has event "Alarm End message received"
  And API: Verify the flight has event "FlightCompletionSuspenseStart"
  And API: Verify the flight has event "FlightCompletionSuspenseEnd"
  And API: Verify the flight doesn't have event "FlightInitialSuspenseEnd"
  And API: Verify the difference between event "FlightCompletionSuspenseStart" and event "FlightComplete" is 20 seconds within 2 seconds range
  And API: Verify the flight has event with attributes '{ "eventType":"FlightComplete", "message":"Reason:Cancellation Suspend ended"}'
  And API: Verify flight entry stopped in 40 seconds within 2 second range