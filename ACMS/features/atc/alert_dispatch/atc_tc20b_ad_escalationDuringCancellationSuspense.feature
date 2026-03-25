@atc @automated @el @critical @atc_ad @flight_path
@EPIC:AirCommand @FEATURE:CancellationSuspend
@clear_atc_flights @TMS:584234
Feature: airDispatch_tc20b_escalationDuringCancellationSuspense
  As an Air Traffic Controller user
  I want to generate a flight that gets escalated after the alarm for the flight has ended and the flight's CancellationSuspense timeout is activated
  So that I can verify that an alarm can change escalation levels successfully with an activated CancellationSuspense timeout

  XXXX-###

  Test Notes: See https://utang.atlassian.net/wiki/spaces/ACMS/pages/3304816692/Setting+up+a+Flight+Plan+and+Generating+an+Alarm+Manually for location of
  flight plan configuration and instructions on how to execute configuration setup/alarm generation

  TestRail Id: C584234

  Jira Stories:

  Jira Bugs/Defects:

  Background:
    Given User executes test from "[props.CONFIGS_TC20B_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    And AC: User is logged in with default filter applied

  Scenario: flight with a non-zero initial suspend value and with an alarm duration that is less than the initial suspend value
    When Alert "TC20b_Alarm" initiated on PM with 30 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    Then AC: User verifies the generated alert is present in Alarm Queue panel
    Then AC: Flight alert status section is blue and has no-icon icon with label Suspended
    And API: Wait until the flight status is Escalated by Flight Manager for 15 seconds
    Then AC: User should see the generated alert present in Alerts panel in Active subsection
    And AC: Flight alert status section is blue and has empty-circle icon with label Waiting
    And AC: User verifies the generated alert is present in Alerts panel with attributes
      """
      { "assigned-to":"destination:[props.DESTINATIONS_DESTINATION1_SINGLEREC]", "escalates-to": "destination:[props.DESTINATIONS_DESTINATION2_SINGLEREC]"}
      """
    When API: Wait until the flight is in cancellation suspense state for 40 seconds
    When API: Wait until the flight is escalated to level 2
    And AC: User verifies the generated alert is present in Alerts panel with attributes
      """
      { "assigned-to":"destination:[props.DESTINATIONS_DESTINATION2_SINGLEREC]", "escalates-to": "destination:[props.DESTINATIONS_DESTINATION3_SINGLEREC]"}
      """
    And API: Wait until the flight isn't in cancellation suspense state for 30 seconds
    Then AC: User should see the generated alert present in Alerts panel in Completed subsection
    And AC: Flight alert status section is grey and has no-icon icon with label Completed
    And AC: User sees the elapsed flight time on the flight entry stop at "1:00" within 3 second range
    When AC: User opens the generated alert details in Alerts panel
    And AC: User opens History tab of the alert details panel
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*NewFlightCreated*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightInitialSuspenseStart. *Initial Suspense started.*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated. To Level:1. *Reason: InitialSuspenseTimeout.*"
    And Time difference between ".*[props.ACMS_TIMESTAMP_REGEXP].*NewFlightCreated*" and ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated. To Level:1, Reason: InitialSuspenseTimeout.*" is 15 seconds
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*AlarmEndReceived. *Alarm End message received.*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightCompletionSuspenseStart. *Starting Completion Suspend.*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated. To Level:2. *Reason: EscalationTimeout.*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightCompletionSuspenseEnd.*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightComplete.*"
