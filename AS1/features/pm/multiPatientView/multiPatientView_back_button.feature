@automated @pm @pm-multi_patient_view
Feature: Multi-Patient View - back button

TestRail Id: C581745

Jira Epic: AS1-2809

Jira Stories: AS1-3675

Jira Bugs/Defects: AS1-4452

Background:
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    Then I should see the patient list screen
    And I clear grouping on patients list
    And reset unit filtering
    When I click "My Patients" on the List
    And I have 16 or more patients added to My Patients List
    Then I should see the patient list screen
    When I click the Multi-Patient View button in header
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I should see patients demographics, location, alarms, and 1 waveform with parameters in each condensed monitor
    And I should see default sort by Bed left to right then top to bottom
    And I should see the zoom control toggle in header
    And I should see condensed monitor control button in header
    And I should see condensed monitor control button is enabled in the header
    And I should see dual monitor control button in header
    And I should see quad monitor control button in header
    And I should see 6 view monitor control button in header
    And I should see 9 view monitor control button in header
    And I should see 12 view monitor control button in header
    And I should see 16 view monitor control button in header
@critical @TMS:581745
Scenario: Multi-Patient View - back button
    When I click the back button in the Header
    Then I should see the patient list screen
    When I click the Multi-Patient View button in header
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode

    When I click the dual monitor control button in the header
    Then I should see 2 full monitors on the screen of the first 2 patients in previous screen
    And I should see the back button in the header
    When I click the back button in the Header
    Then I should see the patient list screen
    When I click the Multi-Patient View button in header
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I should see the back button in the header

    When I click the quad monitor control button in the header
    Then I should see 4 full monitors on the screen of the first 4 patients in previous screen
    And I should see the back button in the header
    When I click the back button in the Header
    Then I should see the patient list screen
    When I click the Multi-Patient View button in header
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I should see the back button in the header

    When I click the 6 view monitor control button in the header
    Then I should see 6 full monitors on the screen of the first 6 patients in previous screen
    And I should see the back button in the header
    When I click the back button in the Header
    Then I should see the patient list screen
    When I click the Multi-Patient View button in header
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I should see the back button in the header

    When I click the 9 view monitor control button in the header
    Then I should see 9 full monitors on the screen of the first 9 patients in previous screen
    And I should see the back button in the header
    When I click the back button in the Header
    Then I should see the patient list screen
    When I click the Multi-Patient View button in header
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I should see the back button in the header

    When I click the 12 view monitor control button in the header
    Then I should see 12 full monitors on the screen of the first 12 patients in previous screen
    And I should see the back button in the header
    When I click the back button in the Header
    Then I should see the patient list screen
    When I click the Multi-Patient View button in header
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I should see the back button in the header

    When I click the 16 view monitor control button in the header
    Then I should see 16 full monitors on the screen of the first 16 patients in previous screen
    And I should see the back button in the header
    When I click the back button in the Header
    Then I should see the patient list screen

    When I click "Census" on the List
    Then I should see the patient list screen
    When I click the Multi-Patient View button in header
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I should see the back button in the header
    When I click the back button in the Header
    Then I should see the patient list screen
    When I click the Multi-Patient View button in header

    When I click the dual monitor control button in the header
    Then I should see 2 full monitors on the screen of the first 2 patients in previous screen
    And I should see the back button in the header
    When I click the back button in the Header
    Then I should see the patient list screen
    When I click the Multi-Patient View button in header
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I should see the back button in the header

    When I click the quad monitor control button in the header
    Then I should see 4 full monitors on the screen of the first 4 patients in previous screen
    And I should see the back button in the header
    When I click the back button in the Header
    Then I should see the patient list screen
    When I click the Multi-Patient View button in header
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I should see the back button in the header

    When I click the 6 view monitor control button in the header
    Then I should see 6 full monitors on the screen of the first 6 patients in previous screen
    And I should see the back button in the header
    When I click the back button in the Header
    Then I should see the patient list screen
    When I click the Multi-Patient View button in header
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I should see the back button in the header

    When I click the 9 view monitor control button in the header
    Then I should see 9 full monitors on the screen of the first 8 patients in previous screen
    And I should see the back button in the header
    When I click the back button in the Header
    Then I should see the patient list screen
    When I click the Multi-Patient View button in header
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I should see the back button in the header

    When I click the 12 view monitor control button in the header
    Then I should see 12 full monitors on the screen of the first 12 patients in previous screen
    And I should see the back button in the header
    When I click the back button in the Header
    Then I should see the patient list screen
    When I click the Multi-Patient View button in header
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I should see the back button in the header

    When I click the 16 view monitor control button in the header
    Then I should see 16 full monitors on the screen of the first 16 patients in previous screen
    And I should see the back button in the header
