@regression @chooseTime @automated @core @pm @pm-snippets @pm-snippets-tools
Feature: PM - Choose Time (tools)

"Choose Time" indicator will appear, right aligned (where "Live" is right-most and "Choose Time" is the next item to the left) in the Secondary navigation of Monitor screens, including:

Events
Patient Monitor (Live and Historical)
Tool
From the Monitor Screen:

Select the Choose Time button, the Choose time popup displays
User can select a time to jump to up to (24h in the past from now) and that time + associated data displays on historical monitor
The user can return to previous navigational context from Monitor
From the Events Screen:

Select the Choose Time button, the Choose time popup displays
User can select a time to jump to up to (24h in the past from now with ability to handle more than 1 day)
User will be navigated to the Patient Monitor for that time
From the Monitor Tool

Select the Choose Time button, the Choose time popup displays
User can select a time to jump to (24h in the past from now, with ability to handle more than 1 day)
User is redirected to the selected time on the Monitor Tool

TestRail Id: C264252

Jira Epic: 

Jira Stories: AS1-127, AS1-2820

Jira Bugs/Defects: AS1-541, AS1-761, AS1-1109, AS1-1231, AS1-1875, AS1-3007, AS1-4997, AS1-5761
@critical @TMS:264252
Scenario: PM - Choose Time (tools)
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  Then I should see the patient list screen
  When I click "Census" on the List
  Then I should see the patient list screen
  When I click on default patient in list without redirect
  Then I should see the Live Monitor screen
  When I click the "Tools" button in sub navigation menu
  Then I should see the Snippet Tool screen
  When I click the "Select Time" button in sub navigation menu
  Then I should see the Select Time window
  When I enter the time of "01" hours ago "35" minutes "45" seconds
  And I click the ok button on Select Time Window - ok text removed from window, button ok still displays
  Then I should see the Snippet Tool screen
  And I should see the Snippet Tool time in "[props.COMMON_DATE_FORMAT]" format
  And the "Select Time" button is active
  And the "Live" button is inactive