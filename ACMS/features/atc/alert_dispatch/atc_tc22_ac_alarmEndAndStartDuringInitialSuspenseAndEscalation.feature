@atc @automated @el @critical @atc_ad @flight_path @flight_path
@EPIC:AirCommand @FEATURE:CancellationSuspend
@clear_atc_flights @TMS:584263
Feature: airDispatch_tc22_alarmEndAndStartDuringInitialSuspenseAndEscalation
  As an Air Traffic Controller user
  I want to generate a flight whose alarm ends in the Initial Suspense state and starts again while in Escalated state
  So that I can verify that a flight will still properly exit the Initial Suspense state after the Cancellation Suspense is activated and deactivated
  XXXX-###

  Test Notes: See https://utang.atlassian.net/wiki/spaces/ACMS/pages/3304816692/Setting+up+a+Flight+Plan+and+Generating+an+Alarm+Manually for location of
  flight plan configuration and instructions on how to execute configuration setup/alarm generation

  TestRail Id: C584263

  Jira Stories:

  Jira Bugs/Defects:

  Background:
    Given User executes test from "[props.ACMS_DEFAULT_CONFIG]" file in ATC Integration Test Console
    And AC: User is logged in with default filter applied

  Scenario: flight whose alarm ends in the Initial Suspense state and starts again while in Escalated state
    When Alert "TC22_Alarm" initiated on PM with 20 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    Then AC: User verifies the generated alert is present in Alarm Queue panel
    Then AC: Flight alert status section is blue and has no-icon icon with label Suspended
    When API: Wait until the flight is in cancellation suspense state for 30 seconds
    When API: Wait for 20 seconds until the flight has event with attributes
  """
  { "eventType":"AlarmEndReceived"}
  """
#    And API: Wait until the flight status is Complete by Flight Manager
#    Then AC: User should see the generated alert present in Alerts panel in In Flight subsection
#    Then AC: Flight alert status section is blue and has empty-circle icon with label Waiting
    When Alert "TC22_Alarm" initiated on PM with 20 seconds timeout
    When API: Wait for 30 seconds until the flight the flight has 2 events with attributes
    """
      { "eventType":"AlarmEndReceived"}
    """
    And API: Wait until the flight status is Complete by Flight Manager for 95 seconds
    Then AC: User should see the generated alert present in Alerts panel in Completed subsection
    And AC: Flight alert status section is grey and has no-icon icon with label Completed
    When AC: User opens the generated alert details in Alerts panel
    And AC: User opens History tab of the alert details panel
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*NewFlightCreated*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightInitialSuspenseStart. *Initial Suspense started.*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*AlarmEndReceived. *Alarm End message received.*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightCompletionSuspenseStart. *Starting Completion Suspend.*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated. To Level:1. *Reason: InitialSuspenseTimeout.*"
    And Time difference between ".*[props.ACMS_TIMESTAMP_REGEXP].*NewFlightCreated*" and ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated. To Level:1, Reason: InitialSuspenseTimeout.*" is 30 seconds
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightCompletionSuspenseExit.*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightComplete.*"
