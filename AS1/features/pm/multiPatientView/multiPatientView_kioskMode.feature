@multiPatient @manual @pm-multi_patient_view @automated @pre_backup_server_config @post_restore_server_config
@edit_server_config @network_logs @TMS:580277 @redesign_data
Feature: Multi Patient View - Kiosk Mode (Multi-User)
  A configuration parameter that allows the user preferences to be saved locally on the browser so that the same
  service account may be used on multiple browser instances.
  If user preferences are not saved/do not exist locally, then pull from the server.

  NOTES:
  - In web client .config, set "multiUserAccount": true for kiosk mode
  - API calls are inspected in Chrome devtools in Network tab

  Tester Notes:
  If patient "NESBITT, ESRON" is not present, use any applicable test patient for testing scenarios

  TestRail Id: C580277
  Jira Issues: AS1-2860, AS1-7958

  Background:
    Given User restores test environment config.json file from "AS1/wc_580277_config.json"
    And restart WebClient service
    And clear browser cache and reload
    And I am a super user with all permissions
    When I login to a testSite with a valid credential
    Then I should see the patient list screen

  Scenario: Multi Patient View - Kiosk Mode - adding patients from Census
    When I click on patient "[props.MPVKIOSK_FULL_NAME]" star icon to "enabled"
    Then I should see the patient "[props.MPVKIOSK_FULL_NAME]" star icon "enabled"
    And I should see My Patients counter increase by "1"
    And I should not see the "api/aso/post/configuration/userconfiguration?" api call made to server

  Scenario: My Patients - removing patients from Census
    When I click on patient "[props.MPVKIOSK_FULL_NAME]" star icon to "enabled"
    And I get my patient count
    When I click on patient "[props.MPVKIOSK_FULL_NAME]" star icon to "disabled"
    Then I should see the patient "[props.MPVKIOSK_FULL_NAME]" star icon "disabled"
    And I should see My Patients count decrease by "1"
    And I should not see the "api/aso/post/configuration/userconfiguration?" api call made to server

  Scenario: My Patients - removing patients from My Patients
    When I click on patient "[props.MPVKIOSK_FULL_NAME]" star icon to "enabled"
    And I get my patient count
    When I click "My Patients" on the List
    Then I should see the patient "[props.MPVKIOSK_FULL_NAME]" star icon "enabled"
    When I click on patient "[props.MPVKIOSK_FULL_NAME]" star icon to "disabled"
    Then I should see the patient "[props.MPVKIOSK_FULL_NAME]" star icon "disabled"
    And I should see My Patients count decrease by "1"
    And I should not see the "api/aso/post/configuration/userconfiguration?" api call made to server

  Scenario: My Patients - removing patients from Multi Patient View
    Given I should see the patient "[props.MPVKIOSK_FULL_NAME]" star icon "disabled"
    When I click PM main list on the sidebar
    Then I should see the patient list screen
    When I click on patient "[props.MPVKIOSK_FULL_NAME]" star icon to "enabled"
    Then I should see the patient "[props.MPVKIOSK_FULL_NAME]" star icon "enabled"
    And I should see My Patients counter increase by "1"
    And I should not see the "api/aso/post/configuration/userconfiguration?" api call made to server
    When I click "My Patients" on the List
    Then I should see the patient "[props.MPVKIOSK_FULL_NAME]" star icon "enabled"
    When I click the Multi-Patient View button in header
    Then I should see Multi Patient View screen with condensed monitors selected in full screen mode
    When I click on patient "[props.MPVKIOSK_MPV_FNAME]" condensed monitor close button
    Then I should "not see" patient "[props.MPVKIOSK_MPV_FNAME]" condensed monitor in Multi Patient View
    When I click the back button in the Header
    Then I should see the patient list screen
    And I should see My Patients count decrease by "1"

  Scenario: Filter Units link
    When I click PM main list on the sidebar
    Then I should see the patient list screen
    When I click on Filter Units link
    Then I should see the Filter Units window
    When I click the Toggle All button on Filter Units window
    And I click Ok button in Filter Units window
    Then I should see the patient list screen
    And I should see a total of 0 patient(s) in the PM search results
    And I should see the Filter Units link highlighted
    And I should not see the "api/aso/post/configuration/userconfiguration?" api call made to server

  Scenario: PM Patient List Group/Sort
    Given reset unit filtering
    When I click on Group/Sort link
    Then I should see the Group/Sort window
    When I click the reset button on Group / Sort window
    Then I should see the patient list screen
    And I should see the Group Sort link not highlighted
    And I should not see the "api/aso/post/configuration/userconfiguration?" api call made to server
