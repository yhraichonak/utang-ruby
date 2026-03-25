@regression @automated @core @pm @pm-snippets @pm-snippets-document_edit
Feature: PM - Snippet Document Edit - Gridlines and Labels
  Grid Lines
  The Snippet Document Edit Waveform Preview Grid lines should be drawn to provide the user with a visual indicator
  to confirm measurements. (GE only at this time - provided mvPerPoint value) *TBD*
  Server will provide data to the client with the scale to draw grid lines.
  1 big box = 300 beats/min (duration = 0.2 sec)
  2 big boxes = 150 beats/min (duration = 0.4 sec)
  3 big boxes = 100 beats/min (duration = 0.6 sec)
  4 big boxes = 75 beats/min (duration = 0.8 sec)
  5 big boxes = 60 beats/min (duration = 1.0 sec)
  Grid lines color and opacity should be similar to Cardio Module Paper Mode (red) on the waveform Preview
  Grid lines (1x) should appear for ECG leads only on Monitor Tool (Snippets)
  *Note:- The gird lines are a point of reference for the waveform, It is not required for the waveform to snap to a
  specific axis of the grid lines

  Due to updates in the PDF layout, both the Dual lead image on the Document Edit Page and the Snippet PDF will need to
  include lead labels to the left of the image.

  Lead labels should be aligned with the lead, and placed to the left of the image.


  TestRail Id: C264289
  Jira Stories: AS1-164, AS1-489
  Jira Bugs/Defects: AS1-6838

  @critical @TMS:264289
  Scenario: PM - Snippet Document Edit - Gridlines and Labels
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    Then I should see the patient list screen
    When I click "Census" on the List
    Then I should see the patient list screen
    When I click on default patient in list without redirect
    Then I should see the Live Monitor screen
    When I click the "Tools" button in sub navigation menu

    Then I should see the Snippet Tool screen
    When I zoom "out" on snippet tool screen
    Then the snippet tool zoom value is set at "1"
    Then I should see the "[props.COMMON_ECG1]" waveform and "[props.COMMON_ECG2]" waveform in chart and rhythm strip on Snippet screen
    When I click the Create Snippet button
    Then I should see the Snippet Document Edit View
    When I scroll "down" on the Snippet Document Edit View
    When I click the Cancel button on Snippet Document Edit View
    Then I should see Snippet Not Saved window
    When I click the Ok button in Snippet Not Saved window

    Then I should see the Snippet Tool screen
    When I zoom "out" on snippet tool screen
    Then the snippet tool zoom value is set at "1"

    When I select "[props.COMMON_ECG3]" waveform in option 1 dropdown on Snippet screen
    Then I should see the "[props.COMMON_ECG3]" waveform and "[props.COMMON_ECG2]" waveform in chart and rhythm strip on Snippet screen

    When I click the Create Snippet button
    Then I should see the Snippet Document Edit View
    When I scroll "down" on the Snippet Document Edit View
    When I click the Cancel button on Snippet Document Edit View
    Then I should see Snippet Not Saved window
    When I click the Ok button in Snippet Not Saved window

    Then I should see the Snippet Tool screen
    When I zoom "out" on snippet tool screen
    Then the snippet tool zoom value is set at "1"
    When I select "[props.COMMON_ECG4]" waveform in option 1 dropdown on Snippet screen
    Then I should see the "[props.COMMON_ECG4]" waveform and "[props.COMMON_ECG2]" waveform in chart and rhythm strip on Snippet screen
    When I click the Create Snippet button
    Then I should see the Snippet Document Edit View
    When I scroll "down" on the Snippet Document Edit View
    When I click the Cancel button on Snippet Document Edit View
    Then I should see Snippet Not Saved window
    When I click the Ok button in Snippet Not Saved window

    Then I should see the Snippet Tool screen
    When I zoom "out" on snippet tool screen
    Then the snippet tool zoom value is set at "1"
    When I select "[props.COMMON_ECG5]" waveform in option 1 dropdown on Snippet screen
    Then I should see the "[props.COMMON_ECG5]" waveform and "[props.COMMON_ECG2]" waveform in chart and rhythm strip on Snippet screen
    When I click the Create Snippet button
    Then I should see the Snippet Document Edit View
    When I scroll "down" on the Snippet Document Edit View
    When I click the Cancel button on Snippet Document Edit View
    Then I should see Snippet Not Saved window
    When I click the Ok button in Snippet Not Saved window

    Then I should see the Snippet Tool screen
    When I zoom "out" on snippet tool screen
    Then the snippet tool zoom value is set at "1"
    When I select "[props.COMMON_ECG6]" waveform in option 1 dropdown on Snippet screen
    Then I should see the "[props.COMMON_ECG6]" waveform and "[props.COMMON_ECG2]" waveform in chart and rhythm strip on Snippet screen
    When I click the Create Snippet button
    Then I should see the Snippet Document Edit View
    When I scroll "down" on the Snippet Document Edit View
    When I click the Cancel button on Snippet Document Edit View
    Then I should see Snippet Not Saved window
    When I click the Ok button in Snippet Not Saved window

    Then I should see the Snippet Tool screen
    When I zoom "out" on snippet tool screen
    Then the snippet tool zoom value is set at "1"
    When I select "[props.COMMON_ECG7]" waveform in option 1 dropdown on Snippet screen
    Then I should see the "[props.COMMON_ECG7]" waveform and "[props.COMMON_ECG2]" waveform in chart and rhythm strip on Snippet screen
    When I click the Create Snippet button
    Then I should see the Snippet Document Edit View
    When I scroll "down" on the Snippet Document Edit View
    When I click the Cancel button on Snippet Document Edit View
    Then I should see Snippet Not Saved window
    When I click the Ok button in Snippet Not Saved window

