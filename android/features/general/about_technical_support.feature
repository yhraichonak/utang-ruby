@automated @TMS:582425  @general @regression @bvt
Feature: About Screen Technical Support Info
  As an AS1 user
  I want to view the About screen
  So I can verify the Technical Support Information

  TestRail Id: C582425

  Scenario: Verify the Technical Support Information
    When I click the more options button then the About button
    And the Technical Support Info should display
