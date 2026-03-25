@atc @automated @el @critical @atc_ad @flight_path
@EPIC:AirCommand @FEATURE:AutoCancel
@clear_atc_flights @TMS:584196
Feature: airDispatch_tc08_nonZeroAutoCancelWithInitialSuspend
  As an Air Traffic Controller user
  I want to generate a flight with one destination level, a non zero auto cancel timeout, and a non-zero initial suspend timeout that is larger than the auto cancel timeout
  So that I can verify that the flight will still be cancelled when the auto cancel timeout passes even though the flight is in the initial suspend state

  XXXX-###

  Test Notes: See https://utang.atlassian.net/wiki/spaces/ACMS/pages/3304816692/Setting+up+a+Flight+Plan+and+Generating+an+Alarm+Manually for location of
  flight plan configurations and instructions on how to execute configuration setup/alarm generation

  TestRail Id: C584196

  Jira Stories:

  Jira Bugs/Defects:

  Background:
    Given User executes test from "[props.CONFIGS_TC08_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    And AC: User is logged in with default filter applied

  Scenario: flight with one destination level, a non zero auto cancel timeout, and a non-zero initial suspend timeout that is larger than the auto cancel timeout
    When Alert "TC08_Alarm" initiated on PM with 60 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    Then AC: User verifies the generated alert is present in Alarm Queue panel
    Then AC: Flight alert status section is blue and has no-icon icon with label Suspended
    When API: Wait until the flight status is Complete by Flight Manager for 10 seconds
    Then AC: User verifies the generated alert is present in Alarm Queue panel
    And AC: Flight alert status section is grey and has no-icon icon with label Ended
    And AC: User sees the elapsed flight time on the flight entry stop at "0:10" within 3 second range
    When AC: User opens the generated alert details in Alarm Queue panel
    And AC: User opens History tab of the alert details panel
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*NewFlightCreated*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightInitialSuspenseStart. *Initial Suspense started.*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*AutoCancelTimeout.*"
    And Time difference between ".*[props.ACMS_TIMESTAMP_REGEXP].*NewFlightCreated*" and ".*[props.ACMS_TIMESTAMP_REGEXP].*AutoCancelTimeout.*" is 10 seconds
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightComplete. *Reason:AutoCancelTime expired.*"
    And Time difference between ".*[props.ACMS_TIMESTAMP_REGEXP].*NewFlightCreated*" and ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightComplete.*Reason:AutoCancelTime expired.*" is 10 seconds


