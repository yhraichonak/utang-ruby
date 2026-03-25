@cardio @regression @automated @TMS:40225
Feature: ECG Screen - Vector Cardiogram

TestRail Id: C40225

        Background:
            Given I verify the version of the app installed
            Given login to the test site with "[props.U_USERNAME]" and "[props.U_PASSWORD]"

        Scenario: ECG Screen (15 Lead - Vector Cardiogram)
             When I click options button on top left of screen
             Then I should see the ListOfList window

             When I click "CardioSearch" in List of List window
             Then I should see the Cardio Search Screen
             When I enter "[props.CEP_FNAME]" in "First" search field
              And I click the search button
             Then I should see a total of 1 patient(s) in the search results
             When I click on "[props.CEP_FULL_NAME]" in patient list

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
