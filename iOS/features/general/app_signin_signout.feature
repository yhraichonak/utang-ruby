@regression @hotfix @automated  @TMS:328785
Feature: App Signin and Signout
  As an AS1 user
  I want to signin and signout of the utang One application

TestRail Id: C328785

Background:
  Given I verify the version of the app installed
@broken @todofix @skip
#  TODO: implement GS switching logic
Scenario: Verify Registration Code
  And I get the current registration code
  And I should terminate and uninstall utang One
  And I should install utang One
  And I should launch utang One
  Then I should see the Welcome screen
  And I should see WELCOME displayed in the screen header
  And I should see the AS1 Logo on the Welcome Screen
  And I should see the "first" disclaimer "utang ONE® is intended for use by physicians and other care providers."
  And I should see the "second" disclaimer "In order to use utang ONE®, the hospital at which you practice must have purchased and installed the utang ONE® system. If your hospital has done this, please tap the "Sign In" button below."
  And I should see the Sign In button
  And I should see the Reset Password button
  When I click the Sign In button
  Then I should see the utang Credentials window prompt
  When I enter "test@test.com" in username field
  And I enter "XXXXX" in password field
  And I click the Sign In cell
#  Then the utang Would Like to Send You Notifications Alert window displays
#  When I click the Alert Allow Notifications button
  Then I should see the Site List screen

  Then I should verify the registration code has not changed
