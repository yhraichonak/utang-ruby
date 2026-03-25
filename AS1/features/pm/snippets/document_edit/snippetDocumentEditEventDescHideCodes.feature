@regression @manual @automated
  # This test needs to be run on RC-3 branch of web client
Feature: PM - Snippet Document Edit - Event Description Hides Codes
  Description
  Hide Snippet Event Description Code - Configurable
  the Code + Text displayed in Snippet Event Description does not allow for blank items. CCF requested to remove the
  Code (it is currently displayed 1, 2, etc.) because they are not using that field.

  Create a configurable option to hide all or show all snippet event description codes for a site so that the end user
  does not see the numbers that come across in event description (see screenshot)

  Expected results of this change (both scenarios would have same AMP Snippet Event Description as seen in attachment)

  If configured to display all codes, UI would display as Event Descriptions:
  1 - Asystole (Ventricular Standstill)
  2 - Atrial Fibrillation
  etc
  If configured to hide all codes, UI would display as event Descriptions:
  Asystole (Ventricular Standstill)
  Atrial Fibrillation
  etc
  edit by Shane
  2 new fields will be optionally added/provided by the server in the userpreferences model. The default for both fields
  will be "true" if the server fails to provide them.

  "userPreferences":
  {
  "server":
  {
  "pm":
  {
  "snippetsShowStatementCodes": false,
  "snippetsEnableDescriptionFreeText": true
  }
  }
  }

  TestRail Id: C316528
  Jira Epic: AS1-2508
  Jira Stories: AS1-167
  @critical @TMS:316528
  Scenario: PM - Snippet Document Edit - Event Description Hide Codes
    Given I login to a testSite with "utang" and "XXXXX"
    Then I should see the patient list screen
    When I click "Census" on the List
    Then I should see the patient list screen
    When I click on default patient in list without redirect
    Then I should see the Live Monitor screen
    When I click the "Tools" button in sub navigation menu
    Then I should see the Snippet Tool screen
    When I click the Create Snippet button
    Then I should see the Snippet Document Edit View
    When I click into the Event Description field
    Then I should see a selectable list from the server
    When I select "Sinus tachycardia" from Event Description dropdown
    Then I should see "Sinus tachycardia" description in Event Description field
    And I remove the value of "Sinus tachycardia" in the selectable list from the server
    Then I should see the Snippet Document Edit View
    And I should see not "Sinus tachycardia" description in Event Description field
    When I type "Normal sinus rhythm" into the Event Description field
    Then I should see the value of "Normal sinus rhythm" in the selectable list from the server
    And I should see at least 1 events in selectable list
    When I select "Normal sinus rhythm" from Event Description dropdown
    Then I should see "Normal sinus rhythm" description in Event Description field
