@atc @automated @el @critical @atc_at
@EPIC:FlightTracker @FEATURE:Monitor
@clear_atc_flights
@TMS:586472
Feature: at_alert_details_monitor_embedded
  As a Alert Tracker User
  I want to view the embedded monitor
  So that I can verify its display and interaction

  XXXX-1605
  - As a user when I select the monitor tab, I shall see an embedded PM Single Patient View in historical mode at the time of the Flight Alarm.
  The PM Single Patient View shall contain the same functionality as the AS1 PM Single Patient View except for the following items:
  - no app chrome
  - no patient header
  - no primary navigation
  - no patient review list, no event list, and associated tool bar.
  Note: Should not require second login to access AS1 in Flight Details Panel.

  XXXX-1712
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

  TestRail Id: C586472

  Jira Stories: XXXX-1605, XXXX-1712

  Jira Bugs/Defects: XXXX-1900

  Scenario: Flight Details - Embedded Monitor
    Given User executes test from "[props.CONFIGS_TC05_MULTI_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    And FT: User is logged in with default filter applied
    When Alert "TC05_Medium_Alarm_Short,TC05_Low_Alarm_Short" initiated on PM with 20 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    When API: Wait until the flight status is Complete by Flight Manager for 25 seconds
    When FT: User opens the generated alert details
    And FT: User opens Monitor tab of the alert details panel
    And FT: User switch to embedded Monitor tab on the alert details
    And FT: User should see event start time on embedded Monitor
    And FT: User should see embedded Monitor in historical mode
    And FT: User should not see primary navigation bar on embedded Monitor
    And FT: User should not see patient header on embedded Monitor
    And FT: User should not see docked events list on embedded Monitor
    And FT: User should not see side navigation panel on embedded Monitor
    And FT: User should see at least 4 charts on embedded Monitor
    And FT: User opens Tools tab on embedded Monitor
    And FT: User should see rhythm strip on embedded Monitor
    And FT: User should see monitor zoom view on embedded Monitor
    And FT: User should see at least a single cardiac rhythm in the zoom view on embedded Monitor
    And FT: User can zoom in view on embedded Monitor
    And FT: User can zoom out view on embedded Monitor
    And FT: User should see snippet length selector on Tools header of embedded Monitor
    And FT: User should see snippet lead selectors on Tools header of embedded Monitor
    And FT: User should see measure on Tools header of embedded Monitor
    And FT: User should see calipers on Tools header of embedded Monitor
    And FT: User should see paper mode on Tools header of embedded Monitor
    And FT: User should see marchout on Tools header of embedded Monitor
    When FT: User clicks Measure button on embedded Monitor
    Then FT: User should see measurements P, QR, S, T on Tools header of embedded Monitor
    And FT: User could move P, QR, S, T on Tools header of embedded Monitor
    When FT: User clicks Calipers button on embedded Monitor
    Then FT: User see Calipers button is enabled on embedded Monitor
    And FT: User could move caliper handles on Tools header of embedded Monitor
    When FT: User clicks Calipers button on embedded Monitor
    Then FT: User see Calipers button is disabled on embedded Monitor
    When FT: User clicks Create Snippet button on embedded Monitor
    When FT: User wait for 20s until "Preview" button is enabled on embedded Monitor
    When FT: User sets Event Type to "PRN" on embedded Monitor
    When FT: User sets Description to "My description" on embedded Monitor
    When FT: User sets "HR" measurement value to "99" on embedded Monitor
    When FT: User sets "PR (s)" measurement value to "99" on embedded Monitor
    When FT: User sets "QRS (s)" measurement value to "99" on embedded Monitor
    When FT: User sets "QT (s)" measurement value to "99" on embedded Monitor
    When FT: User sets All leads On on embedded Monitor
    When FT: User clicks Preview button on embedded Monitor
    And FT: User wait for spinner disappears on embedded Monitor
    Then FT: User should see Snippet Preview dialog on embedded Monitor
    When FT: User clicks Back button on embedded Monitor
    Then FT: User should see Snippet Edit form on embedded Monitor
    When FT: User clicks Preview button on embedded Monitor
    And FT: User wait for spinner disappears on embedded Monitor
    When FT: User clicks Save button on embedded Monitor
    When FT: User wait for Snippet Saved message on embedded Monitor
    And FT: User opens Events tab on embedded Monitor
    And FT: User verifies that Last Hour events panel 0th element match "(?m).*(TC05_Medium_Alarm_Short|TC05_Low_Alarm_Short).*" and the alert time on embedded Monitor
    And FT: User verifies that Last Hour events panel 1th element match "(?m).*(TC05_Medium_Alarm_Short|TC05_Low_Alarm_Short).*" and the alert time on embedded Monitor
    Then FT: User sees "Last Hour,1–6 Hours Ago,More than 6 Hours Ago" tabs on events panel on embedded Monitor