@regression @nodeSim        @pm @pm-snippets @pm-snippets-document_edit @pipeline_run

Feature: snippetDocumentEditLayout.feature
  As an utang ONE user
  I want to view the Document Edit screen
  So that I can preview the information to be recorded in the Snippet Document

  MIG-310
  - The Document Edit Screen should display a preview of the selected waveform snippet where the user can visually identify the section of waveform that is to be recorded in the Snippet Document.
  - The user should be able to view the center of the selected snippet within the waveform preview, despite which length of time was selected. All selected leads will be visible.

  The user should be able to visually identify:
  - When the Snippet is longer than what is viewed on the screen (Not necessary to display entire waveform without scrolling when > 6 seconds)
  - When the Snippet is shorter than what is viewed on the screen

  Includes the following:
  - Measurements (See AS1-165)
  - Waveform Header
  - Indication of the Lead(s) selected (Lead Labels)
  - Start date of snippet, MM/DD/YYYY (with leading zeroes)
  - Start time of snippet, HH:MM:SS (24h format)
  - End time of snippet, HH:MM:SS (24h format)
  - Matching the times selected from Monitor Tool
  - P, Q/R, S, T labels, located above image relevant to location on strip from Monitor Tool (no markup on strip/measurement indicators)
  - Grid Lines
  - Waveform(s) (black)
  - Waveform image will always be 2x height (including when second lead is "none/blank" where lead 1 would show in top 1/2 of image and "none" would be blank ins bottom 1/2) Note:All leads feature has separate rules - see AS1-488

  AS1-488
  Full Disclosure (All leads) - Document Edit Screen
  - The document edit screen remains unchanged except for the waveform display area and lead label text

  All Leads Checkbox:
  - Snippet Document Edit will contain a checkbox/selector with the field label "All Leads" in place of the lead label text
  - When selected, this option will be considered "All leads ON"
  - When deselected, Document Edit waveform Image will appear in standard Dual Lead configuration (dependent on previously selected waveforms from Monitor Tool)
  - All leads checkbox will retain state across sessions for the same user (i.e. stored in preferences)
  - Default on initial load in of checkbox is "All Leads OFF"

  If All leads ON
  - Document Edit Waveform Image will display all available waveforms from the patient Monitor, in the order they are displayed on monitor, including any waveform labels which contain no waveform data (as would appear on the monitor)
  - The user will be able to scroll vertically in the image to see all available waveforms displayed (will most likely create a "double" scroll which is acceptable for all leads)
  - When greater vertical space is provided, this default height can grow to fit the available area in all leads
  - The user will be able to scroll horizontally (when necessary) in the image to see all available waveforms displayed
  - The zooming/size of dual lead default display for zoom view and rhythm strip will be maintained in all waveforms mode. (no changes to zoom levels on zoom view or rhythm strip)
  - The waveform display will include lead labels to the left of the displayed leads (within the image) note this will also be an update/change to dual lead images. See MIG-325: Snippet Document Edit - Include Lead Labels in Snippets Waveform Image.

  AS1-2329
  - When in Snippet Document Edit, the user has entered a workflow which must be completed or exited. Therefore, the main back navigation (next to patient header) should be disabled.
  - The user will have Preview|Save|Cancel buttons to navigate out of the workflow properly.

  AS1-7024
  - When creating a snippet, a permanent outline is required for the "Events" selector.

  TestRail Id: C264286

  Jira Epic: AS1-2508

  Jira Stories: MIG-310, AS1-135, AS1-488, AS1-2329, AS1-7024

  Jira Bugs/Defects: AS1-163, AS1-424, AS1-596, AS1-597, AS1-760, AS1-881, AS1-1105, AS1-1106, AS1-2554, AS1-4565, AS1-6823, AS1-7328

  Background:
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

    When I select "ECG-AVF" waveform in option 1 dropdown on Snippet screen
    And I select "ECG-II" waveform in option 2 dropdown on Snippet screen
    And User is able to select "10 seconds" snippet duration on Snippet screen
    And I click on Measure button
    Then I should see the Measure button "active"
    And I should see the Measure controls for P, Q/R, S, T
    And I should see P, Q/R, S, T Measure Controls center aligned
    And I should see the HR legend in waveform chart
    And I should see calculating distances of PR, QRS, and QT values
    And I should validate the calculation of QTc value

    When I click the Create Snippet button
    Then I should see the Snippet Document Edit View
    And I should see the patient header with the patients information displayed
    And I should not see the back button in the navigation header
    And The snippet doc type should display "EVENT"

    When I click snippet doc type selector
    And I should see the snippet doc type dropdown menu
    And I should see the Event Description field empty
    And I should see the Measurements label and values

  @TMS:264286
  Scenario: PM - Snippet Document Edit Layout
    And the All Leads toggle is switched "Off"
    And I should see date and timestamp in "%m/%d/%Y (%H:%M:%S-%H:%M:%S)" format
    And the snippet length is same as duration selector from monitor tool
    And I should see the measurement values "HR" from monitor tool
    And I should see the measurement values "PR" from monitor tool
    And I should see the measurement values "QRS" from monitor tool
    And I should see the measurement values "QT" from monitor tool
    And I should see the measurement values "QTc" from monitor tool

    And I should see the waveform image displaying 2 or less waveforms

    @ISSUE:AS1-7621
    #The All Leads button does not stay toggled "on" after logging out and logging back in but there's a Jira assigned to this issue
  Scenario: PM - Snippet Document Layout - All Leads
    When I click the All Leads button "On"
    Then the All Leads toggle is switched "On"
    And I should see the waveform image displaying all the waveforms
    When I click the All Leads button "Off"
    Then the All Leads toggle is switched "Off"
    And I should see the waveform image displaying 2 or less waveforms

    When I click the All Leads button "On"
    Then the All Leads toggle is switched "On"
    When I logout of application
    And I login to a testSite with a valid credential
    And I click on default patient in list
    And I click the "Tools" button in sub navigation menu
    And I click the Create Snippet button
    Then the All Leads toggle is switched "On"

    When I click the All Leads button "Off"
    Then the All Leads toggle is switched "Off"
    When I logout of application
    And I login to a testSite with a valid credential
    And I click on default patient in list
    And I click the "Tools" button in sub navigation menu
    And I click the Create Snippet button
    Then the All Leads toggle is switched "Off"