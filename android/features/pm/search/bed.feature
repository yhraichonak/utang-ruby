@automated @TMS:40315  @pm @pm-search @regression @bvt
Feature: Search: By BED
  As an AS1 user
  I want view a Search for patients by BED
  So that I can make sure I can view the patient's information

  TestRail Id: C40315

  Scenario: Search: By Bed
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    When I click the AS1 button
    When I click "PM Census" on the List
    Then I should see the patient List
    When I select Search from the PM census
    When I enter "[props.CP_BED]" in the field
    Then I should verify the pm patient information
      | patientName  | [props.CP_FULL_NAME]    |
      | gender       | [props.CP_SEX]          |
      | age          | [props.CP_AGE]          |
      | MRN          | [props.CP_MRN]          |
      | DOB          | [props.CP_DOB]          |
      | bed          | [props.CP_BED]          |
