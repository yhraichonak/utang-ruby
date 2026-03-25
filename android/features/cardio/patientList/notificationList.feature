@automated @TMS:40290 @cardio @cardio-patient_list @bvt
Feature: View the Notifications List
  As an AS1 user
  I want view Notifications List
  So that I can make sure I can view my notifications in a site

  TestRail Id: C40290

  Scenario:  Notifications List
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    When  I click the AS1 button
    Then  I should see my ListOfList window
    When  I click "NOTIFICATIONS" on the List
    Then  I should see the NOTIFICATIONS patient List
