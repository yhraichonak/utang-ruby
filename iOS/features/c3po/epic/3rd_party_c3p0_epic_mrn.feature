@automated @TMS:264305
Feature: 3rd_party_c3p0_epic_mrn
              As a C3P0 user
              I want to launch a EPIC C3P0 link
So I can validate the patient ecg loads correctly

TestRail Id: C264305

C3PO links to a patient context should open directly to the specified context without visual indication of the navigational elements in-between (such as site list).
        Example - when user opens a link to shared Patient Monitor, the user will see the splash screen and then the patient monitor.
              Exception: When in backgrounded mode, the screen may briefly show where the user left-off, and then transition to the new context.

        Background:
            Given I reset the AS1 app
             Then I should see the Welcome screen
             When I generate ecg epic C3PO url with query TEST=1234567890&mrn=[props.DP_MRN]&ad=[props.C3PO_USER]&time=2022-08-03T08:58:09+06:00

        Scenario: EPIC - C3P0 launch to ECG screen by MRN (Welcome Screen, Backgrounded Application)
             When I move app to background
              And I navigate to the generated mobile C3PO url
             Then I should see the patient ECG screen

        Scenario: EPIC - C3P0 launch to ECG screen by MRN (Welcome Screen, Force Closed Application)
             When I force close app
              And I navigate to the generated mobile C3PO url
             Then I should see the patient ECG screen

        Scenario: EPIC - C3P0 launch to ECG screen by MRN (Sites List, Backgrounded Application)
             When I sign into AS1
             Then I should see the Site List screen
             When I move app to background
              And I navigate to the generated mobile C3PO url
             Then I should see the patient ECG screen

        Scenario: EPIC - C3P0 launch to ECG screen by MRN (Sites List, Force Closed Application)
             When I sign into AS1
             Then I should see the Site List screen
             When I force close app
              And I navigate to the generated mobile C3PO url
             Then I should see the patient ECG screen
