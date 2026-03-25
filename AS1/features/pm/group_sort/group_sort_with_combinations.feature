@regression @automated @core @pm @pm-group_sort
Feature: Group Sort with Combinations
  I want to be able to group and sort the patients in the patient list
  Using a combination of both the Group By and Sort menus

  Scenario: Group Sort With Combinations
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    When I click "Census" on the List
    Then I should see the patient list screen
    When I click on Group/Sort link
    Then I should see the Group/Sort window
    When I click on Group By dropdown and select "Active Inactive"
    And I click on first Sort By dropdown and select "Last Name"
    And I click the ok button on Group / Sort window
    Then I should see the patient list screen
#    Then I should see the screen grouped by Active and sorted by Last Name
    When I click on Group/Sort link
    Then I should see the Group/Sort window
    When I click on Group By dropdown and select "Active Inactive"
    And I click on first Sort By dropdown and select "Gender"
    And I click on second Sort By dropdown and select "Last Name"
    And I click the ok button on Group / Sort window
    Then I should see the patient list screen
#    Then I should see the screen grouped by Active and sorted by Gender, then Last Name
    When I click on Group/Sort link
    Then I should see the Group/Sort window
    When I click on Group By dropdown and select "None"
    And I click on first Sort By dropdown and select "Gender"
    And I click on second Sort By dropdown and select "Last Name"
    And I click the ok button on Group / Sort window
    Then I should see the patient list screen
#    Then I should see the screen sorted by Gender and then by Last Name
    When I click on Group/Sort link
    And I click the reset button on Group / Sort window
    Then I should see the patient list screen