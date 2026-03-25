@regression @automated @core @patient_summary
Feature: Patient Details Header
    Patient Details Header
    Patient Monitor Patient Details Header will display on all screens where patient data is displayed, for the selected patient.
    Format:

    First line, left justified:  [Last Name], [First Name]*[GENDER]*[AGE] (where gender = M,F, or U)
    Second line, left justified: MRN*DOB*UNIT*BED*SITE
    Rules for use of spacers : Unit, Bed, and Site will have a spacer (but no spaces) preceding the data.
    When blank, each of these data elements will not be shown (including preceding spacer). Example: A patient details header
  second line layout where patient data available includes only MRN, UNIT and SITE would appear : MRN*UNIT*SITE

  Anomalies:

  Vents and EMR - Unit and Bed are not parsed

  OB - No gender is listed

  Precedence order for Patient Information by Module:
  Precedence order for Patient Information by Module
  1) EMR
  when EMR adapter like Cerner or Epic in place AND CDR also in place, then the EMR adapter takes precedence
  1a) CDR
  2) PM
  3) OB
  4) Cardio

  Highest Order precedence module controls the Header + General Info tile (i.e. Patient Details header may show different details
  if higher precedence module is installed, no matter the module list the patient was accessed. )_

  TestRail Id: C328911
  Jira Stories: AS1-1972, AS1-2598
  @critical @TMS:328911
  Scenario: Patient Details Header
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    Then I should see the patient list screen
    When I click "Census" on the List
    Then I should see the patient list screen
    When I click on default patient in list without redirect
    Then I should see the Live Monitor screen
    And I should see the pm patient info in the header
    When I click the "Tools" button in sub navigation menu
    Then I should see the Snippet Tool screen
    And I should see the pm patient info in the header
    When I click the "Events" button in sub navigation menu
    Then I should see the Events screen
    And I should see the pm patient info in the header