@cardio @regression @automated @TMS:40223
Feature: ECG Screen - 500 SPS
              As an AS1 user
              I want view a 12 Lead Screen
  So that I can make sure a patient's ECG displays with diagnostic statements

TestRail Id: C40223

        Background:
            Given I verify the version of the app installed
            Given login to the test site with "[props.U_USERNAME]" and "[props.U_PASSWORD]"

        Scenario: ECG Screen (500 SPS)
             When I click options button on top left of screen
             Then I should see the ListOfList window
             When I click "CardioSearch" in List of List window
             Then I should see the Cardio Search Screen

             When I enter "[props.CEP_FNAME]" in "First" search field
              And I click the search button

             Then I should see a total of 1 patient(s) in the search results
             When I click on "[props.CEP_FULL_NAME]" in patient list

             Then I should see the patient ECG screen "ECG Screen - test_data: 500 SPS patient"

             When I click on the patient caret button
             Then I should see detail patient info

              And I click on the patient caret button
              And I rotate the device to "landscape"
             Then the device orientation is "landscape"

             When I rotate the device to "portrait"
             Then the device orientation is "portrait"
