@atc @automated @el @critical @atc_at
@EPIC:FlightTracker @FEATURE:FlightDetails
@clear_atc_flights
@TMS:586321
Feature: at_flight_details_panel
  As a Alert Tracker user
  I want to be able to view and interact with the Flight Detail Panel
  So that I can confirm it contains the information and access needed

  XXXX-890
  Display Destinations on Flight Status Panel:
  The UI should display:
  -The alert details at the top of the window, includes:
  -Alarm icon and Alarm name

  Below the Alarm details:
  -Patient Name (last, first)
  -DOB (DOT separator) Patient MRN

  Hospital Name (DOT separator) Unit - Room shall be right aligned in the patient cell
  "Alert Time: HH:MM:SS"
  Interaction
  -Flight Details Panel will appear on the right side of the screen when a user clicks directly on a chicklet/flight
  -Focus Mode (Flight Details Panel)
  -Users will be able to tab through 3 focus modes: History, Audit and Monitor (Default "History) <-[audit portion is depricated per XXXX-2022]
  -The user will be able to click back and forth between these tabs

  TestRail Id: C586321

  Jira Stories: XXXX-890

  Jira Bugs/Defects: XXXX-1144

  Scenario: Alert Tracker - Flight Details Panel Display
  And User executes test from "[props.CONFIGS_TC09_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
  When Alert "TC09_Alarm" initiated on PM with 100 seconds timeout
  And FT: User is logged in with default filter applied
   And API: Wait until the alert is processed by Flight Manager
   When FT: User opens the generated alert details
   Then FT: User verifies that the alert details panel is opened
   And FT: User verifies that the alert details has matching text
  """
  (?m).*TC09_Alarm.*Smith, Jim.06/01/2000.2233441.Facility1.ICU3.ICU3-B890.\d\d:\d\d:\d\d.*
"""
   And AC: User verifies that the alert details has tab History active
   And AC: User verifies that the alert details has matching text
  """
 (?m).*FlightInitialSuspenseStart.Initial.Suspense.started.*Timeout.*\d\d\d\d-\d\d-\d\dT\d\d\:\d\d\:\d\d-\d\d\:\d\d.\d\d/\d\d/\d\d\d\d.\d\d\:\d\d\:\d\d.*
 .*NewFlightCreated.*AlarmId.*
"""
   When AC: User opens Monitor tab of the alert details panel
   Then AC: User verifies that the alert details has tab Monitor active
   And AC: User verifies that monitor is displayed on the alert details