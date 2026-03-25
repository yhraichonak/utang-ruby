@regression @hotfix @automated @TMS:147167
Feature: Login valid
              As an AS1 user
              I want to log into (and out) the app
  So that I can make sure valid credentials are used

TestRail Id: C147167

        Background:
            Given I verify the version of the app installed
              And logout of all sites
             When I click the test site button on Site List screen
             Then I should see navigation bar login window

        Scenario: Login with valid credentials
             When I enter username "[props.DU_USERNAME]"
              And I enter password "[props.DU_PASSWORD]"
              And click Login button
             Then I am logged into the site
