@regression @doc_preview @nodeSim @automated @core @pm @pm-snippets @pm-snippets-document_preview
Feature: PM - Snippet Document Preview Layout - 120 seconds

  TestRail Id: C264396
  Jira Stories: AS1-161, AS1-622, AS1-1715, AS1-1742, AS1-2812, AS1-2933, AS1-3015, AS1-3022

  @critical @TMS:264396
  Scenario: PM - Snippet Document Preview Layout - 120 seconds
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

    When I zoom "out" on snippet tool screen
    Then the snippet tool zoom value is set at "1"

    When I select "120 seconds" in option dropdown on Snippet screen
    Then I should see the "[props.COMMON_ECG1]" waveform and "[props.COMMON_ECG2]" waveform in chart and rhythm strip on Snippet screen

    When I click the Create Snippet button
    Then I should see the Snippet Document Edit View
    And I should see a messaging loading bar for snippets data selected in future
    And I should see the All Leads, Preview, OK buttons disabled until page loads
    When I click the Preview button on Snippet Document Edit View
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
    When I scroll the Snippet Preview Document "down"
    Then I should see the Snippet Document Preview window
    When I scroll the Snippet Preview Document "down"
    Then I should see the Snippet Document Preview window
    When I scroll the Snippet Preview Document "right"
    When I scroll the Snippet Preview Document "right"
    Then I should see the Snippet Document Preview window
