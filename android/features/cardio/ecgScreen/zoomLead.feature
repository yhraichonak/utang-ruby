@automated @TMS:40276  @cardio @cardio-ecg_screen @bvt
Feature: ECG Screen
  As an AS1 user
  I want view a Zoom Lead ECG Screen
  So that I can make sure a patient's ECG displays with diagnostic statements

  TestRail Id: C40276

  # Fixed but has crash bug with switching from landscape to portrait in ECG screen:
  # https://utang.atlassian.net/browse/AS1-4839

  Scenario: Zoom Lead View
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
    When  I click on the chevron on zoom lead screen
    Then  I should see detail patient info on zoom lead screen
    When  I click on the chevron on zoom lead screen
    And   I rotate the device to "landscape"
    Then  the device orientation is set to "landscape"
    When  I rotate the device to "portrait"
    Then  the device orientation is set to "portrait"
    When  I swipe the scrubber to the "right" on zoom lead screen
    And   I swipe the scrubber to the "left" on zoom lead screen
    And   I click hardware back button
    Then  I should see the patient ECG screen
    When  I double click on 3 sec Lead "II"
    Then  I should see the Lead "II" zoom lead window
    When  I click on the chevron on zoom lead screen
    Then  I should see detail patient info on zoom lead screen
    When  I click on the chevron on zoom lead screen
    And   I rotate the device to "landscape"
    Then  the device orientation is set to "landscape"
    When  I rotate the device to "portrait"
    Then  the device orientation is set to "portrait"
    When  I swipe the scrubber to the "right" on zoom lead screen
    And   I swipe the scrubber to the "left" on zoom lead screen
    And   I click hardware back button
    Then  I should see the patient ECG screen
    When  I double click on 3 sec Lead "v3"
    Then  I should see the Lead "V3" zoom lead window
    When  I click on the chevron on zoom lead screen
    Then  I should see detail patient info on zoom lead screen
    When  I click on the chevron on zoom lead screen
    And   I rotate the device to "landscape"
    Then  the device orientation is set to "landscape"
    When  I rotate the device to "portrait"
    Then  the device orientation is set to "portrait"
    When  I swipe the scrubber to the "right" on zoom lead screen
    And   I swipe the scrubber to the "left" on zoom lead screen
    And   I click hardware back button
    Then  I should see the patient ECG screen
    When  I double click on 10 sec Lead "aVR"
    Then  I should see the Lead "aVR" zoom lead window
    When  I click on the chevron on zoom lead screen
    Then  I should see detail patient info on zoom lead screen
    When  I click on the chevron on zoom lead screen
    And   I rotate the device to "landscape"
    Then  the device orientation is set to "landscape"
    When  I rotate the device to "portrait"
    Then  the device orientation is set to "portrait"
    And   I swipe the scrubber to the "right" on zoom lead screen
    And   I swipe the scrubber to the "left" on zoom lead screen
