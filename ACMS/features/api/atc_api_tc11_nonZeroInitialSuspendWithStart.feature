@atc_api @automated @el @critical
@EPIC:API @FEATURE:InitialSuspend
@clear_atc_flights @TMS:584200
Feature: api_tc11_nonZeroInitialSuspendWithStart

  Scenario: flight with a non-zero initial suspend value where the "Start" button is clicked before the Initial Suspend timeout is reached
    Given User executes test from "[props.CONFIGS_TC11_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    When Alert "TC11_Alarm" initiated on PM with 60 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    And API: Verify the flight attribute "status" has value "InitialSuspense"
    When API: User manually starts the flight
    Then API: Verify the flight has event "NewFlightCreated"
    And API: Verify the flight has event "FlightInitialSuspenseStart"
    And API: Verify the flight has event "NewFlightCreated"
    And API: Verify the flight has event with attributes '{"message":"EscalationLevel:1; Reason:ManualEscalation"}'
