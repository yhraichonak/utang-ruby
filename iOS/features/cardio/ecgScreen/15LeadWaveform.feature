@cardio @regression @hotfix @automated @TMS:40224
Feature: ECG Screen - (15 Lead - 15 Waveform)

              And I should see the patient ECG displaying: "15 Lead - 15 Waveform"
lead_I, lead_II, lead_III, lead_aVR, lead_aVL, lead_aVF, lead_V1, lead_V2, lead_V3, lead_V4, lead_V5, lead_V6, lead_V3R, lead_V4R, lead_V7

TestRail Id: C40224

        Background:
            Given I verify the version of the app installed
            Given login to the test site with "[props.U_USERNAME]" and "[props.U_PASSWORD]"

        Scenario: ECG Screen (15 Lead - 15 Waveform)
             When I click options button on top left of screen
             Then I should see the ListOfList window

             When I click "SEARCH" in List of List window
             Then I should see the Cardio Search Screen
             When I enter "[props.CP_LNAME]" in "Last" search field
              And I click the search button
             Then I should see a total of 1 patient(s) in the search results
             When I click on "[props.CP_FULL_NAME]" in patient list

             Then I should see the patient ECG screen

             When I click on the patient caret button
             Then I should see detail patient info

              And I click on the patient caret button
              And I should see 10 sec lead "V3R"

              And I should see 10 sec lead "V4R"


              And I should see 10 sec lead "V7"


              And I rotate the device to "landscape"
             Then the device orientation is "landscape"


             When I rotate the device to "portrait"
             Then the device orientation is "portrait"
