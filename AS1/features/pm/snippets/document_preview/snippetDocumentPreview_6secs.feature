@regression @doc_preview @smoke @nodeSim @core
Feature: PM - Snippet Document Preview Layout - 6 seconds

  Snippet Document Preview Screen
  The Snippet Document Preview screen displays the server generated PDF or JPG (see details below) within a new navigational window (non-modal, workflow only navigation - primary nav/secondary nav bars unnecessary). The user can only view the Snippet PDF from this view, and must navigate back to return to the Snippet Document Edit Screen.

  JPG Details:
  Add an option to web.config that allows the web client to display a snippet preview as a jpg.
  Something Like:

  '<add key="JpegPreview" value="true" />'

  when the option is true, the web client should render a jpg image from the snippet preview response from a property named renderedJpgBytes, if this option is not set in the web.config then the client will continue to render a pdf using renderedPdfBytes.

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
  Ex: Scanned documents description field - combination of the abbreviation of first code in the event description field with the start time of the strip itself. For example,
  if it was an AFIB that the patient had at 21:05:30. Then the scanned document description will be "AFIB at 21:05:30 MM-DD-YYYY"
  We can store the text instead of the code by toggling the Host.Config > snippet.scanned.document.by.code to false. Will be defaulted to true which will store the code in the metadata file.

  TestRail Id: C264290

  Jira Stories: AS1-158, AS1-161, AS1-881, AS1-159, AS1-175, MIG-301

  Jira Bugs/Defects: AS1-858, MIG-331, AS1-1725, AS1-1678, AS1-1750, AS1-2573, AS1-3275, AS1-3933, AS1-6822, AS1-6821, AS1-6834, AS1-7553


  @TMS:264290  @network_logs
  Scenario: PM - Snippet Document Preview Layout - 6 seconds
    #TODO: Sync tes implementation with testcase in TestRail as the source test was changed
    # https://teams.microsoft.com/l/message/19:5b9345d8-5273-4013-b13b-f724aed95596_8e661d4a-27b1-4ec1-8d88-c578dcc8eac4@unq.gbl.spaces/1712779169366?context=%7B%22contextType%22%3A%22chat%22%7D
    Given Implementation or refactoring required
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
    And I click on Measure button
    Then I should see the Measure button "active"
    When I "increase" the snippet length duration to "7" seconds
    Then I should see the snippet length duration display "7 seconds"

    When I click the Create Snippet button
    Then I should see the Snippet Document Edit View
    When I click the Cancel button on Snippet Document Edit View
    And I click the Ok button in Snippet Not Saved window
    Then I should see the Snippet Tool screen
    And I should see the snippet length duration display "7 seconds"
    When I click the Create Snippet button
    Then I should see the Snippet Document Edit View
    When I click the Preview button on Snippet Document Edit View
    Then I should see the Snippet Document Preview window
    When I scroll the Snippet Preview Document "down"
    And I scroll the Snippet Preview Document "down"
    Then I should see the Snippet Preview Document display Patient Details
    And I should see the Snippet Preview Document display Snippet Start/End Times HH:MM:SS format
    And I should see the Snippet Preview Document display Measurements from snippet tool
    And I should see the Snippet Preview Document display HR value
    And I should see the Snippet Preview Document display Snippet/Rhythm Strip Image
    And I should see the Snippet Preview Document display Zoom snapshot (measurements on)




