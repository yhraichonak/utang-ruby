@automated @TMS:40289  @cardio @cardio-patient_list @bvt
Feature: Nav the List of List EC ON
  As an AS1 user
  I want view a Nav the List of List with EC On
  So that I can make sure I can view my patient's in a site

  TestRail Id: C40289

  Scenario:  ECG List EC ON
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    When  I click the AS1 button
    Then  I should see my ListOfList window
    And   I should see "ALL PRIVILEGES" in List of List window
