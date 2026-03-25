@automated @TMS:264309  @c3p0
Feature: 3rd_party_c3p0_voalte_monitor
  As a C3P0 user
  I want to launch a VOALTE C3P0 link
  So I can validate the patient monitor loads correctly

  TestRail Id: C264309

  Jira Epic: AS1-258

  Jira Stories: AS1-2168

  Jira Bugs/Defects: AS1-1237

#  C3PO links to a patient context should open directly to the specified context without visual indication of the navigational elements in-between (such as site list).
#  Example - when user opens a link to shared Patient Monitor, the user will see the splash screen and then the patient monitor.
#  Exception: When in backgrounded mode, the screen may briefly show where the user left-off, and then transition to the new context.

#  Background:
#    Given I reset the AS1 app
#    Then I should see the Welcome screen
#
#  Scenario: Voalte - C3P0 launch to PM Monitor screen (Welcome Screen, Backgrounded Application, Live Monitor)
#    When I move app to background
#    And I open pm-mon Voalte C3PO url with payload [props.C3POA_WITHOUT_TIME_PAYLOAD]
#    Then I should see the Live Monitor screen of [props.C3PO_FULL_NAME] patient
#
#  Scenario: Voalte - C3P0 launch to PM Monitor screen (Welcome Screen, Backgrounded Application, Historic Monitor)
#    When I move app to background
#    And I open pm-mon Voalte C3PO url with payload [props.C3POA_WITH_TIME_PAYLOAD]
#    Then I should see the MONITOR screen not LIVE at "01/01/2023 19:00:00" timestamp

  Scenario: PM C3P0 Launch - PM monitor with 1 day ago link
#    When I force close app
    Given I open C3PO URL generation interface
    And I generate pm-mon voalte C3PO url with query TEST=1234567890&time=[YESTERDAY.%Y-%m-%dT%H:%M:%S.%L%z]&bed=[props.C3PO_BED]&unit=[props.C3PO_UNIT]&ad=[props.C3PO_USER]
    And I navigate to the generated mobile C3PO url
    And I should see the MONITOR screen not LIVE at "contains:[YESTERDAY.%m/%d/%Y]" timestamp

#  Scenario: Voalte - C3P0 launch to PM Monitor screen (Welcome Screen, Force Closed Application, Live Monitor)
#    When I force close app
#    And I open pm-mon Voalte C3PO url with payload [props.C3POA_WITHOUT_TIME_PAYLOAD]
#    Then I should see the Live Monitor screen of [props.C3PO_FULL_NAME] patient
#
#  Scenario: Voalte - C3P0 launch to PM Monitor screen (Welcome Screen, Force Closed Application, Historic Monitor)
#  When I force close app
#  And I open pm-mon Voalte C3PO url with payload [props.C3POA_WITH_TIME_PAYLOAD]
#  Then I should see the MONITOR screen not LIVE at "01/01/2023 19:00:00" timestamp
#
#  Scenario: Voalte - C3P0 launch to PM Monitor screen (Sites List, Backgrounded Application, Live Monitor)
#    When I sign into AS1
#    Then I should see the Site List screen
#    When I move app to background
#    And I open pm-mon Voalte C3PO url with payload [props.C3POA_WITHOUT_TIME_PAYLOAD]
#    Then I should see the Live Monitor screen of [props.C3PO_FULL_NAME] patient
#
#  Scenario: Voalte - C3P0 launch to PM Monitor screen (Sites List, Backgrounded Application, Historic Monitor)
#    When I sign into AS1
#    Then I should see the Site List screen
#    When I move app to background
#    And I open pm-mon Voalte C3PO url with payload [props.C3POA_WITH_TIME_PAYLOAD]
#    Then I should see the MONITOR screen not LIVE at "01/01/2023 19:00:00" timestamp
#
#  Scenario: Voalte - C3P0 launch to PM Monitor screen (Sites List, Force Closed Application, Live Monitor)
#    When I sign into AS1
#    Then I should see the Site List screen
#    When I force close app
#    And I open pm-mon Voalte C3PO url with payload [props.C3POA_WITHOUT_TIME_PAYLOAD]
#    Then I should see the Live Monitor screen of [props.C3PO_FULL_NAME] patient
#
#  Scenario: Voalte - C3P0 launch to PM Monitor screen (Sites List, Force Closed Application, Historic Monitor)
#    When I sign into AS1
#    Then I should see the Site List screen
#    When I force close app
#    And I open pm-mon Voalte C3PO url with payload [props.C3POA_WITH_TIME_PAYLOAD]
#    Then I should see the MONITOR screen not LIVE at "01/01/2023 19:00:00" timestamp
