@atc @automated @critical @atc_ad
@atc_smoke @EPIC:AirCommand @FEATURE:Login
@TMS:586334 @clear_atc_flights
Feature: ad_login_logout
  As an Air Command User
  I want to be able to log into/ out of of the application
  So that I can confirm correct login/log out behavior

  XXXX-1561
  - As a user, when I enter my correct username and password then click on the login button, I shall be redirected to the home page.
  - As a user, if I do not key my username, the login button is disabled.
  - As a user, if I do not key my password, the login button is disabled.
  - As a user, if I key my username and password, the login button is enabled.
  - As a user, if I key the incorrect password and click on the login button, I shall receive and error message 'Login failed.'
  - As a user, when I login, logout, and login again, the no units selected popup message shall display.
  - As a user, when I login, logout, and login again the filters shall reset.
  - As a user, when I login, logout, and login again the details panel shall clear.

  XXXX-1569
  - As a User, when I log into Air Command, my username shall display on the User Panel.
  - As a user, when I log out of Air Command, I should be directed to the login page.

  TestRail Id: C586334

  Jira Stories: XXXX-1561, XXXX-1569

  Jira Bugs/Defects:

  Background:

  Scenario: Valid Login - Valid Credentials
    When AC: User opens login page
    Then AC: User should see the login button is disabled
    When AC: User enters "[props.ACMS_USERNAME]" as username
    And AC: User enters "[props.ACMS_PASSWORD]" as password
    And AC: User clicks the login button
    Then AC: User waits for "[props.ACMS_USERNAME]" to be displayed in the top right user panel

  Scenario: Invalid login - Username is Missing
    When AC: User opens login page
    And AC: User enters "[props.ACMS_PASSWORD]" as password
    Then AC: User should see the login button is disabled
    When AC: User enters "props.ACMS_USERNAME]" as username
    Then AC: User should see the login button is enabled

  Scenario: Invalid login - Password is Missing
    When AC: User opens login page
    And AC: User enters "[props.ACMS_USERNAME]" as username
    Then AC: User should see the login button is disabled
    And AC: User enters "[props.ACMS_PASSWORD]" as password
    Then AC: User should see the login button is enabled

  Scenario: Invalid Login - Logging in with an Invalid Username and Password Shows Error Message
    When AC: User opens login page
    And AC: User enters "[props.ACMS_INVALID_USERNAME]" as username
    And AC: User enters "[props.ACMS_PASSWORD]" as password
    And AC: User clicks the login button
    Then AC: User should see a login error message
    When AC: User enters "[props.ACMS_USERNAME]" as username
    And AC: User enters "[props.ACMS_INVALID_PASSWORD]" as password
    And AC: User clicks the login button
    Then AC: User should see a login error message
    When AC: User enters "[props.ACMS_INVALID_USERNAME]" as username
    And AC: User clicks the login button
    Then AC: User should see a login error message

  Scenario: User Locations are Reset when User Logs In, Out and Back into the Site
    When AC: User is logged in
    And AC: User applies unit filter to "[props.ACMS_UNIT]"
    And AC: User logs out
    And AC: User is logged in
    Then AC: User should not see any active filters
@flaky
  Scenario: Prioritize by Severity checkboxes are Reset when User Logs In, Out, and Back into the Site
    When AC: User is logged in with default filter applied
    Then AC: User should see the Alarm Queue section 'Prioritize by Severity' checkbox be checked
    And AC: User should see the Alerts section 'Prioritize by Severity' checkbox be checked
    When AC: User toggles the Alarm Queue section "Prioritize by Severity" checkbox
    And AC: User toggles the Alerts section "Prioritize by Severity" checkbox
    And AC: User logs out
    And AC: User is logged in with default filter applied
    Then AC: User should see the Alarm Queue section 'Prioritize by Severity' checkbox be checked
    And AC: User should see the Alerts section 'Prioritize by Severity' checkbox be checked

  Scenario: Details Panel is Closed when User Logs In, Out, and Back into the Site
    When AC: User is logged in with default filter applied
    And User executes test from "[props.CONFIGS_TC01A_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    And Alert "TC01a_Alarm" initiated on PM with 600 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    And AC: User verifies the generated alert is present in Alerts panel
    And AC: User opens the generated alert details in Alerts panel
    And AC: User logs out
    And AC: User is logged in with default filter applied
    Then AC: User should see that the flight details panel is hidden

  Scenario: User is Directed to the Login Screen after logout
    When AC: User is logged in with default filter applied
    Then AC: User waits for "[props.ACMS_USERNAME]" to be displayed in the top right user panel
    When AC: User logs out
    Then AC: User should see the login button is disabled
