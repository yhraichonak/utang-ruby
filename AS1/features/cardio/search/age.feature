@cardio @regression @automated @core @cardio @cardio-search
Feature: Search - Age
  As an AS1 user
  I want to search for patients using the search form
  So I can find patients by First Name, Last Name, Age, DOB, and by MRN.

  TestRail Id: C179320
  Jira Stories: AS1-34, AS1-299, AS1-611

   @critical @TMS:179320
  Scenario: Search - Age
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    Then I should see the patient list screen
    When I click "SEARCH" on the List
    Then I should see the search patient list screen
    When I enter "[props.CP_CARDIO_AGE] |" in "Age" search field
    And I click on search button
    And I should see patient information in patientList
      | patientName          | gender         | age            | acqDate             | ecgCount             | diagStatement   |
      | [props.CP_FULL_NAME] | [props.CP_SEX] | [props.CP_CARDIO_AGE] | [props.CP_ECG_TIME] | [props.CP_ECG_COUNT] | [props.CP_DIAG] |
    And I should see a total of 1 patient(s) in the search results
