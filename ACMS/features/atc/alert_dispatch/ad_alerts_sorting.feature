@atc @automated @critical @atc_ad
@atc_smoke @EPIC:AirCommand @FEATURE:AlarmSorting
@TMS:586328 @clear_atc_flights
Feature: ad_alerts_sorting
  As an Alert Dispatch user
  I want to see the sorting of the Alerts
  So that I can verify Alerts are being sorted correctly

  XXXX-1078
  The below requirements pertain to Alarm Queue and Alert Queue.
  - Flights are exclusively sorted by timestamp, with the most recent flights (youngest) at the top.
  - There will be no user controllable ability to alter the sorting of flights.
  - This sorting is true in both columns, and for both active, and completed flights sections.
  - Flights will allow to be prioritized by severity.
  - At the top of each column (alarms, alerts) include a checkbox (or similar standard control) labeled "Prioritize by Severity".
  - This checkbox will be ON by default.
  - When checked, instead of a view of flights only by start timestamp, we will now pre-group the flights by severity:
  Critical
  High
  Medium
  Low
  - within each group, it's list of flights will be sorted by timestamp as per above.
  - This grouping is ONLY for active flights. The ended and completed flights section does not "Prioritize".
  - When the checkbox is unchecked, the flights would be sorted only by start timestamp
  - If there was a flight selected before user clicks on the xcheckbox, it will still be selected after. It is nice to have to scroll the selected flight into the view but is not required.

  TESTING NOTES:
  - How-To create an alert flight - https://utang.atlassian.net/wiki/spaces/ACMS/pages/3304816692/Setting+up+a+Flight+Plan+and+Generating+an+Alarm+Manually

  TestRail Id: C586328

  Jira Stories: XXXX-1078

  Jira Bugs/Defects:

  Scenario: Alerts with Prioritized by Severity on
    Given User executes test from "[props.CONFIGS_TC05_MULTI_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    And wait for 1 seconds
    When Alert "TC05_Medium_Alarm_Short" initiated on PM with 10 seconds timeout
    And wait for 1 seconds
    When Alert "TC05_Alarm_Short" initiated on PM with 10 seconds timeout
    And wait for 1 seconds
    When Alert "TC05_Low_Alarm_Short" initiated on PM with 10 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    And API: Wait until the flight status is Escalated by Flight Manager
    When Alert "TC05_Low_01_Alarm" initiated on PM with 60 seconds timeout
    And wait for 1 seconds
    When Alert "TC05_01_Alarm" initiated on PM with 60 seconds timeout
    And wait for 1 seconds
    When Alert "TC05_Medium_01_Alarm" initiated on PM with 60 seconds timeout
    And wait for 1 seconds
    When Alert "TC05_Medium_02_Alarm" initiated on PM with 60 seconds timeout
    And wait for 1 seconds
    When Alert "TC05_Low_02_Alarm" initiated on PM with 60 seconds timeout
    And wait for 1 seconds
    When Alert "TC05_02_Alarm" initiated on PM with 60 seconds timeout
    And AC: User is logged in with default filter applied
    And API: Wait until the alert is processed by Flight Manager
    And API: Wait until the flight status is Escalated by Flight Manager
    And AC: User wait until "TC05_Medium_Alarm_Short" alert appears in Alerts panel in Completed subsection
    And AC: User wait until "TC05_Alarm_Short" alert appears in Alerts panel in Completed subsection
    And AC: User wait until "TC05_Low_Alarm_Short" alert appears in Alerts panel in Completed subsection
    And AC: User wait until "TC05_02_Alarm" alert appears in Alerts panel in Active subsection
    And AC: User verifies that Prioritize by Severity is checked on Alerts panel
    And AC: User verifies the order of items in Active section on Alerts panel
    """
    [
    "TC05_02_Alarm",
    "TC05_01_Alarm",
    "TC05_Medium_02_Alarm",
    "TC05_Medium_01_Alarm",
    "TC05_Low_02_Alarm",
     "TC05_Low_01_Alarm"
    ]
    """
    And AC: User verifies the order of items in Completed section on Alerts panel
    """
    [ "TC05_Low_Alarm_Short", "TC05_Alarm_Short", "TC05_Medium_Alarm_Short"]
    """
    When Alert "TC05_03_Alarm" initiated on PM with 60 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    And API: Wait until the flight status is Escalated by Flight Manager
    And AC: User wait until "TC05_03_Alarm" alert appears in Alerts panel in Active subsection
    And AC: User verifies the order of items in Active section on Alerts panel
    """
    [
    "TC05_03_Alarm",
    "TC05_02_Alarm",
    "TC05_01_Alarm",
    "TC05_Medium_02_Alarm",
    "TC05_Medium_01_Alarm",
    "TC05_Low_02_Alarm",
    "TC05_Low_01_Alarm"
    ]
    """

  Scenario: Alerts with Prioritized by Severity off
    Given User executes test from "[props.CONFIGS_TC05_MULTI_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    When Alert "TC05_Medium_Alarm_Short" initiated on PM with 5 seconds timeout
    And wait for 1 seconds
    When Alert "TC05_Alarm_Short" initiated on PM with 5 seconds timeout
    And wait for 1 seconds
    When Alert "TC05_Low_Alarm_Short" initiated on PM with 5 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    And API: Wait until the flight status is Escalated by Flight Manager
    When Alert "TC05_Low_01_Alarm" initiated on PM with 60 seconds timeout
    And wait for 1 seconds
    When Alert "TC05_01_Alarm" initiated on PM with 60 seconds timeout
    And wait for 1 seconds
    When Alert "TC05_Medium_01_Alarm" initiated on PM with 60 seconds timeout
    And wait for 1 seconds
    When Alert "TC05_Medium_02_Alarm" initiated on PM with 60 seconds timeout
    And wait for 1 seconds
    When Alert "TC05_Low_02_Alarm" initiated on PM with 60 seconds timeout
    And wait for 1 seconds
    When Alert "TC05_02_Alarm" initiated on PM with 60 seconds timeout
    And AC: User is logged in with default filter applied
    And API: Wait until the alert is processed by Flight Manager
    And API: Wait until the flight status is Escalated by Flight Manager
    When AC: User sets Prioritize by Severity to unchecked on Alerts panel
    And AC: User verifies the order of items in Active section on Alerts panel
    """
    [
    "TC05_02_Alarm",
    "TC05_Low_02_Alarm",
    "TC05_Medium_02_Alarm",
    "TC05_Medium_01_Alarm",
    "TC05_01_Alarm",
    "TC05_Low_01_Alarm"
    ]
    """
    And AC: User verifies the order of items in Completed section on Alerts panel
    """
    [ "TC05_Low_Alarm_Short", "TC05_Alarm_Short", "TC05_Medium_Alarm_Short"]
    """
    When Alert "TC05_03_Alarm" initiated on PM with 60 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    And API: Wait until the flight status is Escalated by Flight Manager
    And AC: User verifies the order of items in Active section on Alerts panel
    """
    [
    "TC05_03_Alarm",
    "TC05_02_Alarm",
    "TC05_Low_02_Alarm",
    "TC05_Medium_02_Alarm",
    "TC05_Medium_01_Alarm",
    "TC05_01_Alarm",
    "TC05_Low_01_Alarm"
    ]
    """

  Scenario: Alarm in Alerts remains selected after Prioritized by Severity change
  Given User executes test from "[props.CONFIGS_TC05_MULTI_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
  When Alert "TC05_Low_01_Alarm" initiated on PM with 60 seconds timeout
  When Alert "TC05_01_Alarm" initiated on PM with 60 seconds timeout
  And AC: User is logged in with default filter applied
  And API: Wait until the alert is processed by Flight Manager
  And API: Wait until the flight status is Escalated by Flight Manager
  And AC: User clicks the "TC05_Low_01_Alarm" alert details in Alerts panel
  Then AC: User verifies that the alert details panel is opened
  When AC: User sets Prioritize by Severity to unchecked on Alerts panel
  Then AC: User verifies that the alert details panel is opened

  Scenario: Alarm with Prioritized by Severity is ON - on custom screen size
    And AC: User is logged in with default filter applied
    Then AC: User verifies that Prioritize by Severity is checked on Alerts panel
    When User sets browser size to 1600x1400
    Then AC: User verifies that Prioritize by Severity is checked on Alerts panel
