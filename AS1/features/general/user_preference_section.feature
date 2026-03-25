@regression @automated @general @TMS:582859
Feature: user_preference_section.feature
  As a utang ONE user
  I want to add a User Preference section
  Where a user can set preference that are saved across sessions
  And override system preferences

  AS1-6198
  Create a web “User Preferences” page which will be accessible from web menu/dropdown (where About and Logout currently exist)
  Should be a large popover similar to “About” page for styling
  Contains a discrete button for closing this page/applying settings when complete
  User preferences page will be contain a label/header “Preferences” (or “User Preferences”) TBD
  Will contain various preferences for the user to select; will need to support the following preferences selection types

  Flags (e.g. Paper mode On/Off, sweep mode on/off)
  Strings
  dropdown (e.g. Role select User type A or User type B )

  TestRail Id: C582859

  Jira Epic: AS1-6285

  Jira Stories: AS1-6198

  Jira Bugs/Defects:

  Scenario: User preference displays
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    Then I should see the patient list screen
    When I click the username dropdown indicator
    Then I click the Preferences button
    Then I should see the Preferences window
    When I click on Done button on the Preferences screen
    Then I should see the patient list screen