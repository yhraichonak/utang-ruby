@atc @automated @critical @atc_ad
@atc_smoke @EPIC:AirCommand @FEATURE:Refresh
@TMS:586336 @clear_atc_flights
Feature: ad_home_refresh
  As an Alert Dispatch User
  I want to reload the browser of the Alert Dispatch page
  So that I can verify I am not loggged out of the site

  XXXX-1559
  - As a user, when I refresh the homepage, I shall not be logged out.

  TestRail Id: C586336

  Jira Stories: XXXX-1559

  Jira Bugs/Defects:

  Scenario: Refreshing the page will not log user out of the site
    Given User executes test from "[props.CONFIGS_TC01A_CONFIG]" file in ATC Integration Test Console if aggregated FP is not present
    When Alert "TC01a_Alarm" initiated on PM with 100 seconds timeout
    Given AC: User is logged in
    And AC: Refresh the page only
    And AC: User waits for "[props.ACMS_USERNAME]" to be displayed in the top right user panel
    And AC: User applies unit filter to "[props.ACMS_FILTER]"
    And AC: Refresh the page only
    And AC: User waits for "[props.ACMS_USERNAME]" to be displayed in the top right user panel
    And AC: User applies unit filter to "[props.ACMS_FILTER]"
    And API: Wait until the alert is processed by Flight Manager
    And AC: User clicks the "TC01a_Alarm" alert details in Alerts panel
    Then AC: User verifies that the alert details panel is opened
    And AC: Refresh the page only
    And AC: User waits for "[props.ACMS_USERNAME]" to be displayed in the top right user panel