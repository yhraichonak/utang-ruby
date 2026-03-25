@regression @automated @core @pm @pm-snippets @pm-snippets-document_edit
Feature: PM - Snippet Document Edit - Event Description w/Codes

Event Description
As a user, I expect to be able to enter text on the Document Edit Screen so that I may provide written information about the waveform that is displayed. The AMP Snippet Event Description library should be utilized for the event description field. Snippet Statement library is site-specific.

Create an Event Description Field which will default as blank and will be editable (user can enter max 1000 chars). The user can enter text within the Event Description field which will provide a list of possible matching values depending on AMP Snippet Statement Library configuration. When the user selects a value from the Statement Library (e.g. ENTER key or click on value) the user can continue to make subsequent selections in the same manner. The user can also enter free text if desired, which can be selected in the same manner as Statement Library values. The user can also delete statements

Note: Entered statements can behave like objects/addressees in email programs - enter to autocomplete, x to delete, backspace etc. We will also eventually need to be able to right click each selected/entered statement to add a comment (design TBD).

Snippets Event Description library dropdown is to be invokable via a dropdown button. If there are no matches in the current selection, then show ALL statements so that the user may choose one. Minimum height of dropdown - display 7 items.


TestRail Id: C264288
Jira Stories: AS1-166, AS1-168, AS1-608, AS1-167, AS1-2556
@critical @TMS:264288
Scenario: PM - Snippet Document Edit - Event Description w/Codes
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  Then I should see the patient list screen
  When I click "Census" on the List
  Then I should see the patient list screen
  When I click on default patient in list
  Then I should see the patient summary screen
  When I click on the Monitor tile
  Then I should see the Live Monitor screen
  When I click the "Tools" button in sub navigation menu
  Then I should see the Snippet Tool screen
  When I click the Create Snippet button
  Then I should see the Snippet Document Edit View
  When I click into the Event Description field
  Then I should see a selectable list from the server
  And I should 12 events in selectable list
  And I type "NSR" into the Event Description field
  Then I should see the value of "NSR - Normal sinus rhythm" in the selectable list from the server
  And I should 1 events in selectable list
  When I select "NSR - Normal sinus rhythm" from Event Description dropdown
  Then I should see "NSR - Normal sinus rhythm" description in Event Description field
  
  When I remove the value of "NSR - Normal sinus rhythm" in the selectable list from the server
  Then I should see the Snippet Document Edit View
  And I should see not "NSR - Normal sinus rhythm" description in Event Description field
  
