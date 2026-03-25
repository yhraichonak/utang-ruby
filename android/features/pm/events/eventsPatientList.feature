@automated @TMS:40299  @pm @pm-events @regression @bvt
Feature: Events: Events Patient List
  As an AS1 user
  I want view a Patient's Events
  So that I can make sure I can view the patient's events

  TestRail Id: C40299

  Scenario: Events: View Events from the Patient List
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    When I click the AS1 button
    When I click "PM Census" on the List
    Then I should see the patient List
    When I click on "[props.DP_FULL_NAME]" in patient list
    And I select the Events button on the patient list screen
    Then I should see the PM Events screen
