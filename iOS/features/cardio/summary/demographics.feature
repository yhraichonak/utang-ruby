@cardio @regression @automated @TMS:40251
Feature: Summary Screen - Demographics
              As an AS1 user
              I want view a patient's summary screen
  So that I can get an overall summmary of the patient's demographics, ECGs, labs, etc.

TestRail Id: C40251

        Background:
            Given I verify the version of the app installed
            Given login to the test site with "[props.U_USERNAME]" and "[props.U_PASSWORD]"

        Scenario: Demographics and ECG
             When I click options button on top left of screen

             Then I should see the ListOfList window
             When I click "CardioSearch" in List of List window
             Then I should see the Cardio Search Screen
             When I enter "[props.CP_LNAME]" in "Last" search field
              And I click the search button
             Then I should see a total of 1 patient(s) in the search results

             When I click on "[props.CP_FULL_NAME]" in patient list

             Then I should see the patient ECG screen

             When I select the new nav Home button on the patient ecg screen

             Then I should see the patient summary screen
             When I click on the general info tile
             Then I should see the general info window
             When I click on the < button on the general info window
             Then I should see the patient summary screen
             When I click on the ECG tile
             Then I should see the patient ECG screen "Initial ECG Screen - test_data: 500 SPS patient"

