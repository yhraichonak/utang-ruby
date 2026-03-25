@automated @poc @queue @flight @critical @atc_ad
@EPIC:AirCommand @FEATURE:Flight
@clear_atc_flights @history
Feature: POC ATC Flights

  Background:
    Given The default flight plan is configured in ATC
    And AC: User is logged in with default filter applied

   Scenario:  AC - Alarm Queue List - Flight Details - History
    When Alert "ATEVENT0" initiated on PM and processed by Flight Manager
    And AC: User waits until the generated alert is present in Alarm Queue panel
    And AC: User opens the generated alert details in Alarm Queue panel
    And AC: User opens History tab of the alert details panel
    Then AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*NewFlightCreated.*AlarmId:.*"

