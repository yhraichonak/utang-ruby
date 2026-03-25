@cardio @regression @automated @TMS:40235
Feature: Patient List - EMS

TestRail Id: C40235

        Scenario: EMS list
            Given I verify the version of the app installed
            Given login to the test site with "[props.U_USERNAME]" and "[props.U_PASSWORD]"
             When I click options button on top left of screen
             When I click "EMS" in List of List window
             Then I should see the "EMS" patient List

             When I rotate the device to "landscape"
             Then the device orientation is "landscape"

             When I rotate the device to "portrait"
             Then the device orientation is "portrait"
