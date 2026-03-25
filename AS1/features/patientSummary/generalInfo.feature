@regression @automated @core @patient_summary
Feature: Patient Summary - General Info Navigation
  General Info Expanded Navigation
  Web
  From the Overview Screen:

  The user can view the General Information Tile
  The user can tap on the General Information Tile to view the General Information expanded Tile
  The user can scroll vertically to view entire content of the General Info for a given patient
  From the General Information expanded screen, I can return from where I came from

  TestRail Id: C264291
  Jira Stories: AS1-209, AS1-98, AS1-101, AS1-1108, AS1-4037
@critical @TMS:264291
  Scenario: General Info Navigation
    Given I login to simulator with "username" and "XXXXX"
    Then I should see the patient list screen
    When I click "Census" on the List
    Then I should see the patient list screen
    When I click on "Blair, Jonathan" in patient list
    Then I should see the patient summary screen
    And I should see General Info tile
    When I click General Info tile
    Then I should see the following patient General Information in simulator
      | weight  | admit_date       | code_status           | location                | isolation_status | fin       | dob        | religion      | language | primary_contact                       | secondary_contact              | age | primary_md     |
      | 72.7 kg | 2/7/2016 6:44 AM | 1. Full Resuscitation | 5E CARDIO PMCW 567_A 01 |                  | 123456789 | 05/17/1946 | No Preference | ENG      | Elizabeth Blair 0008675309 (Business) | Ronald Blair 1234567890 (HOME) | 67  | Skinner, James |
    When I click Ok in General Info window
    Then I should see the patient summary screen
