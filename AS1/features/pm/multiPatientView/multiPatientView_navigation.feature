@smoke @automated @multiPatient @regression   @pm @pm-multi_patient_view @TMS:580254
Feature: Multi-Patient View - navigation
  NAVIGATION:
  Tapping on the Multi-Patient View menu item within the List of Lists will present the user with the Multi-Patient View screen and List of List should disappear.

  Note: Currently, if you click other items from List of list, the List of List  does not disappear.
  Tapping the home icon returns the user to the previous screen.

  Clicking on a waveform from any Condensed Patient Monitor box, creates a split view, with A row of all condensed monitors for the unit, and then the remaining space is taken up by the Patient Monitor.   The Patient monitor is to function as a fully capable monitor with all PM features, constrained by in this space, including Tools, Events, Snippets, and other.

  Closing the split window view closes the Patient Monitor and returns the user to the Multi-Patient view.

  Or, clicking Home enables the user to return to the List of Lists

  INTERACTIVITY
  Clicking on a waveform from any Condensed Patient Monitor box, opens the PM Monitor (as a preview)
  The user can Navigate back to the previous screen by

  1.)	Tapping Close button returns the user to the previous screen (Multi-Patient View)
  2.)	Tapping on any Condensed Patient Monitor box returns user to the previous screen (Multi-Patient View)

  TestRail Id: C580254

  Jira Epic:

  Jira Stories: AS1-2817,AS1-2818, AS1-3025, AS1-3160, AS1-3534, AS1-3470

  Jira Bugs/Defects: AS1-2843, AS1-2853, AS1-2901, AS1-2907, AS1-2909, AS1-3642, AS1-4123, AS1-4603, AS1-5074, AS1-5268, AS1-5588, AS1-5634, AS1-6796, AS1-6833, AS1-6857, AS1-6796
