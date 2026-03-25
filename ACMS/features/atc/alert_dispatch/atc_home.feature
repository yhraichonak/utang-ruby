@atc @automated @critical @atc_ad
@atc_smoke @EPIC:AirCommand @FEATURE:Home
@TMS:586334 @clear_atc_flights
Feature: airDispatch_home
  As an Air Commander User
  I want to view the Air Command dashboard
  So that I can verify the dashboard displays correctly

  XXXX-1557
  - The application shall display the main components (Home page, units, site name, utang logo, aircommand logo, alarm queue, alert panel) when a user logs in.

  TestRail Id: C586337

  Jira Stories: XXXX-1557

  Jira Bugs/Defects:

  Background:

  Scenario: Dashboard Display
    When AC: User is logged in with default filter applied
    Then User should see all UI header components
    And AC: User should see the Alarm Queue and Alerts sections