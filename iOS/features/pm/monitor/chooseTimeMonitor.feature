@pm @regression @automated @TMS:40256
Feature: PM Monitor - Choose Time from Monitor screen
              As an AS1 user
              I want view a Patient's Monitor
  So that I can make sure I can view the patient's vitals

TestRail Id: C40256

        Background:
            Given I verify the version of the app installed
            Given login to the test site with "[props.U_USERNAME]" and "[props.U_PASSWORD]"
             When I click options button on top left of screen
             Then I should see the ListOfList window
             When I click "CENSUS" in List of List window
             Then I should see the "PM" patient List

        Scenario: Choose Time for Monitor Screen
             When I enter patient "[props.DP_FULL_NAME]" in the pm patient list search field
             Then I should see patient "[props.DP_FULL_NAME]" in patient search results
             When I click on patient "[props.DP_FULL_NAME]" in the pm patient list
             Then I should see the Live Monitor screen
             When I click the Choose Time button on Monitor screen
             Then I should see the Choose Time screen
             When I select a time of 1 hours and 35 minutes
              And I click the Choose Time button on the Choose Time Screen
             Then I should see the Monitor screen for Event
