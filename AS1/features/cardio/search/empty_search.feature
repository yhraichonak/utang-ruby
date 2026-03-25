@cardio @regression @automated @core @cardio @cardio-search
Feature: Search - Empty Search
  As an AS1 user
  I want to search for patients using the search form
  So I can find patients by First Name, Last Name, Age, DOB, and by MRN.

TestRail Id: C264392
Jira Stories: AS1-617, AS1-611
@critical @TMS:264392
Scenario: Search - Empty Search
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  Then I should see the patient list screen
  When I click "SEARCH" on the List
  Then I should see the search patient list screen
  And I click on search button
  And I should see a total of 0 patient(s) in the search results
  Then I should see At least one field is required to search message