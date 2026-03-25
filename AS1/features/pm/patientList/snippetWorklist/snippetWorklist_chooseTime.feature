@regression @automated @core @pm @pm-patient_list @pm-patient_list-snippet_worklist
Feature: Patient List - Snippet Worklist Navigation - Choose Time
  Tapping on an Undocumented Snippet patient from the worklist jumps to the Monitor Tool time which matches the time value for the worklist Rule Time.
  The *primary *navigational items within this view need to be hidden/not accessible. The *secondary *navigational bar will be visible, but ALL items
  except for "Choose Time" will be inactive/greyed out. (i.e. The user can not navigate anywhere but "back" and the only accessible item within the
  navigation bars is "Choose Time)"

  When utilizing the worklist to invoke Snippets, the user maintains all current functionalities of Snippets (i.e. measurements, calipers,,
  server-controlled snippet durations, and draggable boundary indicators.)


  TestRail Id: C328780
  Jira Stories: AS1-1553
@critical @TMS:328780
Scenario: Snippet Worklist Navigation - Choose Time
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  Then I should see the patient list screen
  When I click "Snippet Worklist" on the List
  Then I should see the snippet worklist screen
  When I click on a undocumented snippet in worklist
  Then I should see the Snippet Tool screen

  When I click the "Select Time" button in sub navigation menu
  Then I should see the Select Time window
  #When I enter the time of "01" hours "35" minutes "45" seconds
  When I enter the time of "1" hours ago "35" minutes "45" seconds
  And I click the ok button on Select Time Window
  Then I should see the Snippet Tool screen
   
  And I should see the Snippet Tool time in "%m/%d/%Y - %H:%M:%S" format
  And the "Live" button is inactive

  When I click the Create Snippet button
  Then I should see the Snippet Document Edit View
   
  When I click the Save button on Snippet Document Edit screen
  Then I see Snippet Saved notification window
  
  When I click OK button Snippet Saved notification window
  Then I should see the snippet worklist screen
