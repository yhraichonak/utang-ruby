@regression @automated @core @cardio @cardio-patient_list
Feature: Patient List - EMS List
  Patient Cell Layout
  Each patient cell contains the following information:
  Patient Name (e.g. "Last, First"), Most recent ECG Acquisition Date/Time (e.g. "12/07/10 - 21:16:03"), Gender, Age, and a counter of ECGs associated with that patient.

TestRail Id: C179311
  Jira Epic: AS1-28, AS1-2525, AS1-2560
  Jira Stories: AS1-2524, AS1-6634
  Jira Bugs/Defects: AS1-32, AS1-3224

  @critical @TMS:179311
Scenario: Patient List - EMS List
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  Then I should see the patient list screen
  When I click "EMS" on the List
  Then I should see the patient list screen
  And I should be on "EMS" patientList
    And I should see patient information in patientList
      | patientName           | gender             | age             | acqDate          | ecgCount              | diagStatement    |
      | [props.EMS_FULL_NAME] | [props.EMS_GENDER] | [props.EMS_AGE] | [props.EMS_DATE] | [props.EMS_ECG_COUNT] | [props.EMS_DIAG] |
  And I should see patient list sorted by acquistion date by LIFO

  When I click on "[props.EMS_FULL_NAME]" in patient list without redirect and without override
  Then I should see the patient ECG screen

  When I click the Back button in patient header
  Then I should see the patient list screen
  And I should be on "EMS" patientList
  And I should see no patient search in header
