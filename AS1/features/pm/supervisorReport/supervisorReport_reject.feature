@regression @automated @core @pm @pm-supervisor_report
Feature: Supervisor Report - Reject Snippet

List of Lists
The user can access the Supervisor Report from the List of Lists (Display as "Snippets Report").
Tapping on the list of list item opens the Supervisor Report

*Not provided in standard list of lists call from server (link only)

TestRail Id: C329173
Jira Stories: AS1-2279, AS1-2377

Background:
  Given I login to a testSite with "utang" and "XXXXX"
  Then I should see the patient list screen
  When I click PM main list on the sidebar
  Then I should see the patient list screen
  When I click on test patient in PM patient list
  Then I should see the patient summary screen
  When I click on the Monitor tile
  Then I should see the Live Monitor screen
  When I click the "Tools" button in sub navigation menu
  Then I should see the Snippet Tool screen
  When I click the Create Snippet button
  Then I should see the Snippet Document Edit View
  And I should see the Description field with header "EVENT"
  When I click into the Event Description field
  When I select "NSR - Normal sinus rhythm" from Event Description dropdown
  When I click the Save button on Snippet Document Edit screen
  Then I see Snippet Saved notification window
  When I click OK button Snippet Saved notification window
  Then I should see the Live Monitor screen

  When I click the username dropdown indicator
  Then I should see About and Logout links
  When I click on Logout link
  Then I should see the login screen
  @TMS:329173
Scenario: Supervisor Report - Reject Snippet
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  When I click "Snippets Report" on the List
  Then I should see the Supervisor Snippet Report screen
  When I click on the View link of "Unapproved" snippet in Supervisor Snippet Report
  Then I see the snippet appear in viewer window
  And I see a Approve button in snippet viewer window
  And I see a Reject button in snippet viewer window
  And the Snippets Document view displays "Created By: Monitor Tech (scottgillenwater)"
  And the Snippets Document view displays "On: <timestamp of creation date of pdf>"
  When I click the Reject button in snippet viewer window
  Then I see the Reject Snippet prompt window
  When I click Cancel button in reject snippet prompt
  Then I should see the Supervisor Snippet Report screen
  And the Snippet display as "Unapproved" in Supervisor Snippet Report

  When I click on the View link of "Unapproved" snippet in Supervisor Snippet Report
  Then I see the snippet appear in viewer window
  And I see a Approve button in snippet viewer window
  And I see a Reject button in snippet viewer window
  And the Snippets Document view displays "Created By: Monitor Tech (scottgillenwater)"
  And the Snippets Document view displays "On: <timestamp of creation date of pdf>"
  When I click the Reject button in snippet viewer window
  Then I see the Reject Snippet prompt window
  When I click Reject button in reject snippet prompt

  Then I should see the Supervisor Snippet Report screen
  And the Snippet display as "Rejected" in Supervisor Snippet Report
