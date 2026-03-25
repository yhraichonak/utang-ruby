@automated @TMS:40319  @pm @pm-summary_screen @regression @bvt
Feature: Summary Screen: View the PM Summary Screen
  I want view the PM Summary Screen
  So that I can make sure I can view the patient's information

  TestRail Id: C40319

  Scenario: Summary Screen: PM Summary Screen
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    When I click the AS1 button
    When I click "PM Census" on the List
    When I click on "[props.DP_FULL_NAME]" in patient list
    When I click the Home button
    Then I should see the patient summary screen
    And I should see the patient demographics tile information
      | patient_name_label      | Patient Name         |
      | patient_name_text       | [props.DP_FULL_NAME] |
      | mrn_label               | MRN                  |
      | mrn_text                | [props.DP_MRN]       |
      | dob_label               | DOB                  |
      | dob_text                | [props.DP_DOB]       |
      | gender_label            | Gender               |
      | gender_text             | [props.DP_SEX]       |
      | age_label               | Age                  |
      | age_text                | [props.DP_AGE]       |
