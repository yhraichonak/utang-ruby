@atc @automated @el @critical @atc_ad @flight_path
@EPIC:AirCommand @FEATURE:InitialSuspend
@clear_atc_flights @TMS:584197
Feature: airDispatch_tc09_nonZeroInitialSuspendWithAlarmEnd
  As an Air Traffic Controller user
  I want to generate a flight with a non-zero initial suspend value and with an alarm duration that is less than the initial suspend value
  So that I can verify an alarm that ends while in the initial suspend state will go into the completion suspense state and then complete state right away

  XXXX-###

  Test Notes: See https://utang.atlassian.net/wiki/spaces/ACMS/pages/3304816692/Setting+up+a+Flight+Plan+and+Generating+an+Alarm+Manually for location of
  flight plan configuration and instructions on how to execute configuration setup/alarm generation

  TestRail Id: C584197

  Jira Stories:

  Jira Bugs/Defects:

  Background:
    Given User executes test from "[props.CONFIGS_TC09_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    And AC: User is logged in with default filter applied

  Scenario: flight with a non-zero initial suspend value and with an alarm duration that is less than the initial suspend value
    When Alert "TC09_Alarm" initiated on PM with 20 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    Then AC: User verifies the generated alert is present in Alarm Queue panel
    Then AC: Flight alert status section is blue and has no-icon icon with label Suspended
    When API: Wait until the flight status is Complete by Flight Manager for 50 seconds
    Then AC: User verifies the generated alert is present in Alarm Queue panel
    And AC: Flight alert status section is grey and has no-icon icon with label Ended
    And AC: User sees the elapsed flight time on the flight entry stop at "0:50" within 3 second range
    When AC: User opens the generated alert details in Alarm Queue panel
    And AC: User opens History tab of the alert details panel
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*NewFlightCreated*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightInitialSuspenseStart. *Initial Suspense started.*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*AlarmEndReceived. *Alarm End message received.*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightCompletionSuspenseStart. *Starting Completion Suspend.*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightCompletionSuspenseEnd. *Event: Cancellation Suspend period ended.*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightComplete. *Reason:Cancellation Suspend ended*"
    And Time difference between ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightCompletionSuspenseStart*" and ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightComplete.*" is 20 seconds
    And Time difference between ".*[props.ACMS_TIMESTAMP_REGEXP].*NewFlightCreated*" and ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightComplete. *Reason:Cancellation Suspend ended.*" is 40 seconds

