@regression @automated @core @pm @pm-navigation
Feature: PM - Primary Navigation

Description
DISPLAY
The Primary Navigation bar displays below the Patient Header and contains left-aligned available component tabs as navigation items
(i.e. specific "tiles" in mobile utang ONE display as "tabs" in the web product.)
The Primary Navigation bar will be utilized for navigation within a patient context, so this navigation will not be necessary on patient lists or site lists.

Display of component tabs is limited to installed components plus Summary component. Additional rules surrounding Order and Display of tabs is dependent on configuration.

NAVIGATION:
When selecting a component tab, tab will display in an "active" state and present the associated screen within the component space.
(e.g. Clicking on Monitor will display the monitor.) *Note:the Secondary Navigation will determine which sub-component screen will display, such as Events or Monitor

-------------------------------------
n the config.json set:

"mainNav": ["overview", "monitor", "ecgs", "documents"]

_____________________________________


TestRail Id: C316508
Jira Stories: AS1-291, AS1-2001, AS1-1802
@critical @TMS:316508
Scenario: PM - Primary Navigation (web)
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
	Then I should see the patient list screen
  When reset unit filtering
  When I click "Census" on the List
  Then I should see the patient list screen
  When I click on "[props.DP_FULL_NAME]" in patient list
  Then I should see the patient summary screen
  When I click the "Monitor" link in main navigation menu
  Then I should see the Live Monitor screen
  And the main navigation "Monitor" button is active

  When I scroll the monitor waveform to the "right"
  Then monitor waveform moves "back" in time
  And the "Live" button is inactive
  And the Monitor Time Ago displays on monitor
  When I click the "Monitor" link in main navigation menu
  Then I should see the Live Monitor screen
  And I should see the Events, Monitor, Tools, Select Time, Live links
  And the "Monitor" button is active
  And the "Live" button is active

  When I click the "Documents" link in main navigation menu
  Then I should see the Snippets Rhythms Documents screen
  When I click the "Documents" link in main navigation menu
  Then I should see the Snippets Rhythms Documents screen

  When I click the "Overview" link in main navigation menu
  Then I should see the patient summary screen
  When I click the "Overview" link in main navigation menu
  Then I should see the patient summary screen
  And the main navigation "Overview" button is active

  When I click the "ECGs" link in main navigation menu
  Then I should see the ecg list on ECG screen
	When I click on row "1" on ecg list
  Then I should see the patient ECG screen
  And the main navigation "ECGs" button is active
