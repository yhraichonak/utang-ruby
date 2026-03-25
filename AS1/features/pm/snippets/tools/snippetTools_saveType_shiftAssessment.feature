@regression @automated @core @TMS:329220
Feature: Snippet Tools - Save shift assessment - Provide Snippet type to Server for PDF

  NOTE: SQL for snippet type on snippetDocument table

  SELECT *
  FROM [utangServer].[dbo].[SnippetDocument]
  Where [SnippetType] = 2

  Description
  Snippet Document Edit Page - "Snippet Type" selector can allow for "Shift Assessment" option to display when configured
  If snippet Type dropdown is configured for display AND the user has accessed Snippets from Patient Monitor (not a worklist)
  AND "show Shift Assessment" selection is configured for display:

  "Shift Assessment" will appear as a selection in the dropdown selector in the Snippet document edit page
  (when dropdown configured for display - otherwise "Event Descrption" text displays with no dropdown

  It is expected that selecting "Shift Assessment" from the dropdown will NOT mark any item on a worklist as complete
  at this time; however, labels associated with Shift Assessment selection should still appear on the PDF.

  ADHOC, Baseline (Conditional), Event, and Shift Assessment will display as selections

  If snippet type dropdown is configured for display and the user has accessed Snippets from PM (not a worklist) and
  "show Shift Assessment" is NOT configured for display:

  Only ADHOC, Baseline (Conditional), and Event will display as options.

  client server config
  pm {
  "showShiftAssessment": true,
  }

  TestRail Id: C329220

  Jira Epic:

  Jira Stories: AS1-2055, AS1-3528

  Jira Bugs/Defects:

  Scenario: Snippet Tools - Save shift assessment set to False
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    Then I should see the patient list screen
    When I click "Census" on the List
    Then I should see the patient list screen
    When I click on default patient in list without redirect
    Then I should see the Live Monitor screen
    When I click the "Tools" button in sub navigation menu
    Then I should see the Snippet Tool screen
    When I click the Create Snippet button
    Then I should see the Snippet Document Edit View
    And I should see the Description field with header "EVENT"
    And I should not see the snippet doc type "Shift Assessment" in dropdown when selected

  @pre_backup_server_config @post_restore_server_config @edit_server_config
  Scenario: Snippet Tools - Save shift assessment set to True - Provide Snippet type to Server for PDF
    Given User restores test environment config.json file from "AS1/wc_329220_config.json"
    And restart WebClient service
    And clear browser cache and reload
    And I am a super user with all permissions
    When I login to a testSite with a valid credential
    Then I should see the patient list screen
    When I click "Census" on the List
    Then I should see the patient list screen
    When I click on default patient in list without redirect
    Then I should see the Live Monitor screen
    When I click the "Tools" button in sub navigation menu
    Then I should see the Snippet Tool screen
    When I click the Create Snippet button
    Then I should see the Snippet Document Edit View
    And I should see the Description field with header "EVENT"
    When I click snippet doc type selector
    When I select snippet doc type of "Shift Assessment"
    Then I should see the Description field with header "Shift Assessment"

    When I click the Save button on Snippet Document Edit screen
    Then I see Snippet Saved notification window
    When I click OK button Snippet Saved notification window
    Then I should see the Live Monitor screen
    When I click the Home icon
    Then I should see the patient list screen

    When I click "Snippet Worklist" on the List
    Then I should see the snippet worklist screen

    When I go to utangserverdb
    And I execute following query from description
    Then I should see the record of the snippetdocument saved with SnippetType equal to 3