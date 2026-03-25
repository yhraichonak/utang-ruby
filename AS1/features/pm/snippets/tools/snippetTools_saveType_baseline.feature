@regression @automated @core @pm @pm-snippets @pm-snippets-tools
Feature: Snippet Tools - Save Baseline - Provide Snippet type to Server for PDF


NOTE: SQL for snippet type on snippetDocument table

  SELECT *
  FROM [utangServer].[dbo].[SnippetDocument]
  Where [SnippetType] = 1

TestRail Id: C329180
Jira Stories: AS1-2055
@critical @TMS:329180
Scenario: Snippet Tools - Save Baseline - Provide Snippet type to Server for PDF
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
  When I click into the Event Description field
  When I select "NSR - Normal sinus rhythm" from Event Description dropdown
  When I select snippet doc type of "Admission Baseline"
  Then I should see the Description field with header "Admission Baseline"
  
  When I click the Save button on Snippet Document Edit screen
  Then I see Snippet Saved notification window
  When I click OK button Snippet Saved notification window
  Then I should see the Live Monitor screen
  
  When I go to utangserverdb
  And I execute following query from description
  Then I should see the record of the snippetdocument saved with SnippetType equal to 1