@regression @automated @core @pm @pm-group_sort
Feature: Group Sort by Last Name
  I want to be able to group and sort the patients in the patient list
  Using the Last Name menu option

  Scenario: Group Sort by Last Name
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    When I click "Census" on the List
    Then I should see the patient list screen
    When I click on Group/Sort link
    Then I should see the Group/Sort window
    When I click on Group By dropdown and select "Last Name"
    And I click the ok button on Group / Sort window
    Then I should see the patient list screen
    Then I should see the patient list grouped by "Last Name"
    When I click on Group/Sort link
    Then I should see the Group/Sort window
    When I click on Group By dropdown and select "None"
    And I click on first Sort By dropdown and select "Last Name"
    And I click the ok button on Group / Sort window
    Then I should see the patient list screen
    When I click on Group/Sort link
    And I click the reset button on Group / Sort window
    Then I should see the patient list screen