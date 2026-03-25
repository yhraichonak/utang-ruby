@atc @automated @el @critical @atc_ad @flight_path
@EPIC:AirCommand @FEATURE:EscalationResponse
@clear_atc_flights @TMS:584244
Feature: airDispatch_tc13_escalationsEscalateResponse
  As an Air Traffic Controller user
  I want to generate a flight with three destination levels and escalations for each level that come from escalate responses received from recipients
  So that I can verify that the alarm is auto escalated properly for each defined destination

  XXXX-###

  Test Notes: See https://utang.atlassian.net/wiki/spaces/ACMS/pages/3304816692/Setting+up+a+Flight+Plan+and+Generating+an+Alarm+Manually for location of
  flight plan configuration and instructions on how to execute configuration setup/alarm generation

  TestRail Id: C584244

  Jira Stories:

  Jira Bugs/Defects:
  Background:
    Given User executes test from "[props.CONFIGS_TC13_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    And AC: User is logged in with default filter applied

  Scenario: flight with autoaccept recipients set, notifications are received and alarms escalated appropriately
    When Alert "TC13_Alarm" initiated on PM with 30 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    And API: Wait until the flight is escalated to level 0
    Then AC: User verifies the generated alert is present in Alarm Queue panel
    Then AC: Flight alert status section is blue and has no-icon icon with label Suspended
    When AC: User clicks start button on alarm
    And AC: User clicks start button in pop up modal
    And AC: User verifies the generated alert is present in Alerts panel
    And API: Wait until the flight is escalated to level 2
    And AC: User verifies the generated alert is present in Alerts panel with attributes
      """
      { "assigned-to":"destination:[props.DESTINATIONS_DESTINATION2_SINGLEREC]", "escalates-to": "destination:[props.DESTINATIONS_DESTINATION3_SINGLEREC]"}
      """
    And API: Wait until the flight status is Complete by Flight Manager for 60 seconds
    When AC: User opens the generated alert details in Alerts panel
    Then AC: User should see the generated alert present in Alerts panel in Completed subsection
    And AC: Flight alert status section is grey and has no-icon icon with label Completed
    And AC: User sees the elapsed flight time on the flight entry stop at "0:30" within 3 second range
    And AC: User opens History tab of the alert details panel
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*NewFlightCreated*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightInitialSuspenseStart. *Initial Suspense started.*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightInitialSuspenseEnd. *Event: Flight initial suspend ended.*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*EscalateReceived*"*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated. To Level:2. *Reason: EscalationResponse.*"
#    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*NotificationSent. *Notification Sent. Destination:Destination3_SingleRec.*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*NotificationSent. *Notification Sent.*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightComplete.*"

