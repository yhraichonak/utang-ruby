@atc @automated @critical @atc_at
@atc_smoke @EPIC:FlightTracker @FEATURE:Home
@TMS:586334 @clear_atc_flights
Feature: alertTracker_home
  As a Flight Tracker User
  I want to view the Flight Tracker dashboard
  So that I can verify the dashboard displays correctly

  XXXX-414
  - On Left of the title bar, Units and selected number of units should be displayed
  - On the center of the title bar, Flight Tracker application logo should be displayed

  XXXX-1599
  - As a user, when I successfully login, the home page and site name shall display.

  TestRail Id: C586287

  Jira Stories: XXXX-414, XXXX-1599

  Jira Bugs/Defects:

  Background:

  Scenario: Dashboard Display
    When FT: User is logged in with default filter applied
    Then User should see all UI header components
    And FT: User should see the Alerts List section

