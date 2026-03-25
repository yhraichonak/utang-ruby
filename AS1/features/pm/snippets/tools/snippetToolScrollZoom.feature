@regression @nodeSim @automated @core @pm @pm-snippets @pm-snippets-tools @pipeline_run
Feature: PM - Snippet Tool - Zooming and Scrolling
  Snippet Tool
  As a user, I expect to adjust the on-screen view of a dual lead PM waveform in the Monitor Tool so that I may select a representative section of waveform.

  The user should be able to scroll and zoom the waveform on zoom view (Up to 10x Zoom) utilizing a ghost control
  The user should be able to scroll the waveform on the rhythm strip
  Waveform and Rhythm strip Scrolling should be both vertical and horizontal, depending on min/max of waveform (i.e. the user should be able to view the highest and lowest points of a single lead waveform. If scrolling is necessary to achieve this view, then the rhythm strip should scroll vertically.)
  The user can vertically scroll the zoom view and rhythm strip separately. Vertical scroll sync between zoom view and rhythm strip is not necessary, but scroll sync horizontally is required.
  Location preview (see AS1-133 TESTING ) should resize/adjust relative to current zoom level and scroll area - it should consistently reflect the zoomed in portion of the waveform above, regardless of screen size.
  The scroll controls should function as a pair - when the zoom view is scrolled, the rhythm strip will scroll as well, and if the rhythm strip is scrolled the zoom view will also scroll.
  **Note: Due to the different levels of zoom on the same waveform, the scroll speed for both the rhythm strip and zoom view will need to adjust depending on zoom level. The only scenario in which the zoom view and rhythm strip would scroll at the same speed is one in which the user had zoomed out on the zoom view to the same zoom level as the rhythm strip.

  Monitor tool with gridlines - scrolling should not allow the waveform to move/scroll independently of the gridlines.

  Lead Labels:

  The lead label should maintain vertical and horizontal location with the lead when lead is scrolled horizontally.
  The lead label should scroll vertically with the waveform when scrolling vertically.
  The lead label should maintain a consistent position (left aligned and central to lead baseline) when zooming

  TestRail Id: C264279

  Jira Stories: AS1-119, AS1-131, AS1-173, AS1-132, AS1-1248, AS1-1877, AS1-1960, AS1-3008, AS1-3508

  @TMS:264279
  Scenario: PM - Snippet Tool - Zooming and Scrolling
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    Then I should see the patient list screen
    When I click "Census" on the List
    Then I should see the patient list screen
    When I click on default patient in list
    Then I should see the patient summary screen
    When I click on the Monitor tile
    Then I should see the Live Monitor screen
    When I click the "Tools" button in sub navigation menu
    Then I should see the Snippet Tool screen
    And I should see the Measure button "inactive"
    And I should see the HR legend in waveform chart
    And the snippet tool zoom value is set at "8"
    When I zoom "in" on snippet tool screen
    Then the snippet tool zoom value is set at "10"
    When I zoom "out" on snippet tool screen
    Then the snippet tool zoom value is set at "1"
    When I scroll the snippet waveform to the "left"
    Then snippet waveform moves "forward" in time
    When I scroll the snippet waveform to the "right"
    Then snippet waveform moves "back" in time