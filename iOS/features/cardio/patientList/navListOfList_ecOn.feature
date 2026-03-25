@cardio @regression @automated @TMS:40239
Feature: Patient List - List of List Navigation (with E/C turned on)

TestRail Id: C40239

        Scenario: List of List Navigation (with E/C turned on)
            Given I verify the version of the app installed
            Given login to the test site with "[props.SU_USERNAME]" and "[props.SU_PASSWORD]"
             When I click options button on top left of screen
              And I click "ALL PRIVILEGES" in List of List window
             Then I should see the "ALL PRIVILEGES" patient List
