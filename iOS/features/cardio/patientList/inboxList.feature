@cardio @regression @automated @TMS:40236
Feature: Patient List - Inbox List
              As an AS1 user
              I want view a Patient List with Most Recent, EMS, My Inbox, and  lists
  So that I can make sure I can view my patient's in a site

TestRail Id: C40236

        Scenario: My Inbox list
            Given I verify the version of the app installed
            Given login to the test site with "[props.SU_USERNAME]" and "[props.SU_PASSWORD]"
             When I click options button on top left of screen
             Then I should see the ListOfList window
             When I click "ALL PRIVILEGES" in List of List window
             Then I should see the "ALL PRIVILEGES" patient List

             When I rotate the device to "landscape"
             Then the device orientation is "landscape"

             When I rotate the device to "portrait"
             Then the device orientation is "portrait"
