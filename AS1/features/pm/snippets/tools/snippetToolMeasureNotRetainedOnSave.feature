@regression @automated @core @pm @pm-snippets @pm-snippets-tools
Feature: PM - Monitor Tool - Measurements not Retained After Snippet Save
  Description
  per Andy at CCF

  Issue 2 – Snippet section shown is wrong
  It’s kind of a complicated workflow, but I don’t think it’s unlikely.  Here are the steps with some screenshots:
  1.	Do a snippet from selecting a time – i.e. 1600
  2.	Save the snippet as normal and you’ll be brought back to the 1600 view (green/black view)
  3.	Click the Live button to see the Live waveforms
  4.	Select Tools
  5.	Here is part of the problem – Measure is still selected and the HR, PR, QRS, QT, and QTc are still populated.
  Those values are actually from the 1600 time.  The waveform section shown is the 1634 time, but the markers are actually back at 1600.
  6.	If I don’t reselect Measure and just select Create Snippet, the Snippet will be from 1600 – not the strip they were seeing on the screen before.
  7.	The issue is that somehow that Measure is staying selected between Snippets.  If users aren’t careful or get distracted and
  don’t realize they need to deselect Measure and reselect it they will get a strip that’s different than what they expected.

  TestRail Id: C581600
  Jira Stories: AS1-3798

  @critical @TMS:581600
  Scenario: PM - Monitor Tool - Measurements not Retained After Snippet Save
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    Then I should see the patient list screen
    When I click "Census" on the List
    Then I should see the patient list screen
    When I click on default patient in list without redirect
    Then I should see the Live Monitor screen
    When I click the "Tools" button in sub navigation menu
    Then I should see the Snippet Tool screen
    And I should see the Measure button "inactive"
    And I should see the HR legend in waveform chart
    When I click on Measure button
    Then I should see the Measure button "active"
    And I should see the HR legend in waveform chart
    And I should see calculating distances of PR, QRS, and QT values
    And I should see calculating distances of QTc value
    And I should see the Measure controls for P, Q/R, S, T
    And I record original measurement values
    When I drag the "P" Measure control to the "left"
    Then I should see the "PR" distance value "increase"
    When I drag the "Q/R" Measure control to the "left"
    Then I should see the "QRS" distance value "increase"
    When I drag the "S" Measure control to the "right"
    Then I should see the "QRS" distance value "increase"
    When I drag the "T" Measure control to the "right"
    Then I should see the "QT" distance value "increase"
    And I should see calculating distances of PR, QRS, and QT values
    And I should see calculating distances of QTc value
    And I should see the Measure controls for P, Q/R, S, T

    When I click the Create Snippet button
    Then I should see the Snippet Document Edit View
    When I click the Cancel button on Snippet Document Edit View
    Then I should see Snippet Not Saved window
    When I click the Ok button in Snippet Not Saved window
    Then I should see the Snippet Tool screen
    And I should see measurement distances retaining their previous values

    When I click the Create Snippet button
    Then I should see the Snippet Document Edit View
    And I should not see PM Navigation link

    When I click the Save button on Snippet Document Edit screen
    Then I see Snippet Saved notification window

    When I click OK button Snippet Saved notification window
    Then I should see the Live Monitor screen
    And the "Live" button is inactive

    When I click the "Tools" button in sub navigation menu
    Then I should see the Snippet Tool screen
    And I should see the Measure button "inactive"
    And I should see the HR legend in waveform chart
