@regression @automated @core @pm @pm-patient_list @pm-patient_list-snippet_worklist
Feature: Patient List - Snippet Worklist Navigation - Documented vs Undocumented Snippets (web)
Worklist Patients without a documented snippet
Tapping on an Undocumented Snippet patient from the worklist jumps to the Monitor Tool time which matches the time value for the worklist Rule Time. The primary navigational items within this view need to be disabled/not accessible

When utilizing the worklist to invoke Snippets, the user maintains all current functionalities of Snippets (i.e. measurements, calipers,, server-controlled snippet durations, and draggable boundary indicators.)

PATIENTS WITH A DOCUMENTED SNIPPET
Tapping on a patient with a Documented Snippet presents the user with a message that alerts the user that a Snippet has already been taken for this patient for this shift :
– Title: Worklist Item Completed
– Text: Worklist item has already been completed

*NOTE: IF two users are documenting same patient at same time, the user who documented with the most recent time would display in the Documented Snippet Status.

TestRail Id: C264353
Jira Stories: AS1-374, AS1-375, AS1-844, AS1-1616, AS1-2083, AS1-2183
@critical @TMS:264353
Scenario: Snippet Worklist Navigation - Documented vs Undocumented Snippets (web)
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  Then I should see the patient list screen
  When I click "Snippet Worklist" on the List
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
  
  
  When I click on a documented snippet in worklist
  Then I should see a message "Worklist Item Completed - Worklist item has already been completed"
  And I click the OK button in snippet worklist completed window
  Then I should see the snippet worklist screen
  When I click on a undocumented snippet in worklist
  Then I should see the Snippet Tool screen
  When I click the Back button in PM patient header
  Then I should see the snippet worklist screen
#  When I refresh the browser
#  Then I should see the snippet worklist screen
  
  When I click the Hide Completed toggle switch to "On"
  Then I should completed snippets toggled "On"
  
  When I click the username dropdown indicator
  Then I should see About and Logout links  
  When I click on Logout link
  Then I should see the login screen
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  Then I should see the patient list screen
  When I click "Snippet Worklist" on the List
  Then I should see the snippet worklist screen
  Then I should completed snippets toggled "On"
  
  When I click the Hide Completed toggle switch to "Off"
  Then I should completed snippets toggled "Off"
  
  