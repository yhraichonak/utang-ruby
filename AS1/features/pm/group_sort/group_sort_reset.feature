@regression @automated @core @pm @pm-group_sort
Feature: Group Sort Reset Button
  I want to be able to verify that the group sort reset button
  Functions as expected

  Scenario: Group Sort Reset Function
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    When I click "Census" on the List
    Then I should see the patient list screen
    When I click on Group/Sort link
    Then I should see the Group/Sort window
    When I click on Group By dropdown and select "Age"
    And I click on first Sort By dropdown and select "MRN"
    And I click on second Sort By dropdown and select "Gender"
    And I click on the Group By invert button
    And I click on the first Sort By invert button
    And I click on the second Sort By invert button
    Then I should see the group sort components not at their default state
    When I click the reset button on Group / Sort window
    Then I should see the patient list screen
    When I click on Group/Sort link
    Then I should see the group sort components at their default state