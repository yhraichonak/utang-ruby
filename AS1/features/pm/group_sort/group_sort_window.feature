@regression @automated @core @pm @pm-group_sort
Feature: Group Sort Window
  I want to be able to verify that each component of the
  Group sort window is functioning properly

  Scenario: Group Sort Window
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    When I click "Census" on the List
    Then I should see the patient list screen
    When I click on Group/Sort link
    Then I should see the Group/Sort window
    And I should see all the group sort components displaying correctly
    When I click the cancel button on Group / Sort window
    Then I should see the patient list screen
    When I click on Group/Sort link
    Then I should see the Group/Sort window
    When I click outside the Group / Sort window
    Then I should see the patient list screen