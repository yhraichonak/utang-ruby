@automated @TMS:264307
Feature: 3rd_party_c3p0_mh_siteId_monitor
              As a C3P0 user
              I want to launch a MH C3P0 link utilizing the Site ID
So I can validate the patient monitor loads correctly

TestRail Id: C264307

C3PO links to a patient context should open directly to the specified context without visual indication of the navigational elements in-between (such as site list).
        Example - when user opens a link to shared Patient Monitor, the user will see the splash screen and then the patient monitor.
              Exception: When in backgrounded mode, the screen may briefly show where the user left-off, and then transition to the new context.

        Background:
            Given I reset the AS1 app
             Then I should see the Welcome screen
             When I generate pm-mon mh C3PO url with query TEST=1234567890&ad=[props.C3PO_USER]&dob=&mrn=[props.DP_MRN]

        Scenario: MH - C3P0 launch to PM Monitor screen by SiteID (Welcome Screen, Backgrounded Application)
             When I move app to background
              And I navigate to the generated mobile C3PO url
             Then I should see the Live Monitor screen of [props.DP_FULL_NAME] patient

        Scenario: MH - C3P0 launch to PM Monitor screen by SiteID (Welcome Screen, Force Closed Application)
             When I force close app
              And I navigate to the generated mobile C3PO url
             Then I should see the Live Monitor screen of [props.DP_FULL_NAME] patient

        Scenario: MH - C3P0 launch to PM Monitor screen by SiteID (Sites List, Backgrounded Application)
             When I sign into AS1
             Then I should see the Site List screen
             When I move app to background
              And I navigate to the generated mobile C3PO url
             Then I should see the Live Monitor screen of [props.DP_FULL_NAME] patient

        Scenario: MH - C3P0 launch to PM Monitor screen by SiteID (Sites List, Force Closed Application)
             When I sign into AS1
             Then I should see the Site List screen
             When I force close app
              And I navigate to the generated mobile C3PO url
             Then I should see the Live Monitor screen of [props.DP_FULL_NAME] patient
