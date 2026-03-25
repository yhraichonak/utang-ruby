@regression @doc_preview @automated @core @pm @pm-snippets @pm-snippets-document_preview
Feature: PM - Snippet Document Preview Layout - Disabled P

Snippet Document Preview Screen
The Snippet Document Preview screen displays the server generated PDF or JPG (see details below) within a new navigational window (non-modal, workflow only navigation - primary nav/secondary nav bars unnecessary). The user can only view the Snippet PDF from this view, and must navigate back to return to the Snippet Document Edit Screen.

JPG Details:
Add an option to web.config that allows the web client to display a snippet preview as a jpg.
Something Like:
<add key="JpegPreview" value="true" />

When the option is true, the web client should render a jpg image from the snippet preview response from a property named renderedJpgBytes, if this option is not set in the web.config then the client will continue to render a pdf using renderedPdfBytes.


TestRail Id: C264385
Jira Stories: AS1-162
@critical @TMS:264385
Scenario: PM - Snippet Document Edit Layout - Disabled P
  Given I login to a testSite with "utang" and "XXXXX"
  Then I should see the patient list screen
  When I click "Census" on the List
  Then I should see the patient list screen
  When I click on "[props.DP_FULL_NAME]" in patient list
  Then I should see the patient summary screen
  When I click on the Monitor tile
  Then I should see the Live Monitor screen
  When I click the "Tools" button in sub navigation menu
  Then I should see the Snippet Tool screen
  When I click on Measure button
  Then I should see the Measure button "active"
  When I click on "P" Measure control
  Then I should see the "P" Measure control "disabled"
  And I should see the "PR" distance value as --
  When I click the Create Snippet button
  Then I should see the Snippet Document Edit View
  When I click the Preview button on Snippet Document Edit View
  Then I should see the Snippet Document Preview window
#  When User reads screen content
#  And Verify screen content matches "(?m)Oppenheimer, J. Robert.*M.*DOB: 08/06/1945"
#  And Verify screen content matches "(?m).*MRN: 139233.*Site: Automation Site.*Unit/Bed: ICU/ICU-05"
#  And Verify screen content matches "(?m).*Measurements:.*HR:.*60.*PR:.*0.00s.*QRS:.*0.20s.*QT:.*0.40"
#  And Verify screen content matches "(?m).*Measurements:.*QTc: 0.40s"
#  And Verify screen content matches "(?m).*EVENT:.*\d\d:\d\d:\d\d \d\d/\d\d/\d\d\d\d.*\d\d:\d\d:\d\d."
  When I scroll the Snippet Preview Document "right"
  Then I should see the Snippet Document Preview window
  When I scroll the Snippet Preview Document "right"
  Then I should see the Snippet Document Preview window

  When I scroll the Snippet Preview Document "left"
  Then I should see the Snippet Document Preview window
  When I scroll the Snippet Preview Document "left"
  Then I should see the Snippet Document Preview window

  When I scroll the Snippet Preview Document "down"
  Then I should see the Snippet Document Preview window
  When I scroll the Snippet Preview Document "right"
  Then I should see the Snippet Document Preview window
  When I scroll the Snippet Preview Document "right"
  Then I should see the Snippet Document Preview window

  When I scroll the Snippet Preview Document "left"
  Then I should see the Snippet Document Preview window
  When I scroll the Snippet Preview Document "left"
  Then I should see the Snippet Document Preview window

  When I scroll the Snippet Preview Document "down"
  Then I should see the Snippet Document Preview window
  When I scroll the Snippet Preview Document "down"
  Then I should see the Snippet Document Preview window
  When I scroll the Snippet Preview Document "right"
  When I scroll the Snippet Preview Document "right"
  Then I should see the Snippet Document Preview window
