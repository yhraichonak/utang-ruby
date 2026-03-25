@automated @poc @el @poc @critical @atc_at
@EPIC:FlightTracker @FEATURE:Escalate
@clear_atc_flights
Feature: POC ATC Escalation
#    Service tags
#      - @clear_atc_db - Before hook for cleaning ALL the content from ATC DB. All the objects (FlightPlans/Units/Recipients/Destinations) should be created
#      - @clear_atc_flights - Before hook for clearing Alert and Flights - specific data. All infrastructure objects preserved.
#      - @restart_atc_apppools - Stop and STart all Apppols in ACMS

  Background:
    Given The default flight plan is configured in ATC
    And FT: User is logged in with default filter applied

  Scenario: FT - EL1-2-3 - Ignore - Escalate - Process Alert
    When Alert "ATEVENT5" initiated on PM and processed by Flight Manager
    And API: Wait until the flight status is Complete by Flight Manager for 35 seconds
    And  FT: User waits unit the generated alert is present in alerts table with attributes "{"End Time":"matches:.*[props.ACMS_TIME_REGEXP]"}"
    Then  FT: User verifies the generated alert is present in alerts table with attributes "{ "Alarm Label":"ATEVENT5", "Delivered":true, "Accepted":"true"}"
    And FT: User opens the generated alert details
    And FT: User opens History tab of the alert details panel
    Then FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated.*To Level.1.*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated.*To Level.2.*Reason.*EscalationTimeout.*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated.*To Level.2.*Reason.*EscalationTimeout.*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*Escalate Received.*From.autoescalate.*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated.*To Level.3.*Reason.*EscalationResponse.*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*Accept Received.*From.autoaccept.*"


