@regression  @automated @core @pm @pm-navigation
Feature: Monitor - Refresh Navigation
Description
Clicking a Primary or Secondary navigation item should result in a reload of the current navigational element.  This occurs when:

Selecting a primary navigation item which does not navigate the user away from the current screen (due to already viewing default secondary navigation)

Selecting a secondary navigation item which is currently "Active"

TestRail Id: C328943
Jira Issues: AS1-1802, AS1-3047
@critical @TMS:328943
Scenario: Monitor - Refresh Navigation
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
  And I should see the Live Monitor time in "[props.COMMON_DATE_FORMAT]" format
  And the "Live" button is active

  When I scroll the monitor waveform to the "right"
  Then monitor waveform moves "back" in time
  And the "Live" button is inactive
  And the Monitor Time Ago displays on monitor
  And I click the "Live" button in sub navigation menu

  Then I should see the Live Monitor screen
  And I should see the Events, Monitor, Tools, Select Time, Live links
  And the "Monitor" button is active
  And the "Live" button is active

  When I scroll the monitor waveform to the "right"
  Then monitor waveform moves "back" in time
  And the "Live" button is inactive
  And the Monitor Time Ago displays on monitor
  When I click the "Monitor" button in sub navigation menu

  Then I should see the Live Monitor screen
  And I should see the Events, Monitor, Tools, Select Time, Live links
  And the "Monitor" button is active
  And the "Live" button is active

  When I scroll the monitor waveform to the "right"
  Then monitor waveform moves "back" in time
  And the "Live" button is inactive
  And the Monitor Time Ago displays on monitor
  When I click the "Events" button in sub navigation menu
  Then I should see the Events screen
  And I should see the Events, Monitor, Tools, Select Time, Live links
  And the "Events" button is active
  When I click the "Monitor" button in sub navigation menu
  Then I should see the Live Monitor screen
  And I should see the Events, Monitor, Tools, Select Time, Live links
  And the "Monitor" button is active
  And the "Live" button is active
