@atc @automated @el @critical @atc_ad
@EPIC:AirCommand @FEATURE:CancellationSuspend
@clear_atc_flights @TMS:584264
Feature: airDispatch_tc22_alarmEndAndStartDuringInitialSuspenseFollowedByManualStart
  As an Air Traffic Controller user
  I want to generate a flight with whose alarm ends and starts again in the Initial Suspense state followed by a manual start
  So that I can verify that a flight will still properly exit the Initial Suspense state through a manual start after the Cancellation Suspense is activated and deactivated
  XXXX-###

  Test Notes: See https://utang.atlassian.net/wiki/spaces/ACMS/pages/3304816692/Setting+up+a+Flight+Plan+and+Generating+an+Alarm+Manually for location of
  flight plan configuration and instructions on how to execute configuration setup/alarm generation

  TestRail Id: C584264

  Jira Stories:

  Jira Bugs/Defects:

  Background:
    Given User executes test from "[props.ACMS_DEFAULT_CONFIG]" file in ATC Integration Test Console
    And AC: User is logged in with default filter applied

  Scenario: flight with whose alarm ends and starts again in the Initial Suspense state
    When Alert "TC22_Alarm" initiated on PM with 20 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    Then AC: User verifies the generated alert is present in Alarm Queue panel
    Then AC: Flight alert status section is blue and has no-icon icon with label Suspended
    When API: Wait until the flight is in cancellation suspense state for 25 seconds
    And Alert "TC22_Alarm" initiated on PM with 20 seconds timeout
    When AC: User clicks start button on alarm
    And AC: User clicks start button in pop up modal
    When API: Wait until the flight is escalated to level 1
    Then AC: User should see the generated alert present in Alerts panel in Active subsection
    And AC: Flight alert status section is blue and has empty-circle icon with label Waiting
    And API: Wait until the flight status is Complete by Flight Manager for 150 seconds
    Then AC: User should see the generated alert present in Alerts panel in Completed subsection
    And AC: Flight alert status section is grey and has no-icon icon with label Completed
    When AC: User opens the generated alert details in Alerts panel
    And AC: User opens History tab of the alert details panel
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*NewFlightCreated*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightInitialSuspenseStart. *Initial Suspense started.*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*AlarmEndReceived. *Alarm End message received.*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightCompletionSuspenseStart. *Starting Completion Suspend.*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightCompletionSuspenseEnd.*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated. To Level:1. *Reason: ManualEscalation.*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightComplete.*"
