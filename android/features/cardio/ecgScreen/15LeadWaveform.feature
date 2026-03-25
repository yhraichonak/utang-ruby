@automated @TMS:40272 @cardio @cardio-ecg_screen @bvt @run
Feature: ECG Screen
  As an AS1 user
  I want view a 15 Lead Wave Form ECG Screen
  So that I can make sure a patient's ECG displays with diagnostic statements

  TestRail Id: C40272

  Scenario: ECG Screen (15 Lead - 15 Waveform)
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    When  I click the AS1 button
    Then  I should see my ListOfList window
    When  I click "MOST RECENT" on the List
    Then  I should see the patient List
    When  I click on "[props.CEP_FULL_NAME]" in patient list
    Then  I should see the patient ECG screen
    Then  I should see the 15 waveforms I II III aVR aVL aVF V1 V2 V3 V4 V5 V6 V3R V4R V7 waveforms display
