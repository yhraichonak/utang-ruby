@smoke @multiPatient @automated @core @pm @pm-patient_list @pm-patient_list-features  @TMS:582911
Feature: My Patients List Empty - navigation

  TestRail Id: C582911
  Jira Issues: AS1-2944

  Scenario: My Patients - no my patients
    Given I am a super user with no permissions
    When I login to a testSite with a valid credential
    Then I should see the patient list screen
    And I reset grouping and sorting on patients list
    Then I should see the patient list screen
    When I click "My Patients" on the List
    And I configure My Patients list to have "0" patients
    And I click "Census" on the List
    Then I should see the patient list screen
    When I get my patient count
    When I click on patient "[props.DP_FULL_NAME]" star icon to "enabled"
    Then I should see the patient "[props.DP_FULL_NAME]" star icon "enabled"
    When I click on patient "[props.AP_FULL_NAME]" star icon to "enabled"
    Then I should see the patient "[props.AP_FULL_NAME]" star icon "enabled"
    And I should see My Patients counter with count of "2"
    When I click "OR Floor 2" on the List
    Then I should be on "OR Floor 2" patientList
    And I should see the patient list screen
    And I should see My Patients counter with count of "2"

    When I click "My Patients" on the List
    Then I should see the patient list screen
    And I should see patient "QA1, QA1" in My Patient list
    And I should see patient "QA2, QA2" in My Patient list
