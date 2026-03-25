@automated @TMS:40273 @cardio @cardio-ecg_screen @bvt
Feature: ECG Screen
  As an AS1 user
  I want view a 500 SPS ECG Screen
  So that I can make sure a patient's ECG displays with diagnostic statements

  TestRail Id: C40273

  Scenario: ECG Screen (500 SPS)
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    When I click the AS1 button
    Then I should see my ListOfList window
    When I click "MOST RECENT" on the List
    Then I should see the patient List
    When  I click on "[props.CEP_FULL_NAME]" in patient list
    Then I should see the patient ECG screen
    When I click the chevron
    Then I should see the patient details
    And  I should see the patient details displayed on the ECG screen
    When I click the chevron
    When I rotate the device to "landscape"
    Then the device orientation is set to "landscape"
    When I rotate the device to "portrait"
    Then the device orientation is set to "portrait"
    And I swipe the scrubber to the "right"
    And I swipe the scrubber to the "left"
    And I pinch zoom "out" on ECG screen
    And I pinch zoom "in" on ECG screen
