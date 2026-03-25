@regression @automated @core @pm @pm-navigation
Feature: Snippet Tool - Refresh Navigation
Description
Clicking a Primary or Secondary navigation item should result in a reload of the current navigational element.  This occurs when:

Selecting a primary navigation item which does not navigate the user away from the current screen (due to already viewing default secondary navigation)

Selecting a secondary navigation item which is currently "Active"

TestRail Id: C328945
Jira Issues: AS1-1802, AS1-3047
@critical @TMS:328945
Scenario: Snippet Tool - Refresh Navigation
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
	Then I should see the patient list screen
  And reset unit filtering
  When I click "Census" on the List
  Then I should see the patient list screen
	When I click on "[props.DP_FULL_NAME]" in patient list
  Then I should see the patient summary screen
  When I click on the Monitor tile
  Then I should see the Live Monitor screen
  When I click the "Tools" button in sub navigation menu
  Then I should see the Snippet Tool screen

  When I click the "Tools" button in sub navigation menu
  Then I should see the Snippet Tool screen
  And I should see the Snippet Tool refresh
