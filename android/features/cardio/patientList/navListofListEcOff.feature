@automated @TMS:40288 @cardio @cardio-patient_list @bvt
Feature: Nav the List of List EC Off
  As an AS1 user
  I want view a Nav the List of List with EC Off
  So that I can make sure I can view my patient's in a site

  TestRail Id: C40288

  Scenario: ECG List EC OFF
    Given I am a super user with no permissions
    When I login to a testSite with a valid credential
    When  I click the AS1 button
    Then  I should see my ListOfList window
    And   I should not see "ALL PRIVILEGES" in List of List window
