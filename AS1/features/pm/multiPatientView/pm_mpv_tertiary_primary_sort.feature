@automated @pm-multi_patient_view @TMS:582886 @ISSUE:AS1-6799
Feature: pm_mpv_tertiary_primary_sort
  As an utang ONE user
  I want to validate that for each patient on MPV
  Users have the ability to group any item

  AS1-4234
  -With the addition of AS1-4233, the Group/Sort option should be enabled on MPV, allowing the user to rearrange patients.
  Unlike rearranging patients using the Vertical Toolbar census list, enabling a group/sort option within MPV will affect the main census list.
  It will also affect the list in the vertical toolbar.
  -Example:
  User enters MPV in group/sort of Alpha by Last Name
  Patient A is first, Patient B is Second, Patient C is third, Patient D is fourth on both "Main" census and Slide out census
  User reorders using the slide out list to the following: A, C, D, B and MPV monitor display changes accordingly.
  -User navigates back to main census patients are still ordered "A, B, C, D" (custom sort from MPV slideout list does not apply)
  -User navigates to MPV and reorders using the slideout list to the following: A, C, D, B and MPV monitor display changes accordingly.
  -User then selects the group/sort button and can view the Group/Sort functionality for lists. They choose to sort Alpha by Last Name, inverted.
  Slideout list updates to D, C, B, A and MPV monitor display changes accordingly
  Group/Sort button changes back to "Group/Sort" in active coloration
  -User navigates back to census. Patients are ordered D,C,B,A.

  TestRail Id: C582886
  Jira Epic:
  Jira Stories: AS1-4234
  Jira Bugs/Defects:

  Background:
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    Then I should see the patient list screen
    When I click the Multi-Patient View button in header
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I reset grouping and sorting on patients list
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I should see the Group Sort link not highlighted
    When I click on Group/Sort link
    Then I should see the Group/Sort window

  Scenario: PM - MPV Sort Dropdown Options
    When I click the "First Sort by" field and should see the following options:
      | None       |
      | Unit       |
      | Last Name  |
      | First Name |
      | Gender     |
      | Age      |
      | DOB      |
      | MRN      |
      | Bed      |
      | Active/Inactive |

  Scenario: PM - MPV Group/Sort icon becomes active when a sort is applied
    When I click on first Sort By dropdown and select "Last Name"
    And I click the ok button on Group / Sort window
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I should see the multi patient list Group or Sort by "Last Name" in Ascending Order
    And I should see the Group Sort link highlighted
    And I reset grouping and sorting on patients list
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I should see the Group Sort link not highlighted

  Scenario: PM - MPV "Unit" Sorting (Ascending)
    When I click on first Sort By dropdown and select "Unit"
    And I click the ok button on Group / Sort window
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I should see the multi patient list Group or Sort by "Unit" in Ascending Order
    When I click the dual monitor control button in the header
    Then I should see 2 full monitors and details should match the first 2 patients in previous screen
    And I should see the multi patient list Group or Sort by "Unit" in Ascending Order
    When I click the quad monitor control button in the header
    Then I should see 4 full monitors on the screen of the first 4 patients in previous screen
    And I should see the multi patient list Group or Sort by "Unit" in Ascending Order
    When I click the 6 view monitor control button in the header
    And I should see 6 full monitors on the screen of the first 6 patients in previous screen
    And I should see the multi patient list Group or Sort by "Unit" in Ascending Order
    When I click the 9 view monitor control button in the header
    Then I should see 9 full monitors on the screen of the first 9 patients in previous screen
    And I should see the multi patient list Group or Sort by "Unit" in Ascending Order
    When I click the 12 view monitor control button in the header
    Then I should see 12 full monitors on the screen of the first 12 patients in previous screen
    And I should see the multi patient list Group or Sort by "Unit" in Ascending Order
    When I click the 16 view monitor control button in the header
    Then I should see 16 full monitors on the screen of the first 16 patients in previous screen
    And I should see the multi patient list Group or Sort by "Unit" in Ascending Order
    When I click "<" button in the header
    Then I should see the patient list screen
    And it should be sorted by "Unit" in ascending order
    When I click the Multi-Patient View button in header
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I should see the multi patient list Group or Sort by "Unit" in Ascending Order

  Scenario: PM - MPV Invert "Unit" Sorting (Descending)
    When I click on first Sort By dropdown and select "Unit"
    And I click on the first Sort By invert button
    And I click the ok button on Group / Sort window
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I should see the multi patient list Group or Sort by "Unit" in Descending Order
    When I click the dual monitor control button in the header
    Then I should see 2 full monitors and details should match the first 2 patients in previous screen
    And I should see the multi patient list Group or Sort by "Unit" in Descending Order
    When I click the quad monitor control button in the header
    Then I should see 4 full monitors on the screen of the first 4 patients in previous screen
    And I should see the multi patient list Group or Sort by "Unit" in Descending Order
    When I click the 6 view monitor control button in the header
    And I should see 6 full monitors on the screen of the first 6 patients in previous screen
    And I should see the multi patient list Group or Sort by "Unit" in Descending Order
    When I click the 9 view monitor control button in the header
    Then I should see 9 full monitors on the screen of the first 9 patients in previous screen
    And I should see the multi patient list Group or Sort by "Unit" in Descending Order
    When I click the 12 view monitor control button in the header
    Then I should see 12 full monitors on the screen of the first 12 patients in previous screen
    And I should see the multi patient list Group or Sort by "Unit" in Descending Order
    When I click the 16 view monitor control button in the header
    Then I should see 16 full monitors on the screen of the first 16 patients in previous screen
    And I should see the multi patient list Group or Sort by "Unit" in Descending Order
    When I click "<" button in the header
    Then I should see the patient list screen
    And I should see the Group Sort link highlighted
    When I click the Multi-Patient View button in header
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I should see the multi patient list Group or Sort by "Unit" in Descending Order
    And I should see the Group Sort link highlighted

  Scenario: PM - MPV "Last Name" Sorting (Ascending)
    When I click on first Sort By dropdown and select "Last Name"
    And I click the ok button on Group / Sort window
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I should see the multi patient list Group or Sort by "Last Name" in Ascending Order
    When I click the dual monitor control button in the header
    Then I should see 2 full monitors and details should match the first 2 patients in previous screen
    And I should see the multi patient list Group or Sort by "Last Name" in Ascending Order
    When I click the quad monitor control button in the header
    Then I should see 4 full monitors on the screen of the first 4 patients in previous screen
    And I should see the multi patient list Group or Sort by "Last Name" in Ascending Order
    When I click the 6 view monitor control button in the header
    And I should see 6 full monitors on the screen of the first 6 patients in previous screen
    And I should see the multi patient list Group or Sort by "Last Name" in Ascending Order
    When I click the 9 view monitor control button in the header
    Then I should see 9 full monitors on the screen of the first 9 patients in previous screen
    And I should see the multi patient list Group or Sort by "Last Name" in Ascending Order
    When I click the 12 view monitor control button in the header
    Then I should see 12 full monitors on the screen of the first 12 patients in previous screen
    And I should see the multi patient list Group or Sort by "Last Name" in Ascending Order
    When I click the 16 view monitor control button in the header
    Then I should see 16 full monitors on the screen of the first 16 patients in previous screen
    And I should see the multi patient list Group or Sort by "Last Name" in Ascending Order
    When I click "<" button in the header
    Then I should see the patient list screen
    And it should be sorted by "Last Name" in ascending order
    And I should see the Group Sort link highlighted
    When I click the Multi-Patient View button in header
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I should see the multi patient list Group or Sort by "Last Name" in Ascending Order
    And I should see the Group Sort link highlighted

  Scenario: PM - MPV Invert "Last Name" Sorting (Descending)
    When I click on first Sort By dropdown and select "Last Name"
    And I click on the first Sort By invert button
    And I click the ok button on Group / Sort window
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I should see the multi patient list Group or Sort by "Last Name" in Descending Order
    When I click the dual monitor control button in the header
    Then I should see 2 full monitors and details should match the first 2 patients in previous screen
    And I should see the multi patient list Group or Sort by "Last Name" in Descending Order
    When I click the quad monitor control button in the header
    Then I should see 4 full monitors on the screen of the first 4 patients in previous screen
    And I should see the multi patient list Group or Sort by "Last Name" in Descending Order
    When I click the 6 view monitor control button in the header
    And I should see 6 full monitors on the screen of the first 6 patients in previous screen
    And I should see the multi patient list Group or Sort by "Last Name" in Descending Order
    When I click the 9 view monitor control button in the header
    Then I should see 9 full monitors on the screen of the first 9 patients in previous screen
    And I should see the multi patient list Group or Sort by "Last Name" in Descending Order
    When I click the 12 view monitor control button in the header
    Then I should see 12 full monitors on the screen of the first 12 patients in previous screen
    And I should see the multi patient list Group or Sort by "Last Name" in Descending Order
    When I click the 16 view monitor control button in the header
    Then I should see 16 full monitors on the screen of the first 16 patients in previous screen
    And I should see the multi patient list Group or Sort by "Last Name" in Descending Order
    When I click "<" button in the header
    Then I should see the patient list screen
    And I should see the Group Sort link highlighted
    When I click the Multi-Patient View button in header
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I should see the multi patient list Group or Sort by "Last Name" in Descending Order
    And I should see the Group Sort link highlighted

  Scenario: PM - MPV "First Name" Sorting (Ascending)
    When I click on first Sort By dropdown and select "First Name"
    And I click the ok button on Group / Sort window
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I should see the multi patient list Group or Sort by "First Name" in Ascending Order
    When I click the dual monitor control button in the header
    Then I should see 2 full monitors and details should match the first 2 patients in previous screen
    And I should see the multi patient list Group or Sort by "First Name" in Ascending Order
    When I click the quad monitor control button in the header
    Then I should see 4 full monitors on the screen of the first 4 patients in previous screen
    And I should see the multi patient list Group or Sort by "First Name" in Ascending Order
    When I click the 6 view monitor control button in the header
    And I should see 6 full monitors on the screen of the first 6 patients in previous screen
    And I should see the multi patient list Group or Sort by "First Name" in Ascending Order
    When I click the 9 view monitor control button in the header
    Then I should see 9 full monitors on the screen of the first 9 patients in previous screen
    And I should see the multi patient list Group or Sort by "First Name" in Ascending Order
    When I click the 12 view monitor control button in the header
    Then I should see 12 full monitors on the screen of the first 12 patients in previous screen
    And I should see the multi patient list Group or Sort by "First Name" in Ascending Order
    When I click the 16 view monitor control button in the header
    Then I should see 16 full monitors on the screen of the first 16 patients in previous screen
    And I should see the multi patient list Group or Sort by "First Name" in Ascending Order
    When I click "<" button in the header
    Then I should see the patient list screen
    And it should be sorted by "First Name" in ascending order
    And I should see the Group Sort link highlighted
    When I click the Multi-Patient View button in header
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I should see the multi patient list Group or Sort by "First Name" in Ascending Order
    And I should see the Group Sort link highlighted

  Scenario: PM - MPV  Invert "First Name" Sorting (Descending)
    When I click on first Sort By dropdown and select "First Name"
    And I click on the first Sort By invert button
    And I click the ok button on Group / Sort window
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I should see the multi patient list Group or Sort by "First Name" in Descending Order
    When I click the dual monitor control button in the header
    Then I should see 2 full monitors and details should match the first 2 patients in previous screen
    And I should see the multi patient list Group or Sort by "First Name" in Descending Order
    When I click the quad monitor control button in the header
    Then I should see 4 full monitors on the screen of the first 4 patients in previous screen
    And I should see the multi patient list Group or Sort by "First Name" in Descending Order
    When I click the 6 view monitor control button in the header
    And I should see 6 full monitors on the screen of the first 6 patients in previous screen
    And I should see the multi patient list Group or Sort by "First Name" in Descending Order
    When I click the 9 view monitor control button in the header
    Then I should see 9 full monitors on the screen of the first 9 patients in previous screen
    And I should see the multi patient list Group or Sort by "First Name" in Descending Order
    When I click the 12 view monitor control button in the header
    Then I should see 12 full monitors on the screen of the first 12 patients in previous screen
    And I should see the multi patient list Group or Sort by "First Name" in Descending Order
    When I click the 16 view monitor control button in the header
    Then I should see 16 full monitors on the screen of the first 16 patients in previous screen
    And I should see the multi patient list Group or Sort by "First Name" in Descending Order
    When I click "<" button in the header
    Then I should see the patient list screen
    And I should see the Group Sort link highlighted
    When I click the Multi-Patient View button in header
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I should see the multi patient list Group or Sort by "First Name" in Descending Order
    And I should see the Group Sort link highlighted

  Scenario: PM - MPV "Unit" Sorting (Ascending)
    When I click on first Sort By dropdown and select "Unit"
    And I click the ok button on Group / Sort window
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I should see the multi patient list Group or Sort by "Unit" in Ascending Order
    When I click the dual monitor control button in the header
    Then I should see 2 full monitors and details should match the first 2 patients in previous screen
    And I should see the multi patient list Group or Sort by "Unit" in Ascending Order
    When I click the quad monitor control button in the header
    Then I should see 4 full monitors on the screen of the first 4 patients in previous screen
    And I should see the multi patient list Group or Sort by "Unit" in Ascending Order
    When I click the 6 view monitor control button in the header
    And I should see 6 full monitors on the screen of the first 6 patients in previous screen
    And I should see the multi patient list Group or Sort by "Unit" in Ascending Order
    When I click the 9 view monitor control button in the header
    Then I should see 9 full monitors on the screen of the first 9 patients in previous screen
    And I should see the multi patient list Group or Sort by "Unit" in Ascending Order
    When I click the 12 view monitor control button in the header
    Then I should see 12 full monitors on the screen of the first 12 patients in previous screen
    And I should see the multi patient list Group or Sort by "Unit" in Ascending Order
    When I click the 16 view monitor control button in the header
    Then I should see 16 full monitors on the screen of the first 16 patients in previous screen
    And I should see the multi patient list Group or Sort by "Unit" in Ascending Order
    When I click "<" button in the header
    Then I should see the patient list screen
    And it should be sorted by "Unit" in ascending order
    When I click the Multi-Patient View button in header
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I should see the multi patient list Group or Sort by "Unit" in Ascending Order

  Scenario: PM - MPV Invert "Unit" Sorting (Descending)
    When I click on first Sort By dropdown and select "Unit"
    And I click on the first Sort By invert button
    And I click the ok button on Group / Sort window
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I should see the multi patient list Group or Sort by "Unit" in Descending Order
    When I click the dual monitor control button in the header
    Then I should see 2 full monitors and details should match the first 2 patients in previous screen
    And I should see the multi patient list Group or Sort by "Unit" in Descending Order
    When I click the quad monitor control button in the header
    Then I should see 4 full monitors on the screen of the first 4 patients in previous screen
    And I should see the multi patient list Group or Sort by "Unit" in Descending Order
    When I click the 6 view monitor control button in the header
    And I should see 6 full monitors on the screen of the first 6 patients in previous screen
    And I should see the multi patient list Group or Sort by "Unit" in Descending Order
    When I click the 9 view monitor control button in the header
    Then I should see 9 full monitors on the screen of the first 9 patients in previous screen
    And I should see the multi patient list Group or Sort by "Unit" in Descending Order
    When I click the 12 view monitor control button in the header
    Then I should see 12 full monitors on the screen of the first 12 patients in previous screen
    And I should see the multi patient list Group or Sort by "Unit" in Descending Order
    When I click the 16 view monitor control button in the header
    Then I should see 16 full monitors on the screen of the first 16 patients in previous screen
    And I should see the multi patient list Group or Sort by "Unit" in Descending Order
    When I click "<" button in the header
    Then I should see the patient list screen
    And I should see the Group Sort link highlighted
    When I click the Multi-Patient View button in header
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I should see the multi patient list Group or Sort by "Unit" in Descending Order
    And I should see the Group Sort link highlighted

  Scenario: PM - MPV "Age" Sorting (Ascending)
    When I click on first Sort By dropdown and select "Age"
    And I click the ok button on Group / Sort window
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I should see the multi patient list Group or Sort by "Age" in Ascending Order
    When I click the dual monitor control button in the header
    Then I should see 2 full monitors and details should match the first 2 patients in previous screen
    And I should see the multi patient list Group or Sort by "Age" in Ascending Order
    When I click the quad monitor control button in the header
    Then I should see 4 full monitors on the screen of the first 4 patients in previous screen
    And I should see the multi patient list Group or Sort by "Age" in Ascending Order
    When I click the 6 view monitor control button in the header
    And I should see 6 full monitors on the screen of the first 6 patients in previous screen
    And I should see the multi patient list Group or Sort by "Age" in Ascending Order
    When I click the 9 view monitor control button in the header
    Then I should see 9 full monitors on the screen of the first 9 patients in previous screen
    And I should see the multi patient list Group or Sort by "Age" in Ascending Order
    When I click the 12 view monitor control button in the header
    Then I should see 12 full monitors on the screen of the first 12 patients in previous screen
    And I should see the multi patient list Group or Sort by "Age" in Ascending Order
    When I click the 16 view monitor control button in the header
    Then I should see 16 full monitors on the screen of the first 16 patients in previous screen
    And I should see the multi patient list Group or Sort by "Age" in Ascending Order
    When I click "<" button in the header
    Then I should see the patient list screen
    And it should be sorted by "Age" in ascending order
    When I click the Multi-Patient View button in header
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I should see the multi patient list Group or Sort by "Age" in Ascending Order

  Scenario: PM - MPV Invert "Age" Sorting (Descending)
    When I click on first Sort By dropdown and select "Age"
    And I click on the first Sort By invert button
    And I click the ok button on Group / Sort window
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I should see the multi patient list Group or Sort by "Age" in Descending Order
    When I click the dual monitor control button in the header
    Then I should see 2 full monitors and details should match the first 2 patients in previous screen
    And I should see the multi patient list Group or Sort by "Age" in Descending Order
    When I click the quad monitor control button in the header
    Then I should see 4 full monitors on the screen of the first 4 patients in previous screen
    And I should see the multi patient list Group or Sort by "Age" in Descending Order
    When I click the 6 view monitor control button in the header
    And I should see 6 full monitors on the screen of the first 6 patients in previous screen
    And I should see the multi patient list Group or Sort by "Age" in Descending Order
    When I click the 9 view monitor control button in the header
    Then I should see 9 full monitors on the screen of the first 9 patients in previous screen
    And I should see the multi patient list Group or Sort by "Age" in Descending Order
    When I click the 12 view monitor control button in the header
    Then I should see 12 full monitors on the screen of the first 12 patients in previous screen
    And I should see the multi patient list Group or Sort by "Age" in Descending Order
    When I click the 16 view monitor control button in the header
    Then I should see 16 full monitors on the screen of the first 16 patients in previous screen
    And I should see the multi patient list Group or Sort by "Age" in Descending Order
    When I click "<" button in the header
    Then I should see the patient list screen
    And I should see the Group Sort link highlighted
    When I click the Multi-Patient View button in header
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I should see the multi patient list Group or Sort by "Age" in Descending Order
    And I should see the Group Sort link highlighted

  Scenario: PM - MPV "Gender" Sorting (Ascending)
    When I click on first Sort By dropdown and select "Gender"
    And I click the ok button on Group / Sort window
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I should see the multi patient list Group or Sort by "Gender" in Ascending Order
    When I click the dual monitor control button in the header
    Then I should see 2 full monitors and details should match the first 2 patients in previous screen
    And I should see the multi patient list Group or Sort by "Gender" in Ascending Order
    When I click the quad monitor control button in the header
    Then I should see 4 full monitors on the screen of the first 4 patients in previous screen
    And I should see the multi patient list Group or Sort by "Gender" in Ascending Order
    When I click the 6 view monitor control button in the header
    And I should see 6 full monitors on the screen of the first 6 patients in previous screen
    And I should see the multi patient list Group or Sort by "Gender" in Ascending Order
    When I click the 9 view monitor control button in the header
    Then I should see 9 full monitors on the screen of the first 9 patients in previous screen
    And I should see the multi patient list Group or Sort by "Gender" in Ascending Order
    When I click the 12 view monitor control button in the header
    Then I should see 12 full monitors on the screen of the first 12 patients in previous screen
    And I should see the multi patient list Group or Sort by "Gender" in Ascending Order
    When I click the 16 view monitor control button in the header
    Then I should see 16 full monitors on the screen of the first 16 patients in previous screen
    And I should see the multi patient list Group or Sort by "Gender" in Ascending Order
    When I click "<" button in the header
    Then I should see the patient list screen
    And it should be sorted by "Gender" in ascending order
    When I click the Multi-Patient View button in header
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I should see the multi patient list Group or Sort by "Gender" in Ascending Order

  Scenario: PM - MPV Invert "Gender" Sorting (Descending)
    When I click on first Sort By dropdown and select "Gender"
    And I click on the first Sort By invert button
    And I click the ok button on Group / Sort window
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I should see the multi patient list Group or Sort by "Gender" in Descending Order
    When I click the dual monitor control button in the header
    Then I should see 2 full monitors and details should match the first 2 patients in previous screen
    And I should see the multi patient list Group or Sort by "Gender" in Descending Order
    When I click the quad monitor control button in the header
    Then I should see 4 full monitors on the screen of the first 4 patients in previous screen
    And I should see the multi patient list Group or Sort by "Gender" in Descending Order
    When I click the 6 view monitor control button in the header
    And I should see 6 full monitors on the screen of the first 6 patients in previous screen
    And I should see the multi patient list Group or Sort by "Gender" in Descending Order
    When I click the 9 view monitor control button in the header
    Then I should see 9 full monitors on the screen of the first 9 patients in previous screen
    And I should see the multi patient list Group or Sort by "Gender" in Descending Order
    When I click the 12 view monitor control button in the header
    Then I should see 12 full monitors on the screen of the first 12 patients in previous screen
    And I should see the multi patient list Group or Sort by "Gender" in Descending Order
    When I click the 16 view monitor control button in the header
    Then I should see 16 full monitors on the screen of the first 16 patients in previous screen
    And I should see the multi patient list Group or Sort by "Gender" in Descending Order
    When I click "<" button in the header
    Then I should see the patient list screen
    And I should see the Group Sort link highlighted
    When I click the Multi-Patient View button in header
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I should see the multi patient list Group or Sort by "Gender" in Descending Order
    And I should see the Group Sort link highlighted

  Scenario: PM - MPV "Bed" Sorting (Ascending)
    When I click on first Sort By dropdown and select "Bed"
    And I click the ok button on Group / Sort window
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I should see the multi patient list Group or Sort by "Bed" in Ascending Order
    When I click the dual monitor control button in the header
    Then I should see 2 full monitors and details should match the first 2 patients in previous screen
    And I should see the multi patient list Group or Sort by "Bed" in Ascending Order
    When I click the quad monitor control button in the header
    Then I should see 4 full monitors on the screen of the first 4 patients in previous screen
    And I should see the multi patient list Group or Sort by "Bed" in Ascending Order
    When I click the 6 view monitor control button in the header
    And I should see 6 full monitors on the screen of the first 6 patients in previous screen
    And I should see the multi patient list Group or Sort by "Bed" in Ascending Order
    When I click the 9 view monitor control button in the header
    Then I should see 9 full monitors on the screen of the first 9 patients in previous screen
    And I should see the multi patient list Group or Sort by "Bed" in Ascending Order
    When I click the 12 view monitor control button in the header
    Then I should see 12 full monitors on the screen of the first 12 patients in previous screen
    And I should see the multi patient list Group or Sort by "Bed" in Ascending Order
    When I click the 16 view monitor control button in the header
    Then I should see 16 full monitors on the screen of the first 16 patients in previous screen
    And I should see the multi patient list Group or Sort by "Bed" in Ascending Order
    When I click "<" button in the header
    Then I should see the patient list screen
    And it should be sorted by "Bed" in ascending order
    And I should see the Group Sort link highlighted
    When I click the Multi-Patient View button in header
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I should see the multi patient list Group or Sort by "Bed" in Ascending Order
    And I should see the Group Sort link highlighted

  Scenario: PM - MPV  Invert "Bed" Sorting (Descending)
    When I click on first Sort By dropdown and select "Bed"
    And I click on the first Sort By invert button
    And I click the ok button on Group / Sort window
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I should see the multi patient list Group or Sort by "Bed" in Descending Order
    When I click the dual monitor control button in the header
    Then I should see 2 full monitors and details should match the first 2 patients in previous screen
    And I should see the multi patient list Group or Sort by "Bed" in Descending Order
    When I click the quad monitor control button in the header
    Then I should see 4 full monitors on the screen of the first 4 patients in previous screen
    And I should see the multi patient list Group or Sort by "Bed" in Descending Order
    When I click the 6 view monitor control button in the header
    And I should see 6 full monitors on the screen of the first 6 patients in previous screen
    And I should see the multi patient list Group or Sort by "Bed" in Descending Order
    When I click the 9 view monitor control button in the header
    Then I should see 9 full monitors on the screen of the first 9 patients in previous screen
    And I should see the multi patient list Group or Sort by "Bed" in Descending Order
    When I click the 12 view monitor control button in the header
    Then I should see 12 full monitors on the screen of the first 12 patients in previous screen
    And I should see the multi patient list Group or Sort by "Bed" in Descending Order
    When I click the 16 view monitor control button in the header
    Then I should see 16 full monitors on the screen of the first 16 patients in previous screen
    And I should see the multi patient list Group or Sort by "Bed" in Descending Order
    When I click "<" button in the header
    Then I should see the patient list screen
    And I should see the Group Sort link highlighted
    When I click the Multi-Patient View button in header
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I should see the multi patient list Group or Sort by "Bed" in Descending Order
    And I should see the Group Sort link highlighted

  Scenario: PM - MPV "None" Sorting (Ascending)
    When I click on first Sort By dropdown and select "None"
    And I click the ok button on Group / Sort window
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I should see the multi patient list Group or Sort by "None" in Ascending Order
    When I click the dual monitor control button in the header
    Then I should see 2 full monitors and details should match the first 2 patients in previous screen
    And I should see the multi patient list Group or Sort by "None" in Ascending Order
    When I click the quad monitor control button in the header
    Then I should see 4 full monitors and details should match the first 4 patients in previous screen
    And I should see the multi patient list Group or Sort by "None" in Ascending Order
    When I click the 6 view monitor control button in the header
    And I should see 6 full monitors and details should match the first 6 patients in previous screen
    And I should see the multi patient list Group or Sort by "None" in Ascending Order
    When I click the 9 view monitor control button in the header
    Then I should see 9 full monitors and details should match the first 9 patients in previous screen
    And I should see the multi patient list Group or Sort by "None" in Ascending Order
    When I click the 12 view monitor control button in the header
    Then I should see 12 full monitors and details should match the first 12 patients in previous screen
    And I should see the multi patient list Group or Sort by "None" in Ascending Order
    When I click the 16 view monitor control button in the header
    Then I should see 16 full monitors and details should match the first 16 patients in previous screen
    And I should see the multi patient list Group or Sort by "None" in Ascending Order
    When I click "◀" button in the header
    Then I should see the patient list screen
    And it should be sorted by "None" in ascending order
    And I should see the Group Sort link highlighted
    When I click the Multi-Patient View button in header
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I should see the multi patient list Group or Sort by "None" in Ascending Order
    And I should see the Group Sort link highlighted

  Scenario: PM - MPV Invert "None" Sorting (Descending)
    When I click on first Sort By dropdown and select "None"
    And I click on the first Sort By invert button
    And I click the ok button on Group / Sort window
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I should see the multi patient list Group or Sort by "None" in Descending Order
    When I click the dual monitor control button in the header
    Then I should see 2 full monitors and details should match the first 2 patients in previous screen
    And I should see the multi patient list Group or Sort by "None" in Descending Order
    When I click the quad monitor control button in the header
    Then I should see 4 full monitors on the screen of the first 4 patients in previous screen
    And I should see the multi patient list Group or Sort by "None" in Descending Order
    When I click the 6 view monitor control button in the header
    And I should see 6 full monitors on the screen of the first 6 patients in previous screen
    And I should see the multi patient list Group or Sort by "None" in Descending Order
    When I click the 9 view monitor control button in the header
    Then I should see 9 full monitors on the screen of the first 9 patients in previous screen
    And I should see the multi patient list Group or Sort by "None" in Descending Order
    When I click the 12 view monitor control button in the header
    Then I should see 12 full monitors on the screen of the first 12 patients in previous screen
    And I should see the multi patient list Group or Sort by "None" in Descending Order
    When I click the 16 view monitor control button in the header
    Then I should see 16 full monitors on the screen of the first 16 patients in previous screen
    And I should see the multi patient list Group or Sort by "None" in Descending Order
    When I click "<" button in the header
    Then I should see the patient list screen
    And I should see the Group Sort link highlighted
    When I click the Multi-Patient View button in header
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I should see the multi patient list Group or Sort by "None" in Descending Order
    And I should see the Group Sort link highlighted
