@regression @automated @core @patient @patient_summary
Feature: Patient Summary - Cardio Tile No Ecgs

    Empty/No Data Tile Behavior:
    Android, iOS and Web

    When no data for ECGs Tile, the tile should read:

  "No ECGs"

  TestRail Id: C264295
  Jira Stories: AS1-265, AS1-269
  @critical @TMS:264295
  Scenario: Patient Summary - Cardio Tile No Ecgs
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    Then I should see the patient list screen
    When I click "Census" on the List
    Then I should see the patient list screen
    When I click on a patient with no ECGs in patient list
    Then I should see the patient summary screen
    And I should see the Ecg Tile with No ECGs