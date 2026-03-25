@regression @doc_preview @automated @core
Feature: PM - Snippet Document Preview Layout - w/Event Descriptions

  Snippet Document Preview Screen
  The Snippet Document Preview screen displays the server generated PDF or JPG (see details below) within a new
  navigational window (non-modal, workflow only navigation - primary nav/secondary nav bars unnecessary). The user can
  only view the Snippet PDF from this view, and must navigate back to return to the Snippet Document Edit Screen.

  JPG Details:
  Add an option to web.config that allows the web client to display a snippet preview as a jpg.
  Something Like:
  '<add key="JpegPreview" value="true" />'

  also When the option is true, the web client should render a jpg image from the snippet preview response from a
  property named renderedJpgBytes, if this option is not set in the web.config then the client will continue to render
  a pdf using renderedPdfBytes.

  AS1-159
  Client to provide Dynamic Values for Snippet PDF
  The client will provide to the server all dynamic values, including

  Patient Details
  Snippet Start Time/Snippet End Time + Date (with each cut)
  HH:MM:SS (24h)
  Measurements from measurement tool
  HR
  Snippet/Rhythm Strip Image
  P, Q/R, S, T included, but appear in perspective locations above the image (no markings on image)
  All aspects of image should match snippet document edit image (e.g. gridlines, color, etc)
  Zoom snapshot (when necessary)
  Metadata for PDF export
  Ex: Scanned documents description field - combination of the abbreviation of first code in the event description
  field with the start time of the strip itself. For example, if it was an AFIB that the patient had at 21:05:30. Then
  the scanned document description will be “AFIB at 21:05:30 MM-DD-YYYY'
  We can store the text instead of the code by toggling the Host.Config > snippet.scanned.document.by.code to false.
  Will be defaulted to true which will store the code in the metadata file.

  TestRail Id: C316530
  Jira Stories: AS1-1383, AS1-1396
  @network_logs
  @TMS:316530
  Scenario: PM - Snippet Document Preview Layout - w/Event Descriptions
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    Then I should see the patient list screen
    When I click "Census" on the List
    Then I should see the patient list screen
    When I click on default patient in list without redirect
    Then I should see the Live Monitor screen
    When I click the "Tools" button in sub navigation menu
    Then I should see the Snippet Tool screen
    When I click on Measure button
    Then I should see the Measure button "active"
    When I click the Create Snippet button
    Then I should see the Snippet Document Edit View
    When I click into the Event Description field
    Then I should see a selectable list from the server
    And I should 12 events in selectable list
    When I select "NSR - Normal sinus rhythm" from Event Description dropdown
    Then I should see "NSR - Normal sinus rhythm" description in Event Description field
    When I click the Preview button on Snippet Document Edit View
    Then I should see the Snippet Document Preview window
    Then I should see the Snippet Preview Document display Patient Details
    Then I should see the Snippet Preview Document display Snippet Start/End Times HH:MM:SS format
    Then I should see the Snippet Preview Document display Measurements from snippet tool
    Then I should see the Snippet Preview Document display HR value
    Then I should see the Snippet Preview Document display Snippet/Rhythm Strip Image
    Then I should see the Snippet Preview Document display Zoom snapshot (measurements on)
