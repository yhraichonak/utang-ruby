@automated @TMS:40302  @pm @pm-monitor @regression @bvt
Feature: Monitor: Live Monitor
  As an AS1 user
  I want to view the Live Monitor
  So that I can make sure I can view the live monitor

  TestRail Id: C40302

  Scenario: Monitor: Live Monitor
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    When I click the AS1 button
    When I click "PM Census" on the List
    Then I should see the patient List
    When I click on default patient in list
    Then I should see the Live Monitor screen
