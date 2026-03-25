@regression @doc_preview @automated @core @pm @pm-snippets @pm-snippets-document_preview
Feature: PM - Snippet Document Preview Layout - 30 seconds

TestRail Id: C264394
Jira Stories: AS1-161, AS1-622
 @critical @TMS:264394
Scenario: PM - Snippet Document Preview Layout - 30 seconds
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

  When I select "30 seconds" in option dropdown on Snippet screen
  Then I should see the "[props.COMMON_ECG1]" waveform and "[props.COMMON_ECG2]" waveform in chart and rhythm strip on Snippet screen

  When I click the Create Snippet button
  Then I should see the Snippet Document Edit View
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
  When I scroll the Snippet Preview Document "right"
  When I scroll the Snippet Preview Document "right"
  Then I should see the Snippet Document Preview window
