@regression @automated @core @pm @pm-snippets @pm-snippets-ops_log
Feature: PM - Snippet Tools - Create Snippet Ops Log - snippet save
Description
For Ops Log:
Log start time (initialization of tool screen) and end time (selecting "Save" button) of creating a Snippet
Logs are to include start time even if the user does not continue on to select Save.

Include some combination of user + patient information (TBD)

NOTE - use following db query: SELECT * FROM [utangServer].[dbo].[OperationLog] WHERE OperationType in ('SnippetSave') ORDER BY Timestamp_UTC desc

TestRail Id: C328850
Jira Stories: AS1-1846
Jira Bugs/Defects:
@critical @TMS:328850
Scenario: PM - Create Snippet Ops Log - snippet save
  Given I am a super user with all permissions
  Then I cleanup the OperationLog table where operation type is "SnippetSave"
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
  Then I should see the Measure controls for P, Q/R, S, T
  When I click the Create Snippet button
  Then I should see the Snippet Document Edit View
  When I click into the Event Description field
  When I select "NSR - Normal sinus rhythm" from Event Description dropdown
  Then I should see "NSR - Normal sinus rhythm" description in Event Description field

  When I click the Save button on Snippet Document Edit View
  Then I see Snippet Saved notification window
  When I click OK button Snippet Saved notification window
  Then I should see the Live Monitor screen
  And I query the OperationLog table and validate operation type is "SnippetSave" for current user
  And the ExtraContext should contain "NSR - Normal sinus rhythm" evebt description
  And the ExtraContext should contain measurementValues for PR QRS QT QTc matching the Snippet Tool screen
  And I should see following columns with information: Id, SessionId, ModuleId, UserName, OperationType, SiteId, ExtraContext, Timestamp_UTC