@critical
  Scenario: Multi-Patient View - navigation
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    Then I should see the patient list screen
    And reset unit filtering
    When I clear grouping on patients list
    And I click on patient "[props.MPV_FULL_NAME]" star icon to "enabled"
    When I click "My Patients" on the List
    And I have 16 or more patients added to My Patients List
    Then I should see the patient list screen
    When I collect "My Patients" patient list data
    And I click the Multi-Patient View button in header
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I should see the same patients in MPV as on the "My Patients" list view
    And I should see patients demographics, location, alarms, and 1 waveform with parameters in each condensed monitor
    And I should see default sort by Bed left to right then top to bottom
    And I should see the zoom control toggle displays as "enabled" in header
    And I should see condensed monitor control button in header
    And I should see condensed monitor control button is enabled in the header
    And I should see dual monitor control button in header
    And I should see quad monitor control button in header
    And I should see 6 view monitor control button in header
    And I should see 9 view monitor control button in header
    And I should see 12 view monitor control button in header
    And I should see 16 view monitor control button in header

    When I click on individual condensed patient monitor on Multi Patient View screen
    Then I should see the selected patient monitor open on left side of Multi Patient View in split screen mode
    And I should not see a blank screen
    And I should see the zoom control toggle displays as "enabled" in header
    When I click on individual condensed patient monitor on Multi Patient View screen
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I should see the zoom control toggle displays as "enabled" in header

    When I click the dual monitor control button in the header
    And I should see dual monitor control button is enabled in the header
    Then I should see 2 full monitors on the screen of the first 2 patients in previous screen
    And I should see the zoom control toggle displays as "disabled" in header

    When I click the quad monitor control button in the header
    And I should see quad monitor control button is enabled in the header
    Then I should see 4 full monitors on the screen of the first 4 patients in previous screen
    And I should see the zoom control toggle displays as "disabled" in header

    When I click the 6 view monitor control button in the header
    And I should see 6 view monitor control button is enabled in the header
    Then I should see 6 full monitors on the screen of the first 6 patients in previous screen
    And I should see the zoom control toggle displays as "disabled" in header

    When I click the 9 view monitor control button in the header
    And I should see 9 view monitor control button is enabled in the header
    Then I should see 9 full monitors on the screen of the first 9 patients in previous screen
    And I should see the zoom control toggle displays as "disabled" in header

    When I click the 12 view monitor control button in the header
    And I should see 12 view monitor control button is enabled in the header
    Then I should see 12 full monitors on the screen of the first 12 patients in previous screen

    When I click the 16 view monitor control button in the header
    And I should see 16 view monitor control button is enabled in the header
    Then I should see 16 full monitors on the screen of the first 16 patients in previous screen

    When I click the Home icon
    Then I should see the patient list screen
    And I should be on "My Patient" patientList

    When I click "Census" on the List
    Then I should see the patient list screen
    When I click the Multi-Patient View button in header
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I should see Filter Units links enabled
    And I should see patients demographics, location, alarms, and 1 waveform with parameters in each condensed monitor
    And I should see default sort by Bed left to right then top to bottom
    And I should see the zoom control toggle displays as "enabled" in header
    And I should see condensed monitor control button in header
    And I should see condensed monitor control button is enabled in the header
    And I should see dual monitor control button in header
    And I should see quad monitor control button in header
    And I should see 6 view monitor control button in header
    And I should see 9 view monitor control button in header
    And I should see 12 view monitor control button in header
    And I should see 16 view monitor control button in header
    And I should see message "Too many beds have been selected for display. Only the first 40 may be viewed. Please adjust your filter settings."

    When I click on individual condensed patient monitor on Multi Patient View screen
    Then I should see the selected patient monitor open on left side of Multi Patient View in split screen mode
    And I should see the zoom control toggle displays as "enabled" in header
    When I click on individual condensed patient monitor on Multi Patient View screen
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I should see the zoom control toggle displays as "enabled" in header
    And I should see message "Too many beds have been selected for display. Only the first 40 may be viewed. Please adjust your filter settings."

    When I click the dual monitor control button in the header
    And I should see dual monitor control button is enabled in the header
    Then I should see 2 full monitors on the screen of the first 2 patients in previous screen
    And I should see the zoom control toggle displays as "disabled" in header
    And I should see not message "Too many beds have been selected for display. Only the first 40 may be viewed. Please adjust your filter settings."

    When I click the quad monitor control button in the header
    And I should see quad monitor control button is enabled in the header
    Then I should see 4 full monitors on the screen of the first 2 patients in previous screen
    And I should see the zoom control toggle displays as "disabled" in header
    And I should see not message "Too many beds have been selected for display. Only the first 40 may be viewed. Please adjust your filter settings."

    When I click the 6 view monitor control button in the header
    And I should see 6 view monitor control button is enabled in the header
    Then I should see 6 full monitors on the screen of the first 6 patients in previous screen
    And I should see the zoom control toggle displays as "disabled" in header
    And I should see not message "Too many beds have been selected for display. Only the first 40 may be viewed. Please adjust your filter settings."

    When I click the 9 view monitor control button in the header
    And I should see 9 view monitor control button is enabled in the header
    Then I should see 9 full monitors on the screen of the first 9 patients in previous screen
    And I should see the zoom control toggle displays as "disabled" in header
    And I should see not message "Too many beds have been selected for display. Only the first 40 may be viewed. Please adjust your filter settings."

    When I click the 12 view monitor control button in the header
    And I should see 12 view monitor control button is enabled in the header
    Then I should see 12 full monitors on the screen of the first 12 patients in previous screen
    And I should see the zoom control toggle displays as "disabled" in header
    And I should see not message "Too many beds have been selected for display. Only the first 40 may be viewed. Please adjust your filter settings."

    When I click the 16 view monitor control button in the header
    And I should see 16 view monitor control button is enabled in the header
    Then I should see 16 full monitors on the screen of the first 16 patients in previous screen
    And I should see the zoom control toggle displays as "disabled" in header
    And I should see not message "Too many beds have been selected for display. Only the first 40 may be viewed. Please adjust your filter settings."

    When I click the Multi-Patient View button on MPV screen
    Then I should see the patient list screen

    #When I click "Census" on the List
    #Then I should see the patient list screen
    #When I click on the "Unit Filter" button
    #Then I should see the Unit Filter screen appear
    #When I click the "Toggle All" button
    #Then I should see all the units toggled to Off
    #When I click the toggle button for the Red unit #any unit with less than 40 patients
    #Then I should see the Red unit toggled to On
    #When I click the "OK" button
    #Then I should see the Census screen
    #And I should see that only the Red unit is displayed
    #When I click the Multi-Patient View button in header
    #Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    #And I should see that only the Red unit is displayed
    #And I should not see the message "Too many beds have been selected for display. Only the first 40 may be viewed. Please adjust your filter settings."
    # (AS1-5588)

  Scenario: MPV - Navigation between greater and lesser views
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    And I click "Census" on the List
    Then I should see the patient list screen
    When I clear grouping on patients list
    And I click on patient "[props.MPV_FULL_NAME]" star icon to "enabled"
    When I click the Multi-Patient View button in header
    Then I should see Condensed View screen for the Main Census
    And I click on individual condensed patient monitor on Multi Patient View screen
    And I should see the selected patient monitor open on left side of Multi Patient View in split screen mode
    When I click on the "2" button
    Then I should see the Dual View screen
    When I click the "[props.COMMON_SITE_NAME]" button in the main header
    Then I should see the patient list screen

    And I click "My Patients" on the List
    And I should be on "My Patient" patientList
    When I click the Multi-Patient View button in header
    Then I should see Condensed View screen for the Main Census
    When I click on the "2" button
    Then I should see the Dual View screen
    When I click on the "6" button
    Then I should see the six view screen
    When I click on the "4" button
    Then I should see the quad view screen
    When I click the "[props.COMMON_SITE_NAME]" button in the main header
    Then I should be on "My Patient" patientList
    When I click "OR Floor 1" on the List
    Then I should see the patient list screen
    When I click the Multi-Patient View button in header
    Then I should see Condensed View screen for the Main Census
    When I click on the "4" button
    Then I should see the quad view screen
    When I click on the "9" button
    Then I should see the nine view screen

    When I click on the "4" button
    Then I should see the quad view screen
    When I click the "[props.COMMON_SITE_NAME]" button in the main header
    Then I should see the patient list screen
