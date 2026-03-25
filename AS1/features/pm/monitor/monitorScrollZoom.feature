@regression @monitor @nodeSim @automated @core @pm @pm-monitor @critical @TMS:582514
Feature: Monitor - Scrolling and Zooming
Vertical Parameter Display - Monitor
Scrolling:
Vertical Parameter display space can be vertically scrolled to see additional data

Window Resizing:
Vertical Parameter display space - the width of this display will be fixed (i.e. it will not grow when window is resized)
Vertical Parameter display space should be fixed/pinned to the right side of the Waveform display area (i.e. when the Web App window is resized and made wider, the Waveform display area will grow in width; the Vertical Parameter display space should stay fixed to the right side of the Waveform display area)
when Web App window is resized, the Vertical Parameter visible display space should remain linked to the Waveform Display space (i.e. the top boundary of the waveform display space should be matched by the top boundary of the vertical parameter display space; same for bottom boundary)\

Horizontal Parameter Display - Monitor
Scrolling:
Horizontal Parameter display space can be horizontally scrolled to see additional data

Window Resizing:
Horizontal Parameter display space - the height of this display will be fixed (i.e. it will not grow when window is resized)
Horizontal Parameter display space should be fixed/pinned to the top of the Waveform display area (i.e. when the Web App window is resized and made taller, the Waveform display area will grow in height; the Horizontal Parameter display space should stay fixed to the top side of the Waveform display area)

(left side)When Web App window is resized, the Horizontal Parameter display space should remain fixed to the left side of the screen (same as the Waveform Display space).
(right side) The visible portion of the Horizontal Parameter display space should be in line with the right side of the Vertical Parameter display space

Patient Monitor
Vertical Scrolling
The patient monitor display area can be scrolled vertically to view all available waveforms and associated labels. Labels and waveforms will scroll together (i.e. labels should maintain associated location with waveforms when scrolling)
As any scrolling action will "pause" live mode on the monitor, scrolling vertically will "stop" the live waveforms from scrolling as well as adjust the Live indicator to display as if in Historical Mode
Scrolling vertically and then selecting "Live" should maintain the vertical placement of the waveforms in the patient Monitor

Horizontal Scrolling
The patient monitor display area can be scrolled horizontally to view all available waveforms.

Scrolling left (a left to right motion) will go back in time
scrolling right (a right to left motion) will go forward in time.
Scrolling right to "now" will reinstate "Live" mode with streaming waveforms and Live indicator on
Horizontal scrolling will not adjust waveform labels. They will remain fixed to the left side of the monitor.
Zooming
The patient monitor display area can be zoomed in and out. (TBD Min/Max)

Zooming in or out should not affect the relative location of the lead label with the associated waveform. (i.e. each lead label should remain "with" the associated lead when zooming)
Anchor Elements
Specific items within each page of the web product will be identified as anchor elements and therefore always remain on screen when scrolling (when included on the page). These are:

App Chrome (AS1 Header)
Patient Details Header
Patient List (Census) Header
Primary Navigation
Secondary Navigation
Patient Monitoring

Parameters (When Visible - if none visible, there should be no anchor elements in the parameter space)

TestRail Id: C582514
Jira Issues: AS1-118, AS1-588, AS1-1129, AS1-4474, AS1-4649
Jira Epic: AS1-2504
Jira Stories: AS1-118,
Jira Bugs/Defects: AS1-588, AS1-1129, AS1-4474, AS1-4649, AS1-6840

  Scenario: Monitor - Scrolling and Zooming
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    Then I should see the patient list screen
#    And reset unit filtering
    When I click "Census" on the List
    Then I should see the patient list screen
    When I click on default patient in list without redirect
    Then I should see the Live Monitor screen
    And I should see the Live Monitor time in "[props.COMMON_DATE_FORMAT]" format
    And I should see the "Live" button is active
    Then the monitor zoom value is set at "2.5"

    When I zoom "in" on monitor screen
    Then the monitor zoom value is set at "10"

    When I zoom "out" on monitor screen
    Then the monitor zoom value is set at "1"

    When I scroll the monitor waveform to the "right"
    Then I should see monitor waveform moves "back" in time
    And I should see the "Live" button is inactive
    And I should see the Monitor Time Ago displays on monitor

    When I scroll the monitor waveform to the "left"
    Then I should see monitor waveform moves "forward" in time
    And I should see the "Live" button is inactive
    And I should see the Monitor Time Ago displays on monitor

    When I scroll the monitor waveform to the "right"
    Then I should see monitor waveform moves "back" in time
    And I should see the "Live" button is inactive
    And I should see the Monitor Time Ago displays on monitor

    When I scroll the monitor waveform to the "up"
    Then I should see monitor waveform moves "no change" in time
    And I should see the "Live" button is inactive
    And I should see the Monitor Time Ago displays on monitor

    When I scroll the monitor waveform to the "down"
    Then I should see monitor waveform moves "no change" in time
    And I should see the "Live" button is inactive
    And I should see the Monitor Time Ago displays on monitor

    When I click the "Live" button in sub navigation menu
    Then I should see the "Live" button is active
