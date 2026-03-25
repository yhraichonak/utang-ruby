@pm @regression @hotfix @automated @TMS:40253
Feature: PM Monitor - Live
              As an AS1 user
              I want view a Patient's Monitor
  So that I can make sure I can view the patient's vitals

TestRail Id: C40253

        Background:
            Given I verify the version of the app installed
            Given login to the test site with "[props.U_USERNAME]" and "[props.U_PASSWORD]"
             When I click options button on top left of screen
             Then I should see the ListOfList window
             When I click "CENSUS" in List of List window
             Then I should see the "PM" patient List

        Scenario: View Live Monitor
             When I enter patient "[props.DP_FULL_NAME]" in the pm patient list search field
             Then I should see patient "[props.DP_FULL_NAME]" in patient search results
             When I click on patient "[props.DP_FULL_NAME]" in the pm patient list
             Then I should see the Live Monitor screen

             When I click on waveform "[props.COMMON_ECG1]"
             Then I should see the waveform disabled
             When I click on waveform "[props.COMMON_ECG1]"
             Then I should see the waveform enable
             When I swipe "right" on the waveforms
             Then I should see historical data for the waveforms (not Live mode)
             When I click the Live button
             Then I should see the Live Monitor screen
             When I rotate the device to "landscape"

             When I rotate the device to "portrait"
