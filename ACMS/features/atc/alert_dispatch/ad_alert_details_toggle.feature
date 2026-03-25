@atc @automated @critical @atc_ad
@atc_smoke @EPIC:AirCommand @FEATURE:AlertDetails
@TMS:586387 @clear_atc_flights
Feature: ad_alert_details_toggle
  As an Alert Dispatch user
  I want to navigate the Details Panel of Alert Dispatch
  So that I can close or not close the Details Panel as needed

  XXXX-1548
  - As a user, when I click on the close button, the panel will close.
  - As a user, when selecting the same alert, the panel shall close.
  - As a user, when select a new alert, the Panel shall not close.

  TESTING NOTES:
  - How-To create an alert flight - https://utang.atlassian.net/wiki/spaces/ACMS/pages/3304816692/Setting+up+a+Flight+Plan+and+Generating+an+Alarm+Manually

  TestRail Id: C586387

  Jira Stories: XXXX-1548

  Jira Bugs/Defects:

  Scenario: Correct navigation of the Alarm Queue Details Panel opening and closing
   Given User executes test from "[props.CONFIGS_TC09_MULTI_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
   And AC: User is logged in with default filter applied
    When Alert "TC09_01_Alarm,TC09_02_Alarm" initiated on PM with 50 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    Then AC: User verifies the generated alert is present in Alarm Queue panel
    And AC: User clicks the "TC09_01_Alarm" alert details in Alarm Queue panel
    Then AC: User verifies that the alert details panel is opened
    And AC: User verifies that "TC09_01_Alarm" alert card is highlighted in Alarm Queue panel
    Then AC: User verifies that the alert details has matching text
  """
 (?m).*TC09_01_Alarm.*
  """
    And AC: User clicks the "TC09_02_Alarm" alert details in Alarm Queue panel
    Then AC: User verifies that the alert details panel is opened
    And AC: User verifies that "TC09_02_Alarm" alert card is highlighted in Alarm Queue panel
    Then AC: User verifies that the alert details has matching text
  """
 (?m).*TC09_02_Alarm.*
  """
    And AC: User clicks the "TC09_02_Alarm" alert details in Alarm Queue panel
    Then AC: User verifies that the alert details panel is closed
    And AC: User clicks the "TC09_02_Alarm" alert details in Alarm Queue panel
    Then AC: User verifies that the alert details panel is opened
    Then AC: User verifies that the alert details has matching text
      """
 (?m).*TC09_02_Alarm.*
  """

    When AC: User clicks 'X' button on the alert details
    Then AC: User verifies that the alert details panel is closed

  Scenario: Correct navigation of the Alerts Details Panel opening and closing
    Given User executes test from "[props.CONFIGS_TC05_MULTI_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    And AC: User is logged in with default filter applied
    When Alert "TC05_Medium_Alarm_Short,TC05_Low_Alarm_Short" initiated on PM with 50 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    Then AC: User verifies the generated alert is present in Alerts panel
    And AC: User clicks the "TC05_Medium_Alarm_Short" alert details in Alerts panel
    Then AC: User verifies that the alert details panel is opened
    And AC: User verifies that "TC05_Medium_Alarm_Short" alert card is highlighted in Alerts panel
    Then AC: User verifies that the alert details has matching text
  """
 (?m).*TC05_Medium_Alarm_Short.*
  """
    And AC: User clicks the "TC05_Low_Alarm_Short" alert details in Alerts panel
    Then AC: User verifies that the alert details panel is opened
    And AC: User verifies that "TC05_Low_Alarm_Short" alert card is highlighted in Alerts panel
    Then AC: User verifies that the alert details has matching text
  """
 (?m).*TC05_Low_Alarm_Short.*
  """
    And AC: User clicks the "TC05_Low_Alarm_Short" alert details in Alerts panel
    Then AC: User verifies that the alert details panel is closed
    And AC: User clicks the "TC05_Low_Alarm_Short" alert details in Alerts panel
    Then AC: User verifies that the alert details panel is opened
    Then AC: User verifies that the alert details has matching text
     """
 (?m).*TC05_Low_Alarm_Short.*
  """
    When AC: User clicks 'X' button on the alert details
    Then AC: User verifies that the alert details panel is closed