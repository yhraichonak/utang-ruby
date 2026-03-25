@c3p0 @automated @TMS:328912
Feature: 3rd_party_c3p0_monitor_ccf
  As a C3P0 user
  I want to launch a CCF C3P0 link
  So I can validate the patient loads correctly

  TestRail Id: C328912

  Jira Epic: AS1-258

  Jira Stories: AS1-2168

  Jira Bugs/Defects: AS1-2009

#  C3PO links to a patient context should open directly to the specified context without visual indication of the navigational elements in-between (such as site list).
#  Example - when user opens a link to shared Patient Monitor, the user will see the splash screen and then the patient monitor.
#  Exception: When in backgrounded mode, the screen may briefly show where the user left-off, and then transition to the new context.

  Background:
    Given I reset the AS1 app
    Then I should see the Welcome screen

  Scenario: CCF - C3P0 launch to PM Monitor screen (Welcome Screen, Backgrounded Application, Live Monitor)
    When I move app to background
    And I open pm-mon CCF C3PO url with payload [props.C3POA_CCF_PAYLOAD]
    Then I should see the Live Monitor screen of [props.C3PO_FULL_NAME] patient

  Scenario: CCF - C3P0 launch to PM Monitor screen (Welcome Screen, Force Closed Application, Live Monitor)
    When I force close app
    And I open pm-mon CCF C3PO url with payload [props.C3POA_CCF_PAYLOAD]
    Then I should see the Live Monitor screen of [props.C3PO_FULL_NAME] patient

  Scenario: CCF - C3P0 launch to PM Monitor screen (Sites List, Backgrounded Application, Live Monitor)
    When I sign into AS1
    Then I should see the Site List screen
    When I move app to background
    And I open pm-mon CCF C3PO url with payload [props.C3POA_CCF_PAYLOAD]
    Then I should see the Live Monitor screen of [props.C3PO_FULL_NAME] patient

  Scenario: CCF - C3P0 launch to PM Monitor screen (Sites List, Force Closed Application, Live Monitor)
    When I sign into AS1
    Then I should see the Site List screen
    When I force close app
    And I open pm-mon CCF C3PO url with payload [props.C3POA_CCF_PAYLOAD]
    Then I should see the Live Monitor screen of [props.C3PO_FULL_NAME] patient
