@automated @TMS:582879 @pm-multi_patient_view
Feature: pm_mpv_group_and_sort_control
  As an utang ONE user
  I want to Group/Sort in Multi-Patient View
  So I can validate the Group/Sort effect on the census from Multi-Patient View

  TestRail Id: C582879

  Background:
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    Then I should see the patient list screen
    When I click the Multi-Patient View button in header
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    When I click on Group/Sort link
    Then I should see the Group/Sort window
    When I click the reset button on Group / Sort window
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    When I click on Group/Sort link
    Then I should see the Group/Sort window


  Scenario: PM - MPV Validate User can View and Dismiss Group/Sort Window
    When I click the cancel button on Group / Sort window
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode

    When I click on Group/Sort link
    Then I should see the Group/Sort window
    When I click the ok button on Group / Sort window
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I should see the multi patient list Group or Sort by "Unit" in Ascending Order


  Scenario: PM - MPV Validate Group/Sort Control Screen
    Then I see group sort title
    And I see the group and sort by dropdown options
    And I see the cancel button
    And I see the reset button
    And I see the ok button


  Scenario: PM - MPV Validate Default Group/Sort Settings
    Then Group by should have Unit selected
    And Sort by should have Bed selected
    And second Sort by should have Select... selected


  Scenario: PM - MPV Validate Reset Button
    When I click on Group By dropdown and select "Age"
    And I click the ok button on Group / Sort window
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode

    Then I should see the multi patient list Group or Sort by "Age" in Ascending Order
    When I click on Group/Sort link
    Then I should see the Group/Sort window
    When I click the reset button on Group / Sort window
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode

    Then I should see the multi patient list Group or Sort by "Unit" in Ascending Order


  Scenario: PM - MPV Validate Primary/Secondary Tertiary Group/Sort is Stored Locally
    When I click on Group By dropdown and select "Bed"
    Then Group by should have Bed selected
    When I click on first Sort By dropdown and select "Last Name"
    Then Sort by should have Last Name selected
    When I click on second Sort By dropdown and select "Age"
    Then second Sort by should have Age selected
    When I click the ok button on Group / Sort window
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    And I should see the multi patient list Group or Sort by "Bed" in Ascending Order
    When I logout of application
    And I am a super user with all permissions
    And I login to a testSite with a valid credential
    Then I should see the patient list screen
    And I should see the PM patient list group sort cached from the previous session based on bed
    When I click the Multi-Patient View button in header
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    Then I should see the multi patient list Group or Sort by "Bed" in Descending Order
    When I click on Group/Sort link
    Then I should see the Group/Sort window
    Then Group by should have Bed selected
    And Sort by should have Last Name selected
    And second Sort by should have Age selected