#    Then I should see the Snippet Tool screen
#    When I zoom "out" on snippet tool screen
#    Then the snippet tool zoom value is set at "1"
#    When I select "[props.COMMON_ECG8]" waveform in option 1 dropdown on Snippet screen
#    Then I should see the "[props.COMMON_ECG8]" waveform and "[props.COMMON_ECG2]" waveform in chart and rhythm strip on Snippet screen
#    When I click the Create Snippet button
#    Then I should see the Snippet Document Edit View
#    When I scroll "down" on the Snippet Document Edit View
#    When I click the Cancel button on Snippet Document Edit View
#    Then I should see Snippet Not Saved window
#    When I click the Ok button in Snippet Not Saved window

    Then I should see the Snippet Tool screen
    When I zoom "out" on snippet tool screen
    Then the snippet tool zoom value is set at "1"
    When I select "none" waveform in option 2 dropdown on Snippet screen
    Then I should see the "[props.COMMON_ECG7]" waveform and "none" waveform in chart and rhythm strip on Snippet screen
    When I click the Create Snippet button
    Then I should see the Snippet Document Edit View
    When I scroll "down" on the Snippet Document Edit View
    When I click the Cancel button on Snippet Document Edit View
    Then I should see Snippet Not Saved window
    When I click the Ok button in Snippet Not Saved window

