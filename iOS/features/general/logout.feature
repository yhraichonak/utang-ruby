@regression @hotfix @automated @TMS:147168
Feature: Logout
              As an AS1 user
              I want to log into (and out) the app
  So that I can make sure valid credentials are used

TestRail Id: C147168

        Background:
            Given login to the test site with "[props.U_USERNAME]" and "[props.U_PASSWORD]"

        Scenario: Logout of application from Patient List
             When I click options button on top left of screen
             Then I should see the ListOfList window
             When I click the gear button on list of list window
             Then I should see the About and Logoff buttons
             When I click the Logoff button
             #Confirmation prompt doesn't appear on 6.10.6
#             Then I should see site logout prompt
#             When I click OK button in alert prompt
             Then I should see the Site List screen

              And I click the test site button on Site List screen
             Then I should see the Site Login screen
             Then I should see the test site name in navigation bar login window
              And I should see "username" in the username field as last logged in user
              And I should see the password field empty
