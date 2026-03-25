@automated @core @regression       @pm @pm-patient_list @pm-patient_list-features
Feature: PM - Patient List - Navigation

  Tap the Patient Cell
  User is directed to the Patient Summary for that Patient
  Select the bed, (or near, TBD Jump navigation style) the "jump" navigation will allow the user to select Events or Monitor for that patient.
  User will be presented with the selected "jump" navigation (Events, Monitor, Ventilator if configured. Only module specific jump navigation will display.)
  User can return to previous context from the PM Patient List

  TestRail Id: C264246
  
  Jira Epic: AS1-2521

  Jira Stories: AS1-125, AS1-3556

  Jira Bugs/Defects: AS1-524, AS1-1391, AS1-1878
  
  @critical @TMS:264246
  Scenario: PM Patient List Navigation
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    Then I should see the patient list screen
    And reset unit filtering
    When I click "Census" on the List
    Then I should see the patient list screen
    When I hover of the patient in patient list they appear highlighted
    And I click on "[props.DP_FULL_NAME]" in patient list
    Then I should see the patient summary screen
    When I click the Back button in PM patient header
    Then I should see the patient list screen
    And I should not see previous patient selected highlight (only on hover)

    When I hover over dropdown arrow of test patient in PM patient list
    And I hover of the patient in patient list they appear highlighted
    Then I should see Events, Live Monitor links
    When I click the Events link on patient list
    Then I should see the Events screen
    When I click the Back button in PM patient header
    Then I should see the patient list screen
    And I should not see previous patient selected highlight (only on hover)

    When I hover over dropdown arrow of test patient in PM patient list
    And I hover of the patient in patient list they appear highlighted
    Then I should see Events, Live Monitor links
    When I click the Overview link on patient list
    Then I should see the patient summary screen
    When I click the Back button in PM patient header
    Then I should see the patient list screen
    And I should not see previous patient selected highlight (only on hover)

    When I hover over dropdown arrow of test patient in PM patient list
    And I hover of the patient in patient list they appear highlighted
    Then I should see Events, Live Monitor links