#    Then I should see the Snippet Tool screen
#    When I zoom "out" on snippet tool screen
#    Then the snippet tool zoom value is set at "1"
#    When I select "[props.COMMON_ECG7]" waveform in option 2 dropdown on Snippet screen
#    Then I should see the "[props.COMMON_ECG8]" waveform and "[props.COMMON_ECG7]" waveform in chart and rhythm strip on Snippet screen
#    When I click the Create Snippet button
#    Then I should see the Snippet Document Edit View
#    When I scroll "down" on the Snippet Document Edit View
#    When I click the Cancel button on Snippet Document Edit View
#    Then I should see Snippet Not Saved window
#    When I click the Ok button in Snippet Not Saved window

    Then I should see the Snippet Tool screen
    When I zoom "out" on snippet tool screen
    Then the snippet tool zoom value is set at "1"
    When I select "[props.COMMON_ECG6]" waveform in option 2 dropdown on Snippet screen
    Then I should see the "[props.COMMON_ECG7]" waveform and "[props.COMMON_ECG6]" waveform in chart and rhythm strip on Snippet screen
    When I click the Create Snippet button
    Then I should see the Snippet Document Edit View
    When I scroll "down" on the Snippet Document Edit View
    When I click the Cancel button on Snippet Document Edit View
    Then I should see Snippet Not Saved window
    When I click the Ok button in Snippet Not Saved window

    Then I should see the Snippet Tool screen
    When I zoom "out" on snippet tool screen
    Then the snippet tool zoom value is set at "1"
    When I select "[props.COMMON_ECG5]" waveform in option 2 dropdown on Snippet screen
    Then I should see the "[props.COMMON_ECG7]" waveform and "[props.COMMON_ECG5]" waveform in chart and rhythm strip on Snippet screen
    When I click the Create Snippet button
    Then I should see the Snippet Document Edit View
    When I scroll "down" on the Snippet Document Edit View
    When I click the Cancel button on Snippet Document Edit View
    Then I should see Snippet Not Saved window
    When I click the Ok button in Snippet Not Saved window

    Then I should see the Snippet Tool screen
    When I zoom "out" on snippet tool screen
    Then the snippet tool zoom value is set at "1"
    When I select "[props.COMMON_ECG4]" waveform in option 2 dropdown on Snippet screen
    Then I should see the "[props.COMMON_ECG7]" waveform and "[props.COMMON_ECG4]" waveform in chart and rhythm strip on Snippet screen
    When I click the Create Snippet button
    Then I should see the Snippet Document Edit View
    When I scroll "down" on the Snippet Document Edit View
    When I click the Cancel button on Snippet Document Edit View
    Then I should see Snippet Not Saved window
    When I click the Ok button in Snippet Not Saved window

    Then I should see the Snippet Tool screen
    When I zoom "out" on snippet tool screen
    Then the snippet tool zoom value is set at "1"
    When I select "[props.COMMON_ECG3]" waveform in option 2 dropdown on Snippet screen
    Then I should see the "[props.COMMON_ECG7]" waveform and "[props.COMMON_ECG3]" waveform in chart and rhythm strip on Snippet screen
    When I click the Create Snippet button
    Then I should see the Snippet Document Edit View
    When I scroll "down" on the Snippet Document Edit View
    When I click the Cancel button on Snippet Document Edit View
    Then I should see Snippet Not Saved window
    When I click the Ok button in Snippet Not Saved window

    Then I should see the Snippet Tool screen
    When I zoom "out" on snippet tool screen
    Then the snippet tool zoom value is set at "1"
    When I select "[props.COMMON_ECG2]" waveform in option 2 dropdown on Snippet screen
    Then I should see the "[props.COMMON_ECG7]" waveform and "[props.COMMON_ECG2]" waveform in chart and rhythm strip on Snippet screen
    When I click the Create Snippet button
    Then I should see the Snippet Document Edit View
    When I scroll "down" on the Snippet Document Edit View
    When I click the Cancel button on Snippet Document Edit View
    Then I should see Snippet Not Saved window
    When I click the Ok button in Snippet Not Saved window

    Then I should see the Snippet Tool screen
    When I zoom "out" on snippet tool screen
    Then the snippet tool zoom value is set at "1"
    When I select "[props.COMMON_ECG1]" waveform in option 2 dropdown on Snippet screen
    Then I should see the "[props.COMMON_ECG7]" waveform and "[props.COMMON_ECG1]" waveform in chart and rhythm strip on Snippet screen
    When I click the Create Snippet button
    Then I should see the Snippet Document Edit View
    When I scroll "down" on the Snippet Document Edit View
    When I click the Cancel button on Snippet Document Edit View
    Then I should see Snippet Not Saved window
    When I click the Ok button in Snippet Not Saved window

    Then I should see the Snippet Tool screen
    When I zoom "out" on snippet tool screen
    Then the snippet tool zoom value is set at "1"
    When I select "[props.COMMON_ECG3]" waveform in option 1 dropdown on Snippet screen
    When I select "[props.COMMON_ECG4]" waveform in option 2 dropdown on Snippet screen
    Then I should see the "[props.COMMON_ECG3]" waveform and "[props.COMMON_ECG4]" waveform in chart and rhythm strip on Snippet screen
    When I click the Create Snippet button
    Then I should see the Snippet Document Edit View
    When I scroll "down" on the Snippet Document Edit View
    When I click the Cancel button on Snippet Document Edit View
    Then I should see Snippet Not Saved window
    When I click the Ok button in Snippet Not Saved window

    Then I should see the Snippet Tool screen
    When I zoom "out" on snippet tool screen
    Then the snippet tool zoom value is set at "1"
    When I select "[props.COMMON_ECG5]" waveform in option 1 dropdown on Snippet screen
    When I select "[props.COMMON_ECG6]" waveform in option 2 dropdown on Snippet screen
    Then I should see the "[props.COMMON_ECG5]" waveform and "[props.COMMON_ECG6]" waveform in chart and rhythm strip on Snippet screen
    When I click the Create Snippet button
    Then I should see the Snippet Document Edit View
    When I scroll "down" on the Snippet Document Edit View


