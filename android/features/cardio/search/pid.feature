@automated @TMS:40270  @cardio @cardio-search @bvt
Feature: Search by PID
  As an AS1 user
  I want to search for patients using the search form
  So I can find patients by PID

  TestRail Id: C40270

  Scenario: Search by MRN
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    When  I click the AS1 button
    Then  I should see my ListOfList window
    When  I click "Cardio Search" on the List
    Then  I should see Search in the nav bar
    When  I enter "[props.CP_MRN]" in the cardio "MRN" field
    And   I click the search button
    Then  I should verify the patient information
      | full_name | [props.CP_FULL_NAME] |
      | age       | [props.CP_AGE]       |
      | sex       | [props.CP_SEX]       |
      | time_info | [props.CP_ECG_TIME]  |
      | ecg_info  | [props.CP_ECG_INFO]  |
      | ecg_count | [props.CP_ECG_COUNT] |
