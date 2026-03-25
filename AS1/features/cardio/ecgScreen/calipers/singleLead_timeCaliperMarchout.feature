@regression @ecgCalipers @manual @automated
Feature: ECG Time Caliper with Marchout - Single Lead View
  ECG Time Caliper with Marchout - Single Lead View
  The ECG Time Marchout is contained within the ECG Single Lead Only. The Time Marchout will be invoked through a toggle
  on the Secondary Navigation "Action" area (right aligned). Selecting the button will either invoke or turn off the
  Marchout depending on its current state. Marchout can ONLY be turned on when Time Caliper is in an ON state. TBD
  Marchout default ON or OFF + retaining state

  Time Marchout ON - Single Lead View
  Turning Time Marchout ON will invoke the Marchout and will display:

  Marchout indicators, equal to time/distance spacing of Time calipers
  Marchout displayed/repeated across all of the lead box and rhythm strip
  Time Marchout button with visual ON styling
  Active Time Marchout Display - Single Lead View
  When Time caliper is initialized ON, and Marchout is turned ON, marchout will display in an active state/coloration
  on the viewed Lead box Rhythm Strip (same "active" coloration as 12 lead view).

  Time Marchout OFF - Single lead View
  Turning Time Marchout OFF (i.e. Selecting the button from an ON state) will turn the Time Marchout off and will not display:

  Marchout indicators, equal to time/distance spacing of Time calipers
  Marchout displayed/repeated across all of the lead box and rhythm strip
  Time Marchout button with visual OFF stylingcement is negotiable still - also might depend on BPM. Try upper right
  first. Unless leaving legend as centered caliper drag handle (see time caliper on- 12 lead view note)

  TestRail Id: C328767
  Jira Issues: AS1-1489

  Scenario: ECG Time Caliper with Marchout - Single Lead View
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

    When I click on 3 sec Lead "I"
    Then I should see the Lead "I" zoom lead window
    And I should see V.HR and A.HR labels in ECG Details Header are right aligned
    Then I should see the ECG Time Caliper button "inactive"
    And I should see the ECG Voltage Caliper button "inactive"
    And I should see ECG Toolbar Tools separater

    When I click on ECG Time Caliper button
    Then I should see the ECG Time Caliper button "active"
    And I should see calculating distances for the ecg time calipers
#    And I should see marchout lines across all lead boxes and rhythm strips at same distance as ecg time calipers
    And I should see Enable March Out switch as "ON"

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

    When I click on Enable Marchout Toggle
    And I should see Enable March Out switch as "OFF"
    And I should "not see" calculating distances for the ecg time calipers

    When I click on ECG Time Caliper button
    Then I should see the ECG Time Caliper button "inactive"
    And I should "not see" calculating distances for the ecg time calipers