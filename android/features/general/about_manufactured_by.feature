@automated @TMS:582427  @general @regression @bvt
Feature: About Screen Manufactured By Info
  As an AS1 user
  I want to view the About screen
  So I can verify the Manufactured By Information

  TestRail Id: C582427

  Scenario: Verify the Manufactured By Information
    When I click the more options button then the About button
    And the Manufactured By Info should display
