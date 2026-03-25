@automated @TMS:40297  @pm @pm-events @regression @bvt
Feature: Events: PM Alarms
  As an AS1 user
  I want view a Patient's Alarms
  So that I can make sure I can view the patient's alarms

  TestRail Id: C40297

  Scenario: Events: View PM Alarms
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    When I click the AS1 button
    When I click "PM Census" on the List
    Then I should see the patient List
    When I click on default patient in list
    Then I should see the Live Monitor screen
    When I click on the Events button
    Then I should see the PM Events screen
