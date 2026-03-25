@regression @monitor @nodeSim @automated @core @pm @pm-monitor
Feature: Monitor - Hiding Muting Waveforms
  As an AS1 user
  I want view a Patient's Monitor
  So that I can make sure I can view the patient's vitals

  User can "hide" or "mute" individual waveforms displayed on the patient monitor. (The waveform isn't actually hidden, it's brightness is reduced such that it's "visually muted" - needed in the case of noisy/overlapping waveforms)
  User can "unhide" or "unmute" any previously muted waveforms
  Muted waveforms are not retained across sessions/patients
  The user can isolate a single waveform with a specific action - i.e. all other waveforms would be muted
  Performing this action again would unmute all waveforms
  Muting waveforms should be available in live AND historical mode. (User can mute "streaming" waveforms without coming out of live mode)

  TestRail Id: C264248
  Jira Issues: AS1-199, AS1-2485, AS1-4662
 @unstable @critical @TMS:264248
  Scenario: Monitor - Hiding Muting Waveforms
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    Then I should see the patient list screen
    And reset unit filtering
    When I click "Census" on the List
    Then I should see the patient list screen
    When I click on default patient in list
    Then I should see the patient summary screen
    When I click on the Monitor tile
    Then I should see the Live Monitor screen
    When I click on the monitor "1" waveform
    Then the waveform "1" displayed is disabled
    And the waveform "1" button is "off"

    When I click the "Tools" button in sub navigation menu
    Then I should see the Snippet Tool screen
    And I should see waveform "1" not muted

    When I click the "Monitor" button in sub navigation menu
    Then I should see the Live Monitor screen
    Then the waveform "1" displayed is disabled
    And the waveform "1" button is "off"

    When I click on the monitor "1" waveform
    Then the waveform "1" displayed is enabled
    And the waveform "1" button is "on"

    When I click on the monitor "2" waveform
    Then the waveform "2" displayed is disabled
