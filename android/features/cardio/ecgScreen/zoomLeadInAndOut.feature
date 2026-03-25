@automated @TMS:40306  @cardio @cardio-ecg_screen @bvt
Feature: Zoom Lead View Pinch Zoom In and Out
  As an AS1 user
  I want view a Zoom Lead Pinch in and out on the ECG Screen
  So that I can make sure a patient's ECG displays with diagnostic statements

  TestRail Id: C40306

  Scenario: Zoom Lead View Pinch Zoom In and Out
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    When  I click the AS1 button
    Then  I should see my ListOfList window
    When  I click "MOST RECENT" on the List
    Then  I should see the patient List
    When  I click on "[props.CEP_FULL_NAME]" in patient list
    Then  I should see the patient ECG screen
    When  I double click on 3 sec Lead "I"
    Then  I should see the Lead "I" zoom lead window
    And   I pinch zoom "out" on zoom lead screen
    When  I click hardware back button
    Then  I should see the patient ECG screen
    When  I double click on 3 sec Lead "I"
    Then  I should see the Lead "I" zoom lead window
    And   I pinch zoom "in" on zoom lead screen
