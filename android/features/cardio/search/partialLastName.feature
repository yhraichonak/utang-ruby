@automated @TMS:40307  @cardio @cardio-search @bvt
Feature: Search by partial Last Name
  As an AS1 user
  I want to search for patients using the search form
  So I can find patients by Partial Last Name

  TestRail Id: C40307

  Scenario: Search by Partial Last Name
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    When  I click the AS1 button
    Then  I should see my ListOfList window
    When  I click "Cardio Search" on the List
    Then  I should see Search in the nav bar
    When  I enter "[props.DP_LNAME]" in the cardio "Last" field for partial search
    And   I click the search button
    Then  I should verify the patient information
      | full_name | [props.DP_FULL_NAME] |
      | age       | [props.DP_AGE]       |
      | sex       | [props.DP_SEX]       |
      | time_info | [props.DP_ECG_TIME]  |
      | ecg_info  | [props.DP_ECG_INFO]  |
      | ecg_count | [props.DP_ECG_COUNT] |
