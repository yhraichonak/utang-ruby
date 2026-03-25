@automated @TMS:40296  @pm @pm-discretes @regression
Feature: Discretes: View Discretes
  As an AS1 user
  I want view a Patient's Discretes Screen
  So that I can make sure I can view the patient's discretes

  TestRail Id: C40296

  Scenario: Discretes: View Discretes
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    When I click the AS1 button
    When I click "PM Census" on the List
    Then I should see the patient List
    When  I click on "[props.DP_FULL_NAME]" in patient list
    Then I should see the Live Monitor screen
    When I click on the jump to button on the Live Monitor Screen
    When I click the OK button on the time chooser window
    Then I should see the MONITOR screen not LIVE
    When I long press on the PVC discrete
    Then I should see the PM PVC Trend screen
    When I click hardware back button
    Then I should see the MONITOR screen not LIVE
    When I long press on the HR discrete
    Then I should see the PM HR Trend screen
    When I click hardware back button
    Then I should see the MONITOR screen not LIVE
