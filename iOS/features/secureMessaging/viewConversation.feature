@regression @automated @TMS:148504
Feature: Secure Messaging
              As an AS1 user
              I want the ability to send secure messages to other utang users in app

TestRail Id: C148504

        Background:
            Given I verify the version of the app installed
            Given login to the test site with "[props.U_USERNAME]" and "[props.U_PASSWORD]"

        Scenario: View Existing Conversation
             When I click options button on top left of screen
             Then I should see the ListOfList window
             When I click "SECURE MESSAGING" in List of List window
             Then I should see the Secure Messaging Conversation Center
             When I click the "[props.SA_FULL_NAME]" conversation
             Then the "[props.SA_FULL_NAME]" conversation screen should display
             Then I delete the iOS automated messages
