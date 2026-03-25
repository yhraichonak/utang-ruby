@automated @TMS:582429  @general @regression @bvt
Feature: About Screen AU Auth Rep Info
  As an AS1 user
  I want to view the About screen
  So I can verify the AU Authorized Representative Information

  TestRail Id: C582429

  Scenario: Verify the AU Authorized Representative Information
    When I click the more options button then the About button
    And the AU Authorized Representative Info should display
