@regression @doc_preview @manual
Feature: PM - Snippet Document Preview Layout - Manual measurements

  Send flag when measurements/HR edited
  If the user has edited measurements (deleting or changing the values populated from the measurement tool, or
  adding values when no measurements were taken) a line of text will be added to the PDF measurements.

  Send a flag to the server with PDF document data when the user has edited measurements fields so that the server
  can display conditional text on the PDF.

  If the user has edited HR(deleting or changing the values populated from the source system, or adding HR when no
  HR was provided) a line of text will be added to the PDF HR.

  Send a flag to the server with PDF document data when the user has edited HR field so that the server can
  display conditional text on the PDF.

  TestRail Id: C264440

  Jira Epic:

  Jira Stories: AS1-160

  Jira Bugs/Defect: AS1-7290, AS1-7288

  @TMS:264440 @network_logs
  Scenario: PM - Snippet Document Preview Layout - Manual Measurements
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
    When I enter "90" in "HR" measurement value
    And I enter ".20" in "PR" measurement value
    And I enter ".06" in "QRS" measurement value
    And I enter ".30" in "QT" measurement value
    Then I should see the measurement values entered

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
