@regression @nodeSim @automated @core @pm @pm-snippets @pm-snippets-document_edit @TMS:328949
Feature: PM - Snippet Document Edit Layout - 900 x 600
Current screenshot as-is on 900x600

Need to be able to fit more fields onto the screen on the smaller screen view. Best case - the user can see at least the first waveform

The Measurement entry fields as-is could be at least half the size of screenshot.  The max necessary would be four digits w/decimal: 9.999.

TestRail Id: C328949
Jira Stories: AS1-2254, AS1-2246

Scenario: PM - Snippet Document Edit Layout - 900 x 600
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  Then I should see the patient list screen
  When I click "Census" on the List
  Then I should see the patient list screen
  When I see the browser resolution to "900" width by "600" height
  When I click on default patient in list without redirect
  Then I should see the Live Monitor screen
  When I click the "Tools" button in sub navigation menu
  Then I should see the Snippet Tool screen
  When I click on Measure button
  Then I should see the Measure button "active"
  When I click the Create Snippet button
  Then I should see the Snippet Document Edit View
  And I should see the measurement values "HR" from monitor tool
  And the All Leads toggle is switched "Off"
  And I should see date and timestamp in "%m/%d/%Y (%H:%M:%S-%H:%M:%S)" format
  And the snippet length is same as duration selector from monitor tool
