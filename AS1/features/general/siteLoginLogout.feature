@regression @automated @core @general @TMS:264414
Feature: Site Login/Logout

  TestRail Id: C264414
  Jira Stories: AS1-974
  Jira Bugs/Defects: AS1-1035, AS1-1879, AS1-2570, AS1-2575, AS1-4075, AS1-4532, AS1-4518, AS1-7727

  @critical
  Scenario: Site Login/Logout
    When invalid login to testSite with "username" and "Pass"
    Then I should see the error alert window
    And I should see the "Login Failed." message on the error alert window
    When I click the ok button in error alert window
    Then I should see the login screen

    When invalid login to testSite with "username" and "#&*^&#^%"
    Then I should see the error alert window
    When I click the ok button in error alert window
    Then I should see the login screen

    When invalid login to testSite with "user" and "XXXXX"
    Then I should see the error alert window
    When I click the ok button in error alert window
    Then I should see the login screen

    When I login to a testSite with "utang" and "XXXXX"
    Then I should see the patient list screen
    When I click the username dropdown indicator
    Then I should see About and Logout links
    When I click on Logout link
    Then I should see the login screen

  Scenario: Logout of MPV Returns To Login Screen
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    Then I should see the patient list screen
    When I click the Multi-Patient View button in header
    And I click the username dropdown indicator
    Then I should see About and Logout links
    When I click on Logout link
    Then I should see the login screen
