@atc @automated @el @critical @atc_ad @flight_path
@EPIC:AirCommand @FEATURE:ManualEscalation
@clear_atc_flights @TMS:584246
Feature: airDispatch_tc15_manualEscalations
  As an Air Traffic Controller user
  I want to generate a flight that gets manually esclated to make sure it moves through the process as intended

  XXXX-###

  Test Notes: See https://utang.atlassian.net/wiki/spaces/ACMS/pages/3304816692/Setting+up+a+Flight+Plan+and+Generating+an+Alarm+Manually for location of
  flight plan configuration and instructions on how to execute configuration setup/alarm generation

  TestRail Id: C584246

  Jira Stories:

  Jira Bugs/Defects:
  Background:
    Given User executes test from "[props.CONFIGS_TC15_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    And AC: User is logged in with default filter applied

  Scenario: flight with manual escalations from level 1 to level 2
    When Alert "TC15_Alarm" initiated on PM with 30 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    And API: Wait until the flight is escalated to level 0
    Then AC: User verifies the generated alert is present in Alarm Queue panel
    Then AC: Flight alert status section is blue and has no-icon icon with label Suspended
    When AC: User clicks start button on alarm
    And AC: User clicks start button in pop up modal
    When API: Wait until the flight is escalated to level 1
    Then AC: User should see the generated alert present in Alerts panel in Active subsection
    And AC: User verifies the generated alert is present in Alerts panel with attributes
      """
      { "assigned-to":"destination:[props.DESTINATIONS_DESTINATION1_SINGLEREC]", "escalates-to": "destination:[props.DESTINATIONS_DESTINATION2_SINGLEREC]"}
      """
    When AC: User manually escalates alarm through elipses menu
    Then API: Wait until the flight is escalated to level 2
    And API: Wait until the flight status is Complete by Flight Manager for 30 seconds
    Then AC: User should see the generated alert present in Alerts panel in Completed subsection
    And AC: Flight alert status section is grey and has no-icon icon with label Completed
    And AC: User sees the elapsed flight time on the flight entry stop at "0:30" within 3 second range
    When AC: User opens the generated alert details in Alerts panel
    And AC: User opens History tab of the alert details panel
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*NewFlightCreated*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightInitialSuspenseStart. *Initial Suspense started.*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightEscalated *Flight Escalated. To Level:1, Reason: ManualEscalation.*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightEscalated *Flight Escalated. To Level:2, Reason: ManualEscalation.*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightComplete.*"
