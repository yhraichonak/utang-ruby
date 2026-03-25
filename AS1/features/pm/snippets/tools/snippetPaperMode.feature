@regression @nodeSim @automated @core @pm @pm-snippets @pm-snippets-tools
Feature: PM - Monitor Tool - Paper Mode

TestRail Id: C264271
Jira Stories: AS1-303, AS1-1501, AS1-1983, AS1-2916, AS1-2917
@critical @TMS:264271
Scenario: PM - Monitor Tool - Paper Mode
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
	Then I should see the patient list screen
  When I click "Census" on the List
  Then I should see the patient list screen
  When I click on "[props.DP_FULL_NAME]" in patient list
  Then I should see the patient summary screen
  When I click on the Monitor tile
  Then I should see the Live Monitor screen
  When I click the "Tools" button in sub navigation menu
  Then I should see the Snippet Tool screen
  When I click the Paper Mode toggle
  Then I should see the Snippet Tool screen with Paper Mode "On"
  
  When I click on Measure button
  Then I should see the Measure button "active"
  And I should see the HR legend in waveform chart
  And I should see calculating distances of PR, QRS, and QT values
  
  When I click on Caliper button
  Then I should see the Caliper button "active"
  And I should see the HR legend in waveform chart
  And I should see calculating distances for the calipers
  When I click the Marchout switch to "On"
  Then the Caliper Marchout lines appear in zoom view and rhythm strip
  
  When I click on Measure button
  Then I should see the Measure button "active"
  And I should see the HR legend in waveform chart
  And I should see calculating distances of PR, QRS, and QT values
  
  When I click on Caliper button
  Then I should see the Caliper button "active"
  And I should see the HR legend in waveform chart
  And I should see calculating distances for the calipers
  Then the Caliper Marchout lines appear in zoom view and rhythm strip  
  
  When I click the Paper Mode toggle
  Then I should see the Snippet Tool screen with Paper Mode "Off"
  When I click the Paper Mode toggle
  Then I should see the Snippet Tool screen with Paper Mode "On"
  When I click the Paper Mode toggle
  Then I should see the Snippet Tool screen with Paper Mode "Off"

  