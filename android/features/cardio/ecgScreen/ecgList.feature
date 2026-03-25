@automated @TMS:40274  @cardio @cardio-ecg_screen @bvt
Feature: ECG Screen
  As an AS1 user
  I want view the ECG List Screen
  So that I can make sure a patient's ECG displays with diagnostic statements

  TestRail Id: C40274

  Scenario:  ECG List
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    When  I click the AS1 button
    Then  I should see my ListOfList window
    When  I click "MOST RECENT" on the List
    Then  I should see the patient List
    When  I click on "[props.CP_FULL_NAME]" in patient list
    Then  I should see the patient ECG screen
    When  I click the Home button
    Then  I should see the patient summary screen
    When  I click on the ECG tile
    Then  I should see the patient ECG screen
    When  I click the ECGs List button
    Then  I should see the ECG List window
    When  I click on the ECG on row 2
    Then  I should see the patient ECG screen
