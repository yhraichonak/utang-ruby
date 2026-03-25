@atc_api @automated @el @critical
@EPIC:API @FEATURE:InitialSuspend
@clear_atc_flights @TMS:584199
Feature: api_tc11_nonZeroInitialSuspendWithNoStart

  Scenario: flight with a non-zero initial suspend value where the "Start" button is not pressed
    Given User executes test from "[props.CONFIGS_TC11_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    When Alert "TC11_Alarm" initiated on PM with 60 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    And API: Wait until the flight status is Escalated by Flight Manager for 30 seconds
    And API: Verify the difference between event "NewFlightCreated" and event "EscalationLevel:1" is 30 seconds within 2 seconds range
