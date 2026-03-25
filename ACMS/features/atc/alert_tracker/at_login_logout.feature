@atc @automated @critical @atc_at
@atc_smoke @EPIC:FlightTracker @FEATURE:Login
@TMS:586280
Feature: at_login_logout
  As a Flight Tracker User
  I want to be able to log in to/sign out of the application
  So that I can confirm correct login/logout behavior

  XXXX-1604
  - As a user, when I enter my correct username and password then click on the "Login" button, I shall be redirected to the home page.
  - As a user, if I do not key my username, the "Login" button is disabled.
  - As a user, if I do not key my password, the "Login" button is disabled.
  - As a user, if I key my username and password, the "Login" button is enabled.
  - As a user, if I key the incorrect password and click on the "Login" button, I shall receive and error message 'Login failed.'
  - As a user, when I login, logout, and login again, the no units selected popup message shall display.
  - As a user, when I login, logout, and login again the filters shall reset.
  - As a user, when I login, logout, and login again the details panel shall clear.

  XXXX-1614
  - As a user, when I log into Flight tracker, my username shall be displayed on the User Panel.
  - As a user, when I log out of Flight Tracker, I am redirected to the login page without unauthorized error message.

  Testing Notes: You will need to generate an alert for a scenario in this test. See: https://utang.atlassian.net/wiki/spaces/ACMS/pages/3304816692/Setting+up+a+Flight+Plan+and+Generating+an+Alarm+Manually

  TestRail Id: C586280

  Jira Stories: XXXX-1604, XXXX-1614

  Jira Bugs/Defects:

  Background:

  Scenario: Valid Login - Valid Credentials
    When FT: User opens login page
    Then FT: User should see the login button is disabled
    When FT: User enters "[props.ACMS_USERNAME]" as username
    And FT: User enters "[props.ACMS_PASSWORD]" as password
    And FT: User clicks the login button
    Then FT: User waits for "[props.ACMS_USERNAME]" to be displayed in the top right user panel

  Scenario: Invalid login - Username is Missing
    When FT: User opens login page
    And FT: User enters "[props.ACMS_PASSWORD]" as password
    Then FT: User should see the login button is disabled
    When FT: User enters "[props.ACMS_USERNAME]" as username
    Then FT: User should see the login button is enabled

  Scenario: Invalid login - Password is Missing
    When FT: User opens login page
    And FT: User enters "[props.ACMS_USERNAME]" as username
    Then FT: User should see the login button is disabled
    And FT: User enters "[props.ACMS_PASSWORD]" as password
    Then FT: User should see the login button is enabled

  Scenario: Invalid Login - Logging in with an Invalid Username and Password Shows Error Message
    When FT: User opens login page
    And FT: User enters "[props.ACMS_INVALID_USERNAME]" as username
    And FT: User enters "[props.ACMS_PASSWORD]" as password
    And FT: User clicks the login button
    Then FT: User should see a login error message
    When FT: User enters "[props.ACMS_USERNAME]" as username
    And FT: User enters "[props.ACMS_INVALID_PASSWORD]" as password
    And FT: User clicks the login button
    Then FT: User should see a login error message
    When FT: User enters "[props.ACMS_INVALID_USERNAME]" as username
    And FT: User clicks the login button
    Then FT: User should see a login error message

  Scenario: User Locations are Reset when User Logs In, Out and Back into the Site
    When FT: User is logged in
    And FT: User applies unit filter to "[props.ACMS_UNIT]"
    And FT: User logs out
    And FT: User is logged in
    Then FT: User should not see any active filters

  Scenario: Filters are Reset when User Logs In, Out, and Back into the Site
    When FT: User is logged in with default filter applied
#    And User executes test from "[props.CONFIGS_TC01A_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
#    And Alert "TC01a_Alarm" initiated on PM with 600 seconds timeout
#    And API: Wait until the alert is processed by Flight Manager
#    And FT: User verifies the generated alert is present in alerts table
    And FT: User filters alerts table by Severity value 'Low'
    Then FT: User should see 0 flight entries in the alerts sections
    When FT: User logs out
    And FT: User is logged in with default filter applied
    Then FT: User should not see active column filters for the alerts section

  Scenario: Details Panel is Closed when User Logs In, Out, and Back into the Site
    When FT: User is logged in with default filter applied
    And User executes test from "[props.CONFIGS_TC01A_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    And Alert "TC01a_Alarm" initiated on PM with 600 seconds timeout
    And API: Wait until the alert is processed by Flight Manager
    And FT: User verifies the generated alert is present in alerts table
    And FT: User opens the generated alert details
    And FT: User logs out
    And FT: User is logged in with default filter applied
    Then FT: User should see that the flight details panel is hidden

  Scenario: User is Directed to the Login Screen after logout
    When FT: User is logged in with default filter applied
    Then FT: User waits for "[props.ACMS_USERNAME]" to be displayed in the top right user panel
    When FT: User logs out
    Then FT: User should see the login button is disabled