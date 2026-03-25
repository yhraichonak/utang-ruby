@automated @TMS:40303  @pm @pm-monitor @regression @bvt
Feature: Monitor: Live Monitor Landscape
  I want to view the Live Monitor in Landscape
  So that I can make sure I can view the Live Monitor in landscape

  TestRail Id: C40303
  Scenario: Monitor: Live Monitor Landscape
    Given I am a super user with all permissions
    When I login to a testSite with a valid credential
    When I click the AS1 button
    When I click "PM Census" on the List
    Then I should see the patient List
    When I click on default patient in list
    Then I should see the Live Monitor screen
    When I rotate the device to "landscape"
    Then the device orientation is set to "landscape"
    When I rotate the device to "portrait"
    Then the device orientation is set to "portrait"
