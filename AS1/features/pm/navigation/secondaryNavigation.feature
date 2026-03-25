@regression @automated @core @pm @pm-navigation
Feature: PM - Secondary Navigation

Secondary Navigation Elements for the Monitor are (from left to right, where leftmost is default view when navigating to Monitor from Patient Summary.  _The only exception is "jump navigation" from the patient monitor_):
- Events
- Monitor
- Tool

*From the Events Screen:*
- Select the Monitor Secondary navigation, the Live Monitor screen displays.
- Select an Event, the historical monitor for that Event displays
- *NOTE* Monitor Tool is not a navigational element from the Events screen (due to the Tool needing a time index from the monitor to load)
- The user can return to previous navigational context from Events

*From Patient Monitor*
- Select the Events navigation
-- The Events screen displays for that patient
- Select the "Tool" tab
-- The Monitor tool will display for the time previously viewed on the Patient Monitor
- The user can return to previous navigational context from Patient Monitor

*From Monitor Tool*
- Select the Events navigation
-- The Events screen displays for that patient
- The user can return to previous navigational context from Monitor Tool

TestRail Id: C264249
Jira Stories: AS1-129, AS1-572, AS1-584, AS1-625, AS1-1897, AS1-2296, AS1-2583
@critical @TMS:264249
Scenario: PM - Secondary Navigation (web)
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  Then I should see the patient list screen
  When reset unit filtering
  When I click "Census" on the List
  Then I should see the patient list screen
  When I click on "[props.DP_FULL_NAME]" in patient list
  Then I should see the patient summary screen
  When I click on the Monitor tile
  Then I should see the Live Monitor screen
  When I click the "Events" button in sub navigation menu
  Then I should see the Events screen
  And I should see the Events, Monitor, Tools, Select Time, Live links
  And the "Events" button is active
  And the "Tools" button is disabled

  When I click the "Monitor" button in sub navigation menu
  Then I should see the Live Monitor screen
  When I click the "Events" button in sub navigation menu
  Then I should see the Events screen
  And I should see the Events, Monitor, Tools, Select Time, Live links
  And the "Events" button is active
  And the "Tools" button is disabled

  When I click the "Events" button in sub navigation menu
  Then I should see the Events screen
  And I should see the Events, Monitor, Tools, Select Time, Live links
  And the "Events" button is active
  And the "Tools" button is disabled

  When I click the "Live" button in sub navigation menu
  Then I should see the Live Monitor screen
  When I click the "Events" button in sub navigation menu
  Then I should see the Events screen
  And I should see the Events, Monitor, Tools, Select Time, Live links
  And the "Events" button is active
  And the "Tools" button is disabled

  When I click the "Select Time" button in sub navigation menu
  Then I should see the Select Time window
  And I click the ok button on Select Time Window
  Then I should see the Live Monitor screen
  When I click the "Events" button in sub navigation menu
  Then I should see the Events screen
  And I should see the Events, Monitor, Tools, Select Time, Live links
  And the "Events" button is active
  And the "Tools" button is disabled

  When I click the "Monitor" button in sub navigation menu
  Then I should see the Live Monitor screen

  When I click the "Tools" button in sub navigation menu
  Then I should see the Snippet Tool screen
  When I click the "Monitor" button in sub navigation menu
  Then I should see the Live Monitor screen
  And I should see the Events, Monitor, Tools, Select Time, Live links
  And the "Monitor" button is active

  When I click the "Select Time" button in sub navigation menu
  Then I should see the Select Time window
  And I click the ok button on Select Time Window
  Then I should see the Live Monitor screen
  And I should see the Events, Monitor, Tools, Select Time, Live links
  And the "Monitor" button is active

  When I click the "Live" button in sub navigation menu
  Then I should see the Live Monitor screen
  And I should see the Events, Monitor, Tools, Select Time, Live links

  When I click the "Tools" button in sub navigation menu
  Then I should see the Snippet Tool screen

  When I click the "Select Time" button in sub navigation menu
  Then I should see the Select Time window
  And I click the ok button on Select Time Window
  Then I should see the Snippet Tool screen
  And I should see the Events, Monitor, Tools, Select Time, Live links

  When I click the "Live" button in sub navigation menu
  Then I should see the Live Monitor screen
  And I should see the Events, Monitor, Tools, Select Time, Live links
  Then I should see the Live Monitor screen
  When I click the "Tools" button in sub navigation menu
  Then I should see the Snippet Tool screen




