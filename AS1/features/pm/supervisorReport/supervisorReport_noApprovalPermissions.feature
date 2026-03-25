@regression @automated @core @pm @pm-supervisor_report
Feature: Supervisor Report - no Approval Permission

List of Lists
The user can access the Supervisor Report from the List of Lists (Display as "Snippets Report").
Tapping on the list of list item opens the Supervisor Report

*Not provided in standard list of lists call from server (link only)

Note: scottgillenwater user permissions Snippets Approval Required? = true in amp
      username user permissions Snippets Approval Required? = false in amp

TestRail Id: C329228
Jira Stories: AS1-2377, AS1-2283, AS1-2257, AS1-2573
  @TMS:329228
Scenario: Supervisor Report - no Approval Permission
  Given I login to a testSite with "username" and "XXXXX"
  Then I should see the patient list screen
  When I click "Snippets Report" on the List
  Then I should see the Supervisor Snippet Report screen
  When I sort the "Status" column "ascending" on Supervisor Snippet Report screen
  When I click on the View link of "Unapproved" snippet in Supervisor Snippet Report
  Then I see the snippet appear in viewer window
  And I see a OK button in snippet viewer window
  And the Snippets Document view displays "Created By: Monitor Tech (scottgillenwater)"
  And the Snippets Document view displays "On: <timestamp of creation date of pdf>"
  When I click the OK button in snippet viewer window
  Then I should see the Supervisor Snippet Report screen
  And the Snippet display as "Unapproved" in Supervisor Snippet Report
