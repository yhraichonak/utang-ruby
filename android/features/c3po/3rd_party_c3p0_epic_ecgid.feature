@automated @TMS:328916  @c3p0
Feature: 3rd_party_c3p0_epic_ecgid.feature
  As a C3P0 user
  I want to launch a EPIC C3P0 link
  So I can validate the patient ecg loads correctly

  TestRail Id: C328916

  Jira Epic: AS1-258

  Jira Stories: AS1-2168

#  C3PO links to a patient context should open directly to the specified context without visual indication of the navigational elements in-between (such as site list).
#  Example - when user opens a link to shared Patient Monitor, the user will see the splash screen and then the patient monitor.
#  Exception: When in backgrounded mode, the screen may briefly show where the user left-off, and then transition to the new context.


  Background:
    Given I reset the AS1 app
    Then I should see the Welcome screen

  Scenario: EPIC - C3P0 launch to ECG screen by ECG ID and ASMPID (Welcome Screen, Backgrounded Application)
    When I move app to background
    When I open C3PO url
    When I open ecg for epic C3PO url with payload [props.C3POA_EPIC_PAYLOAD]
    Then I should see the ECG screen of [props.CP_FULL_NAME] patient

  Scenario: EPIC - C3P0 launch to ECG screen by ECG ID and ASMPID (Welcome Screen, Force Closed Application)
    When I force close app
    When I open ecg for epic C3PO url with payload [props.C3POA_EPIC_PAYLOAD]
    Then I should see the ECG screen of [props.CP_FULL_NAME] patient

  Scenario: EPIC - C3P0 launch to ECG screen by ECG ID and ASMPID (Sites List, Backgrounded Application)
    When I sign into AS1
    Then I should see the Site List screen
    When I move app to background
    When I open ecg for epic C3PO url with payload [props.C3POA_EPIC_PAYLOAD]
    Then I should see the ECG screen of [props.CP_FULL_NAME] patient

  Scenario: EPIC - C3P0 launch to ECG screen by ECG ID and ASMPID (Sites List, Force Closed Application)
    When I sign into AS1
    Then I should see the Site List screen
    When I force close app
    When I open ecg for epic C3PO url with payload [props.C3POA_EPIC_PAYLOAD]
    Then I should see the ECG screen of [props.CP_FULL_NAME] patient
