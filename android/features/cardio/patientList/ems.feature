@automated @TMS:40285  @cardio @cardio-patient_list @bvt
Feature: View EMS Patient List
  As an AS1 user
  I want view a EMS Patient List
  So that I can make sure I can view my patient's in a site

  TestRail Id: C40285

  Scenario: EMS list
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    When  I click the AS1 button
    Then  I should see my ListOfList window
    When  I click "EMS" on the List
    Then  I should see No Results for Search Criteria message
    When  I rotate the device to "landscape"
    Then  the device orientation is set to "landscape"
    When  I rotate the device to "portrait"
    Then  the device orientation is set to "portrait"
