@automated @core
Feature: PM - Choose Date


TestRail Id: C582309
Jira Stories: AS1-4242
  @TMS:582309
  Scenario: PM - Choose Date
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
	Then I should see the patient list screen
  And reset unit filtering
  When I click "Census" on the List
  Then I should see the patient list screen
  When I click on "[props.AP_FULL_NAME]" in patient list
  Then I should see the patient summary screen
  When I click on the Monitor tile
  Then I should see the Live Monitor screen
  When I click the "Select Time" button in sub navigation menu
  Then I should see the Select Time window
  When I click day select box
  Then I should see number of dates configured listed in datefield
  And I should not see an option to choose a future day
  When I click the cancel button on Select Time Window
  Then I should see the Live Monitor screen
  When I click the "Tools" button in sub navigation menu
  Then I should see the Snippet Tool screen
  When I click the "Select Time" button in sub navigation menu
  Then I should see the Select Time window
  When I click day select box
  Then I should see number of dates configured listed in datefield
  And I should not see an option to choose a future day
