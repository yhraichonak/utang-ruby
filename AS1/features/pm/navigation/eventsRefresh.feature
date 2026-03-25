@regression @automated @core @pm @pm-navigation
Feature: Events - Refresh Navigation
  Description
  Clicking a Primary or Secondary navigation item should result in a reload of the current navigational element.
  This occurs when:Selecting a primary navigation item which does not navigate the user away from the current screen
  (due to already viewing default secondary navigation)

  Selecting a secondary navigation item which is currently "Active"

  TestRail Id: C328944
  Jira Issues: AS1-1802, AS1-3047

  Scenario: Events - Refresh Navigation
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    Then I should see the patient list screen
    And reset unit filtering
    When I click "Census" on the List
    Then I should see the patient list screen
    When I click on default patient in list without redirect
    Then I should see the Live Monitor screen
    When I click the "Events" button in sub navigation menu
    Then I should see the Events screen

    When I click the "Events" button in sub navigation menu
    Then I should see the Events screen
#  And I should see the Events screen refresh (Need to make api call to create events which needs to be used after screen refresh)
