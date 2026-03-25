@regression @automated @core @pm @pm-supervisor_report
Feature: Supervisor Report - Show/Hide Columns

Allow users to hide or unhide columns on the Snippet Supervisor Report.

Hide/Show Columns Filter Display
Display a "Hide/Show Columns" filter
Tapping the Hide/Show Columns button will display a multiselect dropdown listing all available column headers, each with an associated toggle.
Toggling a specific column off, then saving the filter will result in hiding that column in the Supervisor Report.

Styling
When columns are hidden on the Supervisor Report, the report should display an indication that a column is hidden (example: in excel,
when hiding a column, the column header has an extra spacer indicating a hidden column)

Filter Saving
Filter selections should be retained across sessions.

TestRail Id: C329207
Jira Epic: AS1-2563
Jira Stories: AS1-2427
Jira bugs/Defects: AS1-6687
  @TMS:329207
Scenario: Supervisor Report - Show/Hide Columns
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  Then I should see the patient list screen
  When I click "Snippets Report" on the List
  Then I should see the Supervisor Snippet Report screen

  When I click the Hide Show Columns button
  Then I should see the Hide Show Column toggles window
  When I click to "hide" the "Status" column
  And I click the Ok button on the Hide Show Column toggle window
  Then I should see the Supervisor Snippet Report with "Status" column hidden

  When I click the Hide Show Columns button
  Then I should see the Hide Show Column toggles window
  When I click to "show" the "Status" column
  And I click the Ok button on the Hide Show Column toggle window
  And I should see column header "Status" in Supervisor Snippet Report screen

  When I click the Hide Show Columns button
  Then I should see the Hide Show Column toggles window
  When I click to "hide" the "Captured By" column
  When I click to "hide" the "Event Description" column
  When I click to "hide" the "Reviewed By" column
  And I click the Ok button on the Hide Show Column toggle window
  Then I should see the Supervisor Snippet Report with "Captured By" column hidden
  And I should see the Supervisor Snippet Report with "Event Description" column hidden
  And I should see the Supervisor Snippet Report with "Reviewed By" column hidden

  When I click the Hide Show Columns button
  Then I should see the Hide Show Column toggles window
  When I click to "show" the "Captured By" column
  When I click to "show" the "Event Description" column
  When I click to "show" the "Reviewed By" column
  And I click the Ok button on the Hide Show Column toggle window
  Then I should see column header "Captured By" in Supervisor Snippet Report screen
  And I should see column header "Event Description" in Supervisor Snippet Report screen
  And I should see column header "Reviewed By" in Supervisor Snippet Report screen

  When I click the Hide Show Columns button
  Then I should see the Hide Show Column toggles window
  When I click to "hide" the "Status" column
  And I click to "hide" the "Patient Name" column
  And I click to "hide" the "MRN" column
  And I click to "hide" the "Unit" column
  And I click to "hide" the "Bed" column
  And I click to "hide" the "Captured By" column
  And I click to "hide" the "Created Date/Time" column
  And I click to "hide" the "Event Description" column
  And I click to "hide" the "Snippet Type" column
  And I click to "hide" the "Reviewed By" column
  And I click the Ok button on the Hide Show Column toggle window
  Then I should see the Supervisor Snippet Report with "Status" column hidden
  And I should see the Supervisor Snippet Report with "Patient Name" column hidden
  And I should see the Supervisor Snippet Report with "MRN" column hidden
  And I should see the Supervisor Snippet Report with "Unit" column hidden
  And I should see the Supervisor Snippet Report with "Captured By" column hidden
  And I should see the Supervisor Snippet Report with "Created Date/Time" column hidden
  And I should see the Supervisor Snippet Report with "Event Description" column hidden
  And I should see the Supervisor Snippet Report with "Snippet Type" column hidden
  And I should see the Supervisor Snippet Report with "Reviewed By" column hidden

  When I click the username dropdown indicator
  Then I should see About and Logout links
  When I click on Logout link
  Then I should see the login screen

  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  Then I should see the patient list screen
  When I click "Snippets Report" on the List
  Then I should see the Supervisor Snippet Report screen
  And I should see the Supervisor Snippet Report with "Status" column hidden
  And I should see the Supervisor Snippet Report with "Patient Name" column hidden
  And I should see the Supervisor Snippet Report with "MRN" column hidden
  And I should see the Supervisor Snippet Report with "Unit" column hidden
  And I should see the Supervisor Snippet Report with "Captured By" column hidden
  And I should see the Supervisor Snippet Report with "Created Date/Time" column hidden
  And I should see the Supervisor Snippet Report with "Event Description" column hidden
  And I should see the Supervisor Snippet Report with "Snippet Type" column hidden
  And I should see the Supervisor Snippet Report with "Reviewed By" column hidden

  When I click the Hide Show Columns button
  Then I should see the Hide Show Column toggles window
  When I click to "show" the "Status" column
  And I click to "show" the "Patient Name" column
  And I click to "show" the "MRN" column
  And I click to "show" the "Unit" column
  And I click to "show" the "Bed" column
  And I click to "show" the "Captured By" column
  And I click to "show" the "Created Date/Time" column
  And I click to "show" the "Event Description" column
  And I click to "show" the "Snippet Type" column
  And I click to "show" the "Reviewed By" column
  And I click the Ok button on the Hide Show Column toggle window
  And I should see column header "Status" in Supervisor Snippet Report screen
  And I should see column header "Patient Name" in Supervisor Snippet Report screen
  And I should see column header "MRN" in Supervisor Snippet Report screen
  And I should see column header "Unit" in Supervisor Snippet Report screen
  And I should see column header "Captured By" in Supervisor Snippet Report screen
  And I should see column header "Created Date/Time" in Supervisor Snippet Report screen
  And I should see column header "Event Description" in Supervisor Snippet Report screen
  And I should see column header "Snippet Type" in Supervisor Snippet Report screen
  And I should see column header "Reviewed By" in Supervisor Snippet Report screen

