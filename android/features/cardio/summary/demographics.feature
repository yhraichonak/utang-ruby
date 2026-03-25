@automated @TMS:40293  @cardio @cardio-summary @bvt
Feature:  Demographics
  As an AS1 user
  I want to read the patient's demographic information

  TestRail Id: C40293

  Scenario: Demographics
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    When  I click the AS1 button
    And   I click "MOST RECENT" on the List
    Then  I should see the patient List
    When  I click on "[props.CEP_FULL_NAME]" in patient list
    Then  I should see the patient ECG screen
    And   I should see the patient name info in the demographics header
    And   I should see the patient gender info in the demographics header
    And   I should see the patient age info in the demographics header
    And   I should see the patient MRN info in the demographics header
    And   I should see the patient location info in the demographics header
    And   I should see the patient site info in the demographics header
