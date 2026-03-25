@atc @automated @el @critical @atc_at @flight_path
@EPIC:FlightTracker @FEATURE:EscalationResponse
@clear_atc_flights @TMS:584248
Feature: atc_tc13_ft_escalationsEscalateResponse
  As an Air Traffic Controller user
  I want to generate a flight with three destination levels and escalations for each level that come from escalate responses received from recipients
  So that I can verify that the alarm is auto escalated properly for each defined destination

  XXXX-###

  Test Notes: See https://utang.atlassian.net/wiki/spaces/ACMS/pages/3304816692/Setting+up+a+Flight+Plan+and+Generating+an+Alarm+Manually for location of
  flight plan configuration and instructions on how to execute configuration setup/alarm generation

  TestRail Id: C584248

  Jira Stories:

  Jira Bugs/Defects:
  Background:
    Given User executes test from "[props.CONFIGS_TC13_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    And FT: User is logged in with default filter applied

  Scenario: flight with autoaccept recipients set, notifications are received and alarms escalated appropriately
    When Alert "TC13_Alarm" initiated on PM with 60 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    And FT: User waits unit the generated alert is present in alerts table with attributes "{ "Alarm Label":"TC13_Alarm", "End Time":"", "Delivered":"false", "Accepted":"false"}"
    And FT: The "Total Time" field should be populated with an incrementing time elapsed label
    And API: Wait until the flight status is Escalated by Flight Manager for 30 seconds
    And FT: User waits unit the generated alert is present in alerts table with attributes "{ "Alarm Label":"TC13_Alarm", "End Time":"", "Delivered":"true", "Accepted":"false"}"
    And API: Wait until the flight status is Complete by Flight Manager for 60 seconds
    And FT: User sees the "Total Time" on the flight entry stop at "1:00" within 5 second range
    When FT: User opens the generated alert details
    And FT: User opens History tab of the alert details panel
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*NewFlightCreated*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightInitialSuspenseStart. *Initial Suspense started.*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightInitialSuspenseEnd. *Flight initial suspend ended.*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*EscalateReceived*"*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated. To Level:2. *Reason: EscalationResponse.*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated. To Level:3. *Reason: EscalationResponse.*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightComplete.*"