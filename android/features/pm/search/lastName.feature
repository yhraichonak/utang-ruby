@automated @TMS:40313  @pm @pm-search @regression @bvt
Feature: Search: By Last Name
  As an AS1 user
  I want view a Search for patients by Last Name
  So that I can make sure I can view the patient's information

  TestRail Id: C40313

  Scenario: Search: By Last Name
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    When I click the AS1 button
    When I click "PM Census" on the List
    Then I should see the patient List
    When I select Search from the PM census
    When I enter "[props.CP_LNAME]" in the field
    Then I should verify the pm patient information
      | patientName  | [props.CP_FULL_NAME]    |
      | gender       | [props.CP_SEX]          |
      | age          | [props.CP_AGE]          |
      | MRN          | [props.CP_MRN]          |
      | DOB          | [props.CP_DOB]          |
      | bed          | [props.CP_BED]          |
