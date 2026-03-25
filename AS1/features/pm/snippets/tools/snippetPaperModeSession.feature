@regression @automated @core @pm @pm-snippets @pm-snippets-tools
Feature: PM - Monitor Tool - Paper Mode Session

Note: automated test will not work due to selenium doesn't keep session

TestRail Id: C264272
Jira Stories: AS1-303, AS1-569, AS1-1501
@critical @TMS:264272
Scenario: PM - Monitor Tool - Paper Mode Session
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

  When I click the Paper Mode toggle
  Then I should see the Snippet Tool screen with Paper Mode "On"

  When I logout of application
  And I should see login screen
  When I login to a testSite with "utang" and "XXXXX"
  Then I should see the patient list screen
  When I click "Census" on the List
  Then I should see the patient list screen

  When I click on default patient in list
  Then I should see the patient summary screen

  When I click the "Monitor" link in main navigation menu
  Then I should see the Live Monitor screen
  When I click the "Tools" button in sub navigation menu
  Then I should see the Snippet Tool screen with Paper Mode "On"

