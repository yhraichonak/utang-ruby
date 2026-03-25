@regression @nodeSim @automated @core @pm @pm-snippets @pm-snippets-tools
Feature: PM - Snippet Screen Layout 900 x 600
Description

On smaller screens (screenshot approx 900x600) the user cannot view the lead in Tool Screen without scrolling or zooming.

When initially entering the Tools screen, the user should be able to view waveform(s) regardless of the screen size without zooming or scrolling.

Original Requirement:
*On the Monitor Tool, display a zoomed-in portion of the waveform that is being viewed by the user.

The zoom view should display (best case) the full first waveform, containing at least one cardiac cycle, and a portion of the second waveform.
*Note:The goal is for the user to be able to place measurement indicators with accuracy, without having to adjust zoom/zoom in.

TestRail Id: C328866
Jira Stories: AS1-1947, AS1-2245, AS1-2246, AS1-2931

@critical @TMS:328866
  Scenario: PM - Snippet Screen Layout 900 x 600
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    Then I should see the patient list screen
    When I click "Census" on the List
    Then I should see the patient list screen
    When I see the browser resolution to "900" width by "600" height
    When I click on default patient in list

    When I click the expand icon menu button
    Then I should see the expanded navigation links
    When I click the expand icon menu button
    Then I should not see the expanded navigation links
    When I click on the Monitor tile

    Then I should see the Live Monitor screen
    When I click the expand icon menu button
    Then I should see the expanded navigation links
    When I click the expand icon menu button
    Then I should not see the expanded navigation links
    When I click the "Tools" button in sub navigation menu
    Then I should see the Snippet Tool screen
    When I click the expand icon menu button
    Then I should see the expanded navigation links
    When I click the expand icon menu button
    Then I should not see the expanded navigation links
    And I should see overflow control
    When I click the overflow control
    Then I should see the lead selectors
    And I should see the paper mode toggle
    And I should see the marchout toggle
    And I should see the length selector

