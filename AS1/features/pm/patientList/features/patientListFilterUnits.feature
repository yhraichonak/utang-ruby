@automated @core @pm @pm-patient_list @pm-patient_list-features  @TMS:264314
Feature: PM Patient List - Filter Units
When the patient list has been filtered (either by a search control, grouped/sorted control, and or filtered control)
an indicator(s) should display to alert the User they are viewing a limited patient list and which control(s) has been evoked.

For example if the User is on the PM patient list and has invoked the filter control to filter out out 2 of the 5 units
available and invoked the group/sort control by grouping those three units by Physicians then sorting by patient last
name then sorting by dilatation status, the "grouped/sorted" control and the "filter" control have been invoked.
An indicator needs to displays alerting the user to which controls have been invoked so they are aware they are
viewing a limited patient list.

note iOS handles this by utilizing the sorting/filtering icons as a uncolored (no filter) vs colored (filter) state

TestRail Id: C264314

Jira Stories: AS1-121, AS1-572, AS1-2314, AS1-2840, AS1-3307

Jira Bugs/Defects: AS1-672, MIG-340, AS1-4633, AS1-5269, AS1-6053, AS1-6175
@critical
Scenario: PM Patient List - Filter Units
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  Then I should see the patient list screen
  When I click "Census" on the List
  Then I should see the patient list screen
  When I click on Filter Units link
  Then I should see the Filter Units window
  When I click on "[props.FU_UNIT4]" filter unit switch to "disable" button
  And I click Ok button in Filter Units window
  Then I should see the patient list screen
  And I should see a total of 0 patient(s) in the PM search results from "discharged" section
  And I should see the Filter Units link highlighted

  When I click on Filter Units link
  Then I should see the Filter Units window
  When I click on "[props.FU_UNIT2]" filter unit switch to "disable" button
  And I click Ok button in Filter Units window
  Then I should see the patient list screen
  And I should see a total of 0 patient(s) in the PM search results from "icu" section
  And I should see the Filter Units link highlighted

  When I click on Filter Units link
  Then I should see the Filter Units window
  When I click on "[props.FU_UNIT2]" filter unit switch to "enable" button
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
  And I should see "0" patients active on the patient list screen
  And I should see the Filter Units link highlighted

  When I click the username dropdown indicator
  Then I should see About and Logout links
  When I click on Logout link
  Then I should see the login screen

  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  Then I should see the patient list screen
  When I click "Census" on the List
  Then I should see the patient list screen
  And I should see "0" patients active on the patient list screen
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
  When I click on "[props.FU_UNIT2]" filter unit switch to "enable" button
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

  Scenario: PM Patient List - Unit Header Gaps
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    Then I should see the patient list screen
    And I reset grouping and sorting on patients list
    And reset unit filtering
    And I should see the patient list screen
    When I click on Filter Units link
    Then I should see the Filter Units window
    When I click on "[props.FU_UNIT3]" filter unit switch to "disable" button
    And I click Ok button in Filter Units window
    Then I should see the PM patient list filtered by all units except "[props.FU_UNIT3]"

    When I click on Filter Units link
    And I click the Toggle All button on Filter Units window
    And I click the Toggle All button on Filter Units window
    Then I should see all units toggle "OFF"
    And I click on "[props.FU_UNIT1]" filter unit switch to "enable" button
    And I click on "[props.FU_UNIT2]" filter unit switch to "enable" button
    And I click Ok button in Filter Units window
    And I should see the PM patient list filtered by "[props.FU_UNIT1]"
    And I should see the PM patient list filtered by "[props.FU_UNIT2]"

    When I click on Group/Sort link
    Then I should see the Group/Sort window
    When I click on Group By dropdown and select "Last Name"
    And I click on first Sort By dropdown and select "Unit"
    And I click the ok button on Group / Sort window
    Then I should see the patient list screen
