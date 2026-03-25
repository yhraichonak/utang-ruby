@regression @automated @core @pm @pm-snippets @pm-snippets-document_edit
Feature: PM - Snippet Document Edit - Scrolling
Scrolling
The user can scroll left or right to view the entire snippet waveform preview, up to the boundaries when the entire waveform is not displayed in the preview area. 
The user can scroll up/down to view additional details in the Snippet Document Edit

TestRail Id: C264378
Jira Stories: AS1-174
@critical @TMS:264378
Scenario: PM - Snippet Document Edit - Scrolling
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  Then I should see the patient list screen
  When I click "Census" on the List
  Then I should see the patient list screen

  When I click on "[props.DP_FULL_NAME]" in patient list
  Then I should see the patient summary screen

  When I click on the Monitor tile
  Then I should see the Live Monitor screen
  When I click the "Tools" button in sub navigation menu
  Then I should see the Snippet Tool screen

  When I click the Create Snippet button
  Then I should see the Snippet Document Edit View

  
  When I click the All Leads button "Off"
  Then the All Leads toggle is switched "false"
  When I scroll "down" on the Snippet Document Edit View
  And I scroll "down" on the Snippet Document Edit View
  Then I should see the Snippet Document Edit View

  When I scroll "up" on the Snippet Document Edit View
  And I scroll "up" on the Snippet Document Edit View
  Then I should see the Snippet Document Edit View
  
  When I click the All Leads button "On"
  Then the All Leads toggle is switched "true"
  When I scroll "down" on the Snippet Document Edit View
  And I scroll "down" on the Snippet Document Edit View
  And I scroll "down" on the Snippet Document Edit View
  Then I should see the Snippet Document Edit View
 
  When I scroll "up" on the Snippet Document Edit View
  And I scroll "up" on the Snippet Document Edit View
  And I scroll "up" on the Snippet Document Edit View
  Then I should see the Snippet Document Edit View

  