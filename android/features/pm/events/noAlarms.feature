@automated @TMS:40300  @pm @pm-events @regression @bvt
Feature: Events: No Alarms
  As an AS1 user
  I want view No Alarms
  So that I can make sure I can view no alarms

  TestRail Id: C40300

  Scenario: Events: View No Alarms
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    When I click the AS1 button
    When I click "PM Census" on the List
    Then I should see the patient List
    When I click on "[props.NEP_FULL_NAME]" in patient list
    Then I should see the Live Monitor screen
    When I click on the Events button
    Then I should see the PM Events screen with no events
