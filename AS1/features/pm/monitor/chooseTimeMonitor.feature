@regression @chooseTime @monitor @automated @core @pm @pm-monitor
Feature: PM - Choose Time (monitor)

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

TestRail Id: C264250

Jira Epic:

Jira Stories: AS1-127, AS1-2494, AS1-2820

Jira Bugs/Defects: AS1-306, AS1-761, AS1-1109, AS1-1875, AS1-3007, AS1-2998, AS1-4996, AS1-6828
@critical @TMS:264250
Scenario: PM - Choose Time (monitor)
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  When I click "Census" on the List
  Then I should see the patient list screen
  And reset unit filtering
  When I click on default patient in list without redirect
  Then I should see the Live Monitor screen

  When I click the "Select Time" button in sub navigation menu
  Then I should see the Select Time window
  When I enter the time of "1" hours ago "35" minutes "45" seconds

  And I click the ok button on Select Time Window - ok text removed from window, button ok still displays
  Then I should see the Live Monitor screen
  And I should see the Live Monitor time in "%m/%d/%Y" format "1" hours ago "35" minutes "45" seconds
  And the "Live" button is inactive
  And the "Monitor" button is active
  And the Monitor Time Ago displays on monitor
