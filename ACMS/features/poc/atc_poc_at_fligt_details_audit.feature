@automated @poc @flight @critical @atc_at
@EPIC:FlightTracker @FEATURE:Flight
@clear_atc_flights
Feature: POC ATC Flights

  Background:
    Given The default flight plan is configured in ATC
    And FT: User is logged in with default filter applied


  Scenario: FT - Flight Details - Audit
    When Alert initiated on PM and processed by Flight Manager
    Then FT: User verifies the generated alert is present in alerts table
    And FT: User opens the generated alert details
    And FT: User opens History tab of the alert details panel
    Then FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*NewFlightCreated.*AlarmId:.*"

