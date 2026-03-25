@automated @TMS:582428  @general @regression @bvt
Feature: About Screen EU Auth Rep Info
  As an AS1 user
  I want to view the About screen
  So I can verify the EU Authorized Representative Information

  TestRail Id: C582428

  Scenario: Verify the EU Authorized Representative Information
    When I click the more options button then the About button
    And the EU Authorized Representative Info should display
