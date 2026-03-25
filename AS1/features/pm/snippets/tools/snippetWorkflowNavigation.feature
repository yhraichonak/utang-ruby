@regression @smoke @automated @core @pm @pm-snippets @pm-snippets-tools
Feature: PM - Snippet Workflow Navigation
Selecting Continue from the Monitor Tool (Snippets ON) should present the user with the Snippet Document Edit Screen.

The user should be provided with options when viewing the Snippet Document Edit screen; Cancel, Preview, and Save

The user should be provided with options when viewing the Snippet Document Preview; Back, or Save

Cancel/Back
Selecting Cancel from the Snippet Document Edit Screen should return the user to the previous location on the Monitor Tool.

Include a message which alerts the user that the Snippet was not saved.
Message text: [Canceled: Snippet not saved]
Message color: Red
Message dismisses without user interaction (similar to when successful PDF has been saved)
Selecting Back from the Snippet Document Preview should return the user to the Snippet Document Edit Screen with the same data provided before selecting preview. (e.g. Any data brought forward to Document Edit from Snippets, or user edited fields will be retained after previewing the document).

Preview
Selecting Preview will provide the user with the Snippet Document Preview. 
After previewing a document, any changes to the Snippet Document Preview should be reflected in any successive saves/previews. (e.g. When a user selects preview, then navigates back to the Doc Edit Screen and edits information, selecting Save or Preview should display that most recent information)

Save
Selecting Save from the Snippet Document Edit Screen OR Snippet Document Preview should pass all Snippet Document Edit data elements to server for PDF generation and export to folder.

Selecting Save from Snippet Document Preview should pass all Snippet Document Edit data elements to server for PDF generation and export to folder.

Upon successful export to folder, the user should receive a user-friendly successful save notification that does not need to be dismissed, and the user should be returned to the Patient Monitoring monitor for that patient. 
*Note - It may be necessary to adjust successful save notification based on document's successful folder save and export to (Onbase)

In the event the save/export was not successful, the user should receive a user-friendly notification that the save was not successful (TBD Text, no Wifi etc) and remain on the current screen until dismissed.

AS1-1384
Hide Primary Navigation on Snippet Document Edit (Web)


TestRail Id: C264265
Jira Stories: AS1-152, AS1-540, AS1-766, AS1-1384, AS1-1451, AS1-2459, AS1-2437
@critical @TMS:264265
Scenario: PM - Snippet Workflow Navigation
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
  When I click the Cancel button on Snippet Document Edit View
  Then I should see Snippet Not Saved window
  When I click the Ok button in Snippet Not Saved window
  Then I should see the Snippet Tool screen
  When I click the Create Snippet button
  Then I should see the Snippet Document Edit View
  And I should not see PM Navigation link
  When I click the Preview button on Snippet Document Edit View
  Then I should see the Snippet Document Preview window
  When I click the Back button on Snippet Document Preview window
  Then I should see the Snippet Document Edit View
  When I click the Preview button on Snippet Document Edit View
  Then I should see the Snippet Document Preview window
  When I click the Save button on Snippet Document Preview window
  Then I see Snippet Saved notification window
  When I click OK button Snippet Saved notification window
  Then I should see the Live Monitor screen
  And the "Live" button is inactive
  
  
  