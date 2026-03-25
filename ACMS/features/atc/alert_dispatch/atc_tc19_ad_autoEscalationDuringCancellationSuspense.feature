@atc @automated @el @critical @atc_ad @flight_path
@EPIC:AirCommand @FEATURE:EscalationResponse
@clear_atc_flights @TMS:584257
Feature: airDispatch_tc19_autoEscalationDuringCancellationSuspense
  As an Air Traffic Controller user
  I want to generate a flight that gets auto escalated by the recipient after the alarm for the flight has ended and the flight's CancellationSuspense timeout is activated
  So that I can verify that an escalate response from a recipient increases the escalation level during an activated CancellationSuspense timeout

  XXXX-###

  Test Notes: See <URL here> for location of flight plan configurations and instructions on how to execute
  configuration setup/alarm generation

  TestRail Id: C584257

  Jira Stories:

  Jira Bugs/Defects:

  Background:
    Given User executes test from "[props.CONFIGS_TC19_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    And AC: User is logged in with default filter applied

  Scenario: flight with an auto escalate recipient and with a non-zero cancellation suspense value
    When Alert "TC19_Alarm" initiated on PM with 20 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    Then AC: User verifies the generated alert is present in Alarm Queue panel
    And AC: Flight alert status section is blue and has no-icon icon with label Suspended
    When API: Wait until the flight is escalated to level 1
    And API: Wait until the flight is in cancellation suspense state for 20 seconds
    When API: Wait until the flight is escalated to level 2
    And API: Wait until the flight status is Complete by Flight Manager for 65 seconds
    Then AC: User should see the generated alert present in Alerts panel in Completed subsection
    And AC: Flight alert status section is grey and has no-icon icon with label Completed
    And AC: User sees the elapsed flight time on the flight entry stop at "1:20" within 3 second range
    When AC: User opens the generated alert details in Alerts panel
    And AC: User opens History tab of the alert details panel
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*NewFlightCreated*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightInitialSuspenseStart. *Initial Suspense started.*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightInitialSuspenseEnd. *Flight initial suspend ended.*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated. To Level:1. *Reason: InitialSuspenseTimeout.*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*AlarmEndReceived. *Alarm End message received.*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightCompletionSuspenseStart. *Starting Completion Suspend.*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated. To Level:2, Reason: EscalationTimeout.*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*DispatchSent. *Alert Sent. Address:autoescalate*"
#    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*NotificationSent. *Notification Sent. Destination:Destination2_SingleRec.*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*NotificationSent. *Notification Sent.*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*DispatchReply. *ResponseBy:autoescalate. Choice:Escalate*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*EscalateReceived.*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightCompletionSuspenseEnd.*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightComplete.*"
