@regression
Feature: live_monitor_scroll
  As a utang ONE user
  I want to scroll back and forth on the live monitor
  So that I can see that the monitor scrolls back in time properly

TestRail Id: C582483

Jira Epic: AS1-2498

Jira Stories:

Jira Bugs/Defects: AS1-4501, AS1-4725

#Background:
#  Given I have access to a test site "35 QA Cardio PM"

Scenario: Scrolling Time On Live Monitor
  Given I login to a testSite with "autoone" and "XXXXX"
  Then I should see the patient list screen
  When I click "Census" on the List
  Then I should see the patient list screen
  When I click on "[props.DP_FULL_NAME]" in patient list
  Then I should see the patient summary screen
  When I click on the Monitor tile
  Then I should see the Live Monitor screen
  When I scroll the monitor waveform to the "right"
  Then monitor waveform moves "back" in time
  And the "Live" button is inactive
  And the Monitor Time Ago displays on monitor

  When I scroll the monitor waveform to the "left"
  Then monitor waveform moves "forward" in time
  And the "Live" button is inactive
  And the Monitor Time Ago displays on monitor


  When I log into site "35 QA Cardio PM" with valid credentials
  Then I should see the PM Census list
  When I click on "Nesbitt, Esron" in the PM patient list
  Then I should see the patient summary screen
  When I click on the Monitor tile
  Then I should see the Live Monitor screen
  When I fling the monitor waveforms to the "right" by "30" seconds
  Then the monitor waveforms move "back" in time
  And I should see the Live Monitor screen NOT live
  And I should NOT see the Monitor screen skip to a different time (AS1-2498)
  And the "Live" button should NOT be active
  And the "00:00 ago" time should be increasing
  When I fling the monitor waveforms to the "left" by "20" seconds
  Then the monitor waveforms move "forward" in time
  And I should see the Live Monitor screen NOT live
  And I should NOT see the Monitor screen skip to a different time (AS1-2498)
  And the "Live" button should NOT be active
  And the "00:00 ago" time should be increasing
  When I click the "Live" button
  Then I should see the Live Monitor screen live
  And I should see the "Live" button active
  And I should NOT see the "00:00" time ago indicator
  When I fling the monitor to the "left" by  "20" seconds
  Then I should NOT see the monitor scroll into the future
  And I should NOT see the "Time Ago" read "-20 seconds ago" (AS1-4725)
