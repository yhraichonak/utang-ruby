@automated @pm-multi_patient_view @TMS:582862
Feature: pm_mpv_groupSort_from_census

  TestRail Id: C582862


  Scenario: MPV - Applied Group/Sort from Census is reflected on Census MPV
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    Then I should see the patient list screen
    When I click "Census" on the List
    Then I should see the patient list screen
    When I filter following units "on"
      | 5E |
    And I click Ok button in Filter Units window
    Then I should see the patient list screen
    When I click on Group/Sort link
    Then I should see the Group/Sort window
    When I click on Group By dropdown and select "DOB"
    And I click the ok button on Group / Sort window
    Then I should see the patient list screen
    And I should see the PM patient list grouped by "dob" and sorted by "bed"
    When I click the Multi-Patient View button in header
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I should see the multi patient list Group or Sort by "Age" in Descending Order
    When I click the 4 view monitor control button in the header
    Then I should see 4 view monitor control button is enabled in the header
    And I should see the multi patient list Group or Sort by "Age" in Descending Order
    When I click the 6 view monitor control button in the header
    Then I should see 6 view monitor control button is enabled in the header
    And I should see the multi patient list Group or Sort by "Age" in Descending Order
    When I click the 9 view monitor control button in the header
    Then I should see 9 view monitor control button is enabled in the header
    And I should see the multi patient list Group or Sort by "Age" in Descending Order
    When I click the 12 view monitor control button in the header
    Then I should see 12 view monitor control button is enabled in the header
    And I should see the multi patient list Group or Sort by "Age" in Descending Order
    When I click the 16 view monitor control button in the header
    Then I should see 16 view monitor control button is enabled in the header
    And I should see the multi patient list Group or Sort by "Age" in Descending Order

    When I click the Patient List button on the vertical toolbar
    Then I should see the Patient List slide out open
    And I should see the slide out patient list in the same order as the Multi-Patient View screen
    When I drag a patient to reorder
    And I get the slide out patient list order
    Then I should see the Multi-Patient View census reordered
    When I click the Home icon
    Then I should see the patient list screen
    And I should see the PM patient list grouped by "dob" and sorted by "bed"

    When I click the Multi-Patient View button in header
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I should see the multi patient list Group or Sort by "Age" in Descending Order
    When I click on Group/Sort link
    Then I should see the Group/Sort window
    When I click on Group By dropdown and select "Last Name"
    And I click the ok button on Group / Sort window
    Then I should see the multi patient list Group or Sort by "Last Name" in Ascending Order
    When I click the back button in the Header
    Then I should see the patient list screen
    And I should see the PM patient list grouped by "last_name" and sorted by "bed"
    When I click on Filter Units link
    Then I should see the Filter Units window
    When I click the Toggle All button on Filter Units window
    And I click Ok button in Filter Units window
