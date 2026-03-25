@regression @automated @core @pm @pm-snippets @pm-snippets-tools
Feature: PM - Snippet Screen Layout Disabled User
Continue Button
When Snippets is ON a Continue button will display, right aligned in details header.
When Snippets is OFF the Continue button will be hidden.

*Note: The Snippet Document edit screen will provide the user with a visual, editable representation of the information that will eventually be provided in a finalized Snippet PDF. Therefore, the items selected in the Snippet workflow before selecting "Continue" will be brought through the workflow. (i.e. the "Rhythm Strip" from the Monitor Tool can be used for the Waveform Preview)

Caliper Tool should disable Continue when Snippets ON
_User should not be able to use the Caliper tool to document or create a snippet.

When all of the following are true, Continue is disabled:

Snippets is configured to be ON
Continue Button Present
Caliper tool is ON
the Continue button should be disabled/greyed out (different from "hidden" in other scenarios) so that the user cannot continue the snippet workflow in this mode. In the disabled state, the user can hover over the button to view a message.

Hover Message:
"Snippet creation is disabled in Caliper mode"

Note: This is only when Caliper Tool is ON. When continue button is present, user should still be able to select "Continue" when Measure ON or if neither measure tool is used (i.e. Measure AND Caliper OFF)

TestRail Id: C264372
Jira Stories: AS1-157, AS1-154
  @TMS:264372
Scenario: PM - Snippet Screen Layout Disabled User
  Given I am a super user with no permissions
  When I login to a testSite with a valid credential
	Then I should see the patient list screen
  When I click "Census" on the List
  Then I should see the patient list screen
  When I click on default patient in list
  Then I should see the patient summary screen
  When I click on the Monitor tile
  Then I should see the Live Monitor screen
  When I click the "Tools" button in sub navigation menu
  Then I should see the Snippet Tool screen with Create Snippet button hidden
