@cardio @regression @automated @TMS:40249
Feature: Serial Compare Zoom Screen
              As an AS1 user
              I want view a Serial Compare Zoom Screen
  So that I can display a patient's ECGs side by side in a zoomed view

NOTE: pending tag due to performance of test (clicking caret button)

TestRail Id: C40249

        Background:
            Given I verify the version of the app installed
            Given login to the test site with "[props.U_USERNAME]" and "[props.U_PASSWORD]"
             When I click options button on top left of screen
             Then I should see the ListOfList window
             When I click "CardioSearch" in List of List window
             Then I should see the Cardio Search Screen
             When I enter "[props.CP_LNAME]" in "Last" search field
              And I click the search button
             Then I should see a total of 1 patient(s) in the search results

             When I click on "[props.CP_FULL_NAME]" in patient list

             Then I should see the patient ECG screen "Initial ECG Screen"
             When I click the ECG button
             Then I should see the ECG List window
             When I longclick on another ECG on row 2
             Then I should see the serial presentation screen

        Scenario: Serial Presentation Zoom Screen
             When I double click on main 3 sec Lead "I"
             Then I should see the Lead "I" zoom lead window for both ECGs

             When I click on the patient caret button on Serial Presentation Zoom screen
             Then I should see detail patient info on Serial Presentation Zoom screen for ECG lead "I"

             When I click on the patient caret button on Serial Presentation Zoom screen
             When I rotate the device to "landscape"
             Then the device orientation is "landscape"

             When I rotate the device to "portrait"
             Then the device orientation is "portrait"

             When I click the Close button on Serial Presentation Zoom window
             Then I should see the serial presentation screen

             When I double click on main 3 sec Lead "II"
             Then I should see the Lead "II" zoom lead window for both ECGs

             When I click on the patient caret button on Serial Presentation Zoom screen
             Then I should see detail patient info on Serial Presentation Zoom screen for ECG lead "II"

             When I click on the patient caret button on Serial Presentation Zoom screen
             When I rotate the device to "landscape"
             Then the device orientation is "landscape"

             When I rotate the device to "portrait"
             Then the device orientation is "portrait"

             When I click the Close button on Serial Presentation Zoom window
             Then I should see the serial presentation screen

             When I double click on main 3 sec Lead "III"
             Then I should see the Lead "III" zoom lead window for both ECGs

             When I click on the patient caret button on Serial Presentation Zoom screen
             Then I should see detail patient info on Serial Presentation Zoom screen for ECG lead "III"

             When I click on the patient caret button on Serial Presentation Zoom screen
             When I rotate the device to "landscape"
             Then the device orientation is "landscape"

             When I rotate the device to "portrait"
             Then the device orientation is "portrait"

             When I click the Close button on Serial Presentation Zoom window
             Then I should see the serial presentation screen

             When I double click on main 3 sec Lead "aVR"
             Then I should see the Lead "aVR" zoom lead window for both ECGs

             When I click on the patient caret button on Serial Presentation Zoom screen
             Then I should see detail patient info on Serial Presentation Zoom screen for ECG lead "aVR"

             When I click on the patient caret button on Serial Presentation Zoom screen
             When I rotate the device to "landscape"

             Then the device orientation is "landscape"
             When I rotate the device to "portrait"

             Then the device orientation is "portrait"
             When I click the Close button on Serial Presentation Zoom window
             Then I should see the serial presentation screen

             When I double click on main 3 sec Lead "aVL"
             Then I should see the Lead "aVL" zoom lead window for both ECGs

             When I click on the patient caret button on Serial Presentation Zoom screen
             Then I should see detail patient info on Serial Presentation Zoom screen for ECG lead "aVL"

             When I click on the patient caret button on Serial Presentation Zoom screen
             When I rotate the device to "landscape"
             Then the device orientation is "landscape"

             When I rotate the device to "portrait"
             Then the device orientation is "portrait"

             When I click the Close button on Serial Presentation Zoom window
             Then I should see the serial presentation screen

             When I double click on main 3 sec Lead "aVF"
             Then I should see the Lead "aVF" zoom lead window for both ECGs

             When I click on the patient caret button on Serial Presentation Zoom screen
             Then I should see detail patient info on Serial Presentation Zoom screen for ECG lead "aVF"

             When I click on the patient caret button on Serial Presentation Zoom screen
             When I rotate the device to "landscape"
             Then the device orientation is "landscape"

             When I rotate the device to "portrait"
             Then the device orientation is "portrait"

             When I click the Close button on Serial Presentation Zoom window
             Then I should see the serial presentation screen

             When I double click on main 3 sec Lead "V1"
             Then I should see the Lead "V1" zoom lead window for both ECGs

             When I click on the patient caret button on Serial Presentation Zoom screen
             Then I should see detail patient info on Serial Presentation Zoom screen for ECG lead "V1"

             When I click on the patient caret button on Serial Presentation Zoom screen
             When I rotate the device to "landscape"
             Then the device orientation is "landscape"

             When I rotate the device to "portrait"
             Then the device orientation is "portrait"

             When I click the Close button on Serial Presentation Zoom window
             Then I should see the serial presentation screen

             When I double click on main 3 sec Lead "V2"
             Then I should see the Lead "V2" zoom lead window for both ECGs

             When I click on the patient caret button on Serial Presentation Zoom screen
             Then I should see detail patient info on Serial Presentation Zoom screen for ECG lead "V2"

             When I click on the patient caret button on Serial Presentation Zoom screen
             When I rotate the device to "landscape"
             Then the device orientation is "landscape"

             When I rotate the device to "portrait"
             Then the device orientation is "portrait"

             When I click the Close button on Serial Presentation Zoom window
             Then I should see the serial presentation screen

             When I double click on main 3 sec Lead "V3"
             Then I should see the Lead "V3" zoom lead window for both ECGs

             When I click on the patient caret button on Serial Presentation Zoom screen
             Then I should see detail patient info on Serial Presentation Zoom screen for ECG lead "V3"

             When I click on the patient caret button on Serial Presentation Zoom screen
             When I rotate the device to "landscape"
             Then the device orientation is "landscape"

             When I rotate the device to "portrait"
             Then the device orientation is "portrait"

             When I click the Close button on Serial Presentation Zoom window
             Then I should see the serial presentation screen

             When I double click on main 3 sec Lead "V4"
             Then I should see the Lead "V4" zoom lead window for both ECGs

             When I click on the patient caret button on Serial Presentation Zoom screen
             Then I should see detail patient info on Serial Presentation Zoom screen for ECG lead "V4"

             When I click on the patient caret button on Serial Presentation Zoom screen
             When I rotate the device to "landscape"
             Then the device orientation is "landscape"

             When I rotate the device to "portrait"
             Then the device orientation is "portrait"

             When I click the Close button on Serial Presentation Zoom window
             Then I should see the serial presentation screen

             When I double click on main 3 sec Lead "V5"
             Then I should see the Lead "V5" zoom lead window for both ECGs

             When I click on the patient caret button on Serial Presentation Zoom screen
             Then I should see detail patient info on Serial Presentation Zoom screen for ECG lead "V5"

             When I click on the patient caret button on Serial Presentation Zoom screen
             When I rotate the device to "landscape"
             Then the device orientation is "landscape"

             When I rotate the device to "portrait"
             Then the device orientation is "portrait"

             When I click the Close button on Serial Presentation Zoom window
             Then I should see the serial presentation screen

             When I double click on main 3 sec Lead "V6"
             Then I should see the Lead "V6" zoom lead window for both ECGs

             When I click on the patient caret button on Serial Presentation Zoom screen
             Then I should see detail patient info on Serial Presentation Zoom screen for ECG lead "V6"

             When I click on the patient caret button on Serial Presentation Zoom screen
             When I rotate the device to "landscape"
             Then the device orientation is "landscape"

             When I rotate the device to "portrait"
             Then the device orientation is "portrait"

             When I click the Close button on Serial Presentation Zoom window
             Then I should see the serial presentation screen

