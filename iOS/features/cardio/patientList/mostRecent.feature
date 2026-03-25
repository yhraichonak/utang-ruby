@cardio @regression @automated @TMS:40237
Feature: Patient List - Most Recent

TestRail Id: C40237

        Scenario: Most Recent list
            Given I verify the version of the app installed
            Given login to the test site with "[props.U_USERNAME]" and "[props.U_PASSWORD]"
             When I click options button on top left of screen
              And I click "MOST RECENT" in List of List window
             Then I should see the "MOST RECENT" patient List

             When I rotate the device to "landscape"
             Then the device orientation is "landscape"

             When I rotate the device to "portrait"
             Then the device orientation is "portrait"
