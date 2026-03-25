@regression @automated @core @pm @pm-snippets @pm-snippets-tools
Feature: PM - Snippet Length Picker (Display Boundary Indicators)

As a user, I want to be able to adjust the length of my snippet so that I may capture varying lengths of waveform.

The user can select the from Site-specific AMP configurable snippet lengths. The default snippet length should correspond with the first AMP configured snippet length listed (usually 6s) and this length will be displayed with a visual indicator of the area to be documented (boundary indicators).

When a user selects a new length of time for the snippet, the time added or removed should be split evenly on both sides of the center point of the snippet and displayed with boundary indicators on the rhythm strip and zoom view (when necessary).

If my original snippet length is 12:55:21 - 12:55:27 (6s default) and I select the 30 second option from the snippet length picker, my total snippet should now be from 12:55:09 - 12:55:39. The same rules should apply for longer lengths depending on total increase of time. Decreasing the length of the snippet will follow the same rules but shorten the time from either side of the central location.

Up to five snippet length options may be configured in AMP. If the configuration were to include less than 5 options, only the number of available snippet lengths will display in the UI.

Example snippet lengths:
6s (default)
10s
20s
30s
x (will not display in UI)

Initialization of Boundary indicators Needs to Respect the Value of the Dropdown (default snippet length) when loading into monitor tool. Snippet boundary indicators on initial load should match the AMP configured default time. Boundary indicators should

TestRail Id: C264371
Jira Stories: AS1-156
@critical @TMS:264371
Scenario: PM - Snippet Length Picker (Display Boundary Indicators)
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
  And I see the Snippet Rhythm Strip timestamp "%H:%M:%S" format

  When I select "10 seconds" in option dropdown on Snippet screen
  When I click the Create Snippet button
  Then I should see the Snippet Document Edit View
  And I should see date and timestamp in "[props.COMMON_DATE_FORMAT]" format
  And the snippet length is same as duration selector from monitor tool
  When I click the Cancel button on Snippet Document Edit View
  Then I should see Snippet Not Saved window
  When I click the Ok button in Snippet Not Saved window
  Then I should see the Snippet Tool screen

  When I select "30 seconds" in option dropdown on Snippet screen
  When I click the Create Snippet button
  Then I should see the Snippet Document Edit View
  And I should see date and timestamp in "[props.COMMON_DATE_FORMAT]" format
  And the snippet length is same as duration selector from monitor tool
  When I click the Cancel button on Snippet Document Edit View
  Then I should see Snippet Not Saved window
  When I click the Ok button in Snippet Not Saved window
  Then I should see the Snippet Tool screen

  When I select "60 seconds" in option dropdown on Snippet screen
  When I click the Create Snippet button
  Then I should see the Snippet Document Edit View
  And I should see date and timestamp in "[props.COMMON_DATE_FORMAT]" format
  And the snippet length is same as duration selector from monitor tool
  When I click the Cancel button on Snippet Document Edit View
  Then I should see Snippet Not Saved window
  When I click the Ok button in Snippet Not Saved window
  Then I should see the Snippet Tool screen

  When I select "120 seconds" in option dropdown on Snippet screen
  And I click the Create Snippet button
  Then I should see the Snippet Document Edit View
  And I should see date and timestamp in "[props.COMMON_DATE_FORMAT]" format
  And the snippet length is same as duration selector from monitor tool
  When I click the Cancel button on Snippet Document Edit View
  Then I should see Snippet Not Saved window
  When I click the Ok button in Snippet Not Saved window
  Then I should see the Snippet Tool screen

  When I select "6 seconds" in option dropdown on Snippet screen
  And I click the Create Snippet button
  Then I should see the Snippet Document Edit View
  And I should see date and timestamp in "[props.COMMON_DATE_FORMAT]" format
  And the snippet length is same as duration selector from monitor tool
  When I click the Cancel button on Snippet Document Edit View
  Then I should see Snippet Not Saved window
  When I click the Ok button in Snippet Not Saved window
  Then I should see the Snippet Tool screen
