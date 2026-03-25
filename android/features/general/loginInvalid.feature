@automated @TMS:158827  @general @regression @bvt
Feature: Login Invalid
  As an AS1 user
  I want to log into the app
  So that I can make sure invalid credentials do not work

  TestRail Id: C158827

  Scenario: Login with invalid credentials
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    And I click the more options button then the Logout button
    Then I should see the Site List screen
    When I click "Automation Site" button on Site List screen
    Then I should see the Login window
    And I should see "Automation Site" in the title of the login window
    When I enter username "[props.DU_USERNAME]"
    And I enter password "[props.DU_INVAL-PASS]"
    And click Login button
    Then I should see the Login Failed window
