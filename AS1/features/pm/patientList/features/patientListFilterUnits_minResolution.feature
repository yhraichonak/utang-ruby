@automated @core  @pm @pm-patient_list @pm-patient_list-features
Feature: PM Patient List - Filter Units - scroll window
  Description
  IE11 - Patient List Filter Units when several units appear can't scroll to top of list

  TestRail Id: C581634
  Jira Stories: AS1-3854
@critical @TMS:581634
  Scenario: PM Patient List - Filter Units - ability to scroll filter window
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    Then I should see the patient list screen
    When I click PM main list on the sidebar
    Then I should see the patient list screen

    When I see the browser resolution to "800" width by "600" height
    And I click on Filter Units link
    Then I should see the Filter Units window
    When I click on "{DISCHARGED}" filter unit switch to "disable" button
    And I click Ok button in Filter Units window
    Then I should see the patient list screen
    And I should see a total of 0 patient(s) in the PM search results from "discharged" section
    And I should see the Filter Units link highlighted

    When I click on Filter Units link
    Then I should see the Filter Units window
    When I click on "ICU" filter unit switch to "disable" button
    And I click Ok button in Filter Units window
    Then I should see the patient list screen
    And I should see a total of 0 patient(s) in the PM search results from "icu" section
    And I should see the Filter Units link highlighted

    When I click on Filter Units link
    Then I should see the Filter Units window
    When I click on "ICU" filter unit switch to "enable" button
    And I click Ok button in Filter Units window
    Then I should see the patient list screen
    And I should see a total of 8 patient(s) in the PM search results from "icu" section
    And I should see the Filter Units link highlighted

    When I click on Filter Units link
    Then I should see the Filter Units window
    When I click the Toggle All button on Filter Units window
    And I click Ok button in Filter Units window
    Then I should see the patient list screen
    And I should see the Filter Units link not highlighted

    When I click on Filter Units link
    Then I should see the Filter Units window
    When I click the Toggle All button on Filter Units window
    And I click Ok button in Filter Units window
    Then I should see the patient list screen
    And I should see the Filter Units link highlighted

    When I click on Filter Units link
    Then I should see the Filter Units window
    When I click on "ICU" filter unit switch to "enable" button
    And I click Ok button in Filter Units window
    Then I should see the patient list screen
    And I should see a total of 8 patient(s) in the PM search results from "icu" section
    And I should see the Filter Units link highlighted

    When I click on Filter Units link
    Then I should see the Filter Units window
    When I click the Toggle All button on Filter Units window
    And I click Ok button in Filter Units window
    Then I should see the patient list screen
    And I should see the Filter Units link not highlighted
    