@atc @automated @critical @atc_ad
@atc_smoke @EPIC:AirCommand @FEATURE:AlarmSorting
@TMS:586329 @clear_atc_flights
Feature: ad_alarm_queue_sorting
  As an Alert Dispatch user
  I want to see the sorting of the Alarm Queue
  So that I can verify Alarm Queue are being sorted correctly

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
  - If there was a flight selected before user clicks on the checkbox, it will still be selected after. It is nice to have to scroll the selected flight into the view but is not required.

  TESTING NOTES:
  - How-To create an alert flight - https://utang.atlassian.net/wiki/spaces/ACMS/pages/3304816692/Setting+up+a+Flight+Plan+and+Generating+an+Alarm+Manually
  - Few sites have critical. We do not have a 'Critical' internally so only Low-High can be tested. If a site ever has 'Critical' in the future we will have to decide
  how to test that. Whether update our internal set up or test that part on-site.
  - NOTE: The examples below may need to be adjusted per your server- example '...10.106.5.76...'
  .\createAlarm.ps1 -URL '10.106.5.72:8765' -Session 00000 -AlarmText Low_Alarm -Severity Low -Duration 60
  .\createAlarm.ps1 -URL '10.106.5.72:8765' -Session 00000 -AlarmText Medium_Alarm -Severity Medium -Duration 60
  .\createAlarm.ps1 -URL '10.106.5.72:8765' -Session 00000 -AlarmText High_Alarm -Severity High -Duration 60
  - FIRST - in this test it will be easiest to open 3 powershell windows after you have set up the "TestConf_selectAlarmType"
  In each window set one alarm up as "Low_Alarm", "Medium_Alarm", and "High Alarm" (remember the config will override the severity in your alarm)
  Then set the alarms off in this order - Medium, Low, High - this will allow you to confirm each alarm Prioritizes itself correctly.

  TestRail Id: C586329

  Jira Stories: XXXX-1078

  Jira Bugs/Defects:

  Scenario: Alarm Queue with Prioritized by Severity on
    Given User executes test from "[props.CONFIGS_TC09_MULTI_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    When Alert "TC09_Low_01_Alarm" initiated on PM with 60 seconds timeout
    When Alert "TC09_01_Alarm" initiated on PM with 60 seconds timeout
    When Alert "TC09_Medium_01_Alarm" initiated on PM with 60 seconds timeout
    When Alert "TC09_Medium_02_Alarm" initiated on PM with 60 seconds timeout
    When Alert "TC09_Low_02_Alarm" initiated on PM with 60 seconds timeout
    When Alert "TC09_02_Alarm" initiated on PM with 60 seconds timeout
    And AC: User is logged in with default filter applied
    And API: Wait until the alert is processed by Flight Manager
    And AC: User verifies that Prioritize by Severity is checked on Alarm Queue panel
    And AC: User verifies the order of items on Alarm Queue panel
    """
    [
    "TC09_02_Alarm",
    "TC09_01_Alarm",
    "TC09_Medium_02_Alarm",
    "TC09_Medium_01_Alarm",
    "TC09_Low_02_Alarm",
     "TC09_Low_01_Alarm"
    ]
    """
    When Alert "TC09_03_Alarm" initiated on PM with 60 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    And AC: User verifies the order of items on Alarm Queue panel
    """
    [
    "TC09_03_Alarm",
    "TC09_02_Alarm",
    "TC09_01_Alarm",
    "TC09_Medium_02_Alarm",
    "TC09_Medium_01_Alarm",
    "TC09_Low_02_Alarm",
    "TC09_Low_01_Alarm"
    ]
    """

  Scenario: Alarm Queue with Prioritized by Severity off
    Given User executes test from "[props.CONFIGS_TC09_MULTI_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    When Alert "TC09_Low_01_Alarm" initiated on PM with 60 seconds timeout
    When Alert "TC09_01_Alarm" initiated on PM with 60 seconds timeout
    When Alert "TC09_Medium_01_Alarm" initiated on PM with 60 seconds timeout
    When Alert "TC09_Medium_02_Alarm" initiated on PM with 60 seconds timeout
    When Alert "TC09_Low_02_Alarm" initiated on PM with 60 seconds timeout
    When Alert "TC09_02_Alarm" initiated on PM with 60 seconds timeout
    And AC: User is logged in with default filter applied
    When AC: User sets Prioritize by Severity to unchecked on Alarm Queue panel
    And API: Wait until the alert is processed by Flight Manager
    And AC: User wait until "TC09_02_Alarm" alert appears in Alarm Queue panel
    And AC: User verifies the order of items on Alarm Queue panel
    """
    [
    "TC09_02_Alarm",
    "TC09_Low_02_Alarm",
    "TC09_Medium_02_Alarm",
    "TC09_Medium_01_Alarm",
    "TC09_01_Alarm",
    "TC09_Low_01_Alarm"
    ]
    """
    When Alert "TC09_03_Alarm" initiated on PM with 60 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    And AC: User verifies the order of items on Alarm Queue panel
     """
    [
    "TC09_03_Alarm",
    "TC09_02_Alarm",
    "TC09_Low_02_Alarm",
    "TC09_Medium_02_Alarm",
    "TC09_Medium_01_Alarm",
    "TC09_01_Alarm",
    "TC09_Low_01_Alarm"
    ]
    """
  @ISSUE:XXXX-2290
  Scenario: Alarm in Alarm Queue remains selected after Prioritized by Severity change
    Given User executes test from "[props.CONFIGS_TC09_MULTI_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    When Alert "TC09_Low_01_Alarm" initiated on PM with 60 seconds timeout
    And AC: User is logged in with default filter applied
    And AC: User clicks the "TC09_Low_01_Alarm" alert details in Alarm Queue panel
    Then AC: User verifies that the alert details panel is opened
    When AC: User sets Prioritize by Severity to unchecked on Alarm Queue panel
    Then AC: User verifies that the alert details panel is opened
    And AC: User verifies that "TC09_Low_01_Alarm" alert card is highlighted in Alarm Queue panel
