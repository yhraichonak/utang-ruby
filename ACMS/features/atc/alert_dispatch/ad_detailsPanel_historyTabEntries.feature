@atc @automated @critical @atc_ad
@atc_smoke @EPIC:AirCommand @FEATURE:AlertDetails
@TMS:586349 @clear_atc_flights
Feature: ad_detailsPanel_historyTabEntries
  As an Alert Dispatch user
  I want to view the history tab as flight changes occur
  So that I can view the correct response from the tab itself

  XXXX-911
  - [depracated by XXXX-2170] An indication such a flash of color on the tab name to indicate an updated/new entry on the history
  - Since history tab is a filtered list of events from the audit tab, the history tab name should flash only when a new entry is displayed in the history tab.
  DESIGN:
  - [depracated by XXXX-2170] flash the tab title by Bolding and enlarging the tab title for one second and reverting back to normal
  [Reference to "Audit" tab were removed after the creation of XXXX-2076]

  XXXX-1549
  - History shall be updated when new information is available.
  - (negated by XXXX-2076) Audit shall be updated when new information is available.

  XXXX-2076
  - In Alert Dispatch, remove "History" tab from Expanded window and change "Audit" tab to "History" tab.

  XXXX-2170
  - Remove the blinking (flash) when the history tab is updated.

  TESTING NOTES:
  - How-To create an alert flight - https://utang.atlassian.net/wiki/spaces/ACMS/pages/3304816692/Setting+up+a+Flight+Plan+and+Generating+an+Alarm+Manually
  - Setting up various Flight statuses - https://utang.atlassian.net/wiki/spaces/ACMS/pages/3568041992/Setting+up+various+Flight+statuses

  TestRail Id: C586349

  Jira Story: XXXX-911, XXXX-1549, XXXX-2076, XXXX-2170

  Jira Bugs/Defects:

  Scenario: History tab reactions to new flight entries
    Given User executes test from "[props.CONFIGS_TC05_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    And AC: User is logged in with default filter applied
    When Alert "TC05_Alarm" initiated on PM with 40 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    And AC: User opens the generated alert details in Alerts panel
    And AC: User opens History tab of the alert details panel
    And AC: User remembers History tab content of the alert details panel
    And AC: User waits for 30 seconds until History tab of the alert details panel flashes
    Then AC: User verified History tab loaded new data on the alert details panel
    When API: Wait until the flight status is Complete by Flight Manager for 20 seconds
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*NewFlightCreated*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated. To Level:1, Reason: InitialSuspenseTimeout.*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightComplete.*Reason:AutoCancelTime expired.*"
    And Time difference between ".*[props.ACMS_TIMESTAMP_REGEXP].*NewFlightCreated*" and ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightComplete.*Reason:AutoCancelTime expired.*" is 20 seconds
