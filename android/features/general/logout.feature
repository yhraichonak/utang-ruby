@automated @TMS:158830  @general @regression @bvt
Feature: Logout
  As an AS1 user
  I want to log into the app
  So that I can make sure a user can logout

TestRail Id: C158830

Scenario: Logout
  Given I click the more options button then the About button
  And   I click the OK button on the About window
  And   I click the more options button then the Logout button
  Then  I should see the Site List screen
  When  I click "Automation Site" button on Site List screen
  Then  I should see the Login window
  And   I should see "Automation Site" in the title of the login window
