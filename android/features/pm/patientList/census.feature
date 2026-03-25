@automated @TMS:40318  @pm @pm-patient_list @regression @bvt
Feature: Census: View the PM Census
  I want view the PM Monitor
  So that I can make sure I can view the patient's information

  TestRail Id: C40318

  Scenario: Census: PM Census
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    When I click the AS1 button
    When I click "PM Census" on the List
    Then I should see the patient List
    When I rotate the device to "landscape"
    Then the device orientation is set to "landscape"
    When I rotate the device to "portrait"
    Then the device orientation is set to "portrait"
    Then I should see the patient List
