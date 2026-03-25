@atc @automated @critical @atc_ad
@atc_smoke @EPIC:AirCommand @FEATURE:ManualEscalate
@TMS:586332 @clear_atc_flights
Feature: ad_start_flight_manual
  As an Alert Dispatch User
  I want to manipulate the Manual Start function in the Alarm Queue
  So that I can confirm correct functionality

  XXXX-1562
  - As a user when I click on flight in Alarm Queue, and click on start button, I should see the Start Alert Dialog chicklet.
  - When I click on the dialog box, I shall be able to type in free text notes to be included in the WCTP Alarm Message Body. No Character Limit. The dialog box should also include patient & alarm detail such as you would see in the focus mode:
  - When I close the Start Dialog chicklet, the Start Alert Dialog closes and Flight shall continue.
  - Ended flights shall not display the START button.

  XXXX-1563
  - As a user, when I cancel out of start flight dialog, the start flight request does not send.
  - As a user, when I click on Start, a start flight request will be sent.
  - As a user, I shall be able to see Flight status updates in the start panel.

  TESTING NOTES:
  - How-To create an alert flight - https://utang.atlassian.net/wiki/spaces/ACMS/pages/3304816692/Setting+up+a+Flight+Plan+and+Generating+an+Alarm+Manually

  TestRail Id: C586332

  Jira Stories: XXXX-1562, XXXX-1563

  Jira Bugs/Defects: XXXX-1264, XXXX-142

  Scenario: "Start Alert" modal pop-up
    Given User executes test from "[props.CONFIGS_TC09_MULTI_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    When Alert "TC09_04_Alarm_Ended" initiated on PM with 5 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    When AC: User is logged in with default filter applied
    When API: Wait until the flight status is Complete by Flight Manager for 20 seconds
    When Alert "TC09_01_Alarm" initiated on PM with 60 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
   Then AC: User verifies that "TC09_04_Alarm_Ended" alert card doesn't have button Start in Alarm Queue panel
   Then AC: User verifies that "TC09_01_Alarm" alert card has button Start in Alarm Queue panel
    When AC: User clicks start button on alarm
    And AC: User should see Start Alert modal popup
    And AC: User should see High severity icon on Alert modal popup matching
    And AC: User should see text on Start Alert modal popup matching
"""
 (?m).*Smith, Jim.*06/01/2000.*.{8}-.{4}-.{4}-.{4}-.{12}.*Facility1.*ICU3.*ICU3-B890.*
"""
    And AC: User should see text on Start Alert modal popup matching
"""
 (?m).*TC09_01_Alarm.*Smith, Jim.*06/01/2000.*2233441.*Facility1.*ICU3.*ICU3-B890.*\d\d:\d\d:\d\d.*
"""

  Scenario: Start a flight without notes
    Given User executes test from "[props.CONFIGS_TC09_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    When Alert "TC09_Alarm" initiated on PM with 30 seconds timeout
    And AC: User is logged in with default filter applied
    And API: Wait until the alert is processed by Flight Manager
    Then AC: User verifies the generated alert is present in Alarm Queue panel
    When AC: User clicks start button on alarm
    And AC: User clicks start button in pop up modal
    When API: Wait until the flight is escalated to level 1
    Then AC: User should see the generated alert present in Alerts panel in Active subsection

  Scenario: Start a flight with notes
    Given User executes test from "[props.CONFIGS_TC09_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    When Alert "TC09_Alarm" initiated on PM with 30 seconds timeout
    And AC: User is logged in with default filter applied
    And API: Wait until the alert is processed by Flight Manager
    Then AC: User verifies the generated alert is present in Alarm Queue panel
    When AC: User clicks start button on alarm
    And AC: User specified "Test note" notes at Start Alert modal popup
    And AC: User clicks start button in pop up modal
    When API: Wait until the flight is escalated to level 1
    Then AC: User should see the generated alert present in Alerts panel in Active subsection

  Scenario: Start a flight with notes - no limit
    Given User executes test from "[props.CONFIGS_TC09_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    When Alert "TC09_Alarm" initiated on PM with 30 seconds timeout
    And AC: User is logged in with default filter applied
    And API: Wait until the alert is processed by Flight Manager
    Then AC: User verifies the generated alert is present in Alarm Queue panel
    When AC: User clicks start button on alarm
    And AC: User specified "[Test notes*100]" notes at Start Alert modal popup
    And AC: User clicks start button in pop up modal
    When API: Wait until the flight is escalated to level 1
    Then AC: User should see the generated alert present in Alerts panel in Active subsection

  Scenario: Cancel the start flight process
    Given User executes test from "[props.CONFIGS_TC09_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    When Alert "TC09_Alarm" initiated on PM with 30 seconds timeout
    And AC: User is logged in with default filter applied
    And API: Wait until the alert is processed by Flight Manager
    Then AC: User verifies the generated alert is present in Alarm Queue panel
    When AC: User clicks start button on alarm
    And AC: User clicks cancel button in pop up modal
    Then AC: User should not see the generated alert present in Alerts panel in Active subsection
    When API: Wait until the flight is escalated to level 1
    Then AC: User should see the generated alert present in Alerts panel in Active subsection

  Scenario: The Start Alert modal pop-up updates when status changes for suspended to waiting
    Given User executes test from "[props.CONFIGS_TC09_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    When Alert "TC09_Alarm" initiated on PM with 30 seconds timeout
    And AC: User is logged in with default filter applied
    And API: Wait until the alert is processed by Flight Manager
    Then AC: User verifies the generated alert is present in Alarm Queue panel
    When AC: User clicks start button on alarm
    When API: Wait until the flight is escalated to level 1
    And wait for 1 seconds
    Then AC: Verify that start button has disappeared on pop up modal