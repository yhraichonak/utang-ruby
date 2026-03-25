@cardio @regression @automated @TMS:40242
Feature: Search - Combo
              As an AS1 user
              I want to search for patients using the search form
  So I can find patients by First Name, Last Name, Age, DOB, and by MRN.

TestRail Id: C40242

        Background:
            Given I verify the version of the app installed
            Given login to the test site with "[props.SU_USERNAME]" and "[props.SU_PASSWORD]"
             When I click options button on top left of screen
             Then I should see the ListOfList window
             When I click "CardioSearch" in List of List window
             Then I should see the Cardio Search Screen

        Scenario: Combo Search by First, Last, Age
             When I enter "[props.CP_FNAME]" in "First" search field
              And I enter "[props.CP_LNAME]" in "Last" search field
              And I enter "[props.CP_CARDIO_AGE]" in "Age" search field
              And I click the search button
             Then I should see the following patient in patient list
                  | patientName          | gender         | age            |
                  | [props.CP_FULL_NAME] | [props.CP_SEX] | [props.CP_CARDIO_AGE] |

              And I should see a total of 1 patient(s) in the search results
             When I rotate the device to "landscape"
             Then the device orientation is "landscape"

             When I rotate the device to "portrait"
             Then the device orientation is "portrait"
