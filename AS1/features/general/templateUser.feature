@regression @automated @core @general
Feature: Template User

  Description

  Apply template user preferences at run-time to users who do not have PM configuration for a site

  If an Enterprise user is not registered to a given Site, then the Template User Privileges should be
  inherited and the Enterprise user does not have to have a module instance for the given site.
  For example, if the Enterprise user has a module instance for CRMC but not for "CRMC-Snippets"
  then the user should receive the priviledges of the Template user when they log in to "CRMC-Snippets".

  TestRail Id: C329226

  Jira Issues: AS1-2330, AS1-2453
  @critical @TMS:329226
  Scenario: Template User - Navigation
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    Then I should see the patient list screen
    And I should not see Snippet Worklists
    When I click on "Ohm, Georg" in patient list
    Then I should see the patient summary screen
    When I click on the Monitor tile
    Then I should see the Live Monitor screen
    When I click the "Tools" button in sub navigation menu
    Then I should see the Snippet Tool screen
    When I click the Create Snippet button
    Then I should see the Snippet Document Edit View
