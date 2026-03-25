@automated @core @pm @pm-monitor
Feature: Live Monitor Navigation

TestRail Id: C581727

Jira Epic: AS1-2500

Jira Stories:

Jira Bugs/Defects: AS1-4147, AS1-4461, AS1-4462, AS1-4468, AS1-4663, AS1-4896

@critical @TMS:581727
Scenario: Live Monitor
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  Then I should see the patient list screen
  When reset unit filtering
  When I click "Census" on the List
  Then I should see the patient list screen

  When I click on default patient in list without redirect
  Then I should see the Live Monitor screen
  And I should not see a blank screen
  #(AS1-4461, AS1-4462)
  When I click the "Tools" button in sub navigation menu
  Then I should see the Snippet Tool screen
  And the time displayed should be the time the Live Monitor stopped
  #make note of the time
  When I click the "Monitor" button in sub navigation menu
  Then I should see the Live Monitor screen
  And the "Live" button is active
  And I should not see a blank screen
  And the waveforms should not be resized

  When I click the "Events" button in sub navigation menu
  Then I should see the Events screen
  When I click the "Monitor" button in sub navigation menu
  Then I should see the Live Monitor screen
  And I should not see a blank screen
  And the waveforms should not be resized
  When I click the "Monitor" button in sub navigation menu
  Then I should see the Live Monitor screen
  And I should not see a blank screen
  And the waveforms should not be resized

