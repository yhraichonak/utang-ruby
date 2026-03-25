@regression @automated @core @pm @pm-supervisor_report @redesign_at_sorting
Feature: Supervisor Report - sorting

TestRail Id: C329205
Jira Bugs/Defects: AS1-2484, AS1-2528, AS1-2810, AS1-6264, AS1-6786, AS1-7419
Jira Stories: AS1-2142, AS1-2446, AS1-2416, AS1-2586, AS1-2429
  @TMS:329205
  Scenario: Supervisor Report - sorting
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    Then I should see the patient list screen
    When I click "Snippets Report" on the List
    And Search across "[props.FU_REPORTS_UNITS]" units at Supervisor Snippet Report screen
    Then I should see the Supervisor Snippet Report screen
    And if no columns sorted report is sorted LIFO
    When I sort the "Status" column "ascending" on Supervisor Snippet Report screen
    Then I should see the "Status" column data sorted "ascending"
    When I sort the "Status" column "descending" on Supervisor Snippet Report screen
    Then I should see the "Status" column data sorted "descending"

    When I sort the "Patient Name" column "ascending" on Supervisor Snippet Report screen
    Then I should see the "Patient Name" column data sorted "ascending"
    And I should see the "Status" column data displayed as secondary sort "descending"
    When I sort the "Patient Name" column "descending" on Supervisor Snippet Report screen
    Then I should see the "Patient Name" column data sorted "descending"
    And I should see the "Status" column data displayed as secondary sort "descending"

    When I sort the "MRN" column "ascending" on Supervisor Snippet Report screen
    Then I should see the "MRN" column data sorted "ascending"
    And I should see the "Patient Name" column data displayed as secondary sort "descending"
    When I sort the "MRN" column "descending" on Supervisor Snippet Report screen
    Then I should see the "MRN" column data sorted "descending"
    And I should see the "Patient Name" column data displayed as secondary sort "descending"

    When I sort the "Unit" column "ascending" on Supervisor Snippet Report screen
    Then I should see the "Unit" column data sorted "ascending"
    And I should see the "MRN" column data displayed as secondary sort "descending"
    When I sort the "Unit" column "descending" on Supervisor Snippet Report screen
    Then I should see the "Unit" column data sorted "descending"
    And I should see the "MRN" column data displayed as secondary sort "descending"

    When I sort the "Bed" column "ascending" on Supervisor Snippet Report screen
    Then I should see the "Bed" column data sorted "ascending"
    And I should see the "Unit" column data displayed as secondary sort "descending"
    When I sort the "Bed" column "descending" on Supervisor Snippet Report screen
    Then I should see the "Bed" column data sorted "descending"
    And I should see the "Unit" column data displayed as secondary sort "descending"

    When I sort the "Event Description" column "ascending" on Supervisor Snippet Report screen
    Then I should see the "Event Description" column data sorted "ascending"
    And I should see the "Bed" column data displayed as secondary sort "descending"
    When I sort the "Event Description" column "descending" on Supervisor Snippet Report screen
    Then I should see the "Event Description" column data sorted "descending"
    And I should see the "Bed" column data displayed as secondary sort "descending"

    When I sort the "Captured By" column "ascending" on Supervisor Snippet Report screen
    Then I should see the "Captured By" column data sorted "ascending"
    And I should see the "Event Description" column data displayed as secondary sort "descending"
    When I sort the "Captured By" column "descending" on Supervisor Snippet Report screen
    Then I should see the "Captured By" column data sorted "descending"
    And I should see the "Event Description" column data displayed as secondary sort "descending"

    When I sort the "Snippet Type" column "ascending" on Supervisor Snippet Report screen
    Then I should see the "Snippet Type" column data sorted "ascending"
    And I should see the "Captured By" column data displayed as secondary sort "descending"
    When I sort the "Snippet Type" column "descending" on Supervisor Snippet Report screen
    Then I should see the "Snippet Type" column data sorted "descending"
    And I should see the "Captured By" column data displayed as secondary sort "descending"

    When I sort the "Patient Name" column "descending" on Supervisor Snippet Report screen
    Then I should see the "Patient Name" column data sorted "descending"
    And I should see the "Snippet Type" column data displayed as secondary sort "descending"

    When I click the username dropdown indicator
    Then I should see About and Logout links
    When I click on Logout link
    Then I should see the login screen

    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    Then I should see the patient list screen
    When I click "Snippets Report" on the List
    Then I should see the Supervisor Snippet Report screen
    And if no columns sorted report is sorted LIFO
    When I sort the "Created Date/Time" column "ascending" on Supervisor Snippet Report screen
    Then I should see the "Created Date/Time" column in "ascending" order
    And I should see reports column "DCreated Date/Time" arrow in "upward" direction
    When I sort the "Created Date/Time" column "descending" on Supervisor Snippet Report screen
    Then I should see the "Created Date/Time" column in "descending" order
    And I should see reports column "Created Date/Time" arrow in "downward" direction
