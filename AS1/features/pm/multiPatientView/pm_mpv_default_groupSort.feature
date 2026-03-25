@automated @pm-multi_patient_view
Feature: Group Sort Default
  As a utang ONE user
  I want to view the Multi-Patient View screen
  So that I can verify the default group sort

  TestRail Id: C582861
  @TMS:582861
  Scenario: Group Sort Default
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    Then I should see the patient list screen
    When I click "Census" on the List
    Then I should see the patient list screen
    When I click on Group/Sort link
    Then I should see the Group/Sort window
    When I click the reset button on Group / Sort window
    Then I should see the patient list screen
    When I click on Filter Units link
    Then I should see the Filter Units window
    When I click the Toggle All button on Filter Units window
    When I click on "5E" filter unit switch to "enable" button
    And I click Ok button in Filter Units window
    Then I should see the patient list screen
    And I should see the PM patient list grouped by unit and sorted by bed
    When I click the Multi-Patient View button in header
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I should see default sort by Bed left to right then top to bottom
    When I click on Group/Sort link
    Then I should see the Group/Sort window
    And Group by should have Unit selected
    And Sort by should have Bed selected
    When I click the reset button on Group / Sort window
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    When I click on Filter Units link
    Then I should see the Filter Units window
    When I click the Toggle All button on Filter Units window
    And I click Ok button in Filter Units window
