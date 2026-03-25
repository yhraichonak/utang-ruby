@regression @hotfix @automated @TMS:147166
Feature: Login invalid special characters
              As an AS1 user
              I want to log into (and out) the app
  So that I can make sure valid credentials are used

TestRail Id: C147166

        Background:
            Given I verify the version of the app installed
              And logout of all sites
             When I click the test site button on Site List screen
             Then I should see navigation bar login window

        Scenario: Login with invalid credentials (special characters)
             When I enter username "username"
              And I enter password "!@#$%^&*()"
              And click Login button
             Then I should see an invalid login prompt
             When I click OK button in alert prompt
              And I click Cancel button
             Then I should see the Site List screen
