@automated @core
Feature: listOfLists_navigation
  As an utang ONE user
  I want to navigate from the List of Lists to a patient and back to the List of Lists
  So that I can confirm correct navigational behavior of the List of Lists

  TestRail Id: C582644

  Jira Epic: AS1-2532
  Jira Stories:
  Jira Bugs/Defects: AS1-5216, AS1-5263

  Background:
#    Given my user is set up in AMP with the Module Instance Configuration of "Unspecified" or "PM"
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    Then I should see the patient list screen
    And I should see "Census" highlighted in blue on the List

  Scenario: List of Lists - Behavior upon signing in and navigating from and back to the List of Lists
    When I click "NOTIFICATIONS" on the List
    Then I should be on "NOTIFICATIONS" patientList
    And I should see "NOTIFICATIONS" highlighted in blue on the List
    When I click "Census" on the List
    Then I should see the patient list screen
    And I should be on "Census" patientList
    When I click on default patient in list without redirect
    Then I should see the Live Monitor screen
    When I click the Back button in patient header
    Then I should see the patient list screen
    And I should see "Census" highlighted in blue on the List
    When I click "MOST RECENT" on the List
    Then I should see the patient list screen
    And I should see "MOST RECENT" highlighted in blue on the List
    When I click on "[props.EMS_FULL_NAME]" in patient list
    Then I should see the ECG 12 lead screen
    When I click the Back button in patient header
    Then I should be on "MOST RECENT" patientList
    And I should see "MOST RECENT" highlighted in blue on the List