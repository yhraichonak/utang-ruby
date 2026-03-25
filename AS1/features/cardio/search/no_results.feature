@cardio @regression @automated @core @cardio @cardio-search
Feature: Search - Combo No Results
  As an AS1 user
  I want to search for patients using the search form
  So I can find patients by First Name, Last Name, Age, DOB, and by MRN.

TestRail Id: C179331
Jira Stories: AS1-34, AS1-299, AS1-617, AS1-611, AS1-1467, AS1-2611
@critical @TMS:179331

Scenario: Search - Combo No Results returned
  Given I am a super user with all permissions
  When I login to a testSite with a valid credential
  Then I should see the patient list screen
  When I click "SEARCH" on the List
  Then I should see the search patient list screen
  When I enter "Ohm" in "Last" search field
  And I enter "Georg" in "First" search field
  And I enter "99" in "Age" search field
  And I click on search button
  And I should see a total of 0 patient(s) in the search results
  Then I should see No Results for Search Criteria message
