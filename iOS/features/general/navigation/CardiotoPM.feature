@regression @automated @cardio @skip @pm @pm-nav @TMS:582416
Feature: PM to Cardio navigation
  As an AS1 user
  I want view a Patient's cardio screen
  And then navigate to their PM monitor

  TestRail Id: C582416
  Background:
    Given I verify the version of the app installed
    Given login to the test site with "[props.U_USERNAME]" and "[props.U_PASSWORD]"
    When I click options button on top left of screen
    Then I should see the ListOfList window
    When I click "CENSUS" in List of List window
    Then I should see the "PM" patient List

  Scenario: PM to Cardio Navigation
    When I enter patient "[props.CP_FULL_NAME]" in the pm patient list search field
    Then I should see patient "[props.CP_FULL_NAME]" in patient search results
    When I click on patient "[props.CP_FULL_NAME]" in the pm patient list
    Then I should see the Live Monitor screen

    When I click on the ECG tile
    Then I should see the ecg screen in default color mode

    When I select the new navigation Home button
    Then I should see the patient summary screen

    When I click on the Monitor tile
    Then I should see the Live Monitor screen


