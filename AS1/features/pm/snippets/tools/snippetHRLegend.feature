@regression @automated @core @pm @pm-snippets @pm-snippets-tools
Feature: PM - Monitor Tool - HR Legend
On the Monitor Tool, Display HR as a Legend at all times.

TestRail Id: C264267
Jira Stories: AS1-194, AS1-425
  @TMS:264267
Scenario: PM - Monitor Tool HR Legend
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
	Then I should see the patient list screen
  When I click "Census" on the List
  Then I should see the patient list screen
  When I click on default patient in list without redirect
  Then I should see the Live Monitor screen
  When I click the "Tools" button in sub navigation menu
  Then I should see the Snippet Tool screen
  And I should see the Measure button "inactive"
  And I should see the HR legend in waveform chart
  When I click on Measure button
  Then I should see the Measure button "active"
  And I should see the HR legend in waveform chart
  And I should see calculating distances of PR, QRS, and QT values
  When I click on Measure button
  Then I should see the Measure button "inactive"
  And I should see the HR legend in waveform chart
  And I should not see calculating distances of PR, QRS, and QT values
