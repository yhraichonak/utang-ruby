@c3p0 @skip
Feature: 3rd_party_c3p0_pk_ob
  As a C3P0 user
  I want to launch a PK C3P0 link
  So I can validate the patient summary loads correctly

  TestRail Id: C264308

  Jira Epic: AS1-258

  Jira Stories:

#  C3PO links to a patient context should open directly to the specified context without visual indication of the navigational elements in-between (such as site list).
#  Example - when user opens a link to shared Patient Monitor, the user will see the splash screen and then the patient monitor.
#  Exception: When in backgrounded mode, the screen may briefly show where the user left-off, and then transition to the new context.
#
#  Background:
#    Given I reset the AS1 app
#    Then I should see the Welcome screen

  Scenario: PK - C3P0 launch to OB Dashboard screen (Welcome Screen, Backgrounded Application)
#    When I move app to background
    And I open C3PO url
#    When I open pm-evt PKOB C3PO url with payload [props.C3POA_WITHOUT_TIME_PAYLOAD]
    Then I should see the Events screen of [props.C3POA_FULL_NAME] patient

#  Scenario: PK - C3P0 launch to OB Dashboard screen (Welcome Screen, Force Closed Application)
#    When I force close app
#    And I open pm-evt PKOB C3PO url with payload [props.C3POA_WITHOUT_TIME_PAYLOAD]
#    Then I should see the Events screen of [props.C3POA_FULL_NAME] patient
#
#  Scenario: PK - C3P0 launch to OB Dashboard screen (Sites List, Backgrounded Application)
#    When I sign into AS1
#    Then I should see the Site List screen
#    When I move app to background
#    And I open pm-evt PKOB url with payload [props.C3POA_WITHOUT_TIME_PAYLOAD]
#    Then I should see the Events screen of [props.C3POA_FULL_NAME] patient
#
#  Scenario: PK - C3P0 launch to OB Dashboard screen (Sites List, Force Closed Application)
#    When I sign into AS1
#    Then I should see the Site List screen
#    When I force close app
#    And I open pm-evt PKOB C3PO url with payload [props.C3POA_WITHOUT_TIME_PAYLOAD]
#    Then I should see the Events screen of [props.C3POA_FULL_NAME] patient