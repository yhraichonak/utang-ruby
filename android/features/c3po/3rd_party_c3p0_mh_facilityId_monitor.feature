@c3p0 @skip
Feature: PM C3P0 MH

#  TestRail Id: 264303

  Background:
    Given I reset the AS1 app
    Then I should see the Welcome screen

  Scenario: MH - C3P0 launch to PM Monitor screen (Welcome Screen, Backgrounded Application, Live Monitor)
    When I move app to background
    And I open pm-mon for MH C3PO url with payload [props.C3POA_MH_PAYLOAD]
    Then I should see the Live Monitor screen of [props.C3POA_FULL_NAME] patient

  Scenario: MH - C3P0 launch to PM Monitor screen (Welcome Screen, Force Closed Application, Live Monitor)
    When I force close app
    And I open pm-mon for MH C3PO url with payload [props.C3POA_MH_PAYLOAD]
    Then I should see the Live Monitor screen of [props.C3POA_FULL_NAME] patient

  Scenario: MH - C3P0 launch to PM Monitor screen (Sites List, Backgrounded Application, Live Monitor)
    When I sign into AS1
    Then I should see the Site List screen
    When I move app to background
    And I open pm-mon for MH C3PO url with payload [props.C3POA_MH_PAYLOAD]
    Then I should see the Live Monitor screen of [props.C3POA_FULL_NAME] patient

  Scenario: MH - C3P0 launch to PM Monitor screen (Sites List, Force Closed Application, Live Monitor)
    When I sign into AS1
    Then I should see the Site List screen
    When I force close app
    And I open pm-mon for MH C3PO url with payload [props.C3POA_MH_PAYLOAD]
    Then I should see the Live Monitor screen of [props.C3POA_FULL_NAME] patient