@regression @doc_preview @manual @automated @core
Feature: PM - Snippet Document Preview - Date of Birth is not being passed when creating snippet

  Date of Birth is not being passed when creating snippet

  TestRail Id: C316550
  Jira Stories: MIG-302
  @network_logs
  @TMS:316550
  Scenario: PM - Snippet Document Preview - Date of Birth is not being passed when creating snippet
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    Then I should see the patient list screen
    When I click "Census" on the List
    Then I should see the patient list screen
    When I click on default patient in list without redirect
    Then I should see the Live Monitor screen
    When I click the "Tools" button in sub navigation menu
    Then I should see the Snippet Tool screen
    When I click on Measure button
    Then I should see the Measure button "active"
    When I click the Create Snippet button
    Then I should see the Snippet Document Edit View
    When I click the Preview button on Snippet Document Edit View
    Then I should see the Snippet Document Preview window
    Then I should see the Snippet Preview Document display DOB
