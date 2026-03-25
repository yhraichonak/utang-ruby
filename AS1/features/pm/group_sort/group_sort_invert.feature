@regression @automated @core @pm @pm-group_sort
Feature: Group Sort Invert Function
  I want to be able to group and sort the patients in the patient list
  Using the Invert function

  Scenario: Group Sort Invert Function
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    When I click "Census" on the List
    Then I should see the patient list screen
    When I click on Group/Sort link
    Then I should see the Group/Sort window
    When I click on Group By dropdown and select "Bed"
    And I click on the Group By invert button
    And I click the ok button on Group / Sort window
    Then I should see the patient list screen
    Then I should see the patient list grouped by "Bed" and inverted
    When I click on Group/Sort link
    Then I should see the Group/Sort window
    When I click on Group By dropdown and select "None"
    And I click on first Sort By dropdown and select "Bed"
    And I click on the first Sort By invert button
    And I click the ok button on Group / Sort window
    Then I should see the patient list screen
    When I click on Group/Sort link
    Then I should see the Group/Sort window
    When I click on Group By dropdown and select "None"
    And I click on first Sort By dropdown and select "None"
    And I click on second Sort By dropdown and select "Bed"
    And I click on the second Sort By invert button
    And I click the ok button on Group / Sort window
    Then I should see the patient list screen
    When I click on Group/Sort link
    And I click the reset button on Group / Sort window
    Then I should see the patient list screen