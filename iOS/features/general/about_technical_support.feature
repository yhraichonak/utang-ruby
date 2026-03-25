@regression @hotfix @automated @TMS:580677
Feature: About Screen Technical Support Info
              As an AS1 user
              I want to view the About Screen
  So that I can verify the About Information

TestRail Id: C580677

        Background:
            Given I verify the version of the app installed
            Given I should see the test site button on Site List screen

        Scenario: Verify the Technical Support Information
             When I click the gear button on Site List screen
    # Then I should see the menu display
              And I click the About button
             Then I should see the About screen
              And I verify the Technical Support Info on the About screen
