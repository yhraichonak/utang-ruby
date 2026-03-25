@regression @automated @core  @patient_summary
Feature: PM - Monitor Tile Inactive No Events

  Description
  Monitor - "No monitor data" Occurs when Patient is not active, has no PM data in Past 24 hrs
  (not on a monitor). Server will send status of “na” which client will have to translate into “No Monitor Data”

  -No Monitor Data
  Patient without Monitor data/Events in last 24h
  Monitor Tile - No messaging appears
  Event Tile section - "No Monitor Data" is the message centered in the tile


  TestRail Id: C264360
  Jira Stories: AS1-380
  @critical @TMS:264360 @mock
  Scenario: PM - Monitor Tile Inactive No Events
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    Then I should see the patient list screen
    When I click "Census" on the List
    Then I should see the patient list screen
    When I click on "[props.NEPINACTIVE_FULL_NAME]" in patient list
    Then I should see the patient summary screen
    And I should see the Monitor Tile as "inactive" with No Events
