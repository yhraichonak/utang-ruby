@smoke @automated @core
Feature: Live Monitor Smoke Test
    As an AS1 user
    I want view a Patient's Monitor
    So that I can make sure I can view the patient's vitals

  TestRail Id: C
  Jira Issues: AS1-188, AS1-128, AS1-542, AS1-624, AS1-856, AS1-1107, AS1-1117, AS1-756, AS1-1351, AS1-1405, MIG-249, MIG-341, AS1-2985, AS1-2993, AS1-4208, AS1-4691
  @obsolete
  Scenario: Live Monitor Mindray
    Given I login to a test site "mindray" with user "raytrejo" and pass "XXXXX"
    Then I should see the patient list screen
    When I click "Census" on the List
    Then I should see the patient list screen
    When I click on "Li, Yin-Demo" in patient list
    Then I should see the patient summary screen
    When I click on the Monitor tile
    Then I should see the Live Monitor screen
    And I should see the Live Monitor time in "[props.COMMON_DATE_FORMAT]" format
    And the "Live" button is active
    And I should see ST parameter values
    When I click the "Live" button in sub navigation menu
    And the "Live" button is inactive
    And the Monitor Time Ago displays on monitor
    When I click the "Live" button in sub navigation menu
    And the "Live" button is active
