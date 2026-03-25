@atc @automated @critical @atc_ad
@atc_smoke @EPIC:AirCommand @FEATURE:AlarmsTooltipsWraps
@TMS:586358 @clear_atc_flights @restore_agregated_fp
Feature: ad_tooltips_and_wrap_text
  As an Alert Dispatch User
  I want a tooltip when information is truncated
  So that I can view the entire text

  XXXX-1535
  - As a user I shall be able to see the destination type of a flight id in alerts as a tool tip.
  - As a user I shall be able to see the destination type of a flight id in Flight Details as a tool tip.

  XXXX-1956
  In Alert Dispatch, under the Alerts Column, change "In Flight" to "Active". Attached is a screen shot for reference.

  XXXX-1555
  - Long patient info shall truncate and show tooltip for '<field>'
  - Long Location Information shall wrap.

  TESTING NOTES:
  - See https://utang.atlassian.net/wiki/spaces/ACMS/pages/3304816692/Setting+up+a+Flight+Plan+and+Generating+an+Alarm+Manually for location of flight plan configuration and instructions on how to execute configuration setup/alarm generation
  Flight Plan Configuration: TestConf_longPatientData.json
  .\createAlarm.ps1 -URL '10.106.5.72:8765' -Session 00002 -AlarmText Longdata_Alarm -Severity High -Duration 60
  - where 'Session' is the 'Long Patient Name' session id from PM Debugger

  TestRail Id: C586358

  Jira Stories: XXXX-1535, XXXX-1555, XXXX-1956

  Jira Bugs/Defects: XXXX-1342

  Background:
    Given User executes test from "[props.CONFIGS_TC_PROLONGED_NAMES_CONFIG]" file in ATC Integration Test Console and restore aggregated FP if present
    And AC: User is logged in with default filter applied

  Scenario: Alert Queue Patient Cell - long destination name is truncated and a tooltip displays
    When Alert initiated on PM with attributes
"""
  {"Session":"00004","AlarmText":"[props.ACMS_PROLONGED_ALERT]","Severity":"High","Duration":"120"}
"""
    And API: Wait until the alert is processed by Flight Manager
   And AC: User waits until the generated alert is present in Alerts panel
    And API: Wait until the flight is escalated to level 1
   Then AC: User sees flight entry with text matching
   """
(?m).*Level 1.*[props.ACMS_PROLONGED_DESTINATION1].*Escalates To.*[props.ACMS_PROLONGED_DESTINATION2].*
   """
   Then AC: User opens the generated alert details in Alerts panel
   Then AC: User verifies that the alert details panel is opened
   Then AC: User verifies that the alert details has matching text
      """
(?m).*[props.ACMS_PROLONGED_ALERT].*Level 1.*[props.ACMS_PROLONGED_DESTINATION1].*Escalates To.*[props.ACMS_PROLONGED_DESTINATION2].*
  """

  Scenario: Alarm Queue Patient Cell - long patient information is truncated and a tooltip displays
    When Alert initiated on PM with attributes
"""
  {"Session":"00004","AlarmText":"[props.ACMS_PROLONGED_ALERT_DELAYED]","Severity":"High","Duration":"90"}
"""
    And API: Wait until the alert is processed by Flight Manager
    And AC: User waits until the generated alert is present in Alarm Queue panel
    Then AC: User sees flight entry with text matching
   """
(?m).*[props.ACMS_PROLONGED_PATIENT].*
   """
    Then AC: User opens the generated alert details in Alarm Queue panel
    Then AC: User verifies that the alert details panel is opened
    Then AC: User verifies that the alert details has matching text
      """
(?m).*[props.ACMS_PROLONGED_PATIENT].*
  """

  Scenario: Alert Queue Patient Cell - long patient information is truncated and a tooltip displays
    When Alert initiated on PM with attributes
"""
  {"Session":"00004","AlarmText":"[props.ACMS_PROLONGED_ALERT]","Severity":"High","Duration":"90"}
"""
    And API: Wait until the alert is processed by Flight Manager
    And AC: User waits until the generated alert is present in Alerts panel
    Then AC: User sees flight entry with text matching
   """
(?m).*[props.ACMS_PROLONGED_PATIENT].*
   """
    Then AC: User opens the generated alert details in Alerts panel
    Then AC: User verifies that the alert details panel is opened
    Then AC: User verifies that the alert details has matching text
      """
(?m).*[props.ACMS_PROLONGED_PATIENT].*
  """

  Scenario: Alarm Queue Patient Cell - long location information text will wrap
    When Alert initiated on PM with attributes
"""
  {"Session":"00004","AlarmText":"[props.ACMS_PROLONGED_ALERT_DELAYED]","Severity":"High","Duration":"90"}
"""
    And API: Wait until the alert is processed by Flight Manager
    And AC: User waits until the generated alert is present in Alarm Queue panel
    Then AC: User sees flight entry with text matching
   """
(?m).*[props.ACMS_PROLONGED_FACILITY].*[props.ACMS_PROLONGED_UNIT].*[props.ACMS_PROLONGED_BED].*
   """
    Then AC: User opens the generated alert details in Alarm Queue panel
    Then AC: User verifies that the alert details panel is opened
    Then AC: User verifies that the alert details has matching text
      """
(?m).*[props.ACMS_PROLONGED_FACILITY].*[props.ACMS_PROLONGED_UNIT].*[props.ACMS_PROLONGED_BED].*
  """

  Scenario: Alert Queue Patient Cell - long location information text will wrap
    When Alert initiated on PM with attributes
"""
  {"Session":"00004","AlarmText":"[props.ACMS_PROLONGED_ALERT]","Severity":"High","Duration":"90"}
"""
    And API: Wait until the alert is processed by Flight Manager
    And AC: User waits until the generated alert is present in Alerts panel
    Then AC: User sees flight entry with text matching
   """
(?m).*[props.ACMS_PROLONGED_FACILITY].*[props.ACMS_PROLONGED_UNIT].*[props.ACMS_PROLONGED_BED].*
   """
    Then AC: User opens the generated alert details in Alerts panel
    Then AC: User verifies that the alert details panel is opened
    Then AC: User verifies that the alert details has matching text
      """
(?m).*[props.ACMS_PROLONGED_FACILITY].*[props.ACMS_PROLONGED_UNIT].*[props.ACMS_PROLONGED_BED].*
  """