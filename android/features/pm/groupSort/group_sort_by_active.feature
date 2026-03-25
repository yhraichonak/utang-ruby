@regression @jenkins_pm @pm @pm-group_sort
Feature: Group Sort by Active
  I want to be able to group and sort the patients in the patient list
  Using the Active menu option

  Scenario: Group Sort by Active
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    When I click the AS1 button
    When I click "PM Census" on the List
    Then I should see the patient List
    When I click the group sort button
    Then I should see the group sort window
    When I click the group by dropdown and select "Active"
    And I click the group sort ok button
#    Then I should see the patient list grouped by "Active"
#    Then I should see the patient List
#    When I click on Group/Sort link
#    Then I should see the Group/Sort window
#    When I click on Group By dropdown and select "None"
#    And I click on first Sort By dropdown and select "MRN"
#    And I click the ok button on Group / Sort window
#    Then I should see the patient List
#    When I click on Group/Sort link
#    And I click the reset button on Group / Sort window
#    Then I should see the patient List