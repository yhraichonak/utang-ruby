@automated @TMS:40298  @pm @pm-events @regression @bvt
Feature: Events: PM Choose Time
  As an AS1 user
  I want to Choose Time
  So that I can make sure I can view the patient's monitor

  TestRail Id: C40298

  Scenario: Events: View PM Alarms by Choosing Time
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    When I click the AS1 button
    When I click "PM Census" on the List
    Then I should see the patient List
    When I click on default patient in list
    Then I should see the Live Monitor screen
    When I click on the jump to button on the Live Monitor Screen
    Then I should see the time chooser window
    When I "decrease" the hours by "1" hours
    When I "decrease" the minutes by "2" minutes
    And I click the OK button on the time chooser window
    Then I should see the LIVE MONITOR screen
