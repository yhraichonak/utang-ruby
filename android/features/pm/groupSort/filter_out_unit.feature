@automated @TMS:262711  @pm @pm-group_sort
Feature: Group Sort: Filter Units
  I want view the PM Patient list with a unit based filter
  So that I can make sure I can view the patient's by unit

  TestRail Id: C262711

  # Note: Currently cannot verify filter due to missing data.

  Scenario: Group Sort: Filter Out All Units Except One
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    When I click the AS1 button
    When I click "PM Census" on the List
    Then I should see the patient List
    When I click the unit filter button
    Then I should see the unit filter window
    When I filter out all units except for "ATQA"
    And I click the unit filter ok button
    When I click on "[props.AP_FULL_NAME]" in patient list
    Then I should see the Live Monitor screen
    When I click hardware back button
    Then I should see the patient List
    When I click the unit filter button
    And I click the unit filter toggle all button on
    And I click the unit filter ok button
