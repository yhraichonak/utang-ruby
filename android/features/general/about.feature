@automated @TMS:328932  @general
Feature: About
  As an AS1 user, I can view the About screen

  TestRail Id: C328932

  Scenario: Verify About Screen
    When I click the more options button then the About button
    And the Application Info should display
    And the Device Info should display
    And the Technical Support Info should display
    And the Manufactured By Info should display
    And the EU Authorized Representative Info should display
    And the AU Authorized Representative Info should display
    And I see the End User License Agreement link
