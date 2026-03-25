@atc @automated @critical @atc_ad
@atc_smoke @EPIC:AirCommand @FEATURE:ActionsMenu
@TMS:586355 @clear_atc_flights
Feature: ad_flight_actions_menu
  As an Alert Dispatch User
  I want to manipulate the manual escalate a flight button
  So that I can confirm the UI reacts correctly to the different manual escalate button usage

  XXXX-1539
  - As a user, when I click on flight action menu on a flight, a flight actions menu for the flight shall display.
  - Alerts - Actions
  3 Vertical dots in the top right corner

  XXXX-1536
  - As a user, when I click away from escalate menu item, an escalate flight request does not send.
  - As a user, when I click on an Escalate, an escalate flight request will send.

  TESTING NOTES:
  - How-To create an alert flight - https://utang.atlassian.net/wiki/spaces/ACMS/pages/3304816692/Setting+up+a+Flight+Plan+and+Generating+an+Alarm+Manually
  - Setting up various Flight statuses - https://utang.atlassian.net/wiki/spaces/ACMS/pages/3568041992/Setting+up+various+Flight+statuses

  TestRail Id: C586355

  Jira Stories: XXXX-1536, XXXX-1539

  Jira Bugs/Defects: XXXX-1180

  Scenario: Confirming Manual Escalate button functionality
    Given User executes test from "[props.CONFIGS_TC01A_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    And AC: User is logged in with default filter applied
    When Alert "TC01a_Alarm" initiated on PM with 30 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    And API: Wait until the flight is escalated to level 1
    Then AC: User verifies the generated alert is present in Alerts panel
    When AC: User open the alarm ellipsis menu
    And AC: User verifies that "Escalate" menu is present
    When AC: User clicks on the application header
    And AC: User verifies that "Escalate" menu is not present
    When AC: User manually escalates alarm through elipses menu
    And wait for 1 seconds
    Then AC: User verifies the generated alert is present in Alerts panel with attributes
      """
      { "alarm-label":"TC01a_Alarm","assigned-to":"destination:[props.DESTINATIONS_DESTINATION2_SINGLEREC]","escalates-to": "destination:[props.DESTINATIONS_DESTINATION3_SINGLEREC]"}
      """
    When AC: User opens the generated alert details in Alerts panel
    And AC: User opens History tab of the alert details panel
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*ManualEscalateReceived. *Manual Escalation request from level 1.*"