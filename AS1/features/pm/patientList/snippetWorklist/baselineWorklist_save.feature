@regression  @automated @core @pm @pm-patient_list @pm-patient_list-snippet_worklist
Feature: Snippet Baseline Worklist
    Description

    Navigation
    List of List
    Tapping on the Baseline Worklist menu item within the List of Lists will present the user with the Baseline Documentation Worklist.

    Baseline Census
    Baseline Worklist Patients (without a documented Baseline)
    Tapping on a Baseline patient from the worklist jumps to the Monitor Tool time which matches the time value for the admit time + 15 minutes (configurable).
    Live Monitor for that patient. If admitted for less time than configured, navigate to monitor tool for the current time.  The *primary *navigational
    items within this view need to be hidden/not accessible.  The *secondary *navigational bar will be visible, but ALL items except for "Choose Time"
    will be inactive/greyed out.  (i.e. The user can not navigate anywhere but "back" and the only accessible item within the navigation bars is "Choose Time"

    When utilizing the Baseline Worklist to invoke Snippets, the user maintains all current functionalities of Snippets (i.e. measurements, calipers,,
    server-controlled snippet durations, and draggable boundary indicators.)

    Baseline Worklist Patients (with a documented Baseline)
    Patients who have had previously completed Baseline Worklist will NOT display on the Baseline worklist (i.e. once completed, the patient will no longer display on the baseline list)

    Refresh
    The list will poll every minute for new list data and refresh when new data is available

    Saving
    When the user selects "Save" they will be returned to the Baseline worklist where the worklist will be refreshed and the  completed Baseline patient will
  no longer display on the Baseline List.

  NOTE: SQL for snippet type on snippetDocument table

  SELECT *
  FROM [utangServer].[dbo].[SnippetDocument]
  Where [SnippetType] = 1

  TestRail Id: C328924
  Jira Stories: AS1-2029, AS1-2056, AS1-2162, AS1-2071, AS1-2074, AS1-2058, AS1-1795, AS1-2983
@critical @TMS:328924
  Scenario: Snippet Baseline Worklist
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    And I cleanup baseline worklist snippet in db for mrn "252731"
    Then I should see the patient list screen
    When I click "Snippet Baseline Worklist" on the List
    Then I should see the snippet worklist screen
    And I should see Group Sort, Filter Units links disabled
    And I should see the Multi-Patient View link disabled
    And I should see single column toggle turned "On"
    And I should see snippet worklist with single columns "On"
    And I should see PM patient information in site snippet worklist
      | patientName       | gender | age | MRN        | DOB             | location | bed    | status   | statusColor |
      | Ohm, Georg        | M      | 70  | 252731     | DOB: 07/31/1952 | SU       | SU-06  | active   | blue        |
    And I should see same number of patients in worklist as listed in list of list count

    When I click on "Ohm, Georg" in patient list without redirect
    Then I should see the Live Monitor screen
    When I click the "Tools" button in sub navigation menu
    Then I should see the Snippet Tool screen
    When I click the Create Snippet button
    Then I should see the Snippet Document Edit View
    And I should see the Description field with header "Admission Baseline Description"

    When I click the Save button on Snippet Document Edit screen
    Then I see Snippet Saved notification window
    When I click OK button Snippet Saved notification window
    Then I should see the snippet worklist screen
    And wait for 1 seconds
    And I should see one less patient in baseline worklist
    And I should see same number of patients in worklist as listed in list of list count

    When I go to utangserverdb
    And I execute following query from description
    Then I should see the record of the snippetdocument saved with SnippetType equal to 1
    And I cleanup baseline worklist snippet in db for mrn "252731"



