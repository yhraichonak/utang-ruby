@regression @automated @core @pm @pm-snippets @pm-snippets-tools
Feature: PM - Snippet Screen Layout - Snippet Site Disabled
Snippet Display Flags
The presence or absence of Snippets toggle will determine if the additional functionality pertaining to the Snippets feature will display in the Monitor Tool.

These flags are (AMP Settings, sent by server):

Snippet ON Site
Snippet ON User
For Scenario 1:
Snippets Enabled Site = TRUE
Snippets Enabled User = TRUE
then Tool view will display full Snippets features

For Scenario 2:
If any Snippet Enabled are FALSE (Site or User)
then Tool view will display without Snippets features

Monitor Tool Example (without Snippets Feature) contains the following Elements:

lead zoom view - dual or single
rhythm strip
lead selectors
measure tool(s)
Monitor Tool Example (With Snippets Feature) contains the following elements:

lead zoom view - dual or single
rhythm strip
lead selectors
measure tool(s)
duration picker (Snippets Only)
Create button (Snippets Only)
boundary indicators (Snippets Only)

TestRail Id: C264443
Jira Stories: AS1-154
  @TMS:264443
Scenario: PM - Snippet Screen Layout - Snippet Site Disabled
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
