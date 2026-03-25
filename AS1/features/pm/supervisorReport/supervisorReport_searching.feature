@regression @automated @core @pm @pm-supervisor_report
Feature: Supervisor Report - Searching
  Searching
  Bed will need to be searchable in a manner similar to the date range where user can search for a range of beds using From/To fields.
  From field and To field are begins with alphanumeric searches.

  Ex: when searching From: B3 To:B4
  Results returned would be all beds from B30 to B39, all beds from B300 to B399, etc.

  User can also type a singular bed in the "From" field to search for and return a singular exact match

  Search will be case-insensitive

  TestRail Id: C329221
  Jira Epic: AS1-6847
  Jira Stories: AS1-2430, AS1-2142, AS1-2429
  Jira Bugs/Defects: AS1-7115, AS1-6265

  @ISSUE:AS1-4832   @TMS:329221
  Scenario: Supervisor Report - Searching
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    Then I should see the patient list screen
    When I click "Snippets Report" on the List
    Then I should see the Supervisor Snippet Report screen

    And I should see from and to date filters in Supervisor Snippet Report screen
    And I should see from and to bed filters in Supervisor Snippet Report screen

    When I enter "SU" into Bed search "From" textfield on Supervisor Snippet Report Screen
    When I enter "SU-06" into Bed search "To" textfield on Supervisor Snippet Report Screen
    Then I should see the "Bed" column data filtered by "SU-06"

    When I clear Bed search "From" textfield on Supervisor Snippet Report Screen
    And I clear Bed search "To" textfield on Supervisor Snippet Report Screen

    And I enter "Z" into Bed search "From" textfield on Supervisor Snippet Report Screen
    And I should see the Snippets Report refresh with message "Modify filters to see more search results."

    When I clear Bed search "From" textfield on Supervisor Snippet Report Screen
    And I clear Bed search "To" textfield on Supervisor Snippet Report Screen

    And I enter "SU" into Bed search "From" textfield on Supervisor Snippet Report Screen
    Then I should see the "Bed" column data filtered by "SU-06"
