@cardio @regression @automated @TMS:40245
Feature: Search - FirstName Multiple
              As an AS1 user
              I want to search for patients using the search form
  So I can find patients by First Name, Last Name, Age, DOB, and by MRN.

TestRail Id: C40245

        Background:
            Given I verify the version of the app installed
            Given login to the test site with "[props.SU_USERNAME]" and "[props.SU_PASSWORD]"
             When I click options button on top left of screen
             Then I should see the ListOfList window
             When I click "CardioSearch" in List of List window
             Then I should see the Cardio Search Screen

        Scenario: Search by First (name) with multiple search results
             When I enter "Jo" in "First" search field
              And I click the search button
             Then I should see a total of 7 patient(s) in the search results
             When I rotate the device to "landscape"
             Then the device orientation is "landscape"

             When I rotate the device to "portrait"
             Then the device orientation is "portrait"
