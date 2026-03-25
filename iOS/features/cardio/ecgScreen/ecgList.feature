@cardio @regression @automated @TMS:40222
Feature: ECG Screen - ECG List

TestRail Id: C40222

        Background:
            Given I verify the version of the app installed
            Given login to the test site with "[props.U_USERNAME]" and "[props.U_PASSWORD]"

        Scenario: ECG List
             When I click options button on top left of screen
             Then I should see the ListOfList window

             When I click "SEARCH" in List of List window
             Then I should see the Cardio Search Screen

             When I enter "[props.CP_LNAME]" in "Last" search field
              And I click the search button

             Then I should see a total of 1 patient(s) in the search results

             When I click on "[props.CP_FULL_NAME]" in patient list
             Then I should see the patient ECG screen

             When I click the ECG button
             Then I should see the ECG List window

             When I click on another ECG on row 2
             Then I should see the patient ECG screen "ECG Screen - Lead 2"

             When I click the ECG button
             Then I should see the ECG List window

             When I click on another ECG on row 2
             Then I should see the patient ECG screen "ECG Screen - Lead 2"
