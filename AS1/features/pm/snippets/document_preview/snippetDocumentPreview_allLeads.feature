@regression @doc_preview @nodeSim @automated @core @pm @pm-snippets @pm-snippets-document_preview
Feature: PM - Snippet Document Preview - All Leads On

  Description
  All leads PDF display (Waveform Image)

  One page can have a maximum of 8 leads
  Lead order and label display will be maintained as the same order displayed in the Monitor
  If more than 8 leads, a second page of the SAME six seconds as the first page will display, with as many leads as do not "fit" on the first page
  The grids will remain square, no matter the height of the image (#of leads)
  Considering 1 lead to be 1x height, an image with 6s of snippet and :
  3 leads will display 3 leads with a grid of 3x height
  5 leads will display 5 leads with a grid of 5x height
  9 leads will display 8 leads with a grid of 8x height, with a second page of 1 lead with 1x height grid.
  All leads PDF display (Zoom view snapshot)

  The zoom snapshot will display based on whatever lead was selected in the dropdown menu as the "first" or top lead.
  Note: In the monitor tool. the two displayed leads can be selected, and the "top" lead will be considered the measured lead. The lead selected in the
  first dropdown will be the lead/measurement image displayed in the zoom view, whether dual lead or all leads mode.

  TestRail Id: C264441

  Jira Stories: AS1-490

  @TMS:264441 @network_logs
  Scenario: PM - Snippet Document Preview Layout - All Leads On
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

    When I click the Create Snippet button
    Then I should see the Snippet Document Edit View
    When I click the All Leads button "On"
    Then the All Leads toggle is switched "On"
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
