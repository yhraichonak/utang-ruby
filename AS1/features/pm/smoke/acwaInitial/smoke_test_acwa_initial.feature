@smoke @automated @core
Feature: Live Monitor Smoke Test
    As an AS1 user
    I want view a Patient's Monitor
    So that I can make sure I can view the patient's vitals

  TestRail Id: C
  Jira Issues: AS1-188, AS1-128, AS1-542, AS1-624, AS1-856, AS1-1107, AS1-1117, AS1-756, AS1-1351, AS1-1405, MIG-249, MIG-341, AS1-2985, AS1-2993, AS1-4208, AS1-4691
  @obsolete
  Scenario: Live Monitor Acwa Initial
    Given I login to a test site "acwa initial" with user "raytrejo" and pass "XXXXX"
    Then I should see the patient list screen
    When I click "Census" on the List
    Then I should see the patient list screen
    When I click on "Nesbitt, Esron" in patient list
    Then I should see the patient summary screen
    When I click on the Monitor tile
    Then I should see the Live Monitor screen
    And the "Live" button is active
    And I should see ST parameter values
    When I click the "Live" button in sub navigation menu
    And the "Live" button is inactive
    And the Monitor Time Ago displays on monitor
    When I click the "Live" button in sub navigation menu
    And the "Live" button is active

    And the "ACWA Tools" button is inactive

    When I click the "ACWA Tools" button in sub navigation menu
    Then I should see the acwa tools screen
    Then the "ACWA Tools" button is active
    And I hover over "measure" button on the acwa tools screen
    And I hover over "march out" button on the acwa tools screen

    When I click the "measure" button on the acwa tools screen
    Then I should see P QR QR Complex S and T calipers display on the acwa tools screen
