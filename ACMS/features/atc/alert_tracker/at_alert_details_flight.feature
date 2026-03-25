@atc @automated @el @critical @atc_at
@EPIC:FlightTracker @FEATURE:FlightDetails
@clear_atc_flights
@TMS:586319
Feature: at_alert_details_flight
  As a Alert Tracker user
  I want to view flight details on alert rows
  So that I can confirm the needed information is present

  XXXX-1574
  - As a user, I shall see alert flight details of existing alert on a row.

  TESTING NOTES:
  How-To create an alert flight - https://utang.atlassian.net/wiki/spaces/ACMS/pages/3304816692/Setting+up+a+Flight+Plan+and+Generating+an+Alarm+Manually

  TestRail Id: C586319

  Jira Stories: XXXX-1574

  Jira Bugs/Defects: XXXX-1325, XXXX-1760

  Scenario: Display alert flight details of existing alert on row
  Given User executes test from "[props.CONFIGS_TC01A_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
  And FT: User is logged in with default filter applied
  When Alert "TC01a_Alarm" initiated on PM with 40 seconds timeout
  And API: Wait until the alert is processed by Flight Manager
  When FT: User opens the generated alert details
  Then FT: User verifies that the alert details panel is opened
  And FT: User verifies that the alert details has matching text
  """
  (?m).*TC01a_Alarm.*Smith, Jim.06/01/2000.2233441.Facility1.ICU3.ICU3-B890.\d\d:\d\d:\d\d.*
"""
  And AC: User verifies that the alert details has tab History active
  And AC: User verifies that the alert details has matching text
  """
 (?m).*FlightInitialSuspenseStart.Initial.Suspense.started.*Timeout.*\d\d\d\d-\d\d-\d\dT\d\d\:\d\d\:\d\d-\d\d\:\d\d.\d\d/\d\d/\d\d\d\d.\d\d\:\d\d\:\d\d.*
 .*NewFlightCreated.*AlarmId.*
"""
  When AC: User opens Monitor tab of the alert details panel
  Then AC: User verifies that the alert details has tab Monitor active
  And AC: User verifies that monitor is displayed on the alert details