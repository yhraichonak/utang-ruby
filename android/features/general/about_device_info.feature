@automated @TMS:582426  @general @regression @bvt
Feature: About Screen Device Info
  As an AS1 user
  I want to view the About screen
  So I can verify the Device Information

  TestRail Id: C582426

  Scenario: Verify the Device Information
    When I click the more options button then the About button
    And the Technical Support Info should display
