@regression @automated @core @pm @pm-snippets @pm-snippets-document_edit
Feature: PM - Snippet Document Edit Layout - 2nd Lead None

The Document Edit Screen should display a preview of the selected waveform snippet where the user can visually identify the section of waveform that is to be recorded in the Snippet Document. The user should be able to view the center of the selected snippet within the waveform preview, despite which length of time was selected. All selected leads will be visible.

The user should be able to visually identify:
-When the Snippet is longer than what is viewed on the screen (Not necessary to display entire waveform without scrolling when > 6 seconds)
-When the Snippet is shorter than what is viewed on the screen

Includes the following:

Measurements (See   AS1-165 TEST READY  )
Waveform Header
indication of the Lead(s) selected (Lead Labels)
Start date of snippet, MM/DD/YY (with leading zeroes)
Start time of snippet, HH:MM:SS (24h format)
End time of snippet, HH:MM:SS (24h format)
matching the times selected from Monitor Tool
P, Q/R, S, T labels, located above image relevant to location on strip from Monitor Tool (no markup on strip/measurement indicators)
Grid Lines
Waveform(s) (black)

TestRail Id: C316522
Jira Stories: AS1-135
@critical @TMS:316522
Scenario: PM - Snippet Document Edit Layout - 2nd Lead None
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

  When I select "none" waveform in option 2 dropdown on Snippet screen
  Then I should see the "[props.COMMON_ECG1]" waveform and "none" waveform in chart and rhythm strip on Snippet screen

  When I click the Create Snippet button
  Then I should see the Snippet Document Edit View

  And I should see the measurement values "HR" from monitor tool
  And the All Leads toggle is switched "Off"
  And I should see date and timestamp in "%m/%d/%Y (%H:%M:%S-%H:%M:%S)" format
  And the snippet length is same as duration selector from monitor tool
