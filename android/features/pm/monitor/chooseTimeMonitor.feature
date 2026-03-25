@automated @TMS:40301  @pm @pm-monitor @regression @bvt
Feature: Monitor: Choose Time Monitor
  As an AS1 user
  I want to choose time on the Monitor
  So that I can make sure I can choose a specific time

  TestRail Id: C40301

  Scenario: Monitor: Live Monitor Choose Time
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    When I click the AS1 button
    When I click "PM Census" on the List
    Then I should see the patient List
    When I click on default patient in list
    Then I should see the Live Monitor screen
    When I click on the jump to button on the Live Monitor Screen
    Then I should see the time chooser window
    When I "decrease" the hours by "5" hours
    When I "decrease" the minutes by "10" minutes
    And I click the OK button on the time chooser window
    Then I should see the LIVE MONITOR screen
