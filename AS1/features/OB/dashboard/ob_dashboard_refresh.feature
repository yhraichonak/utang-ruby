@automated @core @ob @ob-dashboard
Feature: ob_dashboard_refresh
  As a utang ONE user
  I want to refresh the OB Dashboard
  So that I can see updated information

AS1-4006
OB DASHBOARD REFRESH
  - The OB dashboard can be refreshed
  - When the monitor strip is live, the chart will update every 3 seconds just like the perinatal monitor

TestRail Id: C582372

Jira Epic: AS1-2544

Jira Stories: AS1-4006

Jira Bugs/Defects: AS1-4961

Background:
#site and credentials will vary
  Given I login to a testSite with "username" and "XXXXX"
  Then I should see the patient list screen
 @obsolete
Scenario: OB Dashboard - Refresh
  When I click "OB Patients" on the List
  Then I should see the patient list screen
  When I click on "Doe, Jane" in patient list
  Then I should see the OB Dashboard screen
  When I take a snapshot of the OB Dashboard
  And I refresh the browser
  Then I should see the OB Dashboard screen
  And I should not see an error popup
  And I should see the dashboard updates with new patient information
  #when applicable
