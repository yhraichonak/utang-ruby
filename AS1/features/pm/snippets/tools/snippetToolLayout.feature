@regression @nodeSim @automated @core @pm @pm-snippets @pm-snippets-tools @pipeline_run
Feature: PM - Snippet Screen Layout
  Description

  When configured, Snippets contains all elements of waveform analysis tool (Monitor Tool)
  The following elements should appear on screen within the Monitor Tool when configured for Snippets (ON)

  Patient Header
  Details header
  Contains Lead Label Selectors
  Contains Snippet Length Selector
  Control Space - Center aligned above waveform area
  Will contain controls such as measurement and calipers
  Zoom view of Selected waveform
  Zoom view of waveform is the area of the screen which will be variable height/width when window height or width is adjusted
  Rhythm Strip:
  Representative of the section of waveform that is currently viewed (no scrubber)
  Boundary Indicators (when necessary for screen size) on Zoom view and Rhythm Strip

  TestRail Id: C264261

  Jira Epics: AS1-2497

  Jira Stories: AS1-135, AS1-153, AS1-154, AS1-157, AS1-2344,

  Jira Bugs/Defects: AS1-571, AS1-2341, AS1-4083, AS1-4503, AS1-4704, AS1-5654, AS1-5667, AS1-6238, AS1-7380

  @TMS:264261
  Scenario: PM - Snippet Screen Layout
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
    And I should see the lead selectors
    And User is able to see the both of the waveform dropdowns on Snippet screen
    And User is able to see the snippet duration dropdown on Snippet screen