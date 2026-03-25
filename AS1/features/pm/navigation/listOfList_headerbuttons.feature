@regression @automated @core @pm @pm-navigation
Feature: Navigation - List of Lists - Active Header buttons
Description
Multi-Patient view is specific to PM census and my patients list types - therefore it should be inactive from other list types in AS1.

Expected:
The MPV button will be active ONLY on

PM census

My Patients

TestRail Id: C581613
Jira Stories: AS1-3813
@critical @TMS:581613
Scenario: Group Sort, Filter Units and MPV buttons active or inactive on Lists
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  Then I should see the patient list screen
  When I click "Census" on the List
  Then I should see the patient list screen
  And I should see Group Sort, Filter Units links active
  And I should see the Multi-Patient View link active

  When I click PM main list on the sidebar
  Then I should see the patient list screen
  And I should see Group Sort, Filter Units links active
  And I should see the Multi-Patient View link active

  When I click "My Patients" on the List
  Then I should see the patient list screen
  And I should see the Group Sort link active
  And I should see the Filter Units link disabled
  And I should see the Multi-Patient View link active

  When I click "Snippet Worklist" on the List
  Then I should see the snippet worklist screen
  And I should see Group Sort, Filter Units links disabled
  And I should see the Multi-Patient View link disabled

  When I click "Monitor Tech 1" on the List
  Then I should see the snippet worklist screen
  And I should see Group Sort, Filter Units links disabled
  And I should see the Multi-Patient View link disabled

  When I click "Monitor Tech 2" on the List
  Then I should see the snippet worklist screen
  And I should see Group Sort, Filter Units links disabled
  And I should see the Multi-Patient View link disabled

  When I click "Snippet Baseline Worklist" on the List
  Then I should see the snippet worklist screen
  And I should see same number of patients in worklist as listed in list of list count
  And I should see Group By Sort By, Filter Units links disabled
  And I should see the Multi-Patient View link disabled

  When I click "Snippets Report" on the List
  Then I should see the Supervisor Snippet Report screen
  And I should see Group By Sort By, Filter Units links not display
  And I should see the Multi-Patient View link not display
  When I click the Home icon
  Then I should see the patient list screen

  When I click "MOST RECENT" on the List
  Then I should see the patient list screen
  And I should see Group By Sort By, Filter Units links disabled
  And I should see the Multi-Patient View link disabled

  When I click "EMS" on the List
  Then I should see the patient list screen
  And I should see Group By Sort By, Filter Units links disabled
  And I should see the Multi-Patient View link disabled

  When I click "SEARCH" on the List
  Then I should see the patient list screen
  And I should see Group By Sort By, Filter Units links disabled
  And I should see the Multi-Patient View link disabled
