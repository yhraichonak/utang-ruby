@regression @chooseTime @automated @core @pm @pm-snippets @pm-snippets-tools
Feature: PM - Choose Time (tools) - Time Mismatch

Description
"When tele tech tried to create a snippet from the Census option and selected a different time, the preview snippet had the actual time snippet was created not the selected time."

Steps to Reproduce: 
On load into Monitor Tool, Turn Measure ON (example load in @ 2:00)
Use Select Time to go to a different time (@1:00) where measurements are no longer visible

Expected Result:
The Measurements and Boundary Indicators remain sticky to their original location (2:00)
(Training required to ensure users know to hit "Measure" again to reset boundary indicators and measure indicators to the currently viewed time)

Actual Result:
Boundary indicators are reset to currently viewed time (1:00)
Measurements are sticky to original location (2:00)
Selecting "Continue" creates a snippet surrounding the Measurement Indicators location (~2:00)

TestRail Id: C328789
Jira Stories: AS1-1586
@critical @TMS:328789
Scenario: PM - Choose Time (tools)
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
  When I click on Measure button
  Then I should see the Measure button "active"
  And I should see the HR legend in waveform chart
  And I should see calculating distances of PR, QRS, and QT values
  And I should see calculating distances of QTc value 
  And I should see the Measure controls for P, Q/R, S, T
  
  When I click the "Select Time" button in sub navigation menu
  Then I should see the Select Time window
  When I enter the time of "01" hours ago "35" minutes "45" seconds
  And I click the ok button on Select Time Window
  Then I should see the Snippet Tool screen
  And I should see the Snippet Tool time in "%m/%d/%Y - %H:%M:%S" format
  And the "Live" button is inactive
  And Measurements and boundary indicators remain sticky to previous location
  
  When I click on Measure button
  Then I should see the Measure button "inactive"
  
  When I click on Measure button
  Then I should see the Measure button "active"
  And I should see the HR legend in waveform chart
  And I should see calculating distances of PR, QRS, and QT values
  And I should see calculating distances of QTc value 
  And I should see the Measure controls for P, Q/R, S, T