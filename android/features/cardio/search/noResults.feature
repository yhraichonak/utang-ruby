@automated @TMS:40269  @cardio @cardio-search @bvt
Feature: Search by No Results
  As an AS1 user
  I want to search for patients using the search form
  So I can find patients by No Results

  TestRail Id: C40269

  Scenario: Search No Results
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    When  I click the AS1 button
    Then  I should see my ListOfList window
    When  I click "Cardio Search" on the List
    Then  I should see Search in the nav bar
    When  I enter "NO" in the cardio "First" field
    And   I enter "RESULTS" in the cardio "Last" field
    And   I click the search button
    Then  I should see No patient matches found on the screen
