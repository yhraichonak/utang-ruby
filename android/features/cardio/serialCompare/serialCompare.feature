@automated @TMS:40291 @cardio @cardio-serial_compare @bvt
Feature: Serial Presentation Screen
  As an AS1 user
  I want view a Serial Presentation Screen
  So that I can display a patient's ECGs side by side

  TestRail Id: C40291

  Scenario: Serial Presentation Screen
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    When  I click the AS1 button
    Then  I should see my ListOfList window
    When  I click "MOST RECENT" on the List
    Then  I should see the patient List
    When  I click on "[props.DP_FULL_NAME]" in patient list
    Then  I should see the patient ECG screen
    When  I click the ECGs List button
    Then  I should see the ECG List window
    When  I longclick on row 2 on ecg list
    Then  I should see the serial presentation screen
    When  I click the chevron
    When  I rotate the device to "landscape"
    Then  the device orientation is set to "landscape"
    And   I should see detail patient info
    When  I click the chevron
    Then  I should see the serial presentation screen
    When  I rotate the device to "portrait"
    Then  the device orientation is set to "portrait"
    And   I swipe the "bottom" ECG leads to the "left"
    And   I swipe the "bottom" ECG leads to the "right"
    And   I swipe the "top" ECG leads to the "left"
    And   I swipe the "top" ECG leads to the "right"
    And   I pinch zoom "out" on Serial Presentation screen
    And   I pinch zoom "in" on Serial Presentation screen
