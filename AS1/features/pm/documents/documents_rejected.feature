@regression @documents @approval @automated @core @pm @pm-documents
Feature: PM - Snippet Rhythms Documents Viewer - Nurse Rejected

TestRail Id: C329177
Jira Stories: AS1-2277, AS1-2278, AS1-2377, AS1-2865

Background:
  Given I login to a testSite with "utang" and "XXXXX"
  Then I should see the patient list screen
  And I click "Census" on the List
  And I reset grouping and sorting on patients list
  Then I should see the patient list screen
  When I click on default patient in list
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
@critical @TMS:329177
Scenario: PM - Snippet Rhythms Documents Viewer - Nurse Rejected
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  Then I should see the patient list screen
  When I click "Census" on the List
  Then I should see the patient list screen
  When I click on "[props.DP_FULL_NAME]" in patient list
  Then I should see the patient summary screen
  And I should see the patient document tile
  And I should see patient snippet descriptions and date of snippet created
  When I click on the document tile
  Then I should see the Snippets Rhythms Documents screen
  And I should see No Documents message and No Documents selected
  When I click on the Unapproved icon for latest snippet document
  Then I should see the document item "1" selected
  And the document should appear in viewer
  And the Snippets Document view displays "Created By: Monitor Tech (monitortech)"
  And the Snippets Document view displays "On: <timestamp of creation date of pdf>"
  And I should see the Approve and Reject buttons in list for selected document
  When I click the Reject button on selected document
  Then I should see prompt to Reject or Cancel selected document
  When I click Cancel button in prompt window
  Then I should see the document selected refresh with unapproved icon

  Then I should see the document item "1" selected
  And the document should appear in viewer
  And the Snippets Document view displays "Created By: Monitor Tech (monitortech)"
  And the Snippets Document view displays "On: <timestamp of creation date of pdf>"
  And I should see the Approve and Reject buttons in list for selected document
  When I click the Reject button on selected document
  Then I should see prompt to Reject or Cancel selected document
  When I click Reject button in prompt window
  Then I should see the document selected refresh with rejected icon
