@atc @automated @critical @atc_ad
@atc_smoke @EPIC:AirCommand @FEATURE:AlarmQueue
@TMS:586330 @clear_atc_flights
Feature: ad_alarm_queue_patient_cell
  As an Air Command User
  I want to view the Alarm queue patient cell
  So that I verify its display

  XXXX-1565
  - A user shall be able to see the flight chicklets once units have been selected.
    Alarm Queue - Chicklets
    Should display the following:
  - alarm icon (high, medium, low) on top left
  - alarm name
  - Patient Name (last name, first name)
  - Patient and date of birth mm/dd/yyyy MRN
  - Unit and room, and bed number (room and bed number concatenated with a hyphen (-) into one)
  - Facility Name
  - Time of alarm when it starts, out of a 24 hour clock to the seconds (Example: 08:13:52)
  - Time alarm has been active to the seconds (Example: 04:15)

  TestRail Id: C586330

  Jira Stories: XXXX-1565

  Jira Bugs/Defects: XXXX-1403

  Background:
    Given User executes test from "[props.CONFIGS_TC01A_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    When Alert "TC01a_Alarm" initiated on PM with 100 seconds timeout

  Scenario: Alert Dispatch Alarm Queue - Patient Cell Display
    When AC: User is logged in with default filter applied
    And API: Wait until the alert is processed by Flight Manager
    Then AC: User should see all UI elements in the Alarm Queue Chicklet for the generated flight
