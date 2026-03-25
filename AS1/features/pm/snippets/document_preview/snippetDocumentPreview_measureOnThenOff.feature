@regression @doc_preview @automated @core
Feature: PM - Snippet Document Preview Measure On and Off
  Snippet Preview: Measurement values are displaying after measure is turn on then off

  User will go to Snippet screen
  click Measure button on
  click Measure button off
  click Create Snippet button
  On Snippet Doc Edit screen, no measurements display (they shouldnt because measure was turned off, Also when server
  has measuremented it config On then the measurement boxes should display empty)
  Click Preview button
  On Snippet Preview, measurements display accordingly to last values from when measurements were On. (they should only
  display labels with no values, because measure was turned off on tool screen)

  TestRail Id: C328919
  Jira Stories: AS1-2200

  @network_logs
  @TMS:328919
  Scenario: PM - Snippet Document Preview Measure On and Off
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
    When I click on Measure button
    Then I should see the Measure button "inactive"
    When I click the Create Snippet button
    Then I should see the Snippet Document Edit View
    When I click the Preview button on Snippet Document Edit View
    Then I should see the Snippet Document Preview window

    Then I should see the Snippet Preview Document display Patient Details
    Then I should see the Snippet Preview Document display Snippet Start/End Times HH:MM:SS format
    Then I should see the Snippet Preview Document display Measurements from snippet tool read blank with Measure Off
    Then I should see the Snippet Preview Document display HR value
    Then I should see the Snippet Preview Document display Snippet/Rhythm Strip Image
#    Then I should see the Snippet Preview Document display a Blank square that reads "No Measurements Taken" (This step requires PDF validation)
