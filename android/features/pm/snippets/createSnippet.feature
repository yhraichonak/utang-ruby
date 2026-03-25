@automated @TMS:581597  @pm @pm-snippets @regression @bvt
Feature: Snippet: Create Snippet
  As an AS1 user
  I want view a Patient's Monitor and create a snippet
  TestRail Id: C581597
 @skip
  Scenario: Snippet: Create Snippet
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    When  I click the AS1 button
    And   I click "PM Census" on the List
    Then  I should see the patient List
    When I click on default patient in list
    Then  I should see the Live Monitor screen
    When  I select the navigation bar Monitor Tool button
    Then  I should see the Monitor Tool Screen
    When  I click the Measure button on the Monitor Tool Screen
#     TODO: Potential place of hanging
    Then  I should see the "P", "QR", "S", and "T" target buttons
    When  I click the Create Snippet button on the Monitor Tool Screen
    Then  I should see the Snippet Document Edit Screen
    When  I click the Save button on the Snippet Document Edit Screen
    Then  I should see the Live Monitor screen
