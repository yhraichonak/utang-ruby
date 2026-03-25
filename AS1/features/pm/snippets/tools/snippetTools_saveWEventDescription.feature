@regression @automated @core @pm @pm-snippets @pm-snippets-tools
Feature: Snippet Tools - Save with Event Description


TestRail Id: C580265
Jira Stories: AS1-2751
@critical @TMS:580265
Scenario: Snippet Tools - Save - Provide Snippet type to Server for PDF
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  Then I should see the patient list screen
  When I click "Census" on the List
  Then I should see the patient list screen
  When I click on default patient in list without redirect
  Then I should see the Live Monitor screen
  When I click the "Tools" button in sub navigation menu
  Then I should see the Snippet Tool screen
  When I click the Create Snippet button
  Then I should see the Snippet Document Edit View
  And I should see the Description field with header "EVENT"
  When I select snippet doc type of "EVENT"
  Then I should see the Description field with header "EVENT"
  
  When I click into the Event Description field
  Then I should see a selectable list from the server
  And I should 12 events in selectable list
  When I select "NSR - Normal sinus rhythm" from Event Description dropdown
  Then I should see "NSR - Normal sinus rhythm" description in Event Description field
  
  When I click the Save button on Snippet Document Edit screen
  Then I see Snippet Saved notification window
  When I click OK button Snippet Saved notification window
  Then I should see the Live Monitor screen
  
  When I click the "Tools" button in sub navigation menu
  Then I should see the Snippet Tool screen
  When I click the Create Snippet button
  Then I should see the Snippet Document Edit View
  And I should see the Description field with header "EVENT"
  And I should see the Event Description field empty