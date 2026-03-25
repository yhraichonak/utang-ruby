@automated @pm-multi_patient_view @TMS:582863
Feature: pm_mpv_groupSort_from_my_patients
  As a utang ONE user
  I want to view the My Patients Multi-Patient View screen
  So that I can ensure the group sort is respected from the census

  TestRail Id: C582863

  Scenario: MPV - Applied Group/Sort from My Patients is reflected on My Patients MPV
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    Then I should see the patient list screen
    When I click "Census" on the List
    Then I should see the patient list screen
    And I configure My Patients list to have "6" patients
    When I click "My Patients" on the List
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
