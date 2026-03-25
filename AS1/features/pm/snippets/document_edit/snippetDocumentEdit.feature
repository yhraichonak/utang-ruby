@regression @nodeSim @automated @core @pm @pm-snippets @pm-snippets-document_edit
Feature: PM - Snippet Document Edit Layout

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

TestRail Id: C264286

Jira Epic: AS1-2508

Jira Stories: AS1-135, AS1-424, AS1-488, AS1-596, AS1-597, AS1-2329

Jira Bugs/Defects: AS1-163, AS1-760, AS1-881, AS1-1105, AS1-1106, AS1-2554, AS1-4565, AS1-6823

Scenario: PM - Snippet Document Edit Layout
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  Then I should see the patient list screen
  And reset unit filtering
  When I click "Census" on the List
  Then I should see the patient list screen
  When I click on default patient in list without redirect
  Then I should see the Live Monitor screen

  When I click the "Tools" button in sub navigation menu
  Then I should see the Snippet Tool screen
  And the Heart Rate from Monitor screen matches the Snippet Tools screen

  When I click on Measure button
  Then I should see the Measure button "active"
  And I should see the HR legend in waveform chart
  And I should see calculating distances of PR, QRS, and QT values
  And I should see the Measure controls for P, Q/R, S, T
  #And I record the original measurement values

  And I should validate the calculation of QTc value

  When I click the Create Snippet button
  Then I should see the Snippet Document Edit View
  And the the Heart Rate from Monitor screen matches the Snippet Document Edit View screen
  And the the Heart Rate from Snippet Tools screen matches the Snippet Document Edit View screen
  #And I should see the measurement values "PR" from the Snippet Tool screen matches the Snippet Document Edit View screen
  #And I should see the measurement values "QRS" from the Snippet Tool screen matches the Snippet Document Edit View screen
  #And I should see the measurement values "QT" from the Snippet Tool screen matches the Snippet Document Edit View screen

  And I should see the measurement values "HR" from monitor tool
  And the All Leads toggle is switched "Off"
  And I should see date and timestamp in "%m/%d/%Y (%H:%M:%S-%H:%M:%S)" format
  And the snippet length is same as duration selector from monitor tool

  When I click the username dropdown indicator
  Then I should see About and Logout links
  When I click on Logout link
  Then I should see the login screen
