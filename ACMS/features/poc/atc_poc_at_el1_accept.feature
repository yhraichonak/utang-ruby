@automated @poc @el @clear_atc_flights @critical @atc_at
@EPIC:FlightTracker @FEATURE:Escalate
@clear_atc_flights
Feature: POC ATC Escalation

 Background:
    Given The default flight plan is configured in ATC
    And FT: User is logged in with default filter applied

  Scenario Outline: FT - EL1 - Accept alert
    When Alert "<alarm_text>" initiated on PM with <alarm_duration> seconds timeout and processed by Flight Manager
    And API: Wait until the flight status is Complete by Flight Manager
    Then  FT: User verifies the generated alert is present in alerts table with attributes "{ "Alarm Label":"<alarm_text>", "End Time":"matches:.*[props.ACMS_TIME_REGEXP]", "Delivered":"true", "Accepted":"true"}"
    And FT: User opens the generated alert details
    And FT: User opens History tab of the alert details panel
    Then FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightComplete.*Reason.Cancellation Suspend ended.*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*AcceptReceived.*Accept Received. From.autoaccept.*"
    Examples:
      | alarm_text | alarm_duration |
      | ATEVENT2   | 4              |

