@cardio @regression @automated @TMS:40238
Feature: Patient List - List of List Navigation with EC turned off

TestRail Id: C40238

        Scenario: List of List Navigation (with E/C turned off)
            Given I verify the version of the app installed
            Given login to the test site with "[props.U_USERNAME]" and "[props.U_PASSWORD]"
             When I click options button on top left of screen
             Then I should see my ListOfList window with no inboxes displaying for test site
