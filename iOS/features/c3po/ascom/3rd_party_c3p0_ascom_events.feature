@automated @TMS:328913
Feature: 3rd_party_c3p0_ascom_events
              As a C3P0 user
              I want to launch a ASCOM C3P0 link
So I can validate the patient events list loads correctly

TestRail Id: C328913

C3PO links to a patient context should open directly to the specified context without visual indication of the navigational elements in-between (such as site list).
        Example - when user opens a link to shared Patient Monitor, the user will see the splash screen and then the patient monitor.
        Background:
            Given I reset the AS1 app
             Then I should see the Welcome screen
             When I generate pm-evt ascom C3PO url with query TEST=1234567890&bed=[props.C3PO_BED]&unit=[props.C3PO_UNIT]&ad=[props.C3PO_USER]

        Scenario: ASCOM - C3P0 launch to PM Events screen (Welcome Screen, Backgrounded Application)
             When I move app to background
              And I navigate to the generated mobile C3PO url
             Then I should see the Events screen of [props.C3PO_FULL_NAME] patient

        Scenario: ASCOM - C3P0 launch to PM Events screen (Welcome Screen, Force Closed Application)
             When I force close app
              And I navigate to the generated mobile C3PO url
             Then I should see the Events screen of [props.C3PO_FULL_NAME] patient

        Scenario: ASCOM - C3P0 launch to PM Events screen (Sites List, Backgrounded Application)
             When I sign into AS1
             Then I should see the Site List screen
             When I move app to background
              And I navigate to the generated mobile C3PO url
             Then I should see the Events screen of [props.C3PO_FULL_NAME] patient

        Scenario: ASCOM - C3P0 launch to PM Events screen (Sites List, Force Closed Application)
             When I sign into AS1
             Then I should see the Site List screen
             When I force close app
              And I navigate to the generated mobile C3PO url
             Then I should see the Events screen of [props.C3PO_FULL_NAME] patient
