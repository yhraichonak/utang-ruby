@automated @TMS:582491  @regression @bvt
Feature: General List of Lists Display and Navigation
  As an AS1 user
  I want to be able to view and navigate through the list of lists

  TestRail Id: C582491

  Scenario: List of Lists Navigation - Android
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    Then I should see the AS1 main menu button in the Open state
    And I click the AS1 button
    Then I should see my ListOfList window
    And I should see the AS1 main menu button in the Closed state
    And I should see the refresh button on the List of Lists
    When I click the refresh button in List of List menu
    And I should see my ListOfList window refresh
#    When I click the AS1 button
    And I click the List of Lists back button
    Then I should see the AS1 main menu button in the Open state
    When I click the AS1 button
    And I click "Census" in List of List menu
    Then I should see the patient List
