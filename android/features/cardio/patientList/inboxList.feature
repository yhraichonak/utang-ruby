@automated @TMS:40286  @cardio @cardio-patient_list @bvt
Feature: View Inbox Patient List
  As an AS1 user
  I want view a Inbox Patient List
  So that I can make sure I can view my patient's in a site

  TestRail Id: C40286

  Scenario: My Inbox list
    Given I am a user with cardiac fellow permissions
    When I login to a testSite with a valid credential
    When  I click the AS1 button
    Then  I should see my ListOfList window
    When  I click "CARDIAC FELLOW" on the List
    Then  I should see the patient List
    When  I rotate the device to "landscape"
    Then  the device orientation is set to "landscape"
    When  I rotate the device to "portrait"
    Then  the device orientation is set to "portrait"
