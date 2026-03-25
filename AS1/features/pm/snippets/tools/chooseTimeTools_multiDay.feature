@regression @chooseTime @nodeSim @automated @core @pm @pm-snippets @pm-snippets-tools
Feature: PM - Choose Time (tools) - Mulitple Days

TestRail Id: C328854

Jira Epic: 

Jira Stories: MIG-487

Jira Bugs/Defects: AS1-1864, AS1-1875, AS1-4997
@critical @TMS:328854
Scenario: PM - Choose Time (tools) - Mulitple Days
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
  When I click the "Select Time" button in sub navigation menu
  Then I should see the Select Time window
  When I click day select box
  Then I should see number of dates configured listed in datefield
  When I select day "2" in datefield
 
  And I click the ok button on Select Time Window
  Then I should see the Snippet Tool screen
  And I should see the Live Monitor time display "%m/%d/%Y" format "1" days ago
  And the "Live" button is inactive
  
  #When I click the "Select Time" button in sub navigation menu
  #Then I should see the Select Time window
  #When I click day select box
  #And I select day "3" in datefield
  #And I enter the time of "01" hours ago "35" minutes "45" seconds
  #And I click the ok button on Select Time Window
  #Then I should see the Snippet Tool screen
  #And I should see the Snippet Tool time in "%m/%d/%Y - 01:35:45" format
  #And the "Live" button is inactive
  
