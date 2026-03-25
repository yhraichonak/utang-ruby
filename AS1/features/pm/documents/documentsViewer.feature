@regression @documents @approval     @pm @pm-documents
Feature: PM - Snippet Rhythms Documents Viewer

  TestRail Id: C328920
  Jira Stories: AS1-2000, AS1-2001, AS1-197, AS1-2002, AS1-1998, AS1-1796, AS1-2278, AS1-2394, AS1-2457, AS1-2573, AS1-2623, AS1-2619, AS1-2698, AS1-2667, AS1-2864, AS1-2997
@critical @TMS:328920
  Scenario: PM - Snippet Rhythms Documents Viewer
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    Then I should see the patient list screen
    When I click "Census" on the List
    Then I should see the patient list screen
    When I click on "[props.DP_FULL_NAME]" in patient list
    Then I should see the patient summary screen
    And I should see the patient document tile
    And I should see patient snippet descriptions and date of snippet created
    When I click on the document tile
    Then I should see the Snippets Rhythms Documents screen
    And I should see Event Descriptions wrapping up to three lines
    And I should see No Documents message and No Documents selected
    And I should see Approval icons in document list
    When I select document item "1" in sidebar list
    Then I should see the document item "1" selected
    And the document should appear in viewer

    When I select document item "2" in sidebar list
    Then I should see the document item "2" selected
    And the document should appear in viewer

    When I select document item "3" in sidebar list
    Then I should see the document item "3" selected
    And the document should appear in viewer

    When I click the zoom "in" button on document viewer
    And I should see document viewer zoom correctly
    When I click the zoom "in" button on document viewer
    And I should see document viewer zoom correctly
    When I click the zoom "in" button on document viewer
    And I should see document viewer zoom correctly

    When I click the zoom "out" button on document viewer
    And I should see document viewer zoom correctly
    When I click the zoom "out" button on document viewer
    And I should see document viewer zoom correctly
    When I click the zoom "out" button on document viewer
    And I should see document viewer zoom correctly

    When I click the page fit button on document viewer
    And I should see document viewer zoom correctly
    When I click the page fit button on document viewer
    And I should see document viewer zoom correctly

    When I scroll "down" on the document list
    And I should see the document list scroll correctly
    When I scroll "up" on the document list
    And I should see the document list scroll correctly

    When I scroll "down" on the document viewer
    And I should see the document viewer scroll correctly
    When I scroll "up" on the document viewer
    And I should see the document viewer scroll correctly

    When I click the zoom "in" button on document viewer
    And I should see document viewer zoom correctly
    When I click the zoom "in" button on document viewer
    And I should see document viewer zoom correctly

    When I scroll "right" on the document viewer
    And I should see the document viewer scroll correctly
    When I scroll "left" on the document viewer
    And I should see the document viewer scroll correctly

    When I click the "Documents" link in main navigation menu
    Then I should see the Snippets Rhythms Documents screen
    And I should see Event Descriptions wrapping up to three lines
    And I should see No Documents message and No Documents selected
    And I should see Approval icons in document list