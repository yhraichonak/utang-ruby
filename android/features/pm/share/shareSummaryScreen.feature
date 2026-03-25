@automated @TMS:40326  @pm @pm-share @regression @bvt
Feature: Share: Share Patient Summary Screen
  As an AS1 user
  I want to share Patient Summary Screen
  So that I can make sure I can share the patient summary screen

  TestRail Id: C40326

  Scenario: Share: Share Patient Summary Screen
	Given I am a super user with all permissions
    When I login to a testSite with a valid credential
	When I click the AS1 button
	When I click "PM Census" on the List
	Then I should see the patient List
	When I select Search from the PM census
	When I enter "[props.DP_FULL_NAME]" in the field
	When I click on "[props.DP_FULL_NAME]" in patient list
	Then I should see the Live Monitor screen
	When I click the Home button
	Then I should see the patient summary screen
	When I select the share icon from the menu
	Then I should see the Share Patient Details window
	And I should see the recipient edit text field
	And I should see the share link icon on the Share Patient Details screen
	And I should see the share link label display "[props.DP_FULL_NAME]"
	And I should see the type message field
	And I should see the send message airplane button
	And I should see the cancel message button
	When I select recipient edit text field
	Then I should see the Choose Contact List
	When I select "[props.SC_NAME]" from the Choose Contact List
	Then the recipient edit text field should display "[props.SC_NAME]"
	When I enter "Automation testing" in the message field on the Share Patient Details screen
	And I select the send message airplane button
	Then the Success response alert displays
	When I click the View Conversation button on the Success Alert
	Then I should see "Automation testing" display in the conversation
	And I should see the "Automation testing" message and the share link label displays the patient name "[props.DP_FULL_NAME]"
