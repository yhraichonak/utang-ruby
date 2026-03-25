@automated @poc @queue @flights  @critical @atc_ad
@EPIC:AirCommand @FEATURE:Flight
@clear_atc_flights
Feature: POC ATC Flights

  Background:
    Given The default flight plan is configured in ATC
    And AC: User is logged in with default filter applied

  Scenario: AC - Alarm Queue List - Flights List
    When Alert "ATEVENT0" initiated on PM and processed by Flight Manager
    And AC: User verifies the generated alert is present in Alarm Queue panel with attributes
  """
  { "alarm-label":"ATEVENT0", "alarm-severity-icon":"[props.ACMS_ALARM_SEVERITY]", "name":"matches:.*", "date-of-birth":"matches:.*",
    "facility":"Facility1","unit":"[props.ACMS_UNIT]", "room-and-bed":"[props.ACMS_UNIT]-[props.ACMS_ROOM]",
    "flight-date":"matches:[props.ACMS_TIME_REGEXP]", "elapsed-time":"matches:[props.ACMS_DURATION_REGEXP]",  "flight-status-section":"matches:.*SUSPENDED.*"}
  """
    Then AC: User verifies the generated alert is present in Alerts panel with attributes
  """
  { "alarm-label":"ATEVENT0", "alarm-severity-icon":"[props.ACMS_ALARM_SEVERITY]", "name":"matches:.*", "date-of-birth":"matches:.*",
    "facility":"Facility1","unit":"[props.ACMS_UNIT]", "room-and-bed":"[props.ACMS_UNIT]-[props.ACMS_ROOM]",
    "flight-date":"matches:[props.ACMS_TIME_REGEXP]","elapsed-time":"matches:[props.ACMS_DURATION_REGEXP]",  "flight-status-section":"matches:.*WAITING.*"}
  """
