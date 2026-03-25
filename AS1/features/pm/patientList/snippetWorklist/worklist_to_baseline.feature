@regression @automated @core @pm @pm-patient_list @pm-patient_list-snippet_worklist
Feature: Snippet Worklist to Baseline Worklist
Description

Steps to Recreate: 
Select Maria patient from the regular "Snippet Worklist"
User is taken to historical monitor for time requested on worklist (i.e. 14:15)
Navigate back to List of List
Select Mara patient on Baseline worklist

Expected:
User is taken to Live monitor

Actual
User is taken to historical monitor for incomplete worklist item (14:15)

TestRail Id: C554778
Jira Stories: AS1-2787, AS1-3210, AS1-3622
@critical @TMS:554778
Scenario: Snippet Baseline Worklist 
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
	Then I should see the patient list screen
  When I click "Snippet Worklist" on the List
  Then I should see the snippet worklist screen
  And I should see Group By Sort By, Filter Units links disabled
  And I should see the Multi-Patient View link disabled
  When I click on a undocumented snippet in worklist
  Then I should see the Snippet Tool screen
   
  When I click the Back button in PM patient header
  Then I should see the snippet worklist screen
  
  When I click "Snippet Baseline Worklist" on the List
  Then I should see the snippet worklist screen
  And I should see same number of patients in worklist as listed in list of list count
  And I should see Group By Sort By, Filter Units links disabled
  And I should see the Multi-Patient View link disabled
  And I should see "Snippet Baseline Worklist" sorted in default order A-Z
  
  When I click on a undocumented snippet in worklist
  Then I should see the Live Monitor screen