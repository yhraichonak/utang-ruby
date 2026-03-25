@pm @regression @automated @TMS:40257
Feature: Events - View Alarm
              As an AS1 user
              I want view a Patient's Monitor
  So that I can make sure I can view the patient's vitals

TestRail Id: C40257

        Background:
            Given login to the test site with "[props.U_USERNAME]" and "[props.U_PASSWORD]"
             When I click options button on top left of screen
             Then I should see the ListOfList window
             When I click "CENSUS" in List of List window
             Then I should see the "PM" patient List

        Scenario: Alarm Events
             When I enter patient "[props.DP_FULL_NAME]" in the pm patient list search field
             Then I should see patient "[props.DP_FULL_NAME]" in patient search results
             When I click on patient "[props.DP_FULL_NAME]" in the pm patient list
             Then I should see the Live Monitor screen
             When I select the new navigation Home button
             Then I should see the patient summary screen

             When I click on the Monitor tile
             Then I should see the Events screen
             When I click on Event on row 1
             Then I should see the Monitor screen for Event
             When I swipe "right" on the waveforms
             Then I should see historical data for the waveforms (not Live mode)
             When I click the back button on Monitor screen
             Then I should see the "PM" patient List
