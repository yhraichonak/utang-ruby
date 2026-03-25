@regression @automated @core@patient_summary
Feature: Patient Details Header - single line min resolution
  Patient Details Header

  TestRail Id: C329219
  Jira Stories: AS1-2495, AS1-2931
@critical @TMS:329219
  Scenario: Patient Details Header - single line min resolution
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    Then I should see the patient list screen
    When I click "Census" on the List
    Then I should see the patient list screen
    When I see the browser resolution to "900" width by "600" height
    And I click the expand icon menu button
    Then I should see the expanded navigation links
    When I click the expand icon menu button
    Then I should not see the expanded navigation links
    When I click on default patient in list
    Then I should see the patient summary screen
    When I click the expand icon menu button
    Then I should see the expanded navigation links
    When I click the expand icon menu button
    Then I should not see the expanded navigation links
    When I click on the Monitor tile
    Then I should see the Live Monitor screen
    And I should see the pm patient info in the header
    When I click the "Tools" button in sub navigation menu
    Then I should see the Snippet Tool screen
    And I should see the pm patient info in the header
    When I click the "Events" button in sub navigation menu
    Then I should see the Events screen
    And I should see the pm patient info in the header