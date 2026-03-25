@atc @automated @critical @atc_ad
@atc_smoke @EPIC:AirCommand @FEATURE:Monitor
@TMS:586473 @clear_atc_flights
Feature: ad_flight_details_monitor_embedded
  As an Alert Dispatch User
  I want to view the embedded monitor
  So that I verify its display and interaction

  XXXX-1617
  - As a user when I select the monitor tab, I shall see an embedded PM Single Patient View in historical mode at the time of the Flight Alarm.
  The PM Single Patient View shall contain the same functionality as the AS1 PM Single Patient View except for the following items:
  - no app chrome
  - no patient header
  - no primary navigation
  - no patient review list, no event list, and associated tool bar.

  XXXX-1711
  - Elements of the Monitor (Monitor/Tools/Events) need to be usable from and end user perspective (Acceptance Criteria)
  Tools https://utang.atlassian.net/wiki/spaces/APPORG/pages/2995257615/PM+WVFRM+Analysis+Tool+w+Snippets https://utang.atlassian.net/wiki/spaces/APPORG/pages/2995192048/PM+Waveform+Analysis+Tool
  - User can view both zoom view and rhythm strip in the tools screen without vertical scrolling
  - User can view/interact with all fields in the snippet header (e.g. length selector, paper mode, etc.)
  - User is able to view at least a single cardiac rhythm in the zoom view of tools (with or without zooming zoom view) *** look for mobile stories
  - User can manipulate PQRST markers without horizontal scrolling
  Snippet Document Edit https://utang.atlassian.net/wiki/spaces/APPORG/pages/2995192055/SNIP+Edit https://utang.atlassian.net/wiki/spaces/APPORG/pages/2995191918/SNIP+Navigation
  - Snippet document edit screen shall have all elements visible, without vertically scrolling, up to at least the first waveform of waveform display area
  - User can vertically scroll to view the rest of the snippet document edit page/waveform
  Snippet Preview https://utang.atlassian.net/wiki/spaces/APPORG/pages/2995257622/SNIP+DOC+Preview
  - User can view a full snippet preview, and associated navigational buttons
  Events https://utang.atlassian.net/wiki/spaces/APPORG/pages/2995192034/PM+Events
  - User can view all three columns of events
  Monitor https://utang.atlassian.net/wiki/spaces/APPORG/pages/2995192027/PM+Monitor+View https://utang.atlassian.net/wiki/spaces/APPORG/pages/2995257608/PM+Navigation
  - Monitor should be able to view a minimum of 4 waveforms (depending on default zoom view configured)
  - Monitor component should not be vertically scrollable (specifically the "entire" monitor component; not the waveform space or parameter space; these have separate rules and are scrollable within themselves)
  - Alarm space can show 1 or more alarms without colliding with date/time

  TESTING NOTES: See: https://utang.atlassian.net/wiki/spaces/ACMS/pages/3921051660/How+to+Generate+Multiple+Alarms+for+Patient+in+AAM for instrucations on how to generate multiple alarms for the same patient in AAM.

  TestRail Id: C586473

  Jira Stories: XXXX-1617, XXXX-1711

  Jira Bugs/Defects: XXXX-1900

  Scenario: Alarm Queue - Embedded Monitor Display and Interaction
    Given User executes test from "[props.CONFIGS_TC09_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    When Alert "TC09_Alarm" initiated on PM with 30 seconds timeout
    And AC: User is logged in with default filter applied
    And API: Wait until the alert is processed by Flight Manager
    Then AC: User verifies the generated alert is present in Alarm Queue panel
    And AC: User opens the generated alert details in Alarm Queue panel
    And AC: User opens Monitor tab of the alert details panel
    And AC: User switch to embedded Monitor tab on the alert details
    And AC: User should see event start time on embedded Monitor
    And AC: User should see embedded Monitor in historical mode
    And AC: User should not see primary navigation bar on embedded Monitor
    And AC: User should not see patient header on embedded Monitor
    And AC: User should not see docked events list on embedded Monitor
    And AC: User should not see side navigation panel on embedded Monitor
    And AC: User should see at least 4 charts on embedded Monitor
    And AC: User opens Tools tab on embedded Monitor
    And AC: User should see rhythm strip on embedded Monitor
    And AC: User should see monitor zoom view on embedded Monitor
    And AC: User should see at least a single cardiac rhythm in the zoom view on embedded Monitor
    And AC: User can zoom in view on embedded Monitor
    And AC: User can zoom out view on embedded Monitor
    When AC: User clicks on Tools header of embedded Monitor
    And AC: User should see snippet length selector on Tools header of embedded Monitor
    And AC: User should see snippet lead selectors on Tools header of embedded Monitor
    And AC: User should see measure on Tools header of embedded Monitor
    And AC: User should see calipers on Tools header of embedded Monitor
    And AC: User should see paper mode on Tools header of embedded Monitor
    And AC: User should see marchout on Tools header of embedded Monitor
    When AC: User clicks Measure button on embedded Monitor
    Then AC: User should see measurements P, QR, S, T on Tools header of embedded Monitor
    And AC: User could move P, QR, S, T on Tools header of embedded Monitor
    When AC: User clicks Calipers button on embedded Monitor
    Then AC: User see Calipers button is enabled on embedded Monitor
    And AC: User could move caliper handles on Tools header of embedded Monitor
    When AC: User clicks Calipers button on embedded Monitor
    Then AC: User see Calipers button is disabled on embedded Monitor
    When AC: User clicks Create Snippet button on embedded Monitor
    When AC: User wait for 20s until "Preview" button is enabled on embedded Monitor
    When AC: User sets Event Type to "PRN" on embedded Monitor
    When AC: User sets Description to "My description" on embedded Monitor
    When AC: User sets "HR" measurement value to "99" on embedded Monitor
    When AC: User sets "PR (s)" measurement value to "99" on embedded Monitor
    When AC: User sets "QRS (s)" measurement value to "99" on embedded Monitor
    When AC: User sets "QT (s)" measurement value to "99" on embedded Monitor
    When AC: User sets All leads On on embedded Monitor
    When AC: User clicks Preview button on embedded Monitor
    And AC: User wait for spinner disappears on embedded Monitor
    Then AC: User should see Snippet Preview dialog on embedded Monitor
    When AC: User clicks Back button on embedded Monitor
    Then AC: User should see Snippet Edit form on embedded Monitor
    When AC: User clicks Preview button on embedded Monitor
    And AC: User wait for spinner disappears on embedded Monitor
    When AC: User clicks Save button on embedded Monitor
    When AC: User wait for Snippet Saved message on embedded Monitor
    And AC: User opens Events tab on embedded Monitor
    And AC: User verifies that Last Hour events panel 0th element match "(?m).*TC09_Alarm.*" and the alert time on embedded Monitor
    Then AC: User sees "Last Hour,1–6 Hours Ago,More than 6 Hours Ago" tabs on events panel on embedded Monitor

  Scenario: Alert Queue - Embedded Monitor Display and Interaction
    Given User executes test from "[props.CONFIGS_TC01A_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    When Alert "TC01a_Alarm" initiated on PM with 100 seconds timeout
    And AC: User is logged in with default filter applied
    And API: Wait until the alert is processed by Flight Manager
    Then AC: User verifies the generated alert is present in Alerts panel with attributes
      """
      { "alarm-label":"TC01a_Alarm"}
      """
    And AC: User opens the generated alert details in Alerts panel
    And AC: User opens Monitor tab of the alert details panel
    And AC: User switch to embedded Monitor tab on the alert details
    And AC: User should see event start time on embedded Monitor
    And AC: User should see embedded Monitor in historical mode
    And AC: User should not see primary navigation bar on embedded Monitor
    And AC: User should not see patient header on embedded Monitor
    And AC: User should not see docked events list on embedded Monitor
    And AC: User should not see side navigation panel on embedded Monitor
    And AC: User should see at least 4 charts on embedded Monitor
    And AC: User opens Tools tab on embedded Monitor
    And AC: User should see rhythm strip on embedded Monitor
    And AC: User should see monitor zoom view on embedded Monitor
    And AC: User should see at least a single cardiac rhythm in the zoom view on embedded Monitor
    And AC: User can zoom in view on embedded Monitor
    And AC: User can zoom out view on embedded Monitor
    When AC: User clicks on Tools header of embedded Monitor
    And AC: User should see snippet length selector on Tools header of embedded Monitor
    And AC: User should see snippet lead selectors on Tools header of embedded Monitor
    And AC: User should see measure on Tools header of embedded Monitor
    And AC: User should see calipers on Tools header of embedded Monitor
    And AC: User should see paper mode on Tools header of embedded Monitor
    And AC: User should see marchout on Tools header of embedded Monitor
    When AC: User clicks Measure button on embedded Monitor
    Then AC: User should see measurements P, QR, S, T on Tools header of embedded Monitor
    And AC: User could move P, QR, S, T on Tools header of embedded Monitor
    When AC: User clicks Calipers button on embedded Monitor
    Then AC: User see Calipers button is enabled on embedded Monitor
    And AC: User could move caliper handles on Tools header of embedded Monitor
    When AC: User clicks Calipers button on embedded Monitor
    Then AC: User see Calipers button is disabled on embedded Monitor
    When AC: User clicks Create Snippet button on embedded Monitor
    When AC: User wait for 20s until "Preview" button is enabled on embedded Monitor
    When AC: User sets Event Type to "PRN" on embedded Monitor
    When AC: User sets Description to "My description" on embedded Monitor
    When AC: User sets "HR" measurement value to "99" on embedded Monitor
    When AC: User sets "PR (s)" measurement value to "99" on embedded Monitor
    When AC: User sets "QRS (s)" measurement value to "99" on embedded Monitor
    When AC: User sets "QT (s)" measurement value to "99" on embedded Monitor
    When AC: User sets All leads On on embedded Monitor
    When AC: User clicks Preview button on embedded Monitor
    And AC: User wait for spinner disappears on embedded Monitor
    Then AC: User should see Snippet Preview dialog on embedded Monitor
    When AC: User clicks Back button on embedded Monitor
    Then AC: User should see Snippet Edit form on embedded Monitor
    When AC: User clicks Preview button on embedded Monitor
    And AC: User wait for spinner disappears on embedded Monitor
    When AC: User clicks Save button on embedded Monitor
    When AC: User wait for Snippet Saved message on embedded Monitor
    And AC: User opens Events tab on embedded Monitor
    And AC: User verifies that Last Hour events panel 0th element match "(?m).*TC01a_Alarm.*" and the alert time on embedded Monitor
    Then AC: User sees "Last Hour,1–6 Hours Ago,More than 6 Hours Ago" tabs on events panel on embedded Monitor