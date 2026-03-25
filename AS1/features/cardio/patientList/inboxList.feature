@regression @automated @core @cardio @cardio-patient_list
Feature: Patient List - Inbasket List
  Patient Cell Layout
  Each patient cell contains the following information:
  Patient Name (e.g. "Last, First"), Most recent ECG Acquisition Date/Time (e.g. "12/07/10 - 21:16:03"), Gender, Age, and a counter of ECGs associated with that patient.

  [Last], [First] * [Gender - M/F] * [Age]
  [Acq Date] - [Acq Time] [ECG Count]
  [Diagnosis Statement]

  TestRail Id: C179312
  Jira Stories: AS1-28, AS1-32, AS1-2473, AS1-2474, AS1-2475, AS1-3224
@critical @TMS:179312
  Scenario: Patient List - Inbasket List
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    Then I should see the patient list screen
    When I click "MOST RECENT" on the List
    And I should see patient list sorted by acquistion date by LIFO
    When I click on "[props.CP_FULL_NAME]" in patient list
    Then I should see the ECG 12 lead screen
    When I click the Back button in patient header
    Then I should see the patient list screen