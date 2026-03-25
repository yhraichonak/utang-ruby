@automated @poc @el @critical @atc_ad
@EPIC:AirCommand @FEATURE:Escalate
@clear_atc_flights
Feature: POC ATC Escalation

 Background:
   Given The default flight plan is configured in ATC
   And AC: User is logged in with default filter applied

  Scenario: AC - EL1 - Escalate alert
    When Alert "ATEVENT3" initiated on PM with 15 seconds timeout and processed by Flight Manager
    And AC: User waits until the generated alert is present in Alerts panel
    And AC: User opens the generated alert details in Alerts panel
    And AC: User opens History tab of the alert details panel
    Then AC: User waits until alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*NotificationSent.*Notification Sent. Destination.AT_Dest_Escalate_Rec.*"
    And AC: User waits until alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*EscalateReceived.*Escalate Received. From.autoescalate.*"
    And AC: User waits until alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightEscalated.*Flight Escalated. To Level.2, Reason. EscalationResponse.*"


