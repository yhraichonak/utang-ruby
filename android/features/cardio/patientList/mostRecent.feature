@automated @TMS:40287  @cardio @cardio-patient_list @bvt
Feature: View Most Recent Patient List
  As an AS1 user
  I want view a Most Recent Patient List
  So that I can make sure I can view my patient's in a site

  TestRail Id: C40287

  Scenario: Most Recent list
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    When  I click the AS1 button
    Then  I should see my ListOfList window
    When  I click "MOST RECENT" on the List
    Then  I should see the patient List
    When  I rotate the device to "landscape"
    Then  the device orientation is set to "landscape"
    When  I rotate the device to "portrait"
    Then  the device orientation is set to "portrait"
