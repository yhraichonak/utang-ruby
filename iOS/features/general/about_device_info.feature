@regression @hotfix @automated @TMS:580680
Feature: About Screen Device Info
              As an AS1 user
              I want to view the About Screen
  So that I can verify the About Information

TestRail Id: C580680

        Background:
            Given I verify the version of the app installed
            Given I should see the test site button on Site List screen

        Scenario: Verify the Device Information
             When I click the gear button on Site List screen
              And I click the About button
             Then I should see the About screen
              And I verify the Device Info on the About screen
