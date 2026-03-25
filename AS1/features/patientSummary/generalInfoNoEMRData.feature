@regression @automated @core  @patient_summary
Feature: Patient Summary - General Info Navigation
    No Data for General Info Tile
    Android, iOS and Web

  If no EMR data, don't display demographics tile; use information from Patient Details Header

  TestRail Id: C264383
  Jira Stories: AS1-264
  @critical @TMS:264383
  Scenario: General Info Navigation
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    When I click "Census" on the List
    Then I should see the patient list screen
    When I click on "[props.AP_FULL_NAME]" in patient list
    Then I should see the patient summary screen
    And I should see General Info tile
    When I click General Info tile
    Then I should see patient General Information
    When I click Ok in General Info window
    Then I should see the patient summary screen
