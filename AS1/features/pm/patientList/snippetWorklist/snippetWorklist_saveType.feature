@regression @automated @core @pm @pm-patient_list @pm-patient_list-snippet_worklist
Feature: Snippet Worklist - Save - Provide Snippet type to Server for PDF


NOTE: SQL for snippet type on snippetDocument table

  SELECT *
  FROM [utangServer].[dbo].[SnippetDocument]
  Where [SnippetType] = 2

TestRail Id: C328937
Jira Stories: AS1-2056, AS1-2162, AS1-2071, AS1-2074, AS1-2058, AS1-1795
@critical @TMS:328937
Scenario: Snippet Worklist - Save - Provide Snippet type to Server for PDF
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
	Then I should see the patient list screen
  When I click "Snippet Worklist" on the List
  Then I should see the snippet worklist screen
  
  When I click on a undocumented snippet in worklist
  Then I should see the Snippet Tool screen
  When I click the Create Snippet button
  Then I should see the Snippet Document Edit View
  And I should see the Description field with header "Shift Assessment Description"
  
  When I click the Save button on Snippet Document Edit screen
  Then I see Snippet Saved notification window
  When I click OK button Snippet Saved notification window
  Then I should see the snippet worklist screen
  And I should be returned to location in worklist of previous patient selected
  
  When I go to utangserverdb
  And I execute following query from description
  Then I should see the record of the snippetdocument saved with SnippetType equal to 2