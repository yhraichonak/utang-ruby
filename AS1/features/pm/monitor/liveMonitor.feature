@regression @smoke @monitor @nodeSim @automated @core @pm @pm-monitor
Feature: Live Monitor
    As an AS1 user
    I want view a Patient's Monitor
    So that I can make sure I can view the patient's vitals

    Monitor Layout
    Parameters (Discretes)

    Parameters (aka discretes) sent from Server with a config to display in the vertical space are displayed
    (e.g. RR, Temp, Pulse)

    display below patient header, above Waveform Display area
    Parameters (aka discretes) sent from Server with a config to display in the horizontal space are displayed
    (e.g. RR, Temp, Pulse)

    Display below patient header, to the right of Waveform Display area
    For parameter values:

    - display -- for each value when parameter values are blank or null
    - Display (--) when mean is blank or null
    - Display (##) for any mean values when data present  where ## is a number
    Waveform Display Area
    Top, Centered - used to display Alarm Label (when Alarm is present)

    Upper right corner

    displays right-indexed time (HH:MM:SS) of visible monitor from server
    displays time ago when viewing Historical Monitor (e.g. "00:43 ago" would display if looking at monitor data from 43 seconds ago)
    Waveforms
    Each waveform will be labeled (left aligned) in alignment with the associated waveform
    Each waveform is streamed in from right to left - with the right-most edge of the waveform display area being the most recent time
    Each (all) waveform will display based on sequence sent from Server

    +*Web*+
    *On the Patient Monitor*
    The "Live" toggle will appear, right-aligned on Monitor Secondary navigation, right aligned.
    - When in "Live" (streaming + time counter actively keeping current right-aligned time) user can select (toggle OFF) the "Live" button to switch to historical mode
    -- Historical mode will be active
    -- "Time ago: HH:MM:SS" will appear, actively calculating right aligned time from current time.
    - When in Historical Mode, user can select (toggle ON) the "Live" button to switch to live mode
    -- Live mode will be active, "Time ago" is no longer visible on screen
    -- Streaming data will commence, jumping to "now" (most recent data and current time)
    -- Any data available will stream
    -- Time counter actively keeps current right-aligned time
    *_*Note* The LIVE monitor means streaming "now". This could be waveforms, or it could be no data.  The live monitor should still be increasing in time whether there is data present or not._*

  TestRail Id: C264244

  Jira Epic: AS1-2498

  Jira Stories: AS1-128, AS1-188

  Jira bugs/defects: MIG-249, MIG-341, AS1-542, AS1-624, AS1-756, AS1-856, AS1-1107, AS1-1117, AS1-1351, AS1-1405, AS1-2985, AS1-2993, AS1-4208, AS1-4691, AS1-4705, AS1-5823
@critical @TMS:264244
  Scenario: Live Monitor
#    Given PM async alarm was generated for patient "[props.DP_FULL_NAME]" with alarm text "YH_ALERT_ASYNC_ABORTED" and "High" severity for 60 seconds
#    And PM alarm was generated for patient "[props.DP_FULL_NAME]" with alarm text "YH_ALERT_ASYNC_ABORTED" and "High" severity for 60 seconds
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
    And I should see the Live Monitor time in "[props.COMMON_DATE_FORMAT]" format
    And the "Live" button is active
    And I should see ST parameter values
    When I click the "Live" button in sub navigation menu expecting button inactive
    And the "Live" button is inactive
    And the Monitor Time Ago displays on monitor
    #And I should see the Time Ago display "1 seconds ago" #time ago listed needs to be consistent but may begin as a different amount per server (ex. "3 seconds ago")
    #And I should see the Time Ago display increase one second per second
    #And I should see the Time Ago display as "00:01:00 ago" after a minute has lapsed
    #(AS1-5823)
    When I click the "Live" button in sub navigation menu
    And the "Live" button is active
