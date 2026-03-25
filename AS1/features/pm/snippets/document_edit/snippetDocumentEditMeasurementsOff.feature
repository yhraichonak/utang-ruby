@regression @nodeSim @automated @pm-snippets @pm-snippets-document_edit @TMS:316529
Feature: PM - Snippet Document Edit - Measurements Edit Flag Off

  AS1-7434
  When a field on the Snippet Document Edit Screen is not editable, provide a visual styling so that the user is aware that the field's Values cannot be edited (such as grey text instead of black, etc).
  Current examples of possible fields on Snippet Document edit screen are:
  Always Editable
  -HR
  Never Editable
  -QTc
  -Any Additional Discretes
  Dependent upon flag
  -PR
  -QRS
  -QT

  TestRail Id: C316529

  Jira Stories: AS1-165, AS1-424, AS1-426, AS1-599, AS1-1345, AS1-1365, AS1-1386, AS1-3053, AS1-7434

  Jira Bugs/Defects: AS1-8249
  Preconditions
  Background:
  # We need to find a way to automate turning amp modules on and off within our tests.
  # I'm leaving these steps in here to show what the structure of these steps might look like.
  # For now we have to go in and manually turn that setting off for the module. Which essentially makes this test useless.
#    Given I have access to the appropriate AMP per the Site
#    And I view the "PM" Module Instance
#    And I Disable the "Snippets Enable Edit Measurements" Config

  Scenario: PM - Snippet Document Edit - Measurements Edit Flag OFF
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    Then I should see the patient list screen
    When I click "Census" on the List
    Then I should see the patient list screen

    When I click on default patient in list without redirect
    Then I should see the Live Monitor screen
    When I click the "Tools" button in sub navigation menu
    Then I should see the Snippet Tool screen

    When I click the Create Snippet button
    Then I should see the Snippet Document Edit View

    And I should see the measurement placeholder "PR" from monitor tool
    And I should see the measurement placeholder "QRS" from monitor tool
    And I should see the measurement placeholder "QT" from monitor tool
    And I should see the measurement placeholder "QTc" from monitor tool
    And I should see the measurement values "HR" from monitor tool
    When I enter "90" in "HR" measurement value
    Then I should see the measurement values entered

    When I click the Cancel button on Snippet Document Edit View
    Then I should see Snippet Not Saved window
    When I click the Ok button in Snippet Not Saved window
    Then I should see the Snippet Tool screen

    When I click on Measure button
    Then I should see the Measure button "active"
    And I should see the HR legend in waveform chart
    And I should see calculating distances of PR, QRS, and QT values
    And I should see calculating distance of QTc value
    And I should see the Measure controls for P, Q/R, S, T

    When I click the Create Snippet button
    Then I should see the Snippet Document Edit View

    And I should see the measurement values "HR" from monitor tool
    And I should see the measurement placeholder "PR" from monitor tool
    And I should see the measurement placeholder "QRS" from monitor tool
    And I should see the measurement placeholder "QT" from monitor tool
    And I should see the measurement placeholder "QTc" from monitor tool

    And I should see the "HR" field is editable
    And I should see the "PR" field maybe editable
    And I should see the "QRS" field maybe editable
    And I should see the "QT" field maybe editable
    And I should see the "QTc" field is not editable

    When I click the Cancel button on Snippet Document Edit View
    Then I should see Snippet Not Saved window
    When I click the Ok button in Snippet Not Saved window
    Then I should see the Snippet Tool screen

    When I click on Measure button
    Then I should see the Measure button "inactive"
    When I click on Measure button
    Then I should see the Measure button "active"
    And I should see the HR legend in waveform chart
    Then I should see calculating distances of PR, QRS, and QT values
    And I should see calculating distances of QTc value
    And I should see the Measure controls for P, Q/R, S, T

    When I click on "P" Measure control
    Then I should see the "P" Measure control "disabled"
    And I should see the "PR" distance value as --

    When I click the Create Snippet button
    Then I should see the Snippet Document Edit View

    And I should see the measurement values "HR" from monitor tool
    And I should see the measurement placeholder "PR" from monitor tool
    And I should see the measurement placeholder "QRS" from monitor tool
    And I should see the measurement placeholder "QT" from monitor tool
    And I should see the measurement placeholder "QTc" from monitor tool

    When I click the Cancel button on Snippet Document Edit View
    Then I should see Snippet Not Saved window
    When I click the Ok button in Snippet Not Saved window
    Then I should see the Snippet Tool screen

    When I click on "P" Measure control
    Then I should see the "P" Measure control "enabled"
    When I click on "Q/R" Measure control
    Then I should see the "Q/R" Measure control "disabled"
    And I should see the "PR" distance value as --
    And I should see the "QRS" distance value as --
    And I should see the "QT" distance value as --
    And I should see the "QTc" distance value as --

    When I click the Create Snippet button
    Then I should see the Snippet Document Edit View

    And I should see the measurement values "HR" from monitor tool
    And I should see the measurement placeholder "PR" from monitor tool
    And I should see the measurement placeholder "QRS" from monitor tool
    And I should see the measurement placeholder "QT" from monitor tool
    And I should see the measurement placeholder "QTc" from monitor tool

    When I click the Cancel button on Snippet Document Edit View
    Then I should see Snippet Not Saved window
    When I click the Ok button in Snippet Not Saved window
    Then I should see the Snippet Tool screen

    When I click on "Q/R" Measure control
    Then I should see the "Q/R" Measure control "enabled"
    When I click on "S" Measure control
    Then I should see the "S" Measure control "disabled"
    And I should see the "QRS" distance value as --

    When I click the Create Snippet button
    Then I should see the Snippet Document Edit View

    And I should see the measurement values "HR" from monitor tool
    And I should see the measurement placeholder "PR" from monitor tool
    And I should see the measurement placeholder "QRS" from monitor tool
    And I should see the measurement placeholder "QT" from monitor tool
    And I should see the measurement placeholder "QTc" from monitor tool

    When I click the Cancel button on Snippet Document Edit View
    Then I should see Snippet Not Saved window
    When I click the Ok button in Snippet Not Saved window
    Then I should see the Snippet Tool screen

    When I click on "S" Measure control
    Then I should see the "S" Measure control "enabled"
    When I click on "T" Measure control
    Then I should see the "T" Measure control "disabled"
    And I should see the "QT" distance value as --

    When I click the Create Snippet button
    Then I should see the Snippet Document Edit View

    And I should see the measurement values "HR" from monitor tool
    And I should see the measurement placeholder "PR" from monitor tool
    And I should see the measurement placeholder "QRS" from monitor tool
    And I should see the measurement placeholder "QT" from monitor tool
    And I should see the measurement placeholder "QTc" from monitor tool
