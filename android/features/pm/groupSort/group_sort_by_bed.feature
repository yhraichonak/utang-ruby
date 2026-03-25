@automated @TMS:262731  @pm @pm-group_sort @regression @bvt
Feature: Group Sort: Bed
  I want view the PM Patient list with a a group or sort
  So that I can make sure I can view the patient's by group and sort

  TestRail Id: C262731

  Scenario: Group Sort: Sort By Bed
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    When I click the AS1 button
    When I click "PM Census" on the List
    Then I should see the patient List
    When I click the unit filter button
    Then I should see the unit filter window
    When I click the unit filter toggle all button on
    And I click the unit filter ok button
    Then I should see the patient List

    When I click the group sort button
    Then I should see the group sort window
    And I click the group sort reset button
    And I click the group sort ok button
    Then I should see the patient List

    When I click the group sort button
    Then I should see the group sort window
    When I click the group by dropdown and select "Bed"
    And I click the group sort invert button
    And I click the group sort ok button
    Then I should see the patient List
    When I click on the first patient
    Then I should see the Live Monitor screen
    When I click hardware back button
    Then I should see the patient List

#   Section below is duplicate of above. Risk of reliability issues.
#
#    When I click the group sort button
#    Then I should see the group sort window
#    And I click the group sort reset button
#    When I click the group by dropdown and select "Bed"
#    And I click the group sort ok button
#    Then I should see the patient List
#    When I click on "GRN5, GRN5" in patient list
#    Then I should see the Live Monitor screen
#    When I click hardware back button
#    Then I should see the patient List
