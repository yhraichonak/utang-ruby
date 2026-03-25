@regression @automated @core @pm @pm-snippets @pm-snippets-tools
Feature: Snippet Tools - Save - Provide Snippet type to Server for PDF


NOTE: SQL for snippet type on snippetDocument table

  SELECT *
  FROM [utangServer].[dbo].[SnippetDocument]
  Where [SnippetType] = 3

TestRail Id: C328938
Jira Stories: AS1-2056, AS1-2162, AS1-2071, AS1-2074, AS1-2058, AS1-1795, AS1-2055, AS1-2797, AS1-2713, AS1-3274
@critical @TMS:328938
Scenario: Snippet Tools - Save - Provide Snippet type to Server for PDF
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
  When I select snippet doc type of "EVENT"
  Then I should see the Description field with header "EVENT"

  When I click the Save button on Snippet Document Edit screen
  Then I see Snippet Saved notification window
  When I click OK button Snippet Saved notification window
  Then I should see the Live Monitor screen

  When I go to utangserverdb
  And I execute following query from description
  Then I should see the record of the snippetdocument saved with SnippetType equal to 3