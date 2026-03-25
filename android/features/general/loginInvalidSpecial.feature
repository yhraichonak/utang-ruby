@automated @TMS:158828  @general @regression @bvt
Feature: Login Invalid With Special Characters
  As an AS1 user
  I want to log into the app
  So that I can make sure invalid credentials using special characters do not work

TestRail Id: C158828

Scenario: Login with invalid credentials (special characters)
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  When I click the AS1 button
  When I click "PM Census" on the List
  Then I should see the patient List
  And I click the more options button then the Logout button
  Then I should see the Site List screen
  When I click "Automation Site" button on Site List screen
  Then I should see the Login window
  And I should see "Automation Site" in the title of the login window
  When I enter username "[props.DU_USERNAME]"
  And I enter password "[props.DU_INVAL-PASS-SPEC]"
  And click Login button
  Then I should see the Login Failed window
  When I click hardware back button on the Site List Screen
  Then I should see the Site List screen
