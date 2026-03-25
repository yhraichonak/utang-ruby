@chooseTime @monitor @nodeSim @automated @core @pm @pm-monitor
Feature: PM - Choose Time (monitor) Mulitple Days


TestRail Id: C328890

Jira Epic: 

Jira Stories: AS1-127, AS1-890

Jira Bugs/Defects: AS1-306, AS1-761, AS1-1109, AS1-1875, AS1-4996, AS1-5141 
@critical @TMS:328890
Scenario: PM - Choose Time (monitor) - Mulitple Days
  Given I login to a testSite with "utang" and "XXXXX"
	Then I should see the patient list screen
  When I click "Census" on the List
  Then I should see the patient list screen
  When I click on default patient in list
  Then I should see the patient summary screen
  
  When I click on the Monitor tile
  Then I should see the Live Monitor screen
  
  When I click the "Select Time" button in sub navigation menu
  Then I should see the Select Time window
  When I click day select box
  Then I should see number of dates configured listed in datefield
  When I select day "2" in datefield
  
  And I click the ok button on Select Time Window
  Then I should see the Live Monitor screen
  And I should see the Live Monitor time display "%m/%d/%Y" format "1" days ago
  And the "Live" button is inactive
  And the Monitor Time Ago displays on monitor
  #And I should not see the time display return to present time (AS1-5141)
  #And I should not see the Time Ago return to the present time (AS1-5141)
  
  #When I click the "Select Time" button in sub navigation menu
  #Then I should see the Select Time window
  #When I click day select box
  #Then I should see number of dates configured listed in datefield
  #When I select day "3" in datefield
  #When I enter the time of "1" hours ago "35" minutes "45" seconds
  #And I click the ok button on Select Time Window
  #Then I should see the Live Monitor screen
  #And I should see the Live Monitor time in "%m/%d/%Y" format "1" hours ago "35" minutes "45" seconds  
  #And the "Live" button is inactive
  #And the Monitor Time Ago displays on monitor