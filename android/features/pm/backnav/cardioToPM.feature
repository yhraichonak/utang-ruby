@automated @TMS:580506  @pm @pm-backnav @regression @bvt
Feature: Cardio to PM Navigation
  As an AS1 user
  I want navigate to the patient's Live Monitor screen
  From the patient's Cardio ECG screen

  TestRail Id: C580506

  Scenario: Cardio to PM Navigation
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    When I click the AS1 button
    Then I should see my ListOfList window
    When I click "Most Recent" in List of List menu
    Then I should see the patient List
    When I click on the first person in the Most Recent List
    Then I should see the patient ECG screen
    When I click hardware back button
    Then I should see the patient List
    When I click the AS1 button
    Then I should see my ListOfList window
    When I click "PM Census" on the List
    Then I should see the patient List
    When I click on the first person in the Patient List
    Then I should see the LIVE MONITOR screen
