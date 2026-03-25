@regression @hotfix @automated @TMS:580678
Feature: About Screen Manufactured By
              As an AS1 user
              I want to view the About Screen
  So that I can verify the About Information

TestRail Id: C580678

        Background:
            Given I verify the version of the app installed
            Given I should see the test site button on Site List screen

        Scenario: Verify the Manufactured By Information
             When I click the gear button on Site List screen
              And I click the About button
             Then I should see the About screen
              And I verify the Manufactured By Info on the About screen
