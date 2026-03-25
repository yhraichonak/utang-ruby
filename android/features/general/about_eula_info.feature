@automated @TMS:582430  @general @regression @bvt
Feature: About Screen EULA Info
  As an AS1 user
  I want to view the About screen
  So I can verify the EULA Information

  TestRail Id: C582430

  Scenario: Verify the End User License Agreement Information
    When I click the more options button then the About button
    And I see the End User License Agreement link
