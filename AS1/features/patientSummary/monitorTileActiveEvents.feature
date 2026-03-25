@regression @automated @core@patient_summary
Feature: PM -  Monitor Tile Active with Events

  Active, With Events
  Active patient currently connected to monitor; they have had no events in the past 24 hrs:
  Monitor Tile - The word “Active” appears at the top in blue
  Event Tile section – Most recent events display (no messaging)

  TestRail Id: C264358
  Jira Stories: AS1-380, AS1-765, AS1-1241
 @critical @TMS:264358
  Scenario: PM -  Monitor Tile Active with Events
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    Then I should see the patient list screen
    When I click "Census" on the List
    Then I should see the patient list screen
    When I click on "[props.DP_FULL_NAME]" in patient list
    Then I should see the patient summary screen
    And I should see the Monitor Tile as "active" with Events
