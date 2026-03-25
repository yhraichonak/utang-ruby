@automated @TMS:158829  @general @regression @bvt
Feature: Login Valid
  As an AS1 user
  I want to log into the app
  So that I can make sure valid credentials do work

TestRail Id: C158829

Scenario: Login with valid credentials
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  When I click the AS1 button
  When I click "PM Census" on the List
  Then I should see the patient List
  And I click the more options button then the Logout button
