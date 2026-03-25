@automated @poc @el @critical @atc_at
@EPIC:FlightTracker @FEATURE:Escalate
@clear_atc_flights
Feature: POC ATC Escalation

  Background:
    Given The default flight plan is configured in ATC
    And FT: User is logged in with default filter applied

  Scenario: FT - EL1 - Escalate alert
    When Alert "ATEVENT3" initiated on PM with 10 seconds timeout and processed by Flight Manager
    Then  FT: User waits unit the generated alert is present in alerts table with attributes "{"End Time":"matches:.*[props.ACMS_TIME_REGEXP]"}"
    And FT: User opens the generated alert details
    And FT: User opens History tab of the alert details panel
#    Then FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*NotificationSent.*Notification Sent. Destination.AT_Dest_Escalate_Rec.*"
    Then FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*NotificationSent.*Notification Sent.*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*EscalateReceived.*Escalate Received. From.autoescalate.*"
    And FT: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightEscalated.*Flight Escalated. To Level.2, Reason. EscalationResponse.*"
