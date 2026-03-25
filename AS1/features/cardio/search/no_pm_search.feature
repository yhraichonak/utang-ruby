@cardio @regression @automated @core @cardio @cardio-search
Feature: Search - Suppressed in List of Lists
  The Web client will put in a check for "PM" based lists, if a "search" menu is included in the
  config from the server, client will suppress it. Until such time as all existing sites have their
  back-end servers updates to remove from the List of Lists... the "search" menu for both PM and OB,
  we'll maintain this forced "deprecation" feature.

  TestRail Id: C328782
  Jira Stories: AS1-1469
  @critical @TMS:328782
  Scenario: Search - Suppressed in List of Lists
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    Then I should see the patient list screen
    And I should see in List of List Patient Monitoring no SEARCH listed