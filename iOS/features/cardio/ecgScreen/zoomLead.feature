@cardio @regression @automated @TMS:40226
Feature: ECG Screen - Zoom Lead
              As an AS1 user
              I want view a 12 Lead Zoom Screen
  So that I can make sure a patient's Zoom ECG displays with diagnostic statements

TestRail Id: C40226

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

             Then I should see the patient ECG screen

        Scenario: Zoom Lead View
             When I double click on 3 sec Lead "I"
             Then I should see the Lead "I" zoom lead window

              And I rotate the device to "landscape"
             Then the device orientation is "landscape"

             When I rotate the device to "portrait"
             Then the device orientation is "portrait"

             When I click the X button on zoom lead window
             Then I should see the patient ECG screen

             When I double click on 3 sec Lead "II"
             Then I should see the Lead "II" zoom lead window


              And I rotate the device to "landscape"
             Then the device orientation is "landscape"

             When I rotate the device to "portrait"
             Then the device orientation is "portrait"

             When I click the X button on zoom lead window
             Then I should see the patient ECG screen

             When I double click on 3 sec Lead "III"
             Then I should see the Lead "III" zoom lead window


              And I rotate the device to "landscape"
             Then the device orientation is "landscape"

             When I rotate the device to "portrait"
             Then the device orientation is "portrait"

             When I click the X button on zoom lead window
             Then I should see the patient ECG screen

             When I double click on 3 sec Lead "aVR"
             Then I should see the Lead "aVR" zoom lead window


              And I rotate the device to "landscape"
             Then the device orientation is "landscape"

             When I rotate the device to "portrait"
             Then the device orientation is "portrait"

             When I click the X button on zoom lead window
             Then I should see the patient ECG screen

             When I double click on 3 sec Lead "aVL"
             Then I should see the Lead "aVL" zoom lead window


              And I rotate the device to "landscape"
             Then the device orientation is "landscape"

             When I rotate the device to "portrait"
             Then the device orientation is "portrait"

             When I click the X button on zoom lead window
             Then I should see the patient ECG screen

             When I double click on 3 sec Lead "aVF"
             Then I should see the Lead "aVF" zoom lead window


              And I rotate the device to "landscape"
             Then the device orientation is "landscape"

             When I rotate the device to "portrait"
             Then the device orientation is "portrait"

             When I click the X button on zoom lead window
             Then I should see the patient ECG screen

             When I double click on 3 sec Lead "V1"
             Then I should see the Lead "V1" zoom lead window


              And I rotate the device to "landscape"
             Then the device orientation is "landscape"

             When I rotate the device to "portrait"
             Then the device orientation is "portrait"

             When I click the X button on zoom lead window
             Then I should see the patient ECG screen

             When I double click on 3 sec Lead "V2"
             Then I should see the Lead "V2" zoom lead window


              And I rotate the device to "landscape"
             Then the device orientation is "landscape"

             When I rotate the device to "portrait"
             Then the device orientation is "portrait"

             When I click the X button on zoom lead window
             Then I should see the patient ECG screen

             When I double click on 3 sec Lead "V3"
             Then I should see the Lead "V3" zoom lead window


              And I rotate the device to "landscape"
             Then the device orientation is "landscape"

             When I rotate the device to "portrait"
             Then the device orientation is "portrait"

             When I click the X button on zoom lead window
             Then I should see the patient ECG screen

             When I double click on 3 sec Lead "V4"
             Then I should see the Lead "V4" zoom lead window


              And I rotate the device to "landscape"
             Then the device orientation is "landscape"

             When I rotate the device to "portrait"
             Then the device orientation is "portrait"

             When I click the X button on zoom lead window
             Then I should see the patient ECG screen

             When I double click on 3 sec Lead "V5"
             Then I should see the Lead "V5" zoom lead window


              And I rotate the device to "landscape"
             Then the device orientation is "landscape"

             When I rotate the device to "portrait"
             Then the device orientation is "portrait"

             When I click the X button on zoom lead window
             Then I should see the patient ECG screen

             When I double click on 3 sec Lead "V6"
             Then I should see the Lead "V6" zoom lead window


              And I rotate the device to "landscape"
             Then the device orientation is "landscape"

             When I rotate the device to "portrait"
             Then the device orientation is "portrait"

             When I click the X button on zoom lead window
             Then I should see the patient ECG screen

             When I double click on 10 sec Lead "I"
             Then I should see the Lead "I" zoom lead window


              And I rotate the device to "landscape"
             Then the device orientation is "landscape"

             When I rotate the device to "portrait"
             Then the device orientation is "portrait"

             When I click the X button on zoom lead window
             Then I should see the patient ECG screen

             When I double click on 10 sec Lead "II"
             Then I should see the Lead "II" zoom lead window


              And I rotate the device to "landscape"
             Then the device orientation is "landscape"

             When I rotate the device to "portrait"
             Then the device orientation is "portrait"

             When I click the X button on zoom lead window
             Then I should see the patient ECG screen

             When I double click on 10 sec Lead "III"
             Then I should see the Lead "III" zoom lead window


              And I rotate the device to "landscape"
             Then the device orientation is "landscape"

             When I rotate the device to "portrait"
             Then the device orientation is "portrait"

             When I click the X button on zoom lead window
             Then I should see the patient ECG screen

             When I double click on 10 sec Lead "aVR"
             Then I should see the Lead "aVR" zoom lead window


              And I rotate the device to "landscape"
             Then the device orientation is "landscape"

             When I rotate the device to "portrait"
             Then the device orientation is "portrait"

             When I click the X button on zoom lead window
             Then I should see the patient ECG screen

             When I double click on 10 sec Lead "aVL"
             Then I should see the Lead "aVL" zoom lead window


              And I rotate the device to "landscape"
             Then the device orientation is "landscape"

             When I rotate the device to "portrait"
             Then the device orientation is "portrait"

             When I click the X button on zoom lead window
             Then I should see the patient ECG screen

             When I double click on 10 sec Lead "aVF"
             Then I should see the Lead "aVF" zoom lead window


              And I rotate the device to "landscape"
             Then the device orientation is "landscape"

             When I rotate the device to "portrait"
             Then the device orientation is "portrait"

             When I click the X button on zoom lead window
             Then I should see the patient ECG screen

             When I double click on 10 sec Lead "V1"
             Then I should see the Lead "V1" zoom lead window


              And I rotate the device to "landscape"
             Then the device orientation is "landscape"

             When I rotate the device to "portrait"
             Then the device orientation is "portrait"

             When I click the X button on zoom lead window
             Then I should see the patient ECG screen

             When I double click on 10 sec Lead "V1"
             Then I should see the Lead "V1" zoom lead window


              And I rotate the device to "landscape"
             Then the device orientation is "landscape"

             When I rotate the device to "portrait"
             Then the device orientation is "portrait"

             When I click the X button on zoom lead window
             Then I should see the patient ECG screen

             When I double click on 10 sec Lead "V3"
             Then I should see the Lead "V3" zoom lead window


              And I rotate the device to "landscape"
             Then the device orientation is "landscape"

             When I rotate the device to "portrait"
             Then the device orientation is "portrait"

             When I click the X button on zoom lead window
             Then I should see the patient ECG screen

             When I double click on 10 sec Lead "V4"
             Then I should see the Lead "V4" zoom lead window


              And I rotate the device to "landscape"
             Then the device orientation is "landscape"

             When I rotate the device to "portrait"
             Then the device orientation is "portrait"

             When I click the X button on zoom lead window
             Then I should see the patient ECG screen

             When I double click on 10 sec Lead "V5"
             Then I should see the Lead "V5" zoom lead window


              And I rotate the device to "landscape"
             Then the device orientation is "landscape"

             When I rotate the device to "portrait"
             Then the device orientation is "portrait"

             When I click the X button on zoom lead window
             Then I should see the patient ECG screen

             When I double click on 10 sec Lead "V6"
             Then I should see the Lead "V6" zoom lead window


              And I rotate the device to "landscape"
             Then the device orientation is "landscape"

             When I rotate the device to "portrait"
             Then the device orientation is "portrait"

             When I click the X button on zoom lead window
             Then I should see the patient ECG screen
