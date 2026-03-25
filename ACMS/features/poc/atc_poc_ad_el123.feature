@automated @poc @el @poc @critical @atc_at
@EPIC:FlightTracker @FEATURE:Escalate
@clear_atc_flights
Feature: POC ATC Escalation

  Scenario: AC - EL1-2-3 - Ignore - Escalate - Process Alert
    Given The default flight plan is configured in ATC
    When Alert "ATEVENT5" initiated on PM and processed by Flight Manager
    And AC: User is logged in with default filter applied
    And API: Wait until the flight status is Complete by Flight Manager for 35 seconds
    And AC: User waits until the generated alert is present in Alerts panel
    And AC: User opens the generated alert details in Alerts panel
    And AC: User opens History tab of the alert details panel
    Then AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated.*To Level.1.*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated.*To Level.2.*Reason.*EscalationTimeout.*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated.*To Level.2.*Reason.*EscalationTimeout.*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*Escalate Received.*From.autoescalate.*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*Flight Escalated.*To Level.3.*Reason.*EscalationResponse.*"
    And AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*Accept Received.*From.autoaccept.*"


