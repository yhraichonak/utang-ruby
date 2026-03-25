@regression @events @chooseTime @automated @core@site34   @pm @pm-events
Feature: PM - Choose Time (events) - Multiple Days


  TestRail Id: C328891
  Jira Stories: AS1-890
@critical @TMS:328891
  Scenario: PM - Choose Time (events) - Multiple Days
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    Then I should see the patient list screen
    When I click "Census" on the List
    Then I should see the patient list screen     
    When I click on default patient in list
    Then I should see the patient summary screen
   
    When I click on the Monitor tile
    Then I should see the Live Monitor screen
    When I click the "Events" button in sub navigation menu
    Then I should see the Events screen
   
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

    #When I click the "Select Time" button in sub navigation menu
    #Then I should see the Select Time window
    #When I click day select box
    #Then I should see number of dates configured listed in datefield
    #When I select day "3" in datefield
    #When I enter the time of "current hour minus one" hours "35" minutes "45" seconds
    #And I click the ok button on Select Time Window
    #Then I should see the Live Monitor screen
    #And I should see the Live Monitor time in "%m/%d/%Y" format "current hour minus one" hours "35" minutes "45" seconds
    #And the "Live" button is inactive
    #And the Monitor Time Ago displays on monitor

