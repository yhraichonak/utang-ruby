@regression @automated @core @pm @pm-patient_list @pm-patient_list-snippet_worklist
Feature: Patient List - Snippet Worklist Layout

Shift Documentation Worklist Display
when configured at the site level, a Patient Monitoring user will be able to access a "Snippet Worklist" menu item from the List of Lists (server driven). Tapping on the Snippet Worklist menu item within the List of Lists will present the user with the Shift Documentation Worklist. The worklist will contain a list of Patient Monitoring patients for Snippet Documentation, with headers separating worklist items into Unit and Worklist Time.

HEADERS:
The worklists are separated by header containing Unit, Shift Label, and Worklist Time (in military). These headers will be grouped first by Worklist time (LIFO), then Alpha Sort by Unit. When available, the Shift Label (configured in AMP) will appear on the header, right aligned before the worklist/rule time. The header(s) which contain the most recent worklists will appear in utang Blue. Note: This may be more than one header as multiple units may be available within each worklist grouping.
ex:

Unit A Shift1 - 12:00 (in Blue)
Unit B Shift1 - 12:00 (in Blue)
Unit A Shift3 - 9:00
Unit B Shift3 - 9:00
Unit C Shift3- 9:00
Unit A - 5:00
PATIENT CELLS:
The patient cells will contain left-aligned text identifying patient information where * is a separator:
Line 1: Last Name, First Name * Gender * Age
Line 2: MRN * DOB: MM/DD/YYYY

The patient cells will contain right-aligned bed (NoActive/Inactive coloration needed - all should display "grey" or "inactive")
Patients should be sorted by bed (location) within each unit

The patient cells will contain conditional right-aligned text or indicator:

Undocumented Snippet: if a Snippet has not been completed for the patient, a right aligned completion indicator ( ) should be present on that patient's cell in an "uncompleted" state.
Documented Snippet: If a Snippet has been completed for the patient, display left aligned text identifying the time completion of a snippet and the Author of the Snippet Document in the following format:
Line 3: AD USername - Time of Snippet Completion "gwashington - HH:MM"
The right aligned completion indicator should also display as a "completed" state

TestRail Id: C264352

Jira Epic: AS1-2542

Jira Stories: AS1-376, MIG-370, AS1-2080

Jira Bugs/Defects: AS1-5265, AS1-2302, AS1-5714, AS1-5836, AS1-5888
@critical @TMS:264352 @broken
Scenario: Snippet Worklist Layout
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  Then I should see the patient list screen
  When I click "Snippet Worklist" on the List
  Then I should see the snippet worklist screen
  And I should see Group Sort, Filter Units links disabled
  And I should see the Multi-Patient View link disabled
  And I should see PM patient information in site snippet worklist
  | patientName       | MRN           | location | bed    | DOB  |
  | NESBITT, ESRON    | 199999        | ICU1     | B850   | DOB: |
  And I should see the first Unit shift header as active-blue on snippet worklist
  And I should see Unit and Time in shift header on snippet worklist
  And I should see Unit Label in shift header on snippet worklist
  And I should see the Filter Units link disabled
  And I should see the Group Sort link disabled
  And I should see the Multi-Patient View link disabled
  And I should see patients with documented and undocumented indicators
  And I should see the snippets grouped first by Worklist Time LIFO, then Alpha Sort by unit
  #And I should not see a "No patients to document" message appear under undocumented snippets
