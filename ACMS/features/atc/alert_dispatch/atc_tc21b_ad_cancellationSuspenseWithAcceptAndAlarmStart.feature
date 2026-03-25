@atc @automated @el @critical @atc_ad @flight_path
@EPIC:AirCommand @FEATURE:CancellationSuspend
@clear_atc_flights @TMS:584324
Feature: airDispatch_tc21b_cancellationSuspenseWithAcceptAndAlarmStart
  As an Air Traffic Controller user
  I want to generate a flight that
  So that I can verify that

  XXXX-###

  Test Notes: See https://utang.atlassian.net/wiki/spaces/ACMS/pages/3304816692/Setting+up+a+Flight+Plan+and+Generating+an+Alarm+Manually for location of
  flight plan configuration and instructions on how to execute configuration setup/alarm generation

  TestRail Id: 584324

  Jira Stories:

  Jira Bugs/Defects:

  Background:
    Given User executes test from "[props.CONFIGS_TC21B_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    And AC: User is logged in with default filter applied
  @prioritized
  Scenario: flight with three destination levels, a non zero delay on accept timeout, and zero accept responses per level
    When Alert "TC21b_Alarm" initiated on PM with 20 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    And AC: User verifies the generated alert is present in Alerts panel with attributes
      """
      { "assigned-to":"destination:[props.DESTINATIONS_DESTINATION1_SINGLEREC]", "escalates-to": "destination:[props.DESTINATIONS_DESTINATION2_SINGLEREC]"}
      """
    And AC: Flight alert status section is blue and has empty-circle icon with label Waiting
    When API: Wait until the flight is in cancellation suspense state for 20 seconds
    When User manually triggers an Accept response to be sent back to the Flight Manager for this flight
    And AC: Flight alert status section is green and has filled-circle icon with label Accepted
    When Alert "TC21b_Alarm" initiated on PM with 60 seconds timeout
    When API: Check for flight "escalationLevel" to be "2" for 70 seconds
    And AC: User verifies the generated alert is present in Alerts panel with attributes
      """
      { "assigned-to":"destination:[props.DESTINATIONS_DESTINATION2_SINGLEREC]", "escalates-to": "destination:[props.DESTINATIONS_DESTINATION3_SINGLEREC]"}
      """
    And API: Wait until the flight status is Complete by Flight Manager for 300 seconds
    Then AC: User should see the generated alert present in Alerts panel in Completed subsection
    And AC: Flight alert status section is grey and has no-icon icon with label Completed
    When AC: User opens the generated alert details in Alerts panel
    And AC: User opens History tab of the alert details panel
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightInitialSuspenseStart. *Initial Suspense started.*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*DispatchSent. *Alert Sent. Address:manual*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightCompletionSuspenseStart. *Starting Completion Suspend.*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*DispatchReply. *ResponseBy:manual, Choice:Accept*"
    Then AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*AcceptReceived.*Accept Received.*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*AlarmStartReceived.*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightCompletionSuspenseExit.*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated. To Level:2. *Reason: EscalationTimeout.*"
    And Time difference between ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated. To Level:1, Reason: InitialSuspenseTimeout.*" and ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated. To Level:2. *Reason: EscalationTimeout.*" is 70 seconds
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightCompletionSuspenseStart. *Starting Completion Suspend.*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightCompletionSuspenseEnd.*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightComplete.*"

