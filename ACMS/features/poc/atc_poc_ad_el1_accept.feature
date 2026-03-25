@automated @poc @el @critical @atc_ad
@EPIC:AirCommand @FEATURE:Escalate
@clear_atc_flights
Feature: POC ATC Escalation

 Background:
   Given The default flight plan is configured in ATC
   And AC: User is logged in with default filter applied

  Scenario: AC - EL1 - Accept alert
    When Alert "ATEVENT2" initiated on PM with 4 seconds timeout and processed by Flight Manager
    And API: Wait until the flight status is Complete by Flight Manager
    And AC: User waits until the generated alert is present in Alerts panel
    And AC: User opens the generated alert details in Alerts panel
    And AC: User opens History tab of the alert details panel
    Then AC: User verifies that the alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*FlightComplete.*Reason.Cancellation Suspend ended.*"
    And AC: User waits until alert details panel has event matching ".*[props.ACMS_TIMESTAMP_REGEXP].*AcceptReceived.*Accept Received. From.autoaccept.*"


