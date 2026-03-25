@automated @TMS:40292 @cardio @cardio-serial_compare @bvt
Feature: Cardio Summary Screen
  As an AS1 user
  I want view a Cardio Summary Screen
  So that I can display a patient's summary screen

  TestRail Id: C40292

  Scenario: Serial Presentation Lead Zoom
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    When 	I click the AS1 button
    Then 	I should see my ListOfList window
    When 	I click "MOST RECENT" on the List
    Then 	I should see the patient List
    When 	I click on "[props.DP_FULL_NAME]" in patient list
    Then 	I should see the patient ECG screen
    When 	I click the ECGs List button
    Then 	I should see the ECG List window
    When 	I longclick on row 2 on ecg list
    Then 	I should see the serial presentation screen
    When 	I click on the top ecg chevron on the Serial Compare screen
    Then 	I should see the top ECG chevron details on the Serial Compare screen
    Then 	I should see the bottom ECG chevron details on the Serial Compare screen
    When 	I double click on the top 3 sec Lead "I"
    Then 	I should see the Lead "I" Serial Presentation Zoom window
    When 	I click on the top ecg chevron on the Serial Compare Zoom screen
    Then 	I should see the top ECG chevron details on the Serial Compare Zoom screen
    Then 	I should see the bottom ECG chevron details on the Serial Compare Zoom screen
