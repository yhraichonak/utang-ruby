@c3p0 @skip
Feature: 3rd_party_c3p0_intouch_smoke_test
  As a C3P0 user
  I want to smoke test C3P0 INTOUCH
  So I can validate the patient loads correctly

  TestRail Id: C264306

  Jira Epic: AS1-258

  Jira Stories:

#  Background:
#    Given I reset the AS1 app
#    Then I should see the Welcome screen

  Scenario: Intouch - C3P0 launch to PM Events screen (Welcome Screen, Backgrounded Application)
#    When I move app to background
    And I open C3PO url
#    When I open pm-evt Intouch C3PO url with payload [props.C3POA_WITHOUT_TIME_PAYLOAD]
    Then I should see the Events screen of [props.C3POA_FULL_NAME] patient

#  Scenario: Intouch - C3P0 launch to PM Events screen (Welcome Screen, Force Closed Application)
#    When I force close app
#    And I open pm-evt Intouch C3PO url with payload [props.C3POA_WITHOUT_TIME_PAYLOAD]
#    Then I should see the Events screen of [props.C3POA_FULL_NAME] patient
#
#  Scenario: Intouch - C3P0 launch to PM Events screen (Sites List, Backgrounded Application)
#    When I sign into AS1
#    Then I should see the Site List screen
#    When I move app to background
#    And I open pm-evt Intouch url with payload [props.C3POA_WITHOUT_TIME_PAYLOAD]
#    Then I should see the Events screen of [props.C3POA_FULL_NAME] patient
#
#  Scenario: Intouch - C3P0 launch to PM Events screen (Sites List, Force Closed Application)
#    When I sign into AS1
#    Then I should see the Site List screen
#    When I force close app
#    And I open pm-evt Intouch C3PO url with payload [props.C3POA_WITHOUT_TIME_PAYLOAD]
#    Then I should see the Events screen of [props.C3POA_FULL_NAME] patient