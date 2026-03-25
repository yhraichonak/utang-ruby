@cardio @regression  @pending @automated @TMS:40240
Feature: Patient List - Notification List
              As an AS1 user
              I want view a Patient List with Most Recent, EMS, My Inbox, and Notifications lists
  So that I can make sure I can view my patient's in a site

TestRail Id: C40240

        Scenario: My Notification list
            Given I verify the version of the app installed
            Given login to the test site with "[props.U_USERNAME]" and "[props.U_PASSWORD]"
             When I click options button on top left of screen
              And I click "NOTIFICATIONS" in List of List window
             Then I should see the "All > NOTIFICATIONS" patient List

             When I rotate the device to "landscape"
             Then the device orientation is "landscape"

             When I rotate the device to "portrait"
             Then the device orientation is "portrait"
             When I turn the On Call button "on"
             Then I should see the On Call button "on"

             When I click options button on top left of screen
             Then I should see ON CALL displayed in List of List window
              And I click "NOTIFICATIONS" in List of List window
             Then I should see the "All > NOTIFICATIONS" patient List
              And I should see the On Call button "enabled"
             When I turn the On Call button "off"
             Then I should see the On Call button "disabled"
             When I click options button on top left of screen
             Then I should not see ON CALL displayed in List of List window
