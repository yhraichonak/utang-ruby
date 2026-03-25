@automated @poc @flights @critical @atc_at @EPIC:FlightTracker @FEATURE:Flight
@clear_atc_flights
Feature: POC ATC Flights

  Background:
    Given The default flight plan is configured in ATC
    And FT: User is logged in with default filter applied

  Scenario Outline: FT - Flights List
    When Alert "<alarm_text>" initiated on PM and processed by Flight Manager
    Then FT: User verifies the generated alert is present in alerts table with attributes
  """
  { "Alarm Label":"<alarm_text>", "Patient Name":"matches:.*", "Unit":"[props.ACMS_UNIT]",
    "Room":"[props.ACMS_UNIT]-[props.ACMS_ROOM]", "Start Date":"matches:[props.ACMS_DATE_REGEXP]",
    "Start Time":"matches:[props.ACMS_TIME_REGEXP]", "End Time":"matches:.*",  "Total Time":"matches:[props.ACMS_TIME_REGEXP]"}
  """
    And FT: User verifies the generated alert is present in alerts table with attributes "{"Delivered":"matches:(true|false)"}"
    And FT: User verifies the generated alert is present in alerts table with attributes "{"Accepted":"false"}"
    And FT: User verifies the generated alert is present in alerts table with attributes "{"Severity":"[props.ACMS_ALARM_SEVERITY]"}"
    Examples:
      | alarm_text |
      | ATEVENT1   |

