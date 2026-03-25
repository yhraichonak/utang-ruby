@cardio @regression @automated @TMS:40247
Feature: Search - No Results returned
              As an AS1 user
              I want to search for patients using the search form
  So I can find patients by First Name, Last Name, Age, DOB, and by MRN.

TestRail Id: C40247

        Background:
            Given I verify the version of the app installed
            Given login to the test site with "[props.SU_USERNAME]" and "[props.SU_PASSWORD]"
             When I click options button on top left of screen
             Then I should see the ListOfList window
             When I click "CardioSearch" in List of List window
             Then I should see the Cardio Search Screen

        Scenario: No Search Results returned
             When I enter "13131313" in "MRN/PID" search field
              And I click the search button
              And I should no patient matches found in patient list

             When I rotate the device to "landscape"
             Then the device orientation is "landscape"

             When I rotate the device to "portrait"
             Then the device orientation is "portrait"
