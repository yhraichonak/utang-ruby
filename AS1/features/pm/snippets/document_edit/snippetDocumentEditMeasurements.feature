@regression @automated @core @pm @pm-snippets @pm-snippets-document_edit
Feature: PM - Snippet Document Edit - Measurements

TestRail Id: C264287

Jira Epic: AS1-165

Jira Stories: AS1-424, AS1-426, AS1-1345, AS1-2172, AS1-4048

Jira Bugs/Defects: AS1-599, AS1-2201, AS1-8003
@critical @TMS:264287
Scenario: PM - Snippet Document Edit - Measurements
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  Then I should see the patient list screen
  When I click "Census" on the List
  Then I should see the patient list screen

  When I click on default patient in list without redirect
  Then I should see the Live Monitor screen
  When I click the "Tools" button in sub navigation menu
  Then I should see the Snippet Tool screen

  When I click the Create Snippet button
  Then I should see the Snippet Document Edit View
  
  And I should see the measurement values "HR" from monitor tool
  When I enter "90" in "HR" measurement value
  Then I should see the measurement values entered
  
  When I click the Cancel button on Snippet Document Edit View
  Then I should see Snippet Not Saved window
  When I click the Ok button in Snippet Not Saved window
  Then I should see the Snippet Tool screen
 
  When I click on Measure button
  Then I should see the Measure button "active"
  And I should see the HR legend in waveform chart
  And I should see calculating distances of PR, QRS, and QT values  
  And I should see the Measure controls for P, Q/R, S, T

  When I click the Create Snippet button
  Then I should see the Snippet Document Edit View

  And I should see the measurement values "HR" from monitor tool
  And I should see the measurement values "PR" from monitor tool
  And I should see the measurement values "QRS" from monitor tool
  And I should see the measurement values "QT" from monitor tool
  When I enter "90" in "HR" measurement value
  When I enter ".20" in "PR" measurement value
  When I enter ".06" in "QRS" measurement value
  When I enter ".30" in "QT" measurement value
  Then I should see the measurement values entered
 
  When I click the Cancel button on Snippet Document Edit View
  Then I should see Snippet Not Saved window
  When I click the Ok button in Snippet Not Saved window
  Then I should see the Snippet Tool screen
 
  When I click on Measure button
  Then I should see the Measure button "inactive"
  When I click on Measure button
  Then I should see the Measure button "active"
  And I should see the HR legend in waveform chart
  When I move the "P" Measure control to the left of "T" measure control
  Then I should see calculating distances of PR, QRS, and QT values
  And I should see the Measure controls for P, Q/R, S, T

  When I zoom "in" on snippet tool screen to zoom "4"
  When I click on "P" Measure control
  Then I should see the "P" Measure control "disabled"
  And I should see the "PR" distance value as 0

  When I click the Create Snippet button
  Then I should see the Snippet Document Edit View

  And I should see the measurement values "HR" from monitor tool
  And I should see the measurement values "PR" from monitor tool
  And I should see the measurement values "QRS" from monitor tool
  And I should see the measurement values "QT" from monitor tool
  And I should see the Measurement Values measured to the one hundreths place

  When I click the Cancel button on Snippet Document Edit View
  Then I should see Snippet Not Saved window
  When I click the Ok button in Snippet Not Saved window
  Then I should see the Snippet Tool screen

  When I zoom "in" on snippet tool screen to zoom "4"
  When I click on "P" Measure control
  Then I should see the "P" Measure control "enabled"

  When I click on Measure button
  Then I should see the Measure button "inactive"
  When I click on Measure button
  Then I should see the Measure button "active"

  When I click on "Q/R" Measure control
  Then I should see the "Q/R" Measure control "disabled"
  And I should see the "PR" distance value as 0
  And I should see the "QRS" distance value as 0
  And I should see the "QT" distance value as 0
  
  When I click the Create Snippet button
  Then I should see the Snippet Document Edit View

  And I should see the measurement values "HR" from monitor tool
  And I should see the measurement values "PR" from monitor tool
  And I should see the measurement values "QRS" from monitor tool
  And I should see the measurement values "QT" from monitor tool
  
  When I click the Cancel button on Snippet Document Edit View
  Then I should see Snippet Not Saved window
  When I click the Ok button in Snippet Not Saved window
  Then I should see the Snippet Tool screen

  When I zoom "in" on snippet tool screen to zoom "4"
  When I click on "Q/R" Measure control
  Then I should see the "Q/R" Measure control "enabled"
  When I click on "S" Measure control
  Then I should see the "S" Measure control "disabled"
  And I should see the "QRS" distance value as 0

  When I click the Create Snippet button
  Then I should see the Snippet Document Edit View

  And I should see the measurement values "HR" from monitor tool
  And I should see the measurement values "PR" from monitor tool
  And I should see the measurement values "QRS" from monitor tool
  And I should see the measurement values "QT" from monitor tool
  
  When I click the Cancel button on Snippet Document Edit View
  Then I should see Snippet Not Saved window
  When I click the Ok button in Snippet Not Saved window
  Then I should see the Snippet Tool screen

  When I zoom "in" on snippet tool screen to zoom "3.4"
  When I click on "S" Measure control
  Then I should see the "S" Measure control "enabled"
  When I click on "T" Measure control
  Then I should see the "T" Measure control "disabled"
  And I should see the "QT" distance value as 0
 
  When I click the Create Snippet button
  Then I should see the Snippet Document Edit View
 
  And I should see the measurement values "HR" from monitor tool
  And I should see the measurement values "PR" from monitor tool
  And I should see the measurement values "QRS" from monitor tool
  And I should see the measurement values "QT" from monitor tool
  
  