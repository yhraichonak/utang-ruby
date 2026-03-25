@automated @TMS:582424  @general @regression @bvt
Feature: About Screen Application Info
  As an AS1 user
  I want to view the About screen
  So I can verify the Application Information

  TestRail Id: C582424

  Scenario: Verify the Application Information
    When I click the more options button then the About button
    And the Application Info should display
