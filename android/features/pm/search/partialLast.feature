@automated @TMS:40317  @pm @pm-search @regression @bvt
Feature: Search: By Partial Last, First Name, MRN, Bed
  As an AS1 user
  I want view a Search for patients by partial Last name
  So that I can make sure I can view the patient's information

  TestRail Id: C40317

  Scenario: Search: By Partial Last, First Name, MRN, Bed
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    When I click the AS1 button
    When I click "PM Census" on the List
    Then I should see the patient List
    When I select Search from the PM census
    When I enter "[props.PSP_LNAME]" in the field for partial search
    Then I should verify the pm patient information
      | patientName  | [props.PSP_FULL_NAME]    |
      | age          | [props.PSP_AGE]          |
      | gender       | [props.PSP_SEX]          |
      | MRN          | [props.PSP_MRN]          |
      | DOB          | [props.PSP_DOB]          |
      | bed          | [props.PSP_BED]          |
