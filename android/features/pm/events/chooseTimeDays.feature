@automated @TMS:181124  @pm @pm-events @regression @bvt
Feature: Events: PM Choose Time Days
  As an AS1 user
  I want to Choose Time by days
  So that I can make sure I can view the patient's monitor

  TestRail Id: C181124

  Scenario: Events: View PM Alarms by Choosing Time by Days
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    When  I click the AS1 button
    When  I click "PM Census" on the List
    Then  I should see the patient List
    When I click on default patient in list
    Then  I should see the Live Monitor screen
    When  I click on the jump to button on the Live Monitor Screen
    Then  I should see the time chooser window
    When  I "decrease" the days by "1" days
    And   I click the OK button on the time chooser window
    Then  I should see the LIVE MONITOR screen
