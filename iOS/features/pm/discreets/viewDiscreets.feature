@pm @regression @automated @TMS:40261
Feature: PM Monitor - View Discreets
              As an AS1 user
              I want view a Patient's Monitor
  So that I can make sure I can view the patient's vitals

TestRail Id: C40261

        Background:
            Given I verify the version of the app installed
            Given login to the test site with "[props.U_USERNAME]" and "[props.U_PASSWORD]"
             When I click options button on top left of screen
             Then I should see the ListOfList window
             When I click "CENSUS" in List of List window
             Then I should see the "PM" patient List

        Scenario: Discretes
             When I enter patient "[props.DP_FULL_NAME]" in the pm patient list search field
             Then I should see patient "[props.DP_FULL_NAME]" in patient search results
             When I click on patient "[props.DP_FULL_NAME]" in the pm patient list
             Then I should see the Live Monitor screen

             When I select the new navigation Home button
             Then I should see the patient summary screen

             When I click on the Monitor tile
             Then I should see the Events screen
             When I select the new nav monitor button on the events screen

             Then I should see the Live Monitor screen
             When I click on discrete value "HR bpm"
             Then I should see the trended value screen

             When I click done on the trended value screen
             Then I should see the Live Monitor screen
             When I click on discrete value "RR"
  #When I click on discrete value "NBP mm[Hg]"
             Then I should see the trended value screen
             When I click done on the trended value screen
             Then I should see the Live Monitor screen
             When I click on discrete value "PVC Bpm"
  #When I click on discrete value "PulseRate {beat}/min"
             Then I should see the trended value screen

             When I click done on the trended value screen
             Then I should see the Live Monitor screen
