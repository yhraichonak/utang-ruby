@cardio @regression @automated @TMS:40243
Feature: Search - DOB
              As an AS1 user
              I want to search for patients using the search form
  So I can find patients by First Name, Last Name, Age, DOB, and by MRN.

TestRail Id: C40243

        Background:
            Given I verify the version of the app installed
            Given login to the test site with "[props.SU_USERNAME]" and "[props.SU_PASSWORD]"
             When I click options button on top left of screen
             Then I should see the ListOfList window
             When I click "CardioSearch" in List of List window
             Then I should see the Cardio Search Screen

        Scenario: Search by DOB
             When I enter "[props.CP_DOB]" in "DOB" search field
              And I click the search button
             Then I should see the following patient in patient list
                  | patientName          | gender         | age            |
                  | [props.CP_FULL_NAME] | [props.CP_SEX] | [props.CP_CARDIO_AGE] |

              And I should see a total of 1 patient(s) in the search results
             When I rotate the device to "landscape"
             Then the device orientation is "landscape"

             When I rotate the device to "portrait"
             Then the device orientation is "portrait"
