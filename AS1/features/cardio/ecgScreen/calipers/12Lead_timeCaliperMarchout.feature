@regression @ecgCalipers @manual @automated
Feature: ECG Time Caliper with Marchout - 12 Lead View
  ECG Time Caliper with Marchout - 12 Lead View
  The ECG Time Caliper is contained within the ECG 12 Lead view. The Time caliper will be invoked through a button on
  the Vertical Toolbar. Selecting the button will either invoke or turn off the Time Caliper, depending on its current
  state. Time caliper in 12 lead view will *always *display with Marchout.

  Time Caliper ON - 12 Lead View
  Turning Time caliper ON will invoke the Calipers and will display:
  Two vertical calipers with grab handles on Lead box, default placement of 1/3 and 2/3 across the lead box
  If this needs to be the same as Single Lead view, where the legend is the grab handle for now, that works
  (as long as we can read the legend still) Marchout indicators, equal to time/distance spacing of active calipers
  Marchout displayed/repeated across all lead boxes and rhythm strips, Time caliper legend
  Time caliper button with visual ON styling
  ECG Time Caliper will display WITH marchout (i.e. No marchout toggle available; marchout *always *on) in 12 Lead ECG
  view. Marchout will continue across all lead boxes and rhythm strips when Time caliper is ON.
  Active Lead - 12 Lead View When Time caliper is initialized ON, the caliper and marchout will display in an active
  state/coloration on (default) Lead I box + Lead 1 Rhythm Strip. The Caliper grab handles and legend display will
  appear in the Active Lead box. The Caliper grab handles and legend display are interactive ONLY in the active lead box.

  Inactive Leads - 12 Lead view
  When Time caliper is ON, the marchout will display on all secondary lead boxes and rhythm strips in a "subtle muted"
  state. The user cannot interact with marchout indicators on any secondary lead boxes.

  Time Caliper OFF - 12 lead View
  Turning Time Calipers OFF (i.e. Selecting the button from an ON state) will turn the Time Calipers off and will not display:

  Two vertical calipers on Lead I box
  Paired grab handle
  Marchout indicators
  Time caliper legend
  Time caliper button with visual ON styling
  The Calipers will not retain placement after being turned OFF by selecting the Caliper control (e.g. Turning Calipers
  ON, adjusting Calipers, then turning OFF, turning back on will "reset" the calipers to default placement)
  Time Caliper Legend When active (ON) the Time Caliper will display a legend, within the active lead box

  The Time Caliper Legend will display the measurement between the Time Calipers in seconds, to the hundredth of a second.
  (e.g. 0.90s)
  Due to space between calipers, time and BPM may not fit on the same line. If wrapping is necessary, ensure that all
  digits of time value remain as one unit, and all digits of BPM remain as one unit. Placement is negotiable still - also
  might depend on BPM. Try upper right first. Unless leaving legend as centered caliper drag handle (see time caliper on- 12 lead view note)

  TestRail Id: C328765
  Jira Issues: AS1-1481, AS1-1544

  Scenario: ECG Time Caliper with Marchout - 12 Lead View
    Given I login to a testSite with "utang" and "XXXXX"
    Then I should see the patient list screen
    When I click "MOST RECENT" on the List
    Then I should see the patient list screen
    When I click on "Nesbitt, Esron" in patient list
    Then I should see the patient summary screen
    When I click on the ECG tile
    Then I should see the ecg list on ECG screen
    And I should see patient info in ecg screen header
    When I click on row "1" on ecg list
    Then I should see the patient ECG screen
    When I click on the info icon on the ecg toolbar
    Then the ecg detailed info drawer displays
    When I click on the info icon on the ecg toolbar
    Then I should see the 12 waveforms I II III aVR aVL aVF V1 V2 V3 V4 V5 V6 waveforms display
    And I should see the lead legend displaying "0.1mV/.04sec" on first ecg three sec lead
    And I should see the lead legend displaying "0.1mV/.04sec" on first ecg rhythm strip lead
    And I should see V.HR and A.HR labels in ECG Details Header are right aligned
    Then I should see the ECG Time Caliper button "inactive"
    And I should see the ECG Voltage Caliper button "disabled"
    And I should see ECG Toolbar Tools separater

    When I click on ECG Time Caliper button
    Then I should see the ECG Time Caliper button "active"
    And I should see calculating distances for the ecg time calipers
#    And I should see marchout lines across all lead boxes and rhythm strips at same distance as ecg time calipers

    When I click on the info icon on the ecg toolbar
    Then the ecg detailed info drawer displays
    And I should see calculating distances for the ecg time calipers
    When I click on the info icon on the ecg toolbar

    When I drag the whole ecg time caliper to the "right"
    Then the ecg time caliper moves to the "right" of waveform
#    And I should see marchout lines across all lead boxes and rhythm strips at same distance as ecg time calipers
    When I drag the whole ecg time caliper to the "left"
    Then the ecg time caliper moves to the "left" of waveform
#    And I should see marchout lines across all lead boxes and rhythm strips at same distance as ecg time calipers
    When I drag the whole ecg time caliper to the "up"
    Then the ecg time caliper moves to the "up" of waveform
#    And I should see marchout lines across all lead boxes and rhythm strips at same distance as ecg time calipers
    When I drag the whole ecg time caliper to the "down"
    Then the ecg time caliper moves to the "down" of waveform
#    And I should see marchout lines across all lead boxes and rhythm strips at same distance as ecg time calipers

    When I drag the "left" ecg time caliper to the "left"
    Then I should see the ecg time caliper distance "increase"
#    And I should see marchout lines across all lead boxes and rhythm strips at same distance as ecg time calipers
    When I drag the "left" ecg time caliper to the "left"
    Then I should see the ecg time caliper distance "increase"
#    And I should see marchout lines across all lead boxes and rhythm strips at same distance as ecg time calipers

    When I drag the "left" ecg time caliper to the "right"
    Then I should see the ecg time caliper distance "decrease"
#    And I should see marchout lines across all lead boxes and rhythm strips at same distance as ecg time calipers
    When I drag the "left" ecg time caliper to the "right"
    Then I should see the ecg time caliper distance "decrease"
#    And I should see marchout lines across all lead boxes and rhythm strips at same distance as ecg time calipers

    When I drag the "right" ecg time caliper to the "left"
    Then I should see the ecg time caliper distance "decrease"
#    And I should see marchout lines across all lead boxes and rhythm strips at same distance as ecg time calipers
    When I drag the "right" ecg time caliper to the "left"
    Then I should see the ecg time caliper distance "decrease"
#    And I should see marchout lines across all lead boxes and rhythm strips at same distance as ecg time calipers

    When I drag the "right" ecg time caliper to the "right"
    Then I should see the ecg time caliper distance "increase"
#    And I should see marchout lines across all lead boxes and rhythm strips at same distance as ecg time calipers
    When I drag the "right" ecg time caliper to the "right"
    Then I should see the ecg time caliper distance "increase"
#    And I should see marchout lines across all lead boxes and rhythm strips at same distance as ecg time calipers

    When I click on ECG Time Caliper button
    Then I should see the ECG Time Caliper button "inactive"
    And I should "not see" calculating distances for the ecg time calipers