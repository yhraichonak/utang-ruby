@automated @TMS:328917  @c3p0
Feature: 3rd_party_c3p0_mh_siteId_events
  As a C3P0 user
  I want to launch a MH C3P0 link utilizing the Site ID
  So I can validate the patient events list loads correctly

  TestRail Id: C328917

  Jira Epic: AS1-258

  Jira Stories: AS1-2168

#  C3PO links to a patient context should open directly to the specified context without visual indication of the navigational elements in-between (such as site list).
#  Example - when user opens a link to shared Patient Monitor, the user will see the splash screen and then the patient monitor.
#  Exception: When in backgrounded mode, the screen may briefly show where the user left-off, and then transition to the new context.

  Background:
    Given I reset the AS1 app
    Then I should see the Welcome screen

  Scenario: MH - C3P0 launch to PM Events screen (Welcome Screen, Backgrounded Application)
    When I move app to background
    And I open pm-evt for MH C3PO url with payload [props.C3POA_MH_PAYLOAD]
    Then I should see the Events screen of [props.C3PO_FULL_NAME] patient

  Scenario: MH - C3P0 launch to PM Events screen (Welcome Screen, Force Closed Application)
    When I force close app
    And I open pm-evt for MH C3PO url with payload [props.C3POA_MH_PAYLOAD]
    Then I should see the Events screen of [props.C3PO_FULL_NAME] patient

  Scenario: MH - C3P0 launch to PM Events screen (Sites List, Backgrounded Application)
    When I sign into AS1
    Then I should see the Site List screen
    When I move app to background
    And I open pm-evt for MH C3PO url with payload [props.C3POA_MH_PAYLOAD]
    Then I should see the Events screen of [props.C3PO_FULL_NAME] patient

  Scenario: MH - C3P0 launch to PM Events screen (Sites List, Force Closed Application)
    When I sign into AS1
    Then I should see the Site List screen
    When I force close app
    And I open pm-evt for MH C3PO url with payload [props.C3POA_MH_PAYLOAD]
    Then I should see the Events screen of [props.C3PO_FULL_NAME] patient
