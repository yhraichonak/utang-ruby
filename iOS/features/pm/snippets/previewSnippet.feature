@pm @regression @automated @TMS:554787
Feature: Preview Snippet
              As an AS1 user
              I want view a Patient's Monitor and create a snippet for preview


TestRail Id: C554787

        Background:
            Given I verify the version of the app installed
            Given login to the test site with "[props.U_USERNAME]" and "[props.U_PASSWORD]"
             When I click options button on top left of screen
             Then I should see the ListOfList window
             When I click "CENSUS" in List of List window

             Then I should see the "PM" patient List

        Scenario: Preview Snippet
             When I enter patient "[props.DP_FULL_NAME]" in the pm patient list search field
             Then I should see patient "[props.DP_FULL_NAME]" in patient search results
             When I click on patient "[props.DP_FULL_NAME]" in the pm patient list
             Then I should see the Live Monitor screen

             When I select the new navigation Tool button
             Then I should see the Monitor Tool Screen
             When I click the Measure button on the Monitor Tool Screen
             Then I should see the P QR S and T target objects
             When I click the Create Snippet button on the Monitor Tool Screen
             Then I should see the Snippet Document Edit Screen
              And I select the done button on the Snippet Document Edit Screen
             When I click the preview button on the Snippet Document Edit Screen
             Then I should see the Snippet Document Preview Screen
             When I click the back button on the Snippet Document Preview Screen
             Then I should see the Snippet Document Edit Screen from Snippet Document Preview Screen
             When I click the preview button on the Snippet Document Edit Screen
             Then I should see the Snippet Document Preview Screen
             When I click the save button on the Snippet Document Preview Screen
             Then I should see the Live Monitor screen
