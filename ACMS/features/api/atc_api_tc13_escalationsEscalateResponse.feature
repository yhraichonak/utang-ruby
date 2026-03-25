@atc_api @automated @el @critical
@EPIC:API @FEATURE:EscalationResponse
@clear_atc_flights @TMS:584244
Feature: api_tc13_escalationsEscalateResponse

  Scenario: flight with autoaccept recipients set, notifications are received and alarms escalated appropriately
    Given User executes test from "[props.CONFIGS_TC13_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    When Alert "TC13_Alarm" initiated on PM with 30 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    And API: Wait until the flight is escalated to level 0
    And API: Verify the flight attribute "status" has value "InitialSuspense"
    When API: User manually starts the flight
    And API: Wait until the flight is escalated to level 2
    And API: Wait until the flight status is Complete by Flight Manager for 30 seconds
     And API: Verify flight entry stopped in 30 seconds within 3 second range
    Then API: Verify the flight has event "NewFlightCreated"
    Then API: Verify the flight has event "Event: Flight initial suspend ended"
    Then API: Verify the flight has event ".*FlightEscalated.*EscalationLevel:2.*"
    Then API: Verify the flight has event "FlightComplete"
