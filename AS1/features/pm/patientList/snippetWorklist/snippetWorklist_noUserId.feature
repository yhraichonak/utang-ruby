@regression @automated @core  @pm @pm-patient_list @pm-patient_list-snippet_worklist
Feature: Snippet Worklist Navigation - EnterpriseId = -1

Updated Requirement:

Saving
When the user selects "Save" they will be returned to the worklist where the worklist will be refreshed and the patient
cell will be with a "Documented Snippet" status: right aligned text identifying the time completion of a snippet and the
Author of the Snippet Document in the following format:
Line 1: Enterprise Username
Line 2: Date and Time of Snippet Completion MM/DD/YYYY - HH:MM
If EnterpriserUserId = -1 use AdUsername else we do a search on the EnterpriseUser table for the EnterpriseUserId

NOTE: For the Snippet Worklist to show on the list of lists for the "noamp" user, set the following config:
HOST Server: 10.10.160.133
C:\utang\amp\Web.config
<add key="TemplateEnterpriseUser" value="TEMPLATE_AS1"/>

Also, ensure that the TEMPLATE_AS1 user has the Snippets Worklist enabled in AMP

TestRail Id: C328844
Jira Stories: AS1-1584
  @TMS:328844
Scenario: Snippet Worklist Navigation - EnterpriseId = -1
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  Then I should see the patient list screen
  When I click "Snippet Worklist" on the List
  Then I should see the snippet worklist screen
  When I click on a documented snippet in worklist
  Then I should see a message "Worklist Item Completed - Worklist item has already been completed"
  And I click the OK button in snippet worklist completed window
  Then I should see the snippet worklist screen
  When I click on a undocumented snippet in worklist
  Then I should see the Snippet Tool screen
  When I click the Back button in PM patient header
  Then I should see the snippet worklist screen
  When I refresh the browser
  Then I should see the snippet worklist screen

  When I click on a undocumented snippet in worklist
  Then I should see the Snippet Tool screen
  When I click the Create Snippet button
  Then I should see the Snippet Document Edit View

  When I click the Save button on Snippet Document Edit screen
  Then I see Snippet Saved notification window
  When I click OK button Snippet Saved notification window
  Then I should see the snippet worklist screen
  And I should be returned to location in worklist of previous patient selected
