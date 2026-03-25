@regression @automated @TMS:148503
Feature: Secure Messaging
              As an AS1 user
              I want the ability to send secure messages to other utang users in app

TestRail Id: C148503

        Background:
            Given I verify the version of the app installed
            Given login to the test site with "[props.U_USERNAME]" and "[props.U_PASSWORD]"

        Scenario: Create a Message
             When I click options button on top left of screen
             Then I should see the ListOfList window
             When I click "SECURE MESSAGING" in List of List window
             Then I should see the Secure Messaging Conversation Center

             When I click the New button
             Then I should see the Contact List for all privileged utang users
             When I select "[props.SA_FULL_NAME]" from the user list
             Then the "[props.SA_FULL_NAME]" conversation screen should display
             When I type the message "iOS test"
              And click the Send button
             Then the message "iOS test" displays on the screen
