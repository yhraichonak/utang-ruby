@atc @automated @el @critical @atc_ad @flight_path
@EPIC:AirCommand @FEATURE:Escalate
@clear_atc_flights @TMS:584188
Feature: airDispatch_tc01a_escalationsWithNoAcceptResponses
  As an Air Traffic Controller user
  I want to generate a flight with three destination levels, a non zero delay on accept timeout, and zero accept responses per level
  So that I can verify that the alarm is auto escalated at the originally defined escalation intervals with no delays

  XXXX-###

  Test Notes: See https://utang.atlassian.net/wiki/spaces/ACMS/pages/3304816692/Setting+up+a+Flight+Plan+and+Generating+an+Alarm+Manually for location of
  flight plan configuration and instructions on how to execute configuration setup/alarm generation

  TestRail Id: C584188

  Jira Stories:

  Jira Bugs/Defects:

  Background:
    Given User executes test from "[props.CONFIGS_TC01A_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    And AC: User is logged in with default filter applied

  Scenario: flight with three destination levels, a non zero delay on accept timeout, and zero accept responses per level
    When Alert "TC01a_Alarm" initiated on PM with 100 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    When API: Wait until the flight status is Escalated by Flight Manager
    Then AC: Flight alert status section is blue and has empty-circle icon with label Waiting
    And AC: User verifies the generated alert is present in Alerts panel with attributes
      """
      { "assigned-to":"destination:[props.DESTINATIONS_DESTINATION1_SINGLEREC]", "escalates-to": "destination:[props.DESTINATIONS_DESTINATION2_SINGLEREC]"}
      """
    When API: Wait until the flight is escalated to level 2
    Then AC: User verifies the generated alert is present in Alerts panel with attributes
      """
      { "assigned-to":"destination:[props.DESTINATIONS_DESTINATION2_SINGLEREC]", "escalates-to": "destination:[props.DESTINATIONS_DESTINATION3_SINGLEREC]"}
      """
    When API: Wait until the flight is escalated to level 3
    And AC: User verifies the generated alert is present in Alerts panel with attributes
      """
      { "assigned-to":"destination:[props.DESTINATIONS_DESTINATION3_SINGLEREC]", "escalates-to": "destination:none"}
      """
    When API: Wait until the flight status is Complete by Flight Manager for 105 seconds
    Then AC: User should see the generated alert present in Alerts panel in Completed subsection
    And AC: Flight alert status section is grey and has no-icon icon with label Completed
    And AC: User sees the elapsed flight time on the flight entry stop at "1:40" within 3 second range
    And AC: User opens the generated alert details in Alerts panel
    And AC: User opens History tab of the alert details panel
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated. To Level:1, Reason: InitialSuspenseTimeout.*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated. To Level:2, Reason: EscalationTimeout.*"
    And Time difference between ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated. To Level:1, Reason: InitialSuspenseTimeout.*" and ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated. To Level:2, Reason: EscalationTimeout.*" is 45 seconds
    Then AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated. To Level:3, Reason: EscalationTimeout.*"
    And Time difference between ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated. To Level:2, Reason: EscalationTimeout.*" and ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated. To Level:3, Reason: EscalationTimeout.*" is 45 seconds
    Then AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightComplete.*Reason.Cancellation Suspend ended.*"
    And Time difference between ".*[props.ACMS_TIMESTAMP_REGEXP].*NewFlightCreated*" and ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightComplete.*Reason.Cancellation Suspend ended.*" is 100 seconds

