@pm @regression @automated @TMS:40259
Feature: PM Monitor - View Events from patient list
              As an AS1 user
              I want view a Patient's Monitor
  So that I can make sure I can view the patient's vitals

TestRail Id: C40259

        Background:
            Given I verify the version of the app installed
            Given login to the test site with "[props.U_USERNAME]" and "[props.U_PASSWORD]"
             When I click options button on top left of screen
             Then I should see the ListOfList window
             When I click "CENSUS" in List of List window

             Then I should see the "PM" patient List
             When I enter patient "[props.DP_FULL_NAME]" in the pm patient list search field
             Then I should see patient "[props.DP_FULL_NAME]" in patient search results
             When I click on patient "[props.DP_FULL_NAME]" in the pm patient list
             Then I should see the Live Monitor screen

        Scenario: View Events from Patient List
             When I select the new navigation Events button
             Then I should see the Events screen
