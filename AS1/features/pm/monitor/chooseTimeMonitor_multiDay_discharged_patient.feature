@automated @core @pm @pm-monitor @critical @TMS:582629
Feature: chooseTimeMonitor_multiDay_discharged_patient
  As an utang ONE user
  I want to be able to click the "Select Time" button for a discharged patient
  So that I can navigate to a specific point in time to view historical data

TestRail Id: C582629

Jira Epic: AS1-2498

Jira Stories:

Jira Bugs/Defects: AS1-5018, AS1-5231
@broken   @TMS:582629
#  Not yet possible to setup discharged patient on permanent basis on Automation env
Scenario: PM - Live Monitor - Select Time functions from a Discharged Patient on Multi Day Site
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  When I click "Census" on the List
  Then I should see the patient list screen
  And reset unit filtering
  When I click on "[props.DCHP_FULL_NAME]" in patient list
  #a patient who is currently discharged
  Then I should see the patient summary screen
  When I click on the Monitor tile
  Then I should see the Live Monitor screen
  When I click the "Select Time" button in sub navigation menu
  # (AS1-5018)
  Then I should see the Select Time window
  #And I should see the dates and time reflective of the present date and time (AS1-5231)
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
  #When I enter the time of "1" hours ago "35" minutes "45" seconds
  #And I click the ok button on Select Time Window
  #Then I should see the Live Monitor screen
  #And I should see the Live Monitor time in "%m/%d/%Y" format "1" hours ago "35" minutes "45" seconds
  #And the "Live" button is inactive
  #And the Monitor Time Ago displays on monitor
