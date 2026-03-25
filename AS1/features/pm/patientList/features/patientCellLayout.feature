@regression @simulator @nodeSim @automated @core @pm @pm-patient_list @pm-patient_list-features
Feature: Patient List - Patient List Cell Layout
    Patient Cell Layout
    LIST-PM02*
    +PM Patient Cell Layout+
    For a Patient Cell for for PM Patient Census the data to display is:
    Last Name
    First Name
    Gender
    Age
    DOB
    MRN
    Bed

    The format of this data should be (where * is a spacer):
    Left aligned line 1: Last, First * Gender * Age
    Left aligned line 2: MRN * DOB: MM/DD/YYYY
    Right aligned: Bed/Location
    *Note* Bed (or tap target near bed) may be used for "jump" navigation, and design for this field should accommodate this

    when a data element is not available, then the separator should still appear.
    Example Patient:
    Doe, John * MALE * 62
    123456789 * DOB: 02/01/1955

    e.g. if DOB not present, then the result would be:
    Doe, John * MALE * 62
    123456789 * DOB:

    if MRN not present, then the result would be:
    Doe, John * MALE * 62
     DOB: 02/01/1955

    if Gender not present:
    Doe, John * * 62
    123456789 * DOB: 02/01/1955

    if Age not present:
    Doe, John * MALE *
    123456789 * DOB: 02/01/1955

    if no data other than name is available:
    Doe, John * *
    *

  TestRail Id: C264243
  Jira Stories: AS1-113, AS1-117, AS1-123, AS1-1398, AS1-3152
@critical @TMS:264243
  Scenario: Patient List Cell Layout
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    When I click "Census" on the List
    And I clear grouping on patients list
    Then I should see the patient list screen
    And I should see default sort by Bed left to right then top to bottom
  